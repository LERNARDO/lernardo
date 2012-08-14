package at.uenterprise.erp.profiles

import at.uenterprise.erp.base.Entity
import at.uenterprise.erp.base.EntityType
import at.uenterprise.erp.base.Link
import at.uenterprise.erp.base.EntityHelperService
import at.uenterprise.erp.base.ProfileHelperService
import at.uenterprise.erp.Contact
import at.uenterprise.erp.FunctionService
import at.uenterprise.erp.MetaDataService
import at.uenterprise.erp.base.Profile
import at.uenterprise.erp.logbook.Attendance

class FacilityProfileController {
  MetaDataService metaDataService
  EntityHelperService entityHelperService
  FunctionService functionService
  def securityManager
  ProfileHelperService profileHelperService

  def index = {
    redirect action: "list", params: params
  }

  // the delete, save and update actions only accept POST requests
  static allowedMethods = [delete: 'POST', save: 'POST', update: 'POST']

  def list = {
    int totalFacilities = Entity.countByType(metaDataService.etFacility)

    return [totalFacilities: totalFacilities]
  }

  def show = {
    Entity facility = Entity.get(params.id)

    if (!facility) {
      flash.message = message(code: "object.notFound", args: [message(code: "facility")])
      redirect(action: list)
      return
    }

      // find colony of this facility
      Entity colony = functionService.findByLink(facility, null, metaDataService.ltGroupMemberFacility)

    return [facility: facility, colony: colony]
  }

    def management = {
        Entity facility = Entity.get(params.id)

        // find all resources of this facility
        //List resources = functionService.findAllByLink(null, facility, metaDataService.ltResource)
        List resources = []
        facility.profile.resources.each {
            resources.add(Entity.get(it.toInteger()))
        }

        // find all educators of this facility
        List educators = functionService.findAllByLink(null, facility, metaDataService.ltWorking)

        // find lead educators
        List leadEducators = functionService.findAllByLink(null, facility, metaDataService.ltLeadEducator)

        // find all clients linked to the facility
        List clients = functionService.findAllByLink(null, facility, metaDataService.ltGroupMemberClient)

        render template: "management", model: [facility: facility,
                educators: educators,
                clients: clients,
                resources: resources,
                leadeducators: leadEducators]
    }

  def delete = {
    Entity facility = Entity.get(params.id)
    if (facility) {
      functionService.deleteReferences(facility)
      try {
        flash.message = message(code: "object.deleted", args: [message(code: "facility"), facility.profile.fullName])
        facility.delete(flush: true)
        redirect(action: "list")
      }
      catch (org.springframework.dao.DataIntegrityViolationException e) {
        flash.message = message(code: "object.notDeleted", args: [message(code: "facility"), facility.profile.fullName])
        redirect(action: "show", id: params.id)
      }
    }
    else {
      flash.message = message(code: "object.notFound", args: [message(code: "facility")])
      redirect(action: "list")
    }
  }

  def edit = {
    Entity facility = Entity.get(params.id)

    if (!facility) {
      flash.message = message(code: "object.notFound", args: [message(code: "facility")])
      redirect action: 'list'
      return
    }

    // find colony of this facility
    Entity colony = functionService.findByLink(facility, null, metaDataService.ltGroupMemberFacility)

    return [facility: facility, colony: colony, allColonies: Entity.findAllByType(metaDataService.etGroupColony)]
    
  }

  def update = {
    Entity facility = Entity.get(params.id)

    facility.profile.properties = params

    if (facility.profile.save() && facility.save()) {

      // delete previously linked colony
      Link.findBySourceAndType(facility, metaDataService.ltGroupMemberFacility)?.delete()

      // link new colony to facility
      new Link(source: facility, target: Entity.get(params.colony), type: metaDataService.ltGroupMemberFacility).save()

      flash.message = message(code: "object.updated", args: [message(code: "facility"), facility.profile.fullName])
      redirect action: 'show', id: facility.id
    }
    else {
      // find colony of this facility
      Entity colony = functionService.findByLink(facility, null, metaDataService.ltGroupMemberFacility)

      render view: 'edit', model: [facility: facility, colony: colony, allColonies: Entity.findAllByType(metaDataService.etGroupColony)]
    }
  }

  def create = {
    return [allColonies: Entity.findAllByType(metaDataService.etGroupColony)]
  }

  def save = {
    EntityType etFacility = metaDataService.etFacility

    try {
      Entity entity = entityHelperService.createEntity(functionService.createNick(params.fullName), etFacility) {Entity ent ->
        ent.profile = profileHelperService.createProfileFor(ent) as Profile
        ent.profile.properties = params
      }

      // link facility to colony
      new Link(source: entity, target: Entity.get(params.colony), type: metaDataService.ltGroupMemberFacility).save()

      flash.message = message(code: "object.created", args: [message(code: "facility"), entity.profile.fullName])
      redirect action: 'show', id: entity.id
    } catch (at.uenterprise.erp.base.EntityException ee) {
      render view: "create", model: [facility: ee.entity, allColonies: Entity.findAllByType(metaDataService.etGroupColony)]
    }

  }

