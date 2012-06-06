package at.uenterprise.erp.profiles

import at.uenterprise.erp.MetaDataService
import at.uenterprise.erp.base.EntityHelperService
import at.uenterprise.erp.FunctionService
import at.uenterprise.erp.base.Entity
import at.uenterprise.erp.base.EntityType
import at.uenterprise.erp.Contact
import at.uenterprise.erp.base.Link
import at.uenterprise.erp.Folder
import at.uenterprise.erp.FolderType

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
    params.offset = params.int('offset') ?: 0
    params.max = Math.min(params.int('max') ?: 15, 100)
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

    if (!partner) {
      flash.message = message(code: "object.notFound", args: [message(code: "partner")])
      redirect(action: list)
      return
    }

    Entity colony = functionService.findByLink(null, partner, metaDataService.ltColonia)

    return [partner: partner, colony: colony]

  }

  def delete = {
    Entity partner = Entity.get(params.id)
    if (partner) {
      functionService.deleteReferences(partner)
      try {
        flash.message = message(code: "object.deleted", args: [message(code: "partner"), partner.profile.fullName])
        partner.delete(flush: true)
        redirect(action: "list")
      }
      catch (org.springframework.dao.DataIntegrityViolationException e) {
        flash.message = message(code: "object.notDeleted", args: [message(code: "partner"), partner.profile.fullName])
        redirect(action: "show", id: params.id)
      }
    }
    else {
      flash.message = message(code: "object.notFound", args: [message(code: "partner")])
      redirect(action: "list")
    }
  }

  def edit = {
    Entity partner = Entity.get(params.id)

    if (!partner) {
      flash.message = message(code: "object.notFound", args: [message(code: "partner")])
      redirect action: 'list'
      return
    }

    Entity colony = functionService.findByLink(null, partner, metaDataService.ltColonia)

    params.sort = params.sort ?: "fullName"
    params.order = params.order ?: "asc"

    def allColonies = Entity.createCriteria().list {
      eq("type", metaDataService.etGroupColony)
      profile {
        order(params.sort, params.order)
      }
    }

    return [partner: partner, colony: colony, allColonies: allColonies]

  }

  def update = {
    Entity partner = Entity.get(params.id)

    partner.profile.properties = params
    partner.user.properties = params

    // update link to colony
    Link.findByTargetAndType(partner, metaDataService.ltColonia)?.delete()
    new Link(source: Entity.get(params.currentColony), target: partner, type: metaDataService.ltColonia).save()

    //if (partner.id == entityHelperService.loggedIn.id)
    //  RequestContextUtils.getLocaleResolver(request).setLocale(request, response, partner.user.locale)

    if (partner.profile.save() && partner.user.save() && partner.save()) {
      flash.message = message(code: "object.updated", args: [message(code: "partner"), partner.profile.fullName])
      redirect action: 'show', id: partner.id
    }
    else {
      params.sort = params.sort ?: "fullName"
      params.order = params.order ?: "asc"
      Entity colony = functionService.findByLink(null, partner, metaDataService.ltColonia)

      def allColonies = Entity.createCriteria().list {
        eq("type", metaDataService.etGroupColony)
        profile {
          order(params.sort, params.order)
        }
      }
      render view: 'edit', model: [partner: partner, colony: colony, allColonies: allColonies]
    }
  }

  def create = {
    params.sort = params.sort ?: "fullName"
    params.order = params.order ?: "asc"

    def allColonies = Entity.createCriteria().list {
      eq("type", metaDataService.etGroupColony)
      profile {
        order(params.sort, params.order)
      }
    }

    [allColonies: allColonies]
  }

  def save = {
    EntityType etPartner = metaDataService.etPartner

    try {
      Entity entity = entityHelperService.createEntityWithUserAndProfile(functionService.createNick(params.fullName), etPartner, params.email, params.fullName) {Entity ent ->
        ent.profile.properties = params
        ent.user.properties = params
        ent.user.password = securityManager.encodePassword(grailsApplication.config.defaultpass)
        ent.profile.favoritesFolder = new Folder(name: "root", type: FolderType.findByName("favorite")).save()
      }

      // create link to colony
      new Link(source: Entity.get(params.currentColony), target: entity, type: metaDataService.ltColonia).save()

      flash.message = message(code: "object.created", args: [message(code: "partner"), entity.profile.fullName])
      redirect action: 'show', id: entity.id
    } catch (at.uenterprise.erp.base.EntityException ee) {
      params.sort = params.sort ?: "fullName"
      params.order = params.order ?: "asc"

      def allColonies = Entity.createCriteria().list {
        eq("type", metaDataService.etGroupColony)
        profile {
          order(params.sort, params.order)
        }
      }
      render view: "create", model: [partner: ee.entity, allColonies: allColonies]
    }

  }

  def addService = {
    String service = params.service
    Entity partner = Entity.get(params.id)
    partner.profile.addToServices(service)
    render template: 'services', model: [partner: partner]
  }

  def removeService = {
    Entity partner = Entity.get(params.id)
    partner.profile.services.remove(params.service)
    render template: 'services', model: [partner: partner]
  }

  def addContact = {ContactCommand cc ->
    Entity partner = Entity.get(params.id)
    if (cc.hasErrors()) {
      render '<p class="italic red">'+message(code: "object.notCreated", args: [message(code: "partner.profile.contact")])+ '</p>'
      render template: 'contacts', model: [partner: partner]
      return
    }
    Contact contact = new Contact(params)
    partner.profile.addToContacts(contact)
    render template: 'contacts', model: [partner: partner]
  }

  def removeContact = {
    Entity partner = Entity.get(params.id)
    partner.profile.removeFromContacts(Contact.get(params.contact))
    Contact.get(params.contact).delete()
    render template: 'contacts', model: [partner: partner]
  }

  def editContact = {
    Entity partner = Entity.get(params.id)
    Contact contact = Contact.get(params.contact)
    render template: 'editcontact', model: [partner: partner, representative: contact]
  }

  def updateContact = {
    Entity partner = Entity.get(params.id)
    Contact contact = Contact.get(params.representative)
    contact.properties = params
    render template: 'contacts', model: [partner: partner]
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