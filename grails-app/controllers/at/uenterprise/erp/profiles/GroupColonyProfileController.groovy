package at.uenterprise.erp.profiles

import at.uenterprise.erp.base.Entity
import at.uenterprise.erp.base.EntityType
import at.uenterprise.erp.base.Link
import at.uenterprise.erp.base.ProfileHelperService
import at.uenterprise.erp.base.EntityHelperService
import at.uenterprise.erp.MetaDataService
import at.uenterprise.erp.Contact
import at.uenterprise.erp.Building
import at.uenterprise.erp.base.Profile
import at.uenterprise.erp.FunctionService
import at.uenterprise.erp.base.EntityException

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
    int totalGroupColonies = Entity.countByType(metaDataService.etGroupColony)

    return [totalGroupColonies: totalGroupColonies]
  }

  def show = {
    def group = Entity.get(params.id)

    if (!group) {
      flash.message = message(code: "object.notFound", args: [message(code: "groupColony")])
      redirect(action: list)
      return
    }

    return [group: group]
  }

    def management = {
        def group = Entity.get(params.id)

        // only show those facilities that aren't already linked to a colony
        def tempFacilities = Entity.findAllByType(metaDataService.etFacility)
        def allFacilities = []
        tempFacilities.each { Entity tf ->
            if (!Link.findBySourceAndType(tf, metaDataService.ltGroupMemberFacility))
                allFacilities << tf
        }

        // find all facilities linked to this group
        List facilities = functionService.findAllByLink(null, group, metaDataService.ltGroupMemberFacility)

        def allPartners = Entity.findAllByType(metaDataService.etPartner)
        // find all partners linked to this group
        List partners = functionService.findAllByLink(null, group, metaDataService.ltGroupMemberPartner)

        // find all resources linked to this group
        //List resources = functionService.findAllByLink(null, group, metaDataService.ltResource)
        List resources = []
        group.profile.resources.each {
            resources.add(Entity.get(it.toInteger()))
        }

        render template: "management", model: [group: group, facilities: facilities,
                allFacilities: allFacilities,
                resources: resources,
                partners: partners,
                allPartners: allPartners]
    }

  def delete = {
    Entity group = Entity.get(params.id)
    if (group) {
      functionService.deleteReferences(group)
      try {
        flash.message = message(code: "object.deleted", args: [message(code: "groupColony"), group.profile.fullName])
        group.delete(flush: true)
        redirect(action: "list")
      }
      catch (org.springframework.dao.DataIntegrityViolationException e) {
        flash.message = message(code: "object.notDeleted", args: [message(code: "groupColony"), group.profile.fullName])
        redirect(action: "show", id: params.id)
      }
    }
    else {
      flash.message = message(code: "object.notFound", args: [message(code: "groupColony")])
      redirect(action: "list")
    }
  }

  def edit = {
    Entity group = Entity.get(params.id)

    if (group) {
      [group: group]
    }
    else {
      flash.message = message(code: "object.notFound", args: [message(code: "groupColony")])
      redirect action: 'list'
    }

  }

  def update = {
    Entity group = Entity.get(params.id)

    group.profile.properties = params

    if (group.profile.save() && group.save()) {
      flash.message = message(code: "object.updated", args: [message(code: "groupColony"), group.profile.fullName])
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

      flash.message = message(code: "object.created", args: [message(code: "groupColony"), entity.profile.fullName])
      redirect action: 'show', id: entity.id
    } catch (EntityException ee) {
      render view: "create", model: [group: ee.entity]
    }

  }

  def addResource = {
    Entity group = Entity.get(params.id)

    EntityType etResource = metaDataService.etResource

    Entity entity = entityHelperService.createEntity("resource", etResource) {Entity ent ->
      ent.profile = profileHelperService.createProfileFor(ent) as Profile
      ent.profile.properties = params
    }
    new Link(source: entity, target: group, type: metaDataService.ltResource).save()

    group.profile.addToResources(entity.id.toString())

    // find all resources linked to this group
    //List resources = functionService.findAllByLink(null, group, metaDataService.ltResource)
    List resources = []
    group.profile.resources.each {
      resources.add(Entity.get(it.toInteger()))
    }

    render template: 'resources', model: [resources: resources, group: group]
  }

  def removeResource = {
    Entity group = Entity.get(params.id)

    def link = Link.createCriteria().get {
      eq('source', Entity.get(params.resource))
      eq('target', group)
      eq('type', metaDataService.ltResource)
    }
    link.delete()

    // delete resource as well
    Entity.get(params.resource).delete()

    group.profile.removeFromResources(params.resource)

    // find all resources linked to this group
    //List resources = functionService.findAllByLink(null, group, metaDataService.ltResource)
    List resources = []
    group.profile.resources.each {
      resources.add(Entity.get(it.toInteger()))
    }

    render template: 'resources', model: [resources: resources, group: group]
  }

  def addRepresentative = {ContactCommand cc ->
    Entity group = Entity.get(params.id)
    if (cc.hasErrors()) {
      render '<p class="italic red">'+message(code: "groupColony.profile.name.insert")+ '</p>'
      render template: 'representatives', model: [group: group]
      return
    }
    else {
      Contact contact = new Contact(params)
      group.profile.addToRepresentatives(contact)
      render template: 'representatives', model: [group: group]
    }
  }

  def removeRepresentative = {
    Entity group = Entity.get(params.id)
    group.profile.removeFromRepresentatives(Contact.get(params.representative))
    render template: 'representatives', model: [group: group]
  }

  def editRepresentative = {
    Entity group = Entity.get(params.id)
    Contact representative = Contact.get(params.representative)
    render template: 'editrepresentative', model: [group: group, representative: representative]
  }

  def updateRepresentative = {
    Entity group = Entity.get(params.id)
    Contact contact = Contact.get(params.representative)
    contact.properties = params
    render template: 'representatives', model: [group: group]
  }

  def addBuilding = {
    Building building = new Building(params)
    Entity group = Entity.get(params.id)
    group.profile.addToBuildings(building)
    render template: 'buildings', model: [group: group]
  }

  def removeBuilding = {
    Entity group = Entity.get(params.id)
    group.profile.removeFromBuildings(Building.get(params.building))
    render template: 'buildings', model: [group: group]
  }

  def addFacility = {
    def linking = functionService.linkEntities(params.facility, params.id, metaDataService.ltGroupMemberFacility)
    if (linking.duplicate)
      render '<span class="red italic">"' + linking.source.profile.fullName + '" '+message(code: "alreadyAssignedTo")+ '</span>'
    render template: 'facilities', model: [facilities: linking.sources, group: linking.target]
  }

  def removeFacility = {
    def breaking = functionService.breakEntities(params.facility, params.id, metaDataService.ltGroupMemberFacility)
    render template: 'facilities', model: [facilities: breaking.sources, group: breaking.target]
  }

  def addPartner = {
    def linking = functionService.linkEntities(params.partner, params.id, metaDataService.ltGroupMemberPartner)
    if (linking.duplicate)
      render '<span class="red italic">"' + linking.source.profile.fullName + '" '+message(code: "alreadyAssignedTo")+ '</span>'
    render template: 'partners', model: [partners: linking.sources, group: linking.target]
  }

  def removePartner = {
    def breaking = functionService.breakEntities(params.partner, params.id, metaDataService.ltGroupMemberPartner)
    render template: 'partners', model: [partners: breaking.sources, group: breaking.target]
  }

  def addEducator = {
    def linking = functionService.linkEntities(params.educator, params.id, metaDataService.ltGroupMemberEducator)
    if (linking.duplicate)
      render '<span class="red italic">"' + linking.source.profile.fullName + '" '+message(code: "alreadyAssignedTo")+ '</span>'
    render template: 'educators', model: [educators: linking.sources, group: linking.target]
  }

  def removeEducator = {
    def breaking = functionService.breakEntities(params.educator, params.id, metaDataService.ltGroupMemberEducator)
    render template: 'educators', model: [educators: breaking.sources, group: breaking.target]
  }

  def moveUp = {
    Entity colony = Entity.get(params.colony)
    if (colony.profile.resources.indexOf(params.id) > 0) {
      int i = colony.profile.resources.indexOf(params.id)
      use(Collections){ colony.profile.resources.swap(i, i - 1) }
    }

    List resources = []
    colony.profile.resources.each {
      resources.add(Entity.get(it.toInteger()))
    }

    render template: 'resources', model: [resources: resources, group: colony]
  }

  def moveDown = {
    Entity colony = Entity.get(params.colony)
    if (colony.profile.resources.indexOf(params.id) < colony.profile.resources.size() - 1) {
      int i = colony.profile.resources.indexOf(params.id)
      use(Collections){ colony.profile.resources.swap(i, i + 1) }
    }
    List resources = []
    colony.profile.resources.each {
      resources.add(Entity.get(it.toInteger()))
    }

    render template: 'resources', model: [resources: resources, group: colony]
  }

  def define = {
    params.sort = params.sort ?: "fullName"
    params.order = params.order ?: "asc"
    params.offset = params.int('offset') ?: 0
    params.max = Math.min(params.int('max') ?: 20, 40)

    // 1. pass - filter by object properties
    def results = Entity.createCriteria().list  {
      eq('type', metaDataService.etGroupColony)
      profile {
        if (params.name)
          ilike('fullName', "%" + params.name + "%")
        order(params.sort, params.order)
      }
    }

    int totalResults = results.size()
    int upperBound = params.offset + params.max < totalResults ? params.offset + params.max : totalResults
    results = results.subList(params.offset, upperBound)

    render template: '/templates/searchresults', model: [results: results, totalResults: totalResults, type: 'groupColony', params: params]
  }

}
