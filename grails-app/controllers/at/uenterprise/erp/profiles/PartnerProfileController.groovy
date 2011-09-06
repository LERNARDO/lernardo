package at.uenterprise.erp.profiles

import at.uenterprise.erp.MetaDataService
import at.openfactory.ep.EntityHelperService
import at.uenterprise.erp.FunctionService
import at.openfactory.ep.Entity
import at.openfactory.ep.Link
import at.uenterprise.erp.Msg
import at.uenterprise.erp.Publication
import org.springframework.web.servlet.support.RequestContextUtils
import at.openfactory.ep.EntityType

import at.uenterprise.erp.Contact
import at.uenterprise.erp.ECalendar
import at.uenterprise.erp.Comment
import at.uenterprise.erp.Evaluation

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

    EntityType etPartner = metaDataService.etPartner
    def partners = Entity.createCriteria().list {
      eq("type", etPartner)
      profile {
        order(params.sort, params.order)
      }
      maxResults(params.max)
      firstResult(params.offset)
    }
    int totalPartners = Entity.countByType(etPartner)

    return [partners: partners, totalPartners: totalPartners]
  }

  def show = {
    Entity partner = Entity.get(params.id)
    Entity entity = params.entity ? partner : entityHelperService.loggedIn

    if (!partner) {
      flash.message = message(code: "partner.idNotFound", args: [params.id])
      redirect(action: list)
      return
    }

    return [partner: partner, entity: entity]

  }

  def delete = {
    Entity partner = Entity.get(params.id)
    if (partner) {
      // delete all links
      Link.findAllBySourceOrTarget(partner, partner).each {it.delete()}
      Msg.findAllBySenderOrReceiver(partner, partner).each {it.delete()}
      Publication.findAllByEntity(partner).each {it.delete()}
      Evaluation.findByOwnerOrWriter(partner, partner).each {it.delete()}
      Comment.findAllByCreator(partner.id.toInteger()).each { Comment comment ->
          // find the profile the comment belongs to and delete it from there
          def c = Entity.createCriteria()
          List entities = c.list {
              or {
                eq("type", metaDataService.etActivity)
                eq("type", metaDataService.etGroupActivity)
                eq("type", metaDataService.etGroupActivityTemplate)
                eq("type", metaDataService.etProject)
                eq("type", metaDataService.etProjectTemplate)
                eq("type", metaDataService.etTemplate)
              }
          }
          entities.each { Entity entity ->
              Comment profileComment = entity?.profile?.comments?.find {it.id == comment.id} as Comment
              if (profileComment)
                entity.profile.removeFromComments(profileComment)
          }
      }
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
      flash.message = message(code: "partner.idNotFound", args: [params.id])
      redirect(action: "list")
    }
  }

  def edit = {
    Entity partner = Entity.get(params.id)

    if (!partner) {
      flash.message = message(code: "partner.idNotFound", args: [params.id])
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
      flash.message = message(code: "partner.updated", args: [partner.profile.fullName])
      redirect action: 'show', id: partner.id, params: [entity: partner.id]
    }
    else {
      render view: 'edit', model: [partner: partner]
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

      flash.message = message(code: "partner.created", args: [entity.profile.fullName])
      redirect action: 'show', id: entity.id, params: [entity: entity.id]
    } catch (at.openfactory.ep.EntityException ee) {
      render(view: "create", model: [partner: ee.entity])
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
      //render '<p class="italic red">Bitte Vor- und Nachname angeben!</p>'
      render '<p class="italic red">'+message(code: "partner.profile.name.insert")+'</p>'
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
  String country
  String zip
  String city
  String street
  String phone
  String email
  String function

  static constraints = {
    firstName blank: false, size: 2..50
    lastName  blank: false, size: 2..50
    country   size: 2..50
    zip       size: 4..10
    city      size: 2..50
    street    size: 2..50
    phone     size: 2..20
    email     size: 2..20
    function  size: 2..50
  }

}