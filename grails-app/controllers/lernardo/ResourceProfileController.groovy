package lernardo

import de.uenterprise.ep.Entity
import de.uenterprise.ep.EntityType
import de.uenterprise.ep.Link

class ResourceProfileController {
    def metaDataService
    def entityHelperService
    def profileHelperService
    
    def index = {
        redirect action:"list", params:params 
    }

    // the delete, save and update actions only accept POST requests
    static allowedMethods = [delete:'POST', save:'POST', update:'POST']

    def list = {
        params.max = Math.min( params.max ? params.int('max') : 20,  100)
        return[resourceList: Entity.findAllByType(metaDataService.etResource),
               resourceTotal: Entity.countByType(metaDataService.etResource)]
    }

    def show = {
        def resource = Entity.get( params.id )

        if(!resource) {
            flash.message = "ResourceProfile not found with id ${params.id}"
            redirect(action:list)
        }
        else {
            [resource: resource, entity: entityHelperService.loggedIn]
        }
    }

    def del = {
        def resource = Entity.get(params.id)
        if(resource) {
            try {
                flash.message = message(code:"resource.deleted", args:[resource.profile.fullName])
                resource.delete(flush:true)
                redirect(action:"list")
            }
            catch(org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = message(code:"resource.notDeleted", args:[resource.profile.fullName])
                redirect(action:"show",id:params.id)
            }
        }
        else {
            flash.message = "ResourceProfile not found with id ${params.id}"
            redirect(action:"list")
        }
    }

    def edit = {
        def resource = Entity.get(params.id)

        if(!resource) {
            flash.message = "ResourceProfile not found with id ${params.id}"
            redirect action:'list'
        }
        else {
            return [resource: resource, entity: entityHelperService.loggedIn]
        }
    }

    def update = {
      def resource = Entity.get(params.id)

      resource.profile.properties = params
      
      if(!resource.profile.hasErrors() && resource.profile.save()) {
          flash.message = message(code:"resource.updated", args:[resource.profile.fullName])
          redirect action:'show', id: resource.id
      }
      else {
          render view:'edit', model:[resource: resource, entity: entityHelperService.loggedIn]
      }
    }

    def create = {
      return [entity: entityHelperService.loggedIn]
    }

    def save = {
      EntityType etResource = metaDataService.etResource

      try {
        def entity = entityHelperService.createEntity("resource", etResource) {Entity ent ->
          ent.profile = profileHelperService.createProfileFor(ent)
          ent.profile.properties = params
        }
        flash.message = message(code:"resource.created", args:[entity.profile.fullName])
        redirect action:'list'
      } catch (de.uenterprise.ep.EntityException ee) {
        render (view:"create", model:[resource: ee.entity, entity: entityHelperService.loggedIn])
        return
      }

    }
}