  def addResource = {
    Entity facility = Entity.get(params.id)

    EntityType etResource = metaDataService.etResource

    Entity entity = entityHelperService.createEntity("resource", etResource) {Entity ent ->
      ent.profile = profileHelperService.createProfileFor(ent) as Profile
      ent.profile.properties = params
    }
    new Link(source: entity, target: facility, type: metaDataService.ltResource).save()

    facility.profile.addToResources(entity.id.toString())

    // find all resources of this facility
    //List resources = functionService.findAllByLink(null, facility, metaDataService.ltResource)
    List resources = []
    facility.profile.resources.each {
      resources.add(Entity.get(it.toInteger()))
    }

    render template: 'resources', model: [resources: resources, facility: facility]
  }

  def removeResource = {
    Entity facility = Entity.get(params.id)

    def link = Link.createCriteria().get {
      eq('source', Entity.get(params.resource))
      eq('target', facility)
      eq('type', metaDataService.ltResource)
    }
    link.delete()

    // delete resource as well
    Entity.get(params.resource).delete()

    facility.profile.removeFromResources(params.resource)

    // find all resources of this facility
    //List resources = functionService.findAllByLink(null, facility, metaDataService.ltResource)
    List resources = []
    facility.profile.resources.each {
      resources.add(Entity.get(it.toInteger()))
    }

    render template: 'resources', model: [resources: resources, facility: facility]
  }

  def addEducator = {
    def linking = functionService.linkEntities(params.educator, params.id, metaDataService.ltWorking)
    if (linking.duplicate)
      render '<span class="red italic">"' + linking.source.profile.fullName+ '" '+message(code: "alreadyAssignedTo")+ '</span>'
    render template: 'educators', model: [educators: linking.sources, facility: linking.target]
  }

  def removeEducator = {
    def breaking = functionService.breakEntities(params.educator, params.id, metaDataService.ltWorking)
    render template: 'educators', model: [educators: breaking.sources, facility: breaking.target]
  }

  def addLeadEducator = {
    def linking = functionService.linkEntities(params.leadeducator, params.id, metaDataService.ltLeadEducator)
    if (linking.duplicate)
      render '<span class="red italic">"' + linking.source.profile.fullName+ '" '+message(code: "alreadyAssignedTo")+ '</span>'
    render template: 'leadeducators', model: [leadeducators: linking.sources, facility: linking.target]
  }

  def removeLeadEducator = {
    def breaking = functionService.breakEntities(params.leadeducator, params.id, metaDataService.ltLeadEducator)
    render template: 'leadeducators', model: [leadeducators: breaking.sources, facility: breaking.target]
  }

  def addClients = {
    Entity facility = Entity.get(params.id)
    Entity clientgroup = Entity.get(params.clientgroup)

    // if the entity is a client add it
    if (clientgroup.type.id == metaDataService.etClient.id) {
      def linking = functionService.linkEntities(params.clientgroup, params.id, metaDataService.ltGroupMemberClient)
      if (linking.duplicate)
        render '<span class="red italic">"' + linking.source.profile.fullName + '" ' + message(code: "alreadyAssignedTo") + '</span>'
      else
        new Attendance(client: clientgroup, facility: facility).save(failOnError: true)
      render template: 'clients', model: [clients: linking.sources, facility: linking.target]
    }
    // if the entity is a client group get all clients and add them
    else if (clientgroup.type.id == metaDataService.etGroupClient.id) {
      // find all clients of the group
      List clients = functionService.findAllByLink(null, clientgroup, metaDataService.ltGroupMemberClient)

      clients.each { Entity client ->
        def linking = functionService.linkEntities(client.id.toString(), params.id, metaDataService.ltGroupMemberClient)
        if (linking.duplicate)
          render '<div class="red italic">"' + linking.source.profile.fullName + '" ' + message(code: "alreadyAssignedTo") + '</div>'
        else
          new Attendance(client: client, facility: facility).save(failOnError: true)
      }

      List clients2 = functionService.findAllByLink(null, facility, metaDataService.ltGroupMemberClient)
      render template: 'clients', model: [clients: clients2, facility: facility]
    }

  }

  def removeClient = {
    Entity facility = Entity.get(params.id)
    Entity client = Entity.get(params.client)

    def link = Link.createCriteria().get {
      eq('source', client)
      eq('target', facility)
      eq('type', metaDataService.ltGroupMemberClient)
    }
    link?.delete()

    Attendance.findByClientAndFacility(client, facility)?.delete()

    // find all clients of this facility
    List clients = functionService.findAllByLink(null, facility, metaDataService.ltGroupMemberClient)

    render template: 'clients', model: [clients: clients, facility: facility]
  }

