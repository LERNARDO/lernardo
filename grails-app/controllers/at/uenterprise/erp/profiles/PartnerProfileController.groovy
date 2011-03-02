package at.uenterprise.erp.profiles

import at.uenterprise.erp.MetaDataService
import at.openfactory.ep.EntityHelperService
import at.uenterprise.erp.FunctionService
import at.openfactory.ep.Entity
import at.openfactory.ep.Link
import at.uenterprise.erp.Msg
import at.uenterprise.erp.Event
import at.uenterprise.erp.Publication
import org.springframework.web.servlet.support.RequestContextUtils
import at.openfactory.ep.EntityType

import at.uenterprise.erp.Contact
import at.uenterprise.erp.ECalendar

class PartnerProfileController {

  MetaDataService metaDataService
  EntityHelperService entityHelperService
  def securityManager
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
    def partners = c.list (max: params.max, offset: params.offset) {
      eq("type", metaDataService.etPartner)
      profile {
        order(params.sort, params.order)
      }
    }

    return [partners: partners]
  }

  def show = {
    Entity partner = Entity.get(params.id)
    Entity entity = params.entity ? partner : entityHelperService.loggedIn

    if (!partner) {
      flash.message = "PartnerProfile not found with id ${params.id}"
      redirect(action: list)
      return
    }

    // AAZ (01.09.2010): not required anymore by customer
    // find colonia of this partner
    //Entity colony = functionService.findByLink(partner, null, metaDataService.ltGroupMemberPartner)

    return [partner: partner, entity: entity/*, colony: colony*/]

  }

  def del = {
    Entity partner = Entity.get(params.id)
    if (partner) {
      // delete all links
      Link.findAllBySourceOrTarget(partner, partner).each {it.delete()}
      Msg.findAllByEntity(partner).each {it.delete()}
      Event.findAllByEntity(partner).each {it.delete()}
      Publication.findAllByEntity(partner).each {it.delete()}
      try {
        flash.message = message(code: "partner.deleted", args: [partner.profile.fullName])
        partner.delete(flush: true)
        redirect(action: "list")
      }
      catch (org.springframework.dao.DataIntegrityViolationException e) {
        flash.message = message(code: "partner.notDeleted", args: [partner.profile.fullName])
        redirect(action: "show", id: params.id)
      }
    }
    else {
      flash.message = "PartnerProfile not found with id ${params.id}"
      redirect(action: "list")
    }
  }

  def edit = {
    Entity partner = Entity.get(params.id)

    if (!partner) {
      flash.message = "PartnerProfile not found with id ${params.id}"
      redirect action: 'list'
      return
    }

    return [partner: partner, allColonias: Entity.findAllByType(metaDataService.etGroupColony)]

  }

  def update = {
    Entity partner = Entity.get(params.id)

    partner.profile.properties = params
    partner.user.properties = params

    if (!partner.profile.calendar) partner.profile.calendar = new ECalendar().save()

    if (partner.id == entityHelperService.loggedIn.id)
      RequestContextUtils.getLocaleResolver(request).setLocale(request, response, partner.user.locale)

    if (partner.profile.save() && partner.user.save() && partner.save()) {

      // AAZ (01.09.2010): not required anymore by customer
      /*// delete current link
      def c = Link.createCriteria()
      def link = c.get {
        eq('source', partner)
        eq('target', Entity.get(params.colonia))
        eq('type', metaDataService.ltGroupMemberPartner)
      }
      if (link)
        link.delete()

      // link facility to colonia
      new Link(source: partner, target: Entity.get(params.colonia), type: metaDataService.ltGroupMemberPartner).save()*/

      flash.message = message(code: "partner.updated", args: [partner.profile.fullName])
      redirect action: 'show', id: partner.id
    }
    else {
      render view: 'edit', model: [partner: partner/*, allColonias: Entity.findAllByType(metaDataService.etGroupColony)*/]
    }
  }

  def create = {
    return [allColonias: Entity.findAllByType(metaDataService.etGroupColony)]
  }

  def save = {
    EntityType etPartner = metaDataService.etPartner

    try {
      Entity entity = entityHelperService.createEntityWithUserAndProfile(functionService.createNick(params.fullName), etPartner, params.email, params.fullName) {Entity ent ->
        ent.profile.properties = params
        ent.user.properties = params
        ent.user.password = securityManager.encodePassword(grailsApplication.config.defaultpass)
        ent.profile.calendar = new ECalendar().save()
      }
      //RequestContextUtils.getLocaleResolver(request).setLocale(request, response, entity.user.locale)

      // AAZ (01.09.2010): not required anymore by customer
      // link partner to colonia
      //new Link(source: entity, target: Entity.get(params.colonia), type: metaDataService.ltGroupMemberPartner).save()

      flash.message = message(code: "partner.created", args: [entity.profile.fullName])
      redirect action: 'show', id: entity.id
    } catch (at.openfactory.ep.EntityException ee) {
      render(view: "create", model: [partner: ee.entity/*, allColonias: Entity.findAllByType(metaDataService.etGroupColony)*/])
    }

  }

  def addService = {
    String service = params.service
    Entity partner = Entity.get(params.id)
    partner.profile.addToServices(service)
    render template: 'services', model: [partner: partner, entity: entityHelperService.loggedIn]
  }

  def removeService = {
    Entity partner = Entity.get(params.id)
    partner.profile.services.remove(params.service)
    render template: 'services', model: [partner: partner, entity: entityHelperService.loggedIn]
  }

  def addContact = {ContactCommand cc ->
    Entity partner = Entity.get(params.id)
    if (cc.hasErrors()) {
      render '<p class="italic red">Bitte Vor- und Nachname angeben!</p>'
      render template: 'contacts', model: [partner: partner, entity: entityHelperService.loggedIn]
      return
    }
    Contact contact = new Contact(params)
    partner.profile.addToContacts(contact)
    render template: 'contacts', model: [partner: partner, entity: entityHelperService.loggedIn]
  }

  def removeContact = {
    Entity partner = Entity.get(params.id)
    partner.profile.removeFromContacts(Contact.get(params.contact))
    Contact.get(params.contact).delete()
    render template: 'contacts', model: [partner: partner, entity: entityHelperService.loggedIn]
  }

  def editContact = {
    Entity partner = Entity.get(params.id)
    Contact contact = Contact.get(params.contact)
    render template: 'editcontact', model: [partner: partner, representative: contact, entity: entityHelperService.loggedIn]
  }

  def updateContact = {
    Entity partner = Entity.get(params.id)
    Contact contact = Contact.get(params.representative)
    contact.properties = params
    render template: 'contacts', model: [partner: partner, entity: entityHelperService.loggedIn]
  }
}

class ContactCommand {
  String firstName
  String lastName

  static constraints = {
    firstName(blank: false, maxSize: 50)
    lastName(blank: false, maxSize: 50)
  }

}