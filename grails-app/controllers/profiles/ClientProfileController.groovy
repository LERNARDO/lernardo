package profiles

import de.uenterprise.ep.Entity
import de.uenterprise.ep.EntityType
import de.uenterprise.ep.Link
import org.springframework.web.servlet.support.RequestContextUtils
import de.uenterprise.ep.EntityHelperService
import org.grails.plugins.springsecurity.service.AuthenticateService
import lernardo.Status
import standard.MetaDataService
import standard.FunctionService

class ClientProfileController {
    MetaDataService metaDataService
    EntityHelperService entityHelperService
    AuthenticateService authenticateService
    FunctionService functionService

    def index = {
        redirect action:"list", params:params
    }

    // the delete, save and update actions only accept POST requests
    static allowedMethods = [delete:'POST', save:'POST', update:'POST']

    def list = {
        params.max = Math.min( params.max ? params.int('max') : 10,  100)
        return [clientList: Entity.findAllByType(metaDataService.etClient),
                clientTotal: Entity.countByType(metaDataService.etClient)]
    }

    def show = {
        Entity client = Entity.get(params.id)
        Entity entity = params.entity ? client : entityHelperService.loggedIn

        if(!client) {
            flash.message = "ClientProfile not found with id ${params.id}"
            redirect(action:list)
        }
        else {
            return [client: client, entity: entity]
        }
    }

    def del = {
        Entity client = Entity.get(params.id)
        if(client) {
            // delete all links
            Link.findAllBySourceOrTarget(client, client).each {it.delete()}
            try {
                flash.message = message(code:"client.deleted", args:[client.profile.fullName])
                client.delete(flush:true)
                redirect(controller:"profile", action:"list")
            }
            catch(org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = message(code:"client.notDeleted", args:[client.profile.fullName])
                redirect(action:"show",id:params.id)
            }
        }
        else {
            flash.message = "ClientProfile not found with id ${params.id}"
            redirect(action:"list")
        }
    }

    def edit = {
        Entity client = Entity.get(params.id)

        if(!client) {
            flash.message = "ClientProfile not found with id ${params.id}"
            redirect action:'list'
        }
        else {
            return [client: client, entity: entityHelperService.loggedIn]
        }
    }

    def update = {
      Entity client = Entity.get(params.id)

      client.profile.properties = params
      client.user.properties = params
      RequestContextUtils.getLocaleResolver(request).setLocale(request, response, client.user.locale)

      if(!client.hasErrors() && client.save()) {
          flash.message = message(code:"client.updated", args:[client.profile.fullName])
          redirect action:'show', id: client.id
      }
      else {
          render view:'edit', model:[client: client, entity: entityHelperService.loggedIn]
      }
    }

    def create = {
        return [entity: entityHelperService.loggedIn]
    }

    def save = {
      EntityType etClient = metaDataService.etClient
      println params

      try {
        Entity entity = entityHelperService.createEntityWithUserAndProfile(functionService.createNick(params.firstName,params.lastName), etClient, params.email, params.lastName + " " + params.firstName) {Entity ent ->
          ent.profile.properties = params
          ent.user.properties = params
          ent.user.password = authenticateService.encodePassword("pass")
        }
        RequestContextUtils.getLocaleResolver(request).setLocale(request, response, entity.user.locale)

        flash.message = message(code:"client.created", args:[entity.profile.fullName])
        redirect action:'list'
      } catch (de.uenterprise.ep.EntityException ee) {
        render (view:"create", model:[client: ee.entity, entity: entityHelperService.loggedIn])
        return
      }

    }

    def addPerformance = {
      Status status = new Status(params)
      Entity client = Entity.get(params.id)
      client.profile.addToStatus(status)
      render template:'performances', model: [client: client, entity: entityHelperService.loggedIn]
    }

    def removePerformance = {
      Entity client = Entity.get(params.id)
      client.profile.removeFromStatus(Status.get(params.performance))
      render template:'performances', model: [client: client, entity: entityHelperService.loggedIn]
    }

    def addHealth = {
      Status status = new Status(params)
      Entity client = Entity.get(params.id)
      client.profile.addToStatus(status)
      render template:'healths', model: [client: client, entity: entityHelperService.loggedIn]
    }

    def removeHealth = {
      Entity client = Entity.get(params.id)
      client.profile.removeFromStatus(Status.get(params.health))
      render template:'healths', model: [client: client, entity: entityHelperService.loggedIn]
    }

    def addMaterial = {
      Status status = new Status(params)
      Entity client = Entity.get(params.id)
      client.profile.addToStatus(status)
      render template:'materials', model: [client: client, entity: entityHelperService.loggedIn]
    }

    def removeMaterial = {
      Entity client = Entity.get(params.id)
      client.profile.removeFromStatus(Status.get(params.material))
      render template:'materials', model: [client: client, entity: entityHelperService.loggedIn]
    }
}
