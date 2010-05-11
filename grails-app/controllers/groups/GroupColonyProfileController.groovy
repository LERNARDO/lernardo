package groups

import de.uenterprise.ep.Entity
import de.uenterprise.ep.EntityType
import de.uenterprise.ep.Link
import de.uenterprise.ep.ProfileHelperService
import de.uenterprise.ep.EntityHelperService
import standard.MetaDataService
import lernardo.Contact
import lernardo.Building

class GroupColonyProfileController {
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
        return [groups: Entity.findAllByType(metaDataService.etGroupColony),
                groupTotal: Entity.countByType(metaDataService.etGroupColony)]
    }

    def show = {
        def group = Entity.get(params.id)
        Entity entity = params.entity ? group : entityHelperService.loggedIn

        if(!group) {
            flash.message = "groupProfile not found with id ${params.id}"
            redirect(action:list)
        }
        else {
          def allFacilities = Entity.findAllByType(metaDataService.etFacility)
          // find all facilities linked to this group
          def links = Link.findAllByTargetAndType(group, metaDataService.ltGroupMember)
          List facilities = links.collect {it.source}

          def c = Entity.createCriteria()
          def allResources = c.list {
            eq('type', metaDataService.etResource)
            profile {
              eq('type', 'planbar')
            }
          }
          // find all resources linked to this group
          links = Link.findAllByTargetAndType(group, metaDataService.ltResource)
          List resources = links.collect {it.source}

          return [group: group,
                  entity: entity,
                  facilities: facilities,
                  allFacilities: allFacilities,
                  resources: resources,
                  allResources: allResources]
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
      EntityType etGroupColony = metaDataService.etGroupColony

      try {
        Entity entity = entityHelperService.createEntity("group", etGroupColony) {Entity ent ->
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

    def addRepresentative = {
      Contact contact = new Contact(params)
      Entity group = Entity.get(params.id)
      group.profile.addToRepresentatives(contact)
      render template:'representatives', model: [group: group, entity: entityHelperService.loggedIn]
    }

    def removeRepresentative = {
      Entity group = Entity.get(params.id)
      group.profile.removeFromRepresentatives(Contact.get(params.representative))
      render template:'representatives', model: [group: group, entity: entityHelperService.loggedIn]
    }

    def addBuilding = {
      Building building = new Building(params)
      Entity group = Entity.get(params.id)
      group.profile.addToBuildings(building)
      render template:'buildings', model: [group: group, entity: entityHelperService.loggedIn]
    }

    def removeBuilding = {
      Entity group = Entity.get(params.id)
      group.profile.removeFromBuildings(Building.get(params.building))
      render template:'buildings', model: [group: group, entity: entityHelperService.loggedIn]
    }

    def addFacility = {
      Entity group = Entity.get(params.id)

      // check if the facility isn't already linked to the group
      def c = Link.createCriteria()
      def link = c.get {
        eq('source', Entity.get(params.facility))
        eq('target', group)
        eq('type', metaDataService.ltGroupMember)
      }
      if (!link)
        new Link(source:Entity.get(params.facility), target: group, type:metaDataService.ltGroupMember).save()

      // find all facilities linked to this group
      def links = Link.findAllByTargetAndType(group, metaDataService.ltGroupMember)
      List facilities = links.collect {it.source}

      render template:'facilities', model: [facilities: facilities, group: group, entity: entityHelperService.loggedIn]
    }

    def removeFacility = {
      Entity group = Entity.get(params.id)

      def c = Link.createCriteria()
      def link = c.get {
        eq('source', Entity.get(params.facility))
        eq('target', group)
        eq('type', metaDataService.ltGroupMember)
      }
      link.delete()

      // find all facilities linked to this group
      def links = Link.findAllByTargetAndType(group, metaDataService.ltGroupMember)
      List facilities = links.collect {it.source}

      render template:'facilities', model: [facilities: facilities, group: group, entity: entityHelperService.loggedIn]
    }

  def addResource = {
    Entity group = Entity.get(params.id)

    // check if the resource isn't already linked to the group
    def c = Link.createCriteria()
    def link = c.get {
      eq('source', Entity.get(params.resource))
      eq('target', group)
      eq('type', metaDataService.ltResource)
    }
    if (!link)
      new Link(source:Entity.get(params.resource), target: group, type:metaDataService.ltResource).save()

    // find all resources linked to this group
    def links = Link.findAllByTargetAndType(group, metaDataService.ltResource)
    List resources = links.collect {it.source}

    render template:'resources', model: [resources: resources, group: group, entity: entityHelperService.loggedIn]
  }

  def removeResource = {
    Entity group = Entity.get(params.id)

    def c = Link.createCriteria()
    def link = c.get {
      eq('source', Entity.get(params.resource))
      eq('target', group)
      eq('type', metaDataService.ltResource)
    }
    link.delete()

    // find all resources linked to this group
    def links = Link.findAllByTargetAndType(group, metaDataService.ltResource)
    List resources = links.collect {it.source}

    render template:'resources', model: [resources: resources, group: group, entity: entityHelperService.loggedIn]
  }

}
