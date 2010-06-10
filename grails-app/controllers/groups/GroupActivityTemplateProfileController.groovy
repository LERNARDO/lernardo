package groups

import de.uenterprise.ep.Entity
import de.uenterprise.ep.EntityType
import de.uenterprise.ep.Link
import de.uenterprise.ep.ProfileHelperService
import de.uenterprise.ep.EntityHelperService
import standard.MetaDataService
import de.uenterprise.ep.Profile

class GroupActivityTemplateProfileController {
    MetaDataService metaDataService
    EntityHelperService entityHelperService
    ProfileHelperService profileHelperService

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

/*      // create links
      def oldEditor = Link.findByTargetAndType(group, metaDataService.ltEditor)
      if (oldEditor)
        oldEditor.delete()
      new Link(source: entityHelperService.loggedIn, target: group, type: metaDataService.ltEditor).save()

      Link.findAllByTargetAndType(group, metaDataService.ltGroupMember).each {
      log.info "group member deleted: "+it
      it.delete()}
      
      def templates = params.templates
      if (templates.class.isArray()) {
        templates.each {
          new Link(source: Entity.get(it), target: group, type: metaDataService.ltGroupMember).save()
        }
      }
      else {
        new Link(source: Entity.get(templates), target: group, type: metaDataService.ltGroupMember).save()
      }*/

      if(!group.hasErrors() && group.save()) {
          flash.message = message(code:"group.updated", args:[group.profile.fullName])
          redirect action:'show', id: group.id
      }
      else {
          render view:'edit', model:[group: group, entity: entityHelperService.loggedIn]
      }
    }

    def create = {
        return [entity: entityHelperService.loggedIn]
    }

    def save = {
      EntityType etGroupActivityTemplate = metaDataService.etGroupActivityTemplate

      try {
        Entity entity = entityHelperService.createEntity("group", etGroupActivityTemplate) {Entity ent ->
          ent.profile = profileHelperService.createProfileFor(ent) as Profile
          ent.profile.properties = params
        }
/*        // create links
        new Link(source: entityHelperService.loggedIn, target: entity, type: metaDataService.ltCreator).save()
        def templates = params.templates
        if (templates.class.isArray()) {
          templates.each {
            new Link(source: Entity.get(it), target: entity, type: metaDataService.ltGroupMember).save()
          }
        }
        else {
          new Link(source: Entity.get(templates), target: entity, type: metaDataService.ltGroupMember).save()
        }*/

        flash.message = message(code:"group.created", args:[entity.profile.fullName])
        redirect action:'list'
      } catch (de.uenterprise.ep.EntityException ee) {
        render (view:"create", model:[group: ee.entity, entity: entityHelperService.loggedIn])
        return
      }

    }

    def addTemplate = {
      Entity group = Entity.get(params.id)

      // check if the template isn't already linked to the group
      def c = Link.createCriteria()
      def link = c.get {
        eq('source', Entity.get(params.template))
        eq('target', group)
        eq('type', metaDataService.ltGroupMember)
      }
      if (!link)
        new Link(source:Entity.get(params.template), target: group, type:metaDataService.ltGroupMember).save()

      // find all templates of this group
      def links = Link.findAllByTargetAndType(group, metaDataService.ltGroupMember)
      List templates = links.collect {it.source}

      def calculatedDuration = 0
      templates.each {
        calculatedDuration += it.profile.duration
      }

      render template:'templates', model: [group: group, templates: templates, entity: entityHelperService.loggedIn, calculatedDuration: calculatedDuration]
    }

    def removeTemplate = {
      Entity group = Entity.get(params.id)

      def c = Link.createCriteria()
      def link = c.get {
        eq('source', Entity.get(params.template))
        eq('target', group)
        eq('type', metaDataService.ltGroupMember)
      }
      link.delete()

      // find all templates of this group
      def links = Link.findAllByTargetAndType(group, metaDataService.ltGroupMember)
      List templates = links.collect {it.source}

      def calculatedDuration = 0
      templates.each {
        calculatedDuration += it.profile.duration
      }

      render template:'templates', model: [group: group, templates: templates, entity: entityHelperService.loggedIn, calculatedDuration: calculatedDuration]
    }
}
