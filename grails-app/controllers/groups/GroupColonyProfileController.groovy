package groups

import at.openfactory.ep.Entity
import at.openfactory.ep.EntityType
import at.openfactory.ep.Link
import at.openfactory.ep.ProfileHelperService
import at.openfactory.ep.EntityHelperService
import standard.MetaDataService
import lernardo.Contact
import lernardo.Building
import at.openfactory.ep.Profile
import standard.FunctionService
import at.openfactory.ep.EntityException
import profiles.ContactCommand

class GroupColonyProfileController {
  MetaDataService metaDataService
  EntityHelperService entityHelperService
  ProfileHelperService profileHelperService
  FunctionService functionService

  def index = {
    redirect action: "list", params: params
  }

  // the delete, save and update actions only accept POST requests
  static allowedMethods = [delete: 'POST', save: 'POST', update: 'POST']

  def list = {
    params.offset = params.offset ? params.int('offset') : 0
    params.max = Math.min(params.max ? params.int('max') : 15, 100)
    params.sort = params.sort ?: "fullName"
    params.order = params.order ?: "asc"

    def c = Entity.createCriteria()
    def groupcolonies = c.list {
      eq("type", metaDataService.etGroupColony)
      profile {
        order(params.sort, params.order)
      }
      maxResults(params.max)
      firstResult(params.offset)
    }

    return [groups: groupcolonies,
            groupTotal: Entity.countByType(metaDataService.etGroupColony)]
  }

  def show = {
    def group = Entity.get(params.id)
    Entity entity = params.entity ? group : entityHelperService.loggedIn

    if (!group) {
      flash.message = "groupProfile not found with id ${params.id}"
      redirect(action: list)
    }
    else {
      def allFacilities = Entity.findAllByType(metaDataService.etFacility)
      // find all facilities linked to this group
      def links = Link.findAllByTargetAndType(group, metaDataService.ltGroupMemberFacility)
      List facilities = links.collect {it.source}

      def allPartners = Entity.findAllByType(metaDataService.etPartner)
      // find all partners linked to this group
      links = Link.findAllByTargetAndType(group, metaDataService.ltGroupMemberPartner)
      List partners = links.collect {it.source}

      def allEducators = Entity.findAllByType(metaDataService.etEducator)
      // find all educators linked to this group
      links = Link.findAllByTargetAndType(group, metaDataService.ltGroupMemberEducator)
      List educators = links.collect {it.source}

      // find all resources linked to this group
      links = Link.findAllByTargetAndType(group, metaDataService.ltResource)
      List resources = links.collect {it.source}

      // find colonia

      return [group: group,
              entity: entity,
              facilities: facilities,
              allFacilities: allFacilities,
              resources: resources,
              partners: partners,
              allPartners: allPartners,
              educators: educators,
              allEducators: allEducators]
    }
  }

  def del = {
    Entity group = Entity.get(params.id)
    if (group) {
      // delete all links
      Link.findAllBySourceOrTarget(group, group).each {it.delete()}
      try {
        flash.message = message(code: "group.deleted", args: [group.profile.fullName])
        group.delete(flush: true)
        redirect(action: "list")
      }
      catch (org.springframework.dao.DataIntegrityViolationException e) {
        flash.message = message(code: "group.notDeleted", args: [group.profile.fullName])
        redirect(action: "show", id: params.id)
      }
    }
    else {
      flash.message = "groupProfile not found with id ${params.id}"
      redirect(action: "list")
    }
  }

  def edit = {
    Entity group = Entity.get(params.id)

    if (!group) {
      flash.message = "groupProfile not found with id ${params.id}"
      redirect action: 'list'
    }
    else {
      [group: group]
    }
  }

  def update = {
    Entity group = Entity.get(params.id)

    group.profile.properties = params

    if (!group.hasErrors() && group.save()) {
      flash.message = message(code: "group.updated", args: [group.profile.fullName])
      redirect action: 'show', id: group.id
    }
    else {
      render view: 'edit', model: [group: group]
    }
  }

  def create = {
    return [templates: Entity.findAllByType(metaDataService.etTemplate)]
  }

  def save = {
    EntityType etGroupColony = metaDataService.etGroupColony

    try {
      Entity entity = entityHelperService.createEntity("group", etGroupColony) {Entity ent ->
        ent.profile = profileHelperService.createProfileFor(ent) as Profile
        ent.profile.properties = params
      }

      flash.message = message(code: "group.created", args: [entity.profile.fullName])
      redirect action: 'show', id: entity.id
    } catch (EntityException ee) {
      render(view: "create", model: [group: ee.entity])
      return
    }

  }

