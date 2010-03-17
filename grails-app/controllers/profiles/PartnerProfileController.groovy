package profiles

import de.uenterprise.ep.Entity
import de.uenterprise.ep.EntityType
import de.uenterprise.ep.Link
import org.springframework.web.servlet.support.RequestContextUtils

class PartnerProfileController {
    def metaDataService
    def entityHelperService
    def authenticateService
    def functionService

    def index = {
        redirect action:"list", params:params 
    }

    // the delete, save and update actions only accept POST requests
    static allowedMethods = [delete:'POST', save:'POST', update:'POST']

    def list = {
        params.max = Math.min( params.max ? params.int('max') : 10,  100)
        return [partnerList: Entity.findAllByType(metaDataService.etPartner),
                partnerTotal: Entity.countByType(metaDataService.etPartner)]
    }

    def show = {
        def partner = Entity.get(params.id)
        def entity = params.entity ? partner : entityHelperService.loggedIn

        if(!partner) {
            flash.message = "PartnerProfile not found with id ${params.id}"
            redirect(action:list)
        }
        else {
            return [partner: partner, entity: entity]
        }
    }

    def del = {
        def partner = Entity.get(params.id)
        if(partner) {
            // delete all links
            Link.findAllBySourceOrTarget(partner, partner).each {it.delete()}
            try {
                flash.message = message(code:"partner.deleted", args:[partner.profile.fullName])
                partner.delete(flush:true)
                redirect(action:"list")
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
        def partner = Entity.get(params.id)

        if(!partner) {
            flash.message = "PartnerProfile not found with id ${params.id}"
            redirect action:'list'
        }
        else {
            return [partner: partner, entity: entityHelperService.loggedIn]
        }
    }

    def update = {
      def partner = Entity.get(params.id)

      partner.profile.properties = params
      partner.user.properties = params

      partner.profile.showTips = params.showTips ?: false
      partner.user.enabled = params.enabled ?: false

      if (params.lang == '1') {
        partner.user.locale = new Locale ("de", "DE")
        Locale locale = partner.user.locale
        RequestContextUtils.getLocaleResolver(request).setLocale(request, response, locale)
      }
      if (params.lang == '2') {
        partner.user.locale = new Locale ("ES", "ES")
        Locale locale = partner.user.locale
        RequestContextUtils.getLocaleResolver(request).setLocale(request, response, locale)
      }

      if(!partner.hasErrors() && partner.save()) {
          flash.message = message(code:"partner.updated", args:[partner.profile.fullName])
          redirect action:'show', id: partner.id
      }
      else {
          render view:'edit', model:[partner: partner, entity: entityHelperService.loggedIn]
      }
    }

    def create = {
        return [entity: entityHelperService.loggedIn]
    }

    def save = {
      EntityType etPartner = metaDataService.etPartner

      try {
        def entity = entityHelperService.createEntityWithUserAndProfile(functionService.createNick(params.fullName), etPartner, params.email, params.fullName) {Entity ent ->
          ent.profile.properties = params
          ent.user.password = authenticateService.encodePassword("pass")
          ent.user.enabled = params.enabled ?: false
        }
        if (params.lang == '1') {
          entity.user.locale = new Locale ("de", "DE")
          Locale locale = entity.user.locale
          RequestContextUtils.getLocaleResolver(request).setLocale(request, response, locale)
        }
        if (params.lang == '2') {
          entity.user.locale = new Locale ("ES", "ES")
          Locale locale = entity.user.locale
          RequestContextUtils.getLocaleResolver(request).setLocale(request, response, locale)
        }
        flash.message = message(code:"partner.created", args:[entity.profile.fullName])
        redirect action:'list'
      } catch (de.uenterprise.ep.EntityException ee) {
        render (view:"create", model:[partner: ee.entity, entity: entityHelperService.loggedIn])
        return
      }

    }
}
