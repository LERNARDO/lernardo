package profiles

import de.uenterprise.ep.Entity
import de.uenterprise.ep.EntityType
import de.uenterprise.ep.Link
import org.springframework.web.servlet.support.RequestContextUtils

class UserProfileController {
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
        return [userList: Entity.findAllByType(metaDataService.etUser),
                userTotal: Entity.countByType(metaDataService.etUser)]
    }

    def show = {
        def user = Entity.get(params.id)
        def entity = params.entity ? user : entityHelperService.loggedIn

        if(!user) {
            flash.message = "UserProfile not found with id ${params.id}"
            redirect(action:list)
        }
        else {
            return [user: user, entity: entity]
        }
    }

    def del = {
        def user = Entity.get(params.id)
        if(user) {
            // delete all links
            Link.findAllBySourceOrTarget(user, user).each {it.delete()}
            try {
                flash.message = message(code:"user.deleted", args:[user.profile.fullName])
                user.delete(flush:true)
                redirect(controller:"profile", action:"list")
            }
            catch(org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = message(code:"user.notDeleted", args:[user.profile.fullName])
                redirect(action:"show",id:params.id)
            }
        }
        else {
            flash.message = "UserProfile not found with id ${params.id}"
            redirect(action:"list")
        }
    }

    def edit = {
        def user = Entity.get(params.id)

        if(!user) {
            flash.message = "UserProfile not found with id ${params.id}"
            redirect action:'list'
        }
        else {
            return [user: user, entity: entityHelperService.loggedIn]
        }
    }

    def update = {
      def user = Entity.get(params.id)

      user.profile.properties = params
      user.user.properties = params

      user.profile.showTips = params.showTips ?: false
      user.user.enabled = params.enabled ?: false

      if (params.lang == '1') {
        user.user.locale = new Locale ("de", "DE")
        Locale locale = user.user.locale
        RequestContextUtils.getLocaleResolver(request).setLocale(request, response, locale)
      }
      if (params.lang == '2') {
        user.user.locale = new Locale ("ES", "ES")
        Locale locale = user.user.locale
        RequestContextUtils.getLocaleResolver(request).setLocale(request, response, locale)
      }

      if(!user.hasErrors() && user.save()) {
          flash.message = message(code:"user.updated", args:[user.profile.fullName])
          redirect action:'show', id: user.id
      }
      else {
          render view:'edit', model:[user: user, entity: entityHelperService.loggedIn]
      }
    }

    def create = {
        return [entity: entityHelperService.loggedIn]
    }

    def save = {
      EntityType etUser = metaDataService.etUser
      println params

      try {
        def entity = entityHelperService.createEntityWithUserAndProfile(functionService.createNick(params.firstName,params.lastName), etUser, params.email, params.lastName + " " + params.firstName) {Entity ent ->
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
        flash.message = message(code:"user.created", args:[entity.profile.fullName])
        redirect action:'list'
      } catch (de.uenterprise.ep.EntityException ee) {
        render (view:"create", model:[user: ee.entity, entity: entityHelperService.loggedIn])
        return
      }

    }
}
