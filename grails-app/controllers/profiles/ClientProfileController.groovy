package profiles

import de.uenterprise.ep.Entity
import de.uenterprise.ep.EntityType
import de.uenterprise.ep.Link
import org.springframework.web.servlet.support.RequestContextUtils

class ClientProfileController {
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
        return [clientList: Entity.findAllByType(metaDataService.etClient),
                clientTotal: Entity.countByType(metaDataService.etClient)]
    }

    def show = {
        def client = Entity.get(params.id)
        def entity = params.entity ? client : entityHelperService.loggedIn

        if(!client) {
            flash.message = "ClientProfile not found with id ${params.id}"
            redirect(action:list)
        }
        else {
            return [client: client, entity: entity]
        }
    }

    def del = {
        def client = Entity.get(params.id)
        if(client) {
            // delete all links
            Link.findAllBySourceOrTarget(client, client).each {it.delete()}
            try {
                flash.message = message(code:"client.deleted", args:[client.profile.fullName])
                client.delete(flush:true)
                redirect(action:"list")
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
        def client = Entity.get(params.id)

        if(!client) {
            flash.message = "ClientProfile not found with id ${params.id}"
            redirect action:'list'
        }
        else {
            return [client: client, entity: entityHelperService.loggedIn]
        }
    }

    def update = {
      def client = Entity.get(params.id)

      client.profile.properties = params

      client.profile.showTips = params.showTips ?: false
      client.profile.doesWork = params.doesWork ?: false
      client.user.enabled = params.enabled ?: false

      if (params.lang == '1') {
        client.user.locale = new Locale ("de", "DE")
        Locale locale = client.user.locale
        RequestContextUtils.getLocaleResolver(request).setLocale(request, response, locale)
      }
      if (params.lang == '2') {
        client.user.locale = new Locale ("ES", "ES")
        Locale locale = client.user.locale
        RequestContextUtils.getLocaleResolver(request).setLocale(request, response, locale)
      }

      if(!client.profile.hasErrors() && client.profile.save()) {
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
        def entity = entityHelperService.createEntityWithUserAndProfile(functionService.createNick(params.firstName,params.lastName), etClient, params.email, params.lastName + " " + params.firstName) {Entity ent ->
          ent.profile.properties = params
          ent.user.password = authenticateService.encodePassword("pass")
          ent.profile.doesWork = params.doesWork ?: false
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
        flash.message = message(code:"client.created", args:[entity.profile.fullName])
        redirect action:'list'
      } catch (de.uenterprise.ep.EntityException ee) {
        render (view:"create", model:[client: ee.entity, entity: entityHelperService.loggedIn])
        return
      }

    }
}
