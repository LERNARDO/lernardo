package profiles

import de.uenterprise.ep.Entity
import de.uenterprise.ep.EntityType
import de.uenterprise.ep.Link

class EducatorProfileController {
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
        return [educatorList: Entity.findAllByType(metaDataService.etEducator),
                educatorTotal: Entity.countByType(metaDataService.etEducator)]
    }

    def show = {
        def educator = Entity.get(params.id)
        def entity = params.entity ? educator : entityHelperService.loggedIn

        if(!educator) {
            flash.message = "EducatorProfile not found with id ${params.id}"
            redirect(action:list)
        }
        else {
            return [educator: educator, entity: entity]
        }
    }

    def del = {
        def educator = Entity.get(params.id)
        if(educator) {
            // delete all links
            Link.findAllBySourceOrTarget(educator, educator).each {it.delete()}
            try {
                flash.message = message(code:"educator.deleted", args:[educator.profile.fullName])
                educator.delete(flush:true)
                redirect(action:"list")
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
        def educator = Entity.get(params.id)

        if(!educator) {
            flash.message = "EducatorProfile not found with id ${params.id}"
            redirect action:'list'
        }
        else {
            return [educator: educator, entity: entityHelperService.loggedIn]
        }
    }

    def update = {
      def educator = Entity.get(params.id)

      educator.profile.properties = params

      educator.profile.showTips = params.showTips ?: false
      educator.profile.employed = params.employed ?: false
      educator.user.enabled = params.enabled ?: false

      if(!educator.profile.hasErrors() && educator.profile.save()) {
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
        def entity = entityHelperService.createEntityWithUserAndProfile("educator", etEducator, params.email, params.lastName + " " + params.firstName) {Entity ent ->
          ent.profile.properties = params
          ent.user.password = authenticateService.encodePassword("pass")
          ent.user.enabled = params.enabled ?: false
          ent.profile.employed = params.employed ?: false

        }
        flash.message = message(code:"educator.created", args:[entity.profile.fullName])
        redirect action:'list'
      } catch (de.uenterprise.ep.EntityException ee) {
        render (view:"create", model:[educator: ee.entity, entity: entityHelperService.loggedIn])
        return
      }

    }
}