  def addResource = {
    Entity group = Entity.get(params.id)

    EntityType etResource = metaDataService.etResource

    Entity entity = entityHelperService.createEntity("resource", etResource) {Entity ent ->
      ent.profile = profileHelperService.createProfileFor(ent) as Profile
      ent.profile.properties = params
      ent.profile.type = "planbar"
    }
    new Link(source: entity, target: group, type: metaDataService.ltResource).save()

    // find all resources linked to this group
    def links = Link.findAllByTargetAndType(group, metaDataService.ltResource)
    List resources = links.collect {it.source}

    render template: 'resources', model: [resources: resources, group: group, entity: entityHelperService.loggedIn]
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

    // delete resource as well
    Entity.get(params.resource).delete()

    // find all resources linked to this group
    def links = Link.findAllByTargetAndType(group, metaDataService.ltResource)
    List resources = links.collect {it.source}

    render template: 'resources', model: [resources: resources, group: group, entity: entityHelperService.loggedIn]
  }

  def addRepresentative = {ContactCommand cc ->
    Entity group = Entity.get(params.id)
    if (cc.hasErrors()) {
      render '<p class="italic red">Bitte Vor- und Nachname angeben!</p>'
      render template: 'representatives', model: [group: group, entity: entityHelperService.loggedIn]
      return
    }
    Contact contact = new Contact(params)    
    group.profile.addToRepresentatives(contact)
    render template: 'representatives', model: [group: group, entity: entityHelperService.loggedIn]
  }

  def removeRepresentative = {
    Entity group = Entity.get(params.id)
    group.profile.removeFromRepresentatives(Contact.get(params.representative))
    render template: 'representatives', model: [group: group, entity: entityHelperService.loggedIn]
  }

  def editRepresentative = {
    Entity group = Entity.get(params.id)
    Contact representative = Contact.get(params.representative)
    render template: 'editrepresentative', model: [group: group, representative: representative, entity: entityHelperService.loggedIn]
  }

  def updateRepresentative = {
    Entity group = Entity.get(params.id)
    Contact contact = Contact.get(params.representative)
    contact.properties = params
    render template: 'representatives', model: [group: group, entity: entityHelperService.loggedIn]
  }

  def addBuilding = {
    Building building = new Building(params)
    Entity group = Entity.get(params.id)
    group.profile.addToBuildings(building)
    render template: 'buildings', model: [group: group, entity: entityHelperService.loggedIn]
  }

  def removeBuilding = {
    Entity group = Entity.get(params.id)
    group.profile.removeFromBuildings(Building.get(params.building))
    render template: 'buildings', model: [group: group, entity: entityHelperService.loggedIn]
  }

  def addFacility = {
    def linking = functionService.linkEntities(params.facility, params.id, metaDataService.ltGroupMemberFacility)
    if (linking.duplicate)
      render '<span class="red italic">"' + linking.source.profile.fullName + '" wurde bereits zugewiesen!</span>'
    render template: 'facilities', model: [facilities: linking.results, group: linking.target, entity: entityHelperService.loggedIn]
  }

  def removeFacility = {
    def breaking = functionService.breakEntities(params.facility, params.id, metaDataService.ltGroupMemberFacility)
    render template: 'facilities', model: [facilities: breaking.results, group: breaking.target, entity: entityHelperService.loggedIn]
  }

  def addPartner = {
    def linking = functionService.linkEntities(params.partner, params.id, metaDataService.ltGroupMemberPartner)
    if (linking.duplicate)
      render '<span class="red italic">"' + linking.source.profile.fullName + '" wurde bereits zugewiesen!</span>'
    render template: 'partners', model: [partners: linking.results, group: linking.target, entity: entityHelperService.loggedIn]
  }

  def removePartner = {
    def breaking = functionService.breakEntities(params.partner, params.id, metaDataService.ltGroupMemberPartner)
    render template: 'partners', model: [partners: breaking.results, group: breaking.target, entity: entityHelperService.loggedIn]
  }

  def addEducator = {
    def linking = functionService.linkEntities(params.educator, params.id, metaDataService.ltGroupMemberEducator)
    if (linking.duplicate)
      render '<span class="red italic">"' + linking.source.profile.fullName + '" wurde bereits zugewiesen!</span>'
    render template: 'educators', model: [educators: linking.results, group: linking.target, entity: entityHelperService.loggedIn]
  }

  def removeEducator = {
    def breaking = functionService.breakEntities(params.educator, params.id, metaDataService.ltGroupMemberEducator)
    render template: 'educators', model: [educators: breaking.results, group: breaking.target, entity: entityHelperService.loggedIn]
  }

}
