package profiles

import at.openfactory.ep.Entity
import at.openfactory.ep.EntityType
import at.openfactory.ep.Link
import org.springframework.web.servlet.support.RequestContextUtils
import at.openfactory.ep.EntityHelperService
import standard.FunctionService
import standard.MetaDataService
import at.openfactory.ep.security.DefaultSecurityManager

class UserProfileController {
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
        return [userList: Entity.findAllByType(metaDataService.etUser),
                userTotal: Entity.countByType(metaDataService.etUser),
                entity: entityHelperService.loggedIn]
    }

    def show = {
        Entity user = Entity.get(params.id)
        Entity entity = params.entity ? user : entityHelperService.loggedIn

        if(!user) {
            flash.message = "UserProfile not found with id ${params.id}"
            redirect(action:list)
        }
        else {
            return [user: user, entity: entity]
        }
    }

    def del = {
        Entity user = Entity.get(params.id)
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
        Entity user = Entity.get(params.id)

        if(!user) {
            flash.message = "UserProfile not found with id ${params.id}"
            redirect action:'list'
        }
        else {
            return [user: user, entity: entityHelperService.loggedIn]
        }
    }

    def update = {
      Entity user = Entity.get(params.id)

      user.profile.properties = params
      user.profile.fullName = params.lastName + " " + params.firstName

      user.user.properties = params
      RequestContextUtils.getLocaleResolver(request).setLocale(request, response, user.user.locale)

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
        Entity entity = entityHelperService.createEntityWithUserAndProfile(functionService.createNick(params.firstName,params.lastName), etUser, params.email, params.lastName + " " + params.firstName) {Entity ent ->
          ent.profile.properties = params
          ent.user.properties = params
          ent.user.password = securityManager.encodePassword(grailsApplication.config.defaultpass)
        }
        RequestContextUtils.getLocaleResolver(request).setLocale(request, response, entity.user.locale)

        flash.message = message(code:"user.created", args:[entity.profile.fullName])
        redirect action:'list'
      } catch (at.openfactory.ep.EntityException ee) {
        render (view:"create", model:[user: ee.entity, entity: entityHelperService.loggedIn])
        return
      }

    }
}
