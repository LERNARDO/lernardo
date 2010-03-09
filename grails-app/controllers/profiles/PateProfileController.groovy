package profiles

import de.uenterprise.ep.Entity
import de.uenterprise.ep.EntityType
import de.uenterprise.ep.Link

class PateProfileController {
    def metaDataService
    def entityHelperService
    def profileHelperService

    def index = {
        redirect action:"list", params:params 
    }

    // the delete, save and update actions only accept POST requests
    static allowedMethods = [delete:'POST', save:'POST', update:'POST']

    def list = {
        params.max = Math.min( params.max ? params.max.toInteger() : 10,  100)
        return [pateList: Entity.findAllByType(metaDataService.etPate),
                pateTotal: Entity.countByType(metaDataService.etPate)]
    }

    def show = {
        def pate = Entity.get(params.id)

        if(!pate) {
            flash.message = "PateProfile not found with id ${params.id}"
            redirect(action:list)
        }
        else {
            return [pate: pate, entity: entityHelperService.loggedIn]
        }
    }

    def del = {
        def pate = Entity.get(params.id)
        if(pate) {
            // delete all links
            Link.findAllBySourceOrTarget(pate, pate).each {it.delete()}
            try {
                flash.message = message(code:"pate.deleted", args:[pate.profile.lastName])
                pate.delete(flush:true)
                redirect(action:"list")
            }
            catch(org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = message(code:"pate.notDeleted", args:[pate.profile.lastName])
                redirect(action:"show",id:params.id)
            }
        }
        else {
            flash.message = "PateProfile not found with id ${params.id}"
            redirect(action:"list")
        }
    }

    def edit = {
        def pate = Entity.get(params.id)

        if(!pate) {
            flash.message = "PateProfile not found with id ${params.id}"
            redirect action:'list'
        }
        else {
            return [pate : pate, entity: entityHelperService.loggedIn]
        }
    }

    def update = {
      def pate = Entity.get(params.id)

      pate.profile.properties = params

      if(!pate.profile.hasErrors() && pate.profile.save()) {
          flash.message = message(code:"pate.updated", args:[pate.profile.lastName])
          redirect action:'show', id: pate.id
      }
      else {
          render view:'edit', model:[pate: pate, entity: entityHelperService.loggedIn]
      }
    }

    def create = {
        return [entity: entityHelperService.loggedIn]
    }

    def save = {
      EntityType etPate = metaDataService.etPate
           println params
      try {
        def entity = entityHelperService.createEntity("pate", etPate) {Entity ent ->
          ent.profile = profileHelperService.createProfileFor(ent)
          ent.profile.properties = params
        }
        flash.message = message(code:"pate.created", args:[entity.profile.lastName])
        redirect action:'list'
      } catch (de.uenterprise.ep.EntityException ee) {
        render (view:"create", model:[pate: ee.entity, entity: entityHelperService.loggedIn])
        return
      }

    }
}
