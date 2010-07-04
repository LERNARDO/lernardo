package groups

import at.openfactory.ep.Entity
import at.openfactory.ep.EntityType
import at.openfactory.ep.Link
import at.openfactory.ep.ProfileHelperService
import at.openfactory.ep.EntityHelperService
import standard.MetaDataService
import at.openfactory.ep.Profile
import standard.FunctionService
import at.openfactory.ep.EntityException

class GroupActivityTemplateProfileController {
    MetaDataService metaDataService
    EntityHelperService entityHelperService
    ProfileHelperService profileHelperService
    FunctionService functionService

    def index = {
        redirect action:"list", params:params
    }

    // the delete, save and update actions only accept POST requests
    static allowedMethods = [delete:'POST', save:'POST', update:'POST']

    def list = {
        params.max = Math.min( params.max ? params.int('max') : 10,  100)
        return [groups: Entity.findAllByType(metaDataService.etGroupActivityTemplate),
                groupTotal: Entity.countByType(metaDataService.etGroupActivityTemplate),
                entity: entityHelperService.loggedIn]
    }

    def show = {
        def group = Entity.get(params.id)
        Entity entity = params.entity ? group : entityHelperService.loggedIn

        if(!group) {
            flash.message = "groupProfile not found with id ${params.id}"
            redirect(action:list)
        }
        else {
          //def allTemplates = Entity.findAllByType(metaDataService.etTemplate)

          // get all templates that are set to completed
          def c = Entity.createCriteria()
          def allTemplates = c.list {
             eq("type", metaDataService.etTemplate)
             profile {
                eq("status", "fertig")
             }
          }

          // find all templates linked to this group
          def links = Link.findAllByTargetAndType(group, metaDataService.ltGroupMember)
          List templates = links.collect {it.source}

          def calculatedDuration = 0
          templates.each {
            calculatedDuration += it.profile.duration
          }

          return [group: group, entity: entity, allTemplates: allTemplates, templates: templates, calculatedDuration: calculatedDuration]
        }
    }

    def del = {
        Entity group = Entity.get(params.id)
        if(group) {
            // delete all links
            Link.findAllBySourceOrTarget(group, group).each {it.delete()}
            try {
                flash.message = message(code:"group.deleted", args:[group.profile.fullName])
                group.delete(flush:true)
                redirect(action:"list")
            }
            catch(org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = message(code:"group.notDeleted", args:[group.profile.fullName])
                redirect(action:"show",id:params.id)
            }
        }
        else {
            flash.message = "groupProfile not found with id ${params.id}"
            redirect(action:"list")
        }
    }

    def edit = {
        Entity group = Entity.get(params.id)

        if(!group) {
            flash.message = "groupProfile not found with id ${params.id}"
            redirect action:'list'
        }
        else {
            [group: group, entity: entityHelperService.loggedIn]
        }
    }

    def update = {
      Entity group = Entity.get(params.id)

      group.profile.properties = params

      if(!group.hasErrors() && group.save()) {
          flash.message = message(code:"group.updated", args:[group.profile.fullName])
          redirect action:'show', id: group.id
      }
      else {
          render view:'edit', model:[group: group, entity: entityHelperService.loggedIn]
      }
    }

    def create = {
        Entity group = Entity.get(params.id)
        return [entity: entityHelperService.loggedIn,
                group: group]
    }

    def save = {
      EntityType etGroupActivityTemplate = metaDataService.etGroupActivityTemplate

      try {
        Entity entity = entityHelperService.createEntity("group", etGroupActivityTemplate) {Entity ent ->
          ent.profile = profileHelperService.createProfileFor(ent) as Profile
          ent.profile.properties = params
        }

        flash.message = message(code:"group.created", args:[entity.profile.fullName])
        redirect action:'list'
      } catch (EntityException ee) {
        render (view:"create", model:[group: ee.entity, entity: entityHelperService.loggedIn])
        return
      }

    }

    def addTemplate = {
      def linking = functionService.linkEntities(params.template, params.id, metaDataService.ltGroupMember)
      if (linking.duplicate)
        render '<span class="red italic">"' + linking.source.profile.fullName + '" wurde bereits zugewiesen!</span>'

      def calculatedDuration = 0
      linking.results.each {
        calculatedDuration += it.profile.duration
      }

      render template:'templates', model: [templates: linking.results, group: linking.target, entity: entityHelperService.loggedIn, calculatedDuration: calculatedDuration]
    }

    def removeTemplate = {
      def breaking = functionService.breakEntities(params.template, params.id, metaDataService.ltGroupMember)

      def calculatedDuration = 0
      breaking.results.each {
        calculatedDuration += it.profile.duration
      }

      render template:'templates', model: [templates: breaking.results, group: breaking.target, entity: entityHelperService.loggedIn, calculatedDuration: calculatedDuration]
    }
}
