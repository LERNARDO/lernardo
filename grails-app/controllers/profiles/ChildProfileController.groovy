package profiles

import de.uenterprise.ep.Entity
import de.uenterprise.ep.EntityType
import de.uenterprise.ep.Link
import org.springframework.web.servlet.support.RequestContextUtils
import de.uenterprise.ep.EntityHelperService
import org.grails.plugins.springsecurity.service.AuthenticateService

class ChildProfileController {
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
        return [childList: Entity.findAllByType(metaDataService.etChild),
                childTotal: Entity.countByType(metaDataService.etChild)]
    }

    def show = {
        Entity child = Entity.get(params.id)
        Entity entity = params.entity ? child : entityHelperService.loggedIn

        if(!child) {
            flash.message = "ChildProfile not found with id ${params.id}"
            redirect(action:list)
        }
        else {
            return [child: child, entity: entity]
        }
    }

    def del = {
        Entity child = Entity.get(params.id)
        if(child) {
            // delete all links
            Link.findAllBySourceOrTarget(child, child).each {it.delete()}
            try {
                flash.message = message(code:"child.deleted", args:[child.profile.fullName])
                child.delete(flush:true)
                redirect(controller:"profile", action:"list")
            }
            catch(org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = message(code:"child.notDeleted", args:[child.profile.fullName])
                redirect(action:"show",id:params.id)
            }
        }
        else {
            flash.message = "ChildProfile not found with id ${params.id}"
            redirect(action:"list")
        }
    }

    def edit = {
        Entity child = Entity.get(params.id)

        if(!child) {
            flash.message = "ChildProfile not found with id ${params.id}"
            redirect action:'list'
        }
        else {
            return [child: child, entity: entityHelperService.loggedIn]
        }
    }

    def update = {
      Entity child = Entity.get(params.id)

      child.profile.properties = params
      child.user.properties = params

      child.profile.showTips = params.showTips ?: false
      child.profile.job = params.job ?: false
      child.user.enabled = params.enabled ?: false

      if (params.lang == '1') {
        child.user.locale = new Locale ("de", "DE")
        Locale locale = child.user.locale
        RequestContextUtils.getLocaleResolver(request).setLocale(request, response, locale)
      }
      if (params.lang == '2') {
        child.user.locale = new Locale ("ES", "ES")
        Locale locale = child.user.locale
        RequestContextUtils.getLocaleResolver(request).setLocale(request, response, locale)
      }

      if(!child.hasErrors() && child.save()) {
          flash.message = message(code:"child.updated", args:[child.profile.fullName])
          redirect action:'show', id: child.id
      }
      else {
          render view:'edit', model:[child: child, entity: entityHelperService.loggedIn]
      }
    }

    def create = {
        return [entity: entityHelperService.loggedIn]
    }

    def save = {
      EntityType etChild = metaDataService.etChild
      println params

      try {
        Entity entity = entityHelperService.createEntityWithUserAndProfile(functionService.createNick(params.firstName,params.lastName), etChild, params.email, params.lastName + " " + params.firstName) {Entity ent ->
          ent.profile.properties = params
          ent.user.password = authenticateService.encodePassword("pass")
          ent.profile.job = params.job ?: false
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
        flash.message = message(code:"child.created", args:[entity.profile.fullName])
        redirect action:'list'
      } catch (de.uenterprise.ep.EntityException ee) {
        render (view:"create", model:[child: ee.entity, entity: entityHelperService.loggedIn])
        return
      }

    }
}
