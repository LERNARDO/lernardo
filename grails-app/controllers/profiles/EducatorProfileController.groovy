package profiles

import de.uenterprise.ep.Entity
import de.uenterprise.ep.EntityType
import de.uenterprise.ep.Link
import org.springframework.web.servlet.support.RequestContextUtils
import org.grails.plugins.springsecurity.service.AuthenticateService
import de.uenterprise.ep.EntityHelperService

class EducatorProfileController {
    def metaDataService
    EntityHelperService entityHelperService
    AuthenticateService authenticateService
    def functionService

    def index = {
        redirect action:"list", params:params
    }

    // the delete, save and update actions only accept POST requests
    static allowedMethods = [delete:'POST', save:'POST', update:'POST']

    def list = {
        params.max = Math.min( params.max ? params.int('max') : 10,  100)
        return [educatorList: Entity.findAllByType(metaDataService.etEducator),
                educatorTotal: Entity.countByType(metaDataService.etEducator)]
    }

    def show = {
        Entity educator = Entity.get(params.id)
        Entity entity = params.entity ? educator : entityHelperService.loggedIn

        if(!educator) {
            flash.message = "EducatorProfile not found with id ${params.id}"
            redirect(action:list)
        }
        else {
            return [educator: educator, entity: entity]
        }
    }

    def del = {
        Entity educator = Entity.get(params.id)
        if(educator) {
            // delete all links
            Link.findAllBySourceOrTarget(educator, educator).each {it.delete()}
            try {
                flash.message = message(code:"educator.deleted", args:[educator.profile.fullName])
                educator.delete(flush:true)
                redirect(controller:"profile", action:"list")
            }
            catch(org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = message(code:"educator.notDeleted", args:[educator.profile.fullName])
                redirect(action:"show",id:params.id)
            }
        }
        else {
            flash.message = "EducatorProfile not found with id ${params.id}"
            redirect(action:"list")
        }
    }

    def edit = {
        Entity educator = Entity.get(params.id)

        if(!educator) {
            flash.message = "EducatorProfile not found with id ${params.id}"
            redirect action:'list'
        }
        else {
            return [educator: educator, entity: entityHelperService.loggedIn]
        }
    }

    def update = {
      Entity educator = Entity.get(params.id)

      educator.profile.properties = params
      educator.user.properties = params

      educator.profile.showTips = params.showTips ?: false
      educator.profile.employed = params.employed ?: false
      educator.user.enabled = params.enabled ?: false

      if (params.lang == '1') {
        educator.user.locale = new Locale ("de", "DE")
        Locale locale = educator.user.locale
        RequestContextUtils.getLocaleResolver(request).setLocale(request, response, locale)
      }
      if (params.lang == '2') {
        educator.user.locale = new Locale ("ES", "ES")
        Locale locale = educator.user.locale
        RequestContextUtils.getLocaleResolver(request).setLocale(request, response, locale)
      }

      if(!educator.hasErrors() && educator.save()) {
          flash.message = message(code:"educator.updated", args:[educator.profile.fullName])
          redirect action:'show', id: educator.id
      }
      else {
          render view:'edit', model:[educator: educator, entity: entityHelperService.loggedIn]
      }
    }

    def create = {
        return [entity: entityHelperService.loggedIn]
    }

    def save = {
      EntityType etEducator = metaDataService.etEducator
      println params

      try {
        Entity entity = entityHelperService.createEntityWithUserAndProfile(functionService.createNick(params.firstName,params.lastName), etEducator, params.email, params.lastName + " " + params.firstName) {Entity ent ->
          ent.profile.properties = params
          ent.user.password = authenticateService.encodePassword("pass")
          ent.user.enabled = params.enabled ?: false
          ent.profile.employed = params.employed ?: false
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
        flash.message = message(code:"educator.created", args:[entity.profile.fullName])
        redirect action:'list'
      } catch (de.uenterprise.ep.EntityException ee) {
        render (view:"create", model:[educator: ee.entity, entity: entityHelperService.loggedIn])
        return
      }

    }
}
