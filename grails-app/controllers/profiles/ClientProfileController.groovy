package profiles

import de.uenterprise.ep.Entity
import de.uenterprise.ep.EntityType
import de.uenterprise.ep.Link

class ClientProfileController {
    def metaDataService
    def entityHelperService
    def authenticateService

    def index = {
        redirect action:"list", params:params
    }

    // the delete, save and update actions only accept POST requests
    static allowedMethods = [delete:'POST', save:'POST', update:'POST']

    def list = {
        params.max = Math.min( params.max ? params.max.toInteger() : 10,  100)
        return [clientList: Entity.findAllByType(metaDataService.etClient),
                clientTotal: Entity.countByType(metaDataService.etClient)]
    }

    def show = {
        def client = Entity.get(params.id)

        if(!client) {
            flash.message = "ClientProfile not found with id ${params.id}"
            redirect(action:list)
        }
        else {
            return [client: client, entity: entityHelperService.loggedIn]
        }
    }

    def del = {
        def client = Entity.get(params.id)
        if(client) {
            // delete all links
            Link.findAllBySourceOrTarget(client, client).each {it.delete()}
            try {
                flash.message = message(code:"client.deleted", args:[client.profile.lastName])
                client.delete(flush:true)
                redirect(action:"list")
            }
            catch(org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = message(code:"client.notDeleted", args:[client.profile.lastName])
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
      //client.profile.birthDate = new Date(Integer.parseInt(params.birthDate_year)-1900,Integer.parseInt(params.birthDate_month)-1,Integer.parseInt(params.birthDate_day))

      if (params.showTips)
        client.profile.showTips = true
      else
        client.profile.showTips = false

      if (params.doesWork)
        client.profile.doesWork = true
      else
        client.profile.doesWork = false

      if (params.enabled)
        client.user.enabled = true
      else
        client.user.enabled = false

      if(!client.profile.hasErrors() && client.profile.save()) {
          flash.message = message(code:"client.updated", args:[client.profile.lastName])
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
        def entity = entityHelperService.createEntityWithUserAndProfile("client", etClient, params.email, params.lastName + " " + params.firstName) {Entity ent ->
          ent.profile.properties = params
          // TODO: figure out why the date makes problems, once again
          //ent.profile.birthDate = new Date(Integer.parseInt(params.birthDate_year)-1900,Integer.parseInt(params.birthDate_month)-1,Integer.parseInt(params.birthDate_day))
          ent.profile.birthDate = new Date()
          ent.user.password = authenticateService.encodePassword("pass")
          if (params.enabled)
            ent.user.enabled = true
          else
            ent.user.enabled = false

          if (params.doesWork)
            ent.profile.doesWork = true
          else
            ent.profile.doesWork = false
        }
        flash.message = message(code:"client.created", args:[entity.profile.lastName])
        redirect action:'list'
      } catch (de.uenterprise.ep.EntityException ee) {
        render (view:"create", model:[client: ee.entity, entity: entityHelperService.loggedIn])
        return
      }

    }
}
