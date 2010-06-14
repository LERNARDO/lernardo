package profiles

import at.openfactory.ep.Entity
import at.openfactory.ep.EntityType
import at.openfactory.ep.Link
import org.springframework.web.servlet.support.RequestContextUtils
import at.openfactory.ep.EntityHelperService
import lernardo.Contact
import standard.MetaDataService
import standard.FunctionService
import at.openfactory.ep.security.DefaultSecurityManager

class PartnerProfileController {
    MetaDataService metaDataService
    EntityHelperService entityHelperService
    def securityManager
    FunctionService functionService

    def index = {
        redirect action:"list", params:params 
    }

    // the delete, save and update actions only accept POST requests
    static allowedMethods = [delete:'POST', save:'POST', update:'POST']

    def list = {
        params.max = Math.min( params.max ? params.int('max') : 10,  100)
        return [partnerList: Entity.findAllByType(metaDataService.etPartner),
                partnerTotal: Entity.countByType(metaDataService.etPartner),
                entity: entityHelperService.loggedIn]
    }

    def show = {
        Entity partner = Entity.get(params.id)
        Entity entity = params.entity ? partner : entityHelperService.loggedIn

        if(!partner) {
            flash.message = "PartnerProfile not found with id ${params.id}"
            redirect(action:list)
        }
        else {

            // find colonia of this partner
            def link = Link.findBySourceAndType(partner, metaDataService.ltGroupMemberPartner)
            Entity colony = link?.target

            return [partner: partner, entity: entity, colony: colony]
        }
    }

    def del = {
        Entity partner = Entity.get(params.id)
        if(partner) {
            // delete all links
            Link.findAllBySourceOrTarget(partner, partner).each {it.delete()}
            try {
                flash.message = message(code:"partner.deleted", args:[partner.profile.fullName])
                partner.delete(flush:true)
                redirect(controller:"profile", action:"list")
            }
            catch(org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = message(code:"partner.notDeleted", args:[partner.profile.fullName])
                redirect(action:"show",id:params.id)
            }
        }
        else {
            flash.message = "PartnerProfile not found with id ${params.id}"
            redirect(action:"list")
        }
    }

    def edit = {
        Entity partner = Entity.get(params.id)

        if(!partner) {
            flash.message = "PartnerProfile not found with id ${params.id}"
            redirect action:'list'
        }
        else {
            return [partner: partner, entity: entityHelperService.loggedIn, allColonias: Entity.findAllByType(metaDataService.etGroupColony)]
        }
    }

    def update = {
      Entity partner = Entity.get(params.id)

      partner.profile.properties = params
      partner.user.properties = params
      RequestContextUtils.getLocaleResolver(request).setLocale(request, response, partner.user.locale)

      if(!partner.hasErrors() && partner.save()) {

          // delete current link
          def c = Link.createCriteria()
          def link = c.get {
            eq('source', partner)
            eq('target', Entity.get(params.colonia))
            eq('type', metaDataService.ltGroupMemberPartner)
          }
          if (link)
            link.delete()

          // link facility to colonia
          new Link(source:partner, target: Entity.get(params.colonia), type:metaDataService.ltGroupMemberPartner).save()

          flash.message = message(code:"partner.updated", args:[partner.profile.fullName])
          redirect action:'show', id: partner.id
      }
      else {
          render view:'edit', model:[partner: partner, entity: entityHelperService.loggedIn, allColonias: Entity.findAllByType(metaDataService.etGroupColony)]
      }
    }

    def create = {
        return [entity: entityHelperService.loggedIn, allColonias: Entity.findAllByType(metaDataService.etGroupColony)]
    }

    def save = {
      EntityType etPartner = metaDataService.etPartner

      try {
        Entity entity = entityHelperService.createEntityWithUserAndProfile(functionService.createNick(params.fullName), etPartner, params.email, params.fullName) {Entity ent ->
          ent.profile.properties = params
          ent.user.properties = params
          ent.user.password = securityManager.encodePassword("pass")
        }
        RequestContextUtils.getLocaleResolver(request).setLocale(request, response, entity.user.locale)

        // link partner to colonia
        new Link(source:entity, target: Entity.get(params.colonia), type:metaDataService.ltGroupMemberPartner).save()

        flash.message = message(code:"partner.created", args:[entity.profile.fullName])
        redirect action:'list'
      } catch (at.openfactory.ep.EntityException ee) {
        render (view:"create", model:[partner: ee.entity, entity: entityHelperService.loggedIn], allColonias: Entity.findAllByType(metaDataService.etGroupColony))
        return
      }

    }

    def addService = {
      String service = params.service
      Entity partner = Entity.get(params.id)
      partner.profile.addToServices(service)
      render template:'services', model: [partner: partner, entity: entityHelperService.loggedIn]
    }

    def removeService = {
      Entity partner = Entity.get(params.id)
      partner.profile.services.remove(params.service)
      render template:'services', model: [partner: partner, entity: entityHelperService.loggedIn]
    }

    def addContact = {
      Contact contact = new Contact()
      contact.properties = params
      Entity partner = Entity.get(params.id)
      partner.profile.addToContacts(contact)
      render template:'contacts', model: [partner: partner, entity: entityHelperService.loggedIn]
    }

    def removeContact = {
      Entity partner = Entity.get(params.id)
      partner.profile.removeFromContacts(Contact.get(params.contact))
      Contact.get(params.contact).delete()
      render template:'contacts', model: [partner: partner, entity: entityHelperService.loggedIn]
    }
}
