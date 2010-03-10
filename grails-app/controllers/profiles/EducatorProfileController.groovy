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

        if(!educator) {
            flash.message = "EducatorProfile not found with id ${params.id}"
            redirect(action:list)
        }
        else {
            return [educator: educator, entity: entityHelperService.loggedIn]
        }
    }

    def del = {
        def educator = Entity.get(params.id)
        if(educator) {
            // delete all links
            Link.findAllBySourceOrTarget(educator, educator).each {it.delete()}
            try {
                flash.message = message(code:"educator.deleted", args:[educator.profile.lastName])
                educator.delete(flush:true)
                redirect(action:"list")
            }
            catch(org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = message(code:"educator.notDeleted", args:[educator.profile.lastName])
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
      //educator.profile.birthDate = new Date(Integer.parseInt(params.birthDate_year)-1900,Integer.parseInt(params.birthDate_month)-1,Integer.parseInt(params.birthDate_day))

      if (params.showTips)
        educator.profile.showTips = true
      else
        educator.profile.showTips = false

      if (params.employed)
        educator.profile.employed = true
      else
        educator.profile.employed = false

      if (params.enabled)
        educator.user.enabled = true
      else
        educator.user.enabled = false

      if(!educator.profile.hasErrors() && educator.profile.save()) {
          flash.message = message(code:"educator.updated", args:[educator.profile.lastName])
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
          // TODO: figure out why the date makes problems, once again
          //ent.profile.birthDate = new Date(Integer.parseInt(params.birthDate_year)-1900,Integer.parseInt(params.birthDate_month)-1,Integer.parseInt(params.birthDate_day))
          ent.profile.birthDate = new Date()
          ent.profile.joinDate = new Date()
          ent.user.password = authenticateService.encodePassword("pass")
          if (params.enabled)
            ent.user.enabled = true
          else
            ent.user.enabled = false

          if (params.employed)
            ent.profile.employed = true
          else
            ent.profile.employed = false
        }
        flash.message = message(code:"educator.created", args:[entity.profile.lastName])
        redirect action:'list'
      } catch (de.uenterprise.ep.EntityException ee) {
        render (view:"create", model:[educator: ee.entity, entity: entityHelperService.loggedIn])
        return
      }

    }
}