  def addContact = {ContactCommand cc ->
    Entity facility = Entity.get(params.id)
    if (cc.hasErrors()) {
      render '<p class="italic red">'+message(code: "facility.profile.name.insert")+ '</p>'
      render template: 'contacts', model: [facility: facility]
      return
    }
    else {
      Contact contact = new Contact(params)
      facility.profile.addToContacts(contact)
      render template: 'contacts', model: [facility: facility]
    }
  }

  def removeContact = {
    Entity facility = Entity.get(params.id)
    facility.profile.removeFromContacts(Contact.get(params.contact))
    Contact.get(params.contact).delete()
    render template: 'contacts', model: [facility: facility]
  }

  def editContact = {
    Entity facility = Entity.get(params.id)
    Contact contact = Contact.get(params.contact)
    render template: 'editcontact', model: [facility: facility, representative: contact]
  }

  def updateContact = {
    Entity facility = Entity.get(params.id)
    Contact contact = Contact.get(params.representative)
    contact.properties = params
    render template: 'contacts', model: [facility: facility]
  }

  /*
   * retrieves all educators matching the search parameter
   */
  def remoteEducators = {
    if (!params.value) {
      render ""
      return
    }
    else if (params.value.size() < 2) {
      render '<span class="gray">Bitte mindestens 2 Zeichen eingeben!</span>'
      return
    }

    def results = Entity.createCriteria().listDistinct {
      eq('type', metaDataService.etEducator)
      user {
        eq("enabled", true)
      }
      profile {
        ilike('fullName', "%" + params.value + "%")
        order('fullName','asc')
      }
      maxResults(15)
    }

    if (results.size() == 0) {
      render '<span class="italic">'+message(code:'noResultsFound')+ '</span>'
      return
    }
    else {
      render template: 'educatorresults', model: [results: results, facility: params.id]
    }
  }

  /*
   * retrieves all educators matching the search parameter
   */
  def remoteLeadEducators = {
    if (!params.value) {
      render ""
      return
    }
    else if (params.value.size() < 2) {
      render '<span class="gray">Bitte mindestens 2 Zeichen eingeben!</span>'
      return
    }

    def results = Entity.createCriteria().listDistinct {
      eq('type', metaDataService.etEducator)
      user {
        eq("enabled", true)
      }
      profile {
        ilike('fullName', "%" + params.value + "%")
        order('fullName','asc')
      }
      maxResults(15)
    }

    if (results.size() == 0) {
      render '<span class="italic">'+message(code:'noResultsFound')+ '</span>'
      return
    }
    else {
      render template: 'leadeducatorresults', model: [results: results, facility: params.id]
    }
  }

  /*
   * retrieves all clients and client groups matching the search parameter
   */
  def remoteClients = {
    if (!params.value) {
      render ""
      return
    }
    else if (params.value.size() < 2) {
      render '<span class="gray">Bitte mindestens 2 Zeichen eingeben!</span>'
      return
    }

    def results = Entity.createCriteria().list {
      or {
        eq('type', metaDataService.etClient)
        eq('type', metaDataService.etGroupClient)
      }
      profile {
        ilike('fullName', "%" + params.value + "%")
        order('fullName','asc')
      }
      maxResults(15)
    }

    if (results.size() == 0) {
      render '<span class="italic">'+message(code:'noResultsFound')+ '</span>'
      return
    }
    else {
      render template: 'clientresults', model: [results: results, facility: params.id]
    }
  }

  def moveUp = {
    Entity facility = Entity.get(params.facility)
    if (facility.profile.resources.indexOf(params.id) > 0) {
      int i = facility.profile.resources.indexOf(params.id)
      use(Collections){ facility.profile.resources.swap(i, i - 1) }
    }

    List resources = []
    facility.profile.resources.each {
      resources.add(Entity.get(it.toInteger()))
    }

    render template: 'resources', model: [resources: resources, facility: facility]
  }

  def moveDown = {
    Entity facility = Entity.get(params.facility)
    if (facility.profile.resources.indexOf(params.id) < facility.profile.resources.size() - 1) {
      int i = facility.profile.resources.indexOf(params.id)
      use(Collections){ facility.profile.resources.swap(i, i + 1) }
    }
    List resources = []
    facility.profile.resources.each {
      resources.add(Entity.get(it.toInteger()))
    }

    render template: 'resources', model: [resources: resources, facility: facility]
  }

  def define = {
    params.sort = params.sort ?: "fullName"
    params.order = params.order ?: "asc"
    params.offset = params.int('offset') ?: 0
    params.max = Math.min(params.int('max') ?: 20, 40)

    // 1. pass - filter by object properties
    def results = Entity.createCriteria().list  {
      eq('type', metaDataService.etFacility)
      profile {
        if (params.name)
          ilike('fullName', "%" + params.name + "%")
        order(params.sort, params.order)
      }
    }

    int totalResults = results.size()
    int upperBound = params.offset + params.max < totalResults ? params.offset + params.max : totalResults
    results = results.subList(params.offset, upperBound)

    render template: '/templates/searchresults', model: [results: results, totalResults: totalResults, type: 'facility', params: params]
  }
}
