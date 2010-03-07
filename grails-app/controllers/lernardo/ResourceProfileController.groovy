package lernardo

import de.uenterprise.ep.Entity
import de.uenterprise.ep.EntityType

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
        params.max = Math.min( params.max ? params.max.toInteger() : 20,  100)
        return[resourceProfileInstanceList: Entity.findAllByType(metaDataService.etResource),
               resourceProfileInstanceTotal: Entity.countByType(metaDataService.etResource)]
    }

    def show = {
        def resourceProfileInstance = Entity.get( params.id )

        if(!resourceProfileInstance) {
            flash.message = "ResourceProfile not found with id ${params.id}"
            redirect(action:list)
        }
        else {
            [ resourceProfileInstance : resourceProfileInstance, entity: entityHelperService.loggedIn ]
        }
    }

    def del = {
        def resourceProfileInstance = Entity.get( params.id )
        if(resourceProfileInstance) {
            try {
                flash.message = "ResourceProfile ${params.id} deleted"
                resourceProfileInstance.delete(flush:true)
                redirect(action:"list")
            }
            catch(org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "ResourceProfile ${params.id} could not be deleted"
                redirect(action:"show",id:params.id)
            }
        }
        else {
            flash.message = "ResourceProfile not found with id ${params.id}"
            redirect(action:"list")
        }
    }

    def edit = {
        def resourceProfileInstance = Entity.get( params.id )

        if(!resourceProfileInstance) {
            flash.message = "ResourceProfile not found with id ${params.id}"
            redirect action:'list'
        }
        else {
            return [ resourceProfileInstance : resourceProfileInstance,entity: entityHelperService.loggedIn ]
        }
    }

    def update = {
      def resource = Entity.get(params.id)

      //template.properties = params
      resource.profile.fullName = params.fullName
      resource.profile.description = params.description

      if(!resource.hasErrors() && template.save()) {
          flash.message = message(code:"resource.updated", args:[resource.profile.fullName])
          redirect action:'show', id: resource.id
      }
      else {
          render view:'edit', model:[resourceProfileInstance: resource, entity: entityHelperService.loggedIn]
      }
    }

    def create = {
        //def resourceProfileInstance = new ResourceProfile()
        //resourceProfileInstance.properties = params
        return [entity: entityHelperService.loggedIn]
    }

    def save = {
      EntityType etResource = metaDataService.etResource

      try {
        def entity = entityHelperService.createEntity(params.fullName, etResource) {Entity ent ->
          ent.profile = profileHelperService.createProfileFor(ent)
          ent.profile.fullName = params.fullName
          ent.profile.description = params.description
        }
      } catch (de.uenterprise.ep.EntityException ee) {
        render (view:"create", model:[resourceProfileInstance:ee.entity, entity: entityHelperService.loggedIn])
        return
      }

      flash.message = message(code:"resource.created", args:[params.name])
      redirect action:'list'
    }
}
