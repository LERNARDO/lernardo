package profiles

import at.openfactory.ep.Entity
import at.openfactory.ep.EntityType
import at.openfactory.ep.Link
import org.springframework.web.servlet.support.RequestContextUtils
import at.openfactory.ep.EntityHelperService
import at.openfactory.ep.ProfileHelperService
import lernardo.Contact
import standard.FunctionService
import standard.MetaDataService
import at.openfactory.ep.Profile
import lernardo.Msg
import lernardo.Event
import lernardo.Publication

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
    params.offset = params.offset ? params.int('offset') : 0
    params.max = Math.min(params.max ? params.int('max') : 15, 100)
    params.sort = params.sort ?: "fullName"
    params.order = params.order ?: "asc"

    def c = Entity.createCriteria()
    def facilities = c.list {
      eq("type", metaDataService.etFacility)
      profile {
        order(params.sort, params.order)
      }
      maxResults(params.max)
      firstResult(params.offset)
    }

    return [facilities: facilities,
            facilityTotal: Entity.countByType(metaDataService.etFacility)]
  }

  def show = {
    Entity facility = Entity.get(params.id)
    Entity entity = params.entity ? facility : entityHelperService.loggedIn

    if (!facility) {
      flash.message = "FacilityProfile not found with id ${params.id}"
      redirect(action: list)
      return
    }

    // find all resources of this facility
    List resources = functionService.findAllByLink(null, facility, metaDataService.ltResource)

    def allEducators = Entity.findAllByType(metaDataService.etEducator)
    // find all educators of this facility
    List educators = functionService.findAllByLink(null, facility, metaDataService.ltWorking)

    // find lead educators
    List leadEducators = functionService.findAllByLink(null, facility, metaDataService.ltLeadEducator)

    def allClientGroups = Entity.findAllByType(metaDataService.etGroupClient)
    // find all clients linked to the facility
    List clients = functionService.findAllByLink(null, facility, metaDataService.ltGroupMemberClient)

    // find colonia of this facility
    List entities = functionService.findAllByLink(facility, null, metaDataService.ltGroupMemberFacility)
    Entity colony
    entities.each {
      if (it.type.id == metaDataService.etColonia.id) {
        colony = it as Entity
      }
    }

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

  def del = {
    Entity facility = Entity.get(params.id)
    if (facility) {
      // delete all links
      Link.findAllBySourceOrTarget(facility, facility).each {it.delete()}
      Msg.findAllByEntity(facility).each {it.delete()}
      Event.findAllByEntity(facility).each {it.delete()}
      Publication.findAllByEntity(facility).each {it.delete()}
      try {
        flash.message = message(code: "facility.deleted", args: [facility.profile.fullName])
        facility.delete(flush: true)
        redirect(action: "list")
      }
      catch (org.springframework.dao.DataIntegrityViolationException e) {
        flash.message = message(code: "facility.notDeleted", args: [facility.profile.fullName])
        redirect(action: "show", id: params.id)
      }
    }
    else {
      flash.message = "FacilityProfile not found with id ${params.id}"
      redirect(action: "list")
    }
  }

  def edit = {
    Entity facility = Entity.get(params.id)

    if (!facility) {
      flash.message = "FacilityProfile not found with id ${params.id}"
      redirect action: 'list'
      return
    }

    return [facility: facility, allColonias: Entity.findAllByType(metaDataService.etGroupColony)]
    
  }

  def update = {
    Entity facility = Entity.get(params.id)

    facility.profile.properties = params
    facility.user.properties = params
    if (facility.id == entityHelperService.loggedIn.id)
      RequestContextUtils.getLocaleResolver(request).setLocale(request, response, facility.user.locale)

    if (!facility.hasErrors() && facility.save()) {

      // delete previously linked colonia
      Link.findBySourceAndType(facility, metaDataService.ltGroupMemberFacility)?.delete()

      // link new colonia to facility
      new Link(source: facility, target: Entity.get(params.colonia), type: metaDataService.ltGroupMemberFacility).save()

      flash.message = message(code: "facility.updated", args: [facility.profile.fullName])
      redirect action: 'show', id: facility.id
    }
    else {
      render view: 'edit', model: [facility: facility, allColonias: Entity.findAllByType(metaDataService.etGroupColony)]
    }
  }

  def create = {
    return [allColonias: Entity.findAllByType(metaDataService.etGroupColony)]
  }

  def save = {
    EntityType etFacility = metaDataService.etFacility

    try {
      Entity entity = entityHelperService.createEntityWithUserAndProfile(functionService.createNick(params.fullName), etFacility, params.email, params.fullName) {Entity ent ->
        ent.profile.properties = params
        ent.user.properties = params
        // override - facilities are always disabled for login
        ent.user.enabled = false
        ent.user.password = securityManager.encodePassword(grailsApplication.config.defaultpass)
      }
      //RequestContextUtils.getLocaleResolver(request).setLocale(request, response, entity.user.locale)

      // link facility to colonia
      new Link(source: entity, target: Entity.get(params.colonia), type: metaDataService.ltGroupMemberFacility).save()

      flash.message = message(code: "facility.created", args: [entity.profile.fullName])
      redirect action: 'show', id: entity.id
    } catch (at.openfactory.ep.EntityException ee) {
      render(view: "create", model: [facility: ee.entity, allColonias: Entity.findAllByType(metaDataService.etGroupColony)])
      return
    }

  }

  def addResource = {
    Entity facility = Entity.get(params.id)

    EntityType etResource = metaDataService.etResource

    Entity entity = entityHelperService.createEntity("resource", etResource) {Entity ent ->
      ent.profile = profileHelperService.createProfileFor(ent) as Profile
      ent.profile.properties = params
      ent.profile.type = "planbar"
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
      render '<span class="red italic">"' + linking.source.profile.fullName + '" wurde bereits zugewiesen!</span>'
    render template: 'educators', model: [educators: linking.results, facility: linking.target, entity: entityHelperService.loggedIn]
  }

  def removeEducator = {
    def breaking = functionService.breakEntities(params.educator, params.id, metaDataService.ltWorking)
    render template: 'educators', model: [educators: breaking.results, facility: breaking.target, entity: entityHelperService.loggedIn]
  }

  def addLeadEducator = {
    def linking = functionService.linkEntities(params.leadeducator, params.id, metaDataService.ltLeadEducator)
    if (linking.duplicate)
      render '<span class="red italic">"' + linking.source.profile.fullName + '" wurde bereits zugewiesen!</span>'
    render template: 'leadeducators', model: [leadeducators: linking.results, facility: linking.target, entity: entityHelperService.loggedIn]
  }

  def removeLeadEducator = {
    def breaking = functionService.breakEntities(params.leadeducator, params.id, metaDataService.ltLeadEducator)
    render template: 'leadeducators', model: [leadeducators: breaking.results, facility: breaking.target, entity: entityHelperService.loggedIn]
  }

  def addClients = {
    Entity facility = Entity.get(params.id)
    Entity clientgroup = Entity.get(params.clientgroup)

    // find all clients linked to the clientgroup
    List clients = functionService.findAllByLink(null, clientgroup, metaDataService.ltGroupMemberClient)

    // link each client to the facility now
    clients.each { client ->
      def c = Link.createCriteria()
      def link = c.get {
        eq('source', client)
        eq('target', facility)
        eq('type', metaDataService.ltGroupMemberClient)
      }
      if (!link)
        new Link(source: client as Entity, target: facility, type: metaDataService.ltGroupMemberClient).save()
    }

    // find all clients of this facility
    clients = functionService.findAllByLink(null, facility, metaDataService.ltGroupMemberClient)

    render template: 'clients', model: [clients: clients, facility: facility, entity: entityHelperService.loggedIn]
  }

  def removeClient = {
    Entity facility = Entity.get(params.id)

    def c = Link.createCriteria()
    def link = c.get {
      eq('source', Entity.get(params.client))
      eq('target', facility)
      eq('type', metaDataService.ltGroupMemberClient)
    }
    link.delete()

    // find all clients of this facility
    List clients = functionService.findAllByLink(null, facility, metaDataService.ltGroupMemberClient)

    render template: 'clients', model: [clients: clients, facility: facility, entity: entityHelperService.loggedIn]
  }

  def addContact = {ContactCommand cc ->
    Entity facility = Entity.get(params.id)
    if (cc.hasErrors()) {
      render '<p class="italic red">Bitte Vor- und Nachname angeben!</p>'
      render template: 'contacts', model: [facility: facility, entity: entityHelperService.loggedIn]
      return
    }
    Contact contact = new Contact(params)
    facility.profile.addToContacts(contact)
    render template: 'contacts', model: [facility: facility, entity: entityHelperService.loggedIn]
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
      or {
        ilike('name', "%" + params.value + "%")
        profile {
          ilike('fullName', "%" + params.value + "%")
        }
      }
      maxResults(15)
    }

    if (results.size() == 0) {
      render '<span class="italic">Keine Ergebnisse gefunden!</span>'
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
      or {
        ilike('name', "%" + params.value + "%")
        profile {
          ilike('fullName', "%" + params.value + "%")
        }
      }
      maxResults(15)
    }

    if (results.size() == 0) {
      render '<span class="italic">Keine Ergebnisse gefunden!</span>'
      return
    }
    else {
      render(template: 'leadeducatorresults', model: [results: results, facility: params.id])
    }
  }

  /*
   * retrieves all educators matching the search parameter
   */
  def remoteClients = {
    if (!params.value) {
      render ""
      return
    }

    def c = Entity.createCriteria()
    def results = c.list {
      eq('type', metaDataService.etGroupClient)
      or {
        ilike('name', "%" + params.value + "%")
        profile {
          ilike('fullName', "%" + params.value + "%")
        }
      }
      maxResults(15)
    }

    if (results.size() == 0) {
      render '<span class="italic">Keine Ergebnisse gefunden!</span>'
      return
    }
    else {
      render(template: 'clientresults', model: [results: results, facility: params.id])
    }
  }
}
