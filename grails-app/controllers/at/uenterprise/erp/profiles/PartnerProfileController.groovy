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
import at.uenterprise.erp.Setup
import at.uenterprise.erp.EntityDataService
import at.uenterprise.erp.LinkDataService

class PartnerProfileController {

  MetaDataService metaDataService
  EntityHelperService entityHelperService
  def securityManager
  FunctionService functionService
  EntityDataService entityDataService
  LinkDataService linkDataService

  def index = {
    redirect action: "list", params: params
  }

  // the delete, save and update actions only accept POST requests
  static allowedMethods = [delete: 'POST', save: 'POST', update: 'POST']

  def list = {
    int totalPartners = Entity.countByType(metaDataService.etPartner)
    List partnerServices = Setup.list()[0]?.partnerServices

    return [totalPartners: totalPartners, partnerServices: partnerServices]
  }

  def show = {
    Entity partner = Entity.get(params.id)

    if (!partner) {
      flash.message = message(code: "object.notFound", args: [message(code: "partner")])
      redirect(action: list)
      return
    }

    return [partner: partner, ajax: params.ajax, ajaxId: params.ajaxId]

  }

    def management = {
        Entity partner = Entity.get(params.id)

        List grouppartners = functionService.findAllByLink(partner, null, metaDataService.ltGroupMember)

        render template: "management", model: [partner: partner, grouppartners: grouppartners]

    }

  def delete = {
    Entity partner = Entity.get(params.id)
    if (partner) {
      functionService.deleteReferences(partner)
      try {
        flash.message = message(code: "object.deleted", args: [message(code: "partner"), partner.profile])
        partner.delete(flush: true)
        redirect(action: "list")
      }
      catch (org.springframework.dao.DataIntegrityViolationException ignore) {
        flash.message = message(code: "object.notDeleted", args: [message(code: "partner"), partner.profile])
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

    return [partner: partner]

  }

  def update = {
    Entity partner = Entity.get(params.id)

    partner.profile.properties = params
    partner.user.properties = params

    // update link to colony
    Link.findByTargetAndType(partner, metaDataService.ltColonia)?.delete()
    new Link(source: Entity.get(params.currentColony), target: partner, type: metaDataService.ltColonia).save()

    if (partner.profile.save() && partner.user.save() && partner.save()) {
      flash.message = message(code: "object.updated", args: [message(code: "partner"), partner.profile])
      redirect action: 'show', id: partner.id
    }
    else {
      render view: 'edit', model: [partner: partner]
    }
  }

  def create = {}

  def save = {
    EntityType etPartner = metaDataService.etPartner

    try {
      Entity entity = entityHelperService.createEntityWithUserAndProfile(functionService.createNick(params.fullName), etPartner, params.email, params.fullName) {Entity ent ->
        ent.profile.properties = params
        ent.user.properties = params
        ent.user.password = securityManager.encodePassword(grailsApplication.config.defaultpass)
        ent.profile.favoritesFolder = new Folder(name: "root", type: FolderType.findByName("favorite")).save()
      }

      flash.message = message(code: "object.created", args: [message(code: "partner"), entity.profile])
      redirect action: 'show', id: entity.id
    } catch (at.uenterprise.erp.base.EntityException ee) {
      def allColonies = entityDataService.getAllColonies()
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
      render {p(class: 'red italic', message(code: 'object.notCreated', args: [message(code: "partner.profile.contact")]))}
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

  def define = {
    params.sort = params.sort ?: "fullName"
    params.order = params.order ?: "asc"
    params.offset = params.int('offset') ?: 0
    params.max = Math.min(params.int('max') ?: 20, 40)

    // 1. pass - filter by object properties
    def results = Entity.createCriteria().listDistinct  {
      eq('type', metaDataService.etPartner)
      user {
        eq('enabled', params.active ? true : false)
      }
      profile {
        if (params.name)
          ilike('fullName', "%" + params.name + "%")
        order(params.sort, params.order)
      }
    }

// 2. pass - filter by services
    if (params.services) {
      List services = params.list('services')
      results = results.findAll {it.profile.services.intersect(services)}
    }

    int totalResults = results.size()
    int upperBound = params.offset + params.max < totalResults ? params.offset + params.max : totalResults
    results = results.subList(params.offset, upperBound)

    render template: '/templates/searchresults', model: [results: results, totalResults: totalResults, type: 'parent', params: params]
  }

   /*
   * retrieves all group partners matching the search parameter
   */
    def remoteGroupPartners = {
        if (!params.value) {
            render ""
            return
        }
        else if (params.value.size() < 2) {
            render {span(class: 'gray', message(code: 'minChars'))}
            return
        }

        def results = Entity.createCriteria().listDistinct {
            eq('type', metaDataService.etGroupPartner)
            profile {
                ilike('fullName', "%" + params.value + "%")
                order('fullName','asc')
            }
            maxResults(15)
        }

        if (results.size() == 0) {
            render {span(class: 'italic', message(code: 'noResultsFound'))}
            return
        }
        else {
            render template: 'grouppartnerresults', model: [results: results, partner: params.id]
        }
    }

    def addGroupPartner = {
        def linking = functionService.linkEntities(params.id, params.group, metaDataService.ltGroupMember)
        if (linking.duplicate)
            render {p(class: 'red italic', message(code: "alreadyAssignedTo", args: [linking.source.profile]))}
        render template: 'grouppartners', model: [partner: linking.source, grouppartners: linking.targets]
    }

    def removeGroupPartner = {
        def breaking = functionService.breakEntities(params.partner, params.id, metaDataService.ltGroupMember)
        render template: 'grouppartners', model: [partner: breaking.source, grouppartners: breaking.targets]
    }

    def createpdf = {
        Entity partner = Entity.get(params.id)
        renderPdf template: 'createpdf', model: [pageformat: params.pageformat,
                partner: partner],
                filename: message(code: 'partner') + '_' + partner.profile + '.pdf'
    }

    def createpdfall = {
        List partners = Entity.findAllByType(metaDataService.etPartner)
        renderPdf template: 'createpdfall', model: [pageformat: params.pageformat,
                partners: partners],
                filename: message(code: 'partner') + '.pdf'
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