package groups

import de.uenterprise.ep.Entity
import de.uenterprise.ep.EntityType
import de.uenterprise.ep.Link
import de.uenterprise.ep.ProfileHelperService
import de.uenterprise.ep.EntityHelperService
import standard.MetaDataService

class GroupPartnerProfileController {
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
        return [groups: Entity.findAllByType(metaDataService.etGroupPartner),
                groupTotal: Entity.countByType(metaDataService.etGroupPartner)]
    }

    def show = {
        def group = Entity.get(params.id)
        Entity entity = params.entity ? group : entityHelperService.loggedIn

        if(!group) {
            flash.message = "groupProfile not found with id ${params.id}"
            redirect(action:list)
        }
        else {
          def allPartners = Entity.findAllByType(metaDataService.etPartner)
          // find all partners linked to this group
          def links = Link.findAllByTargetAndType(group, metaDataService.ltGroupMember)
          List partners = links.collect {it.source}

          return [group: group,
                  entity: entity,
                  partners: partners,
                  allPartners: allPartners]
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
            return [group: group, entity: entityHelperService.loggedIn]
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
        return [entity: entityHelperService.loggedIn, templates: Entity.findAllByType(metaDataService.etTemplate)]
    }

    def save = {
      EntityType etGroupPartner = metaDataService.etGroupPartner

      try {
        Entity entity = entityHelperService.createEntity("group", etGroupPartner) {Entity ent ->
          ent.profile = profileHelperService.createProfileFor(ent)
          ent.profile.properties = params
        }

        flash.message = message(code:"group.created", args:[entity.profile.fullName])
        redirect action:'list'
      } catch (de.uenterprise.ep.EntityException ee) {
        render (view:"create", model:[group: ee.entity, entity: entityHelperService.loggedIn])
        return
      }

    }

  def addPartner = {
    Entity group = Entity.get(params.id)

    // check if the partner isn't already linked to the group
    def c = Link.createCriteria()
    def link = c.get {
      eq('source', Entity.get(params.partner))
      eq('target', group)
      eq('type', metaDataService.ltGroupMember)
    }
    if (!link)
      new Link(source:Entity.get(params.partner), target: group, type:metaDataService.ltGroupMember).save()

    // find all partners linked to this group
    def links = Link.findAllByTargetAndType(group, metaDataService.ltGroupMember)
    List partners = links.collect {it.source}

    render template:'partners', model: [partners: partners, group: group, entity: entityHelperService.loggedIn]
  }

  def removePartner = {
    Entity group = Entity.get(params.id)

    def c = Link.createCriteria()
    def link = c.get {
      eq('source', Entity.get(params.partner))
      eq('target', group)
      eq('type', metaDataService.ltGroupMember)
    }
    link.delete()

    // find all partners linked to this group
    def links = Link.findAllByTargetAndType(group, metaDataService.ltGroupMember)
    List partners = links.collect {it.source}

    render template:'partners', model: [partners: partners, group: group, entity: entityHelperService.loggedIn]
  }

}
