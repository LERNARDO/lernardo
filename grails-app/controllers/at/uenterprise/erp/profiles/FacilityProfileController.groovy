package at.uenterprise.erp.profiles

import at.openfactory.ep.Entity
import at.openfactory.ep.EntityType
import at.openfactory.ep.Link
import at.openfactory.ep.EntityHelperService
import at.openfactory.ep.ProfileHelperService
import at.uenterprise.erp.Contact
import at.uenterprise.erp.FunctionService
import at.uenterprise.erp.MetaDataService
import at.openfactory.ep.Profile
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
    params.offset = params.int('offset') ?: 0
    params.max = Math.min(params.int('max') ?: 15, 100)
    params.sort = params.sort ?: "fullName"
    params.order = params.order ?: "asc"

    EntityType etFacility = metaDataService.etFacility
    def facilities = Entity.createCriteria().list {
      eq("type", etFacility)
      profile {
        order(params.sort, params.order)
      }
      maxResults(params.max)
      firstResult(params.offset)
    }
    int totalFacilities = Entity.countByType(etFacility)

    return [facilities: facilities, totalFacilities: totalFacilities]
  }

  def show = {
    Entity facility = Entity.get(params.id)
    Entity entity = params.entity ? facility : entityHelperService.loggedIn

    if (!facility) {
      flash.message = message(code: "object.notFound", args: [message(code: "facility")])
      redirect(action: list)
      return
    }

    // find all resources of this facility
    List resources = functionService.findAllByLink(null, facility, metaDataService.ltResource)

    def allEducators = Entity.findAllByType(metaDataService.etEducator).findAll {it.user.enabled}
    // find all educators of this facility
    List educators = functionService.findAllByLink(null, facility, metaDataService.ltWorking)

    // find lead educators
    List leadEducators = functionService.findAllByLink(null, facility, metaDataService.ltLeadEducator)

    def allClientGroups = Entity.findAllByType(metaDataService.etGroupClient)
    // find all clients linked to the facility
    List clients = functionService.findAllByLink(null, facility, metaDataService.ltGroupMemberClient)

    // find colony of this facility
    Entity colony = functionService.findByLink(facility, null, metaDataService.ltGroupMemberFacility)

    return [facility: facility,
            entity: entity,
            allEducators: allEducators,
            educators: educators,
            allClientGroups: allClientGroups,
            clients: clients,
            resources: resources,
            colony: colony,
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
      redirect action: 'show', id: facility.id, params: [entity: facility.id]
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
      redirect action: 'show', id: entity.id, params: [entity: entity.id]
    } catch (at.openfactory.ep.EntityException ee) {
      render(view: "create", model: [facility: ee.entity, allColonies: Entity.findAllByType(metaDataService.etGroupColony)])
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

    // find all resources of this facility
    List resources = functionService.findAllByLink(null, facility, metaDataService.ltResource)

    render template: 'resources', model: [resources: resources, facility: facility, entity: entityHelperService.loggedIn]
  }

  def removeResource = {
    Entity facility = Entity.get(params.id)

    def c = Link.createCriteria()
    def link = c.get {
      eq('source', Entity.get(params.resource))
      eq('target', facility)
      eq('type', metaDataService.ltResource)
    }
    link.delete()

    // delete resource as well
    Entity.get(params.resource).delete()

    // find all resources of this facility
    List resources = functionService.findAllByLink(null, facility, metaDataService.ltResource)

    render template: 'resources', model: [resources: resources, facility: facility, entity: entityHelperService.loggedIn]
  }

  def addEducator = {
    def linking = functionService.linkEntities(params.educator, params.id, metaDataService.ltWorking)
    if (linking.duplicate)
      render '<span class="red italic">"' + linking.source.profile.fullName+'" '+message(code: "alreadyAssignedTo")+'</span>'
    render template: 'educators', model: [educators: linking.results, facility: linking.target, entity: entityHelperService.loggedIn]
  }

  def removeEducator = {
    def breaking = functionService.breakEntities(params.educator, params.id, metaDataService.ltWorking)
    render template: 'educators', model: [educators: breaking.results, facility: breaking.target, entity: entityHelperService.loggedIn]
  }

  def addLeadEducator = {
    def linking = functionService.linkEntities(params.leadeducator, params.id, metaDataService.ltLeadEducator)
    if (linking.duplicate)
      render '<span class="red italic">"' + linking.source.profile.fullName+'" '+message(code: "alreadyAssignedTo")+'</span>'
    render template: 'leadeducators', model: [leadeducators: linking.results, facility: linking.target, entity: entityHelperService.loggedIn]
  }

  def removeLeadEducator = {
    def breaking = functionService.breakEntities(params.leadeducator, params.id, metaDataService.ltLeadEducator)
    render template: 'leadeducators', model: [leadeducators: breaking.results, facility: breaking.target, entity: entityHelperService.loggedIn]
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
      render template: 'clients', model: [clients: linking.results, facility: linking.target, entity: entityHelperService.loggedIn]
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
      render template: 'clients', model: [clients: clients2, facility: facility, entity: entityHelperService.loggedIn]
    }


    /*// find all clients linked to the clientgroup
    List clients = functionService.findAllByLink(null, clientgroup, metaDataService.ltGroupMemberClient)

    // link each client to the facility now
    clients.each { Entity client ->
      def c = Link.createCriteria()
      def link = c.get {
        eq('source', client)
        eq('target', facility)
        eq('type', metaDataService.ltGroupMemberClient)
      }
      if (!link)
        new Link(source: client, target: facility, type: metaDataService.ltGroupMemberClient).save()
    }

    // find all clients of this facility
    clients = functionService.findAllByLink(null, facility, metaDataService.ltGroupMemberClient)

    render template: 'clients', model: [clients: clients, facility: facility, entity: entityHelperService.loggedIn]*/
  }

  def removeClient = {
    Entity facility = Entity.get(params.id)
    Entity client = Entity.get(params.client)

    def c = Link.createCriteria()
    def link = c.get {
      eq('source', client)
      eq('target', facility)
      eq('type', metaDataService.ltGroupMemberClient)
    }
    link?.delete()

    Attendance.findByClientAndFacility(client, facility)?.delete()

    // find all clients of this facility
    List clients = functionService.findAllByLink(null, facility, metaDataService.ltGroupMemberClient)

    render template: 'clients', model: [clients: clients, facility: facility, entity: entityHelperService.loggedIn]
  }

  def addContact = {ContactCommand cc ->
    Entity facility = Entity.get(params.id)
    if (cc.hasErrors()) {
      render '<p class="italic red">'+message(code: "facility.profile.name.insert")+'</p>'
      render template: 'contacts', model: [facility: facility, entity: entityHelperService.loggedIn]
      return
    }
    else {
      Contact contact = new Contact(params)
      facility.profile.addToContacts(contact)
      render template: 'contacts', model: [facility: facility, entity: entityHelperService.loggedIn]
    }
  }

  def removeContact = {
    Entity facility = Entity.get(params.id)
    facility.profile.removeFromContacts(Contact.get(params.contact))
    Contact.get(params.contact).delete()
    render template: 'contacts', model: [facility: facility, entity: entityHelperService.loggedIn]
  }

  def editContact = {
    Entity facility = Entity.get(params.id)
    Contact contact = Contact.get(params.contact)
    render template: 'editcontact', model: [facility: facility, representative: contact, entity: entityHelperService.loggedIn]
  }

  def updateContact = {
    Entity facility = Entity.get(params.id)
    Contact contact = Contact.get(params.representative)
    contact.properties = params
    render template: 'contacts', model: [facility: facility, entity: entityHelperService.loggedIn]
  }

  /*
   * retrieves all educators matching the search parameter
   */
  def remoteEducators = {
    if (!params.value) {
      render ""
      return
    }

    def c = Entity.createCriteria()
    def results = c.list {
      eq('type', metaDataService.etEducator)
      user {
        eq("enabled", true)
      }
      or {
        ilike('name', "%" + params.value + "%")
        profile {
          ilike('fullName', "%" + params.value + "%")
        }
      }
      maxResults(15)
    }

    if (results.size() == 0) {
      render '<span class="italic">'+message(code:'noResultsFound')+'</span>'
      return
    }
    else {
      render(template: 'educatorresults', model: [results: results, facility: params.id])
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

    def c = Entity.createCriteria()
    def results = c.list {
      eq('type', metaDataService.etEducator)
      user {
        eq("enabled", true)
      }
      or {
        ilike('name', "%" + params.value + "%")
        profile {
          ilike('fullName', "%" + params.value + "%")
        }
      }
      maxResults(15)
    }

    if (results.size() == 0) {
      render '<span class="italic">'+message(code:'noResultsFound')+'</span>'
      return
    }
    else {
      render(template: 'leadeducatorresults', model: [results: results, facility: params.id])
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

    def c = Entity.createCriteria()
    def results = c.list {
      or {
        eq('type', metaDataService.etClient)
        eq('type', metaDataService.etGroupClient)
      }
      or {
        ilike('name', "%" + params.value + "%")
        profile {
          ilike('fullName', "%" + params.value + "%")
        }
      }
      maxResults(15)
    }

    if (results.size() == 0) {
      render '<span class="italic">'+message(code:'noResultsFound')+'</span>'
      return
    }
    else {
      render(template: 'clientresults', model: [results: results, facility: params.id])
    }
  }
}
