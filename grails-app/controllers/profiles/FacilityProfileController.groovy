package profiles

import at.openfactory.ep.Entity
import at.openfactory.ep.EntityType
import at.openfactory.ep.Link
import org.springframework.web.servlet.support.RequestContextUtils
import at.openfactory.ep.EntityHelperService
import lernardo.Contact
import standard.FunctionService
import standard.MetaDataService
import at.openfactory.ep.Profile

class FacilityProfileController {
  MetaDataService metaDataService
  EntityHelperService entityHelperService
  FunctionService functionService
  def securityManager

  def index = {
    redirect action: "list", params: params
  }

  // the delete, save and update actions only accept POST requests
  static allowedMethods = [delete: 'POST', save: 'POST', update: 'POST']

  def list = {
    params.max = Math.min(params.max ? params.int('max') : 10, 100)
    return [facilities: Entity.findAllByType(metaDataService.etFacility),
            facilityTotal: Entity.countByType(metaDataService.etFacility),
            entity: entityHelperService.loggedIn]
  }

  def show = {
    Entity facility = Entity.get(params.id)
    Entity entity = params.entity ? facility : entityHelperService.loggedIn

    if (!facility) {
      flash.message = "FacilityProfile not found with id ${params.id}"
      redirect(action: list)
    }
    else {
      // find all resources of this facility
      def links = Link.findAllByTargetAndType(facility, metaDataService.ltResource)
      List resources = links.collect {it.source}

      def allEducators = Entity.findAllByType(metaDataService.etEducator)
      // find all educators of this facility
      links = Link.findAllByTargetAndType(facility, metaDataService.ltWorking)
      List educators = links.collect {it.source}

      // find lead educator
      def link = Link.findByTargetAndType(facility, metaDataService.ltLeadEducator)
      Entity leadEducator = link?.source

      def allClientGroups = Entity.findAllByType(metaDataService.etGroupClient)
      // find all clients linked to the facility
      links = Link.findAllByTargetAndType(facility, metaDataService.ltGroupMemberClient)
      List clients = links.collect {it.source}

      // find colonia of this facility
      link = Link.findBySourceAndType(facility, metaDataService.ltGroupMemberFacility)
      Entity colony = link?.target

      return [facility: facility,
              entity: entity,
              allEducators: allEducators,
              educators: educators,
              allClientGroups: allClientGroups,
              clients: clients,
              resources: resources,
              colony: colony,
              leadeducator: leadEducator]
    }
  }

  def del = {
    Entity facility = Entity.get(params.id)
    if (facility) {
      // delete all links
      Link.findAllBySourceOrTarget(facility, facility).each {it.delete()}
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
    }
    else {
      return [facility: facility, entity: entityHelperService.loggedIn, allColonias: Entity.findAllByType(metaDataService.etGroupColony)]
    }
  }

  def update = {
    Entity facility = Entity.get(params.id)

    facility.profile.properties = params
    facility.user.properties = params
    RequestContextUtils.getLocaleResolver(request).setLocale(request, response, facility.user.locale)

    if (!facility.hasErrors() && facility.save()) {

      // delete current link
      def link = Link.findBySourceAndType(facility, metaDataService.ltGroupMemberFacility)
      /*def c = Link.createCriteria()
      def link = c.get {
        eq('source', facility)
        eq('target', Entity.get(params.colonia))
        eq('type', metaDataService.ltGroupMemberFacility)
      }*/
      if (link)
        link.delete()

      // link facility to colonia
      new Link(source: facility, target: Entity.get(params.colonia), type: metaDataService.ltGroupMemberFacility).save()

      flash.message = message(code: "facility.updated", args: [facility.profile.fullName])
      redirect action: 'show', id: facility.id
    }
    else {
      render view: 'edit', model: [facility: facility, entity: entityHelperService.loggedIn, allColonias: Entity.findAllByType(metaDataService.etGroupColony)]
    }
  }

  def create = {
    return [entity: entityHelperService.loggedIn, allColonias: Entity.findAllByType(metaDataService.etGroupColony)]
  }

  def save = {
    EntityType etFacility = metaDataService.etFacility

    try {
      Entity entity = entityHelperService.createEntityWithUserAndProfile(functionService.createNick(params.fullName), etFacility, params.email, params.fullName) {Entity ent ->
        ent.profile.properties = params
        ent.user.properties = params
        ent.user.password = securityManager.encodePassword(grailsApplication.config.defaultpass)
      }
      RequestContextUtils.getLocaleResolver(request).setLocale(request, response, entity.user.locale)

      // link facility to colonia
      new Link(source: entity, target: Entity.get(params.colonia), type: metaDataService.ltGroupMemberFacility).save()

      flash.message = message(code: "facility.created", args: [entity.profile.fullName])
      redirect action: 'list'
    } catch (at.openfactory.ep.EntityException ee) {
      render(view: "create", model: [facility: ee.entity, entity: entityHelperService.loggedIn, allColonias: Entity.findAllByType(metaDataService.etGroupColony)])
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
    def links = Link.findAllByTargetAndType(facility, metaDataService.ltResource)
    List resources = links.collect {it.source}

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
    def links = Link.findAllByTargetAndType(facility, metaDataService.ltResource)
    List resources = links.collect {it.source}

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
    render template: 'leadeducator', model: [leadeducator: linking.results, facility: linking.target, entity: entityHelperService.loggedIn]
  }

  def removeLeadEducator = {
    def breaking = functionService.breakEntities(params.leadeducator, params.id, metaDataService.ltLeadEducator)
    render template: 'leadeducator', model: [leadeducator: breaking.results, facility: breaking.target, entity: entityHelperService.loggedIn]
  }

  def addClients = {
    Entity facility = Entity.get(params.id)
    Entity clientgroup = Entity.get(params.clientgroup)

    // find all clients linked to the clientgroup
    def links = Link.findAllByTargetAndType(clientgroup, metaDataService.ltGroupMemberClient)
    List clients = links.collect {it.source}

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
    links = Link.findAllByTargetAndType(facility, metaDataService.ltGroupMemberClient)
    clients = links.collect {it.source}

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
    def links = Link.findAllByTargetAndType(facility, metaDataService.ltGroupMemberClient)
    List clients = links.collect {it.source}

    render template: 'clients', model: [clients: clients, facility: facility, entity: entityHelperService.loggedIn]
  }

  def addContact = {
    Contact contact = new Contact()
    contact.properties = params
    Entity facility = Entity.get(params.id)
    facility.profile.addToContacts(contact)
    render template: 'contacts', model: [facility: facility, entity: entityHelperService.loggedIn]
  }

  def removeContact = {
    Entity facility = Entity.get(params.id)
    facility.profile.removeFromContacts(Contact.get(params.contact))
    Contact.get(params.contact).delete()
    render template: 'contacts', model: [facility: facility, entity: entityHelperService.loggedIn]
  }
}
