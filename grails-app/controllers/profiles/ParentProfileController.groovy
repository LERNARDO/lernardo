package profiles

import de.uenterprise.ep.Entity
import de.uenterprise.ep.EntityType
import de.uenterprise.ep.Link

class ParentProfileController {
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
        return [parentList: Entity.findAllByType(metaDataService.etParent),
                parentTotal: Entity.countByType(metaDataService.etParent)]
    }

    def show = {
        def parent = Entity.get(params.id)

        if(!parent) {
            flash.message = "ParentProfile not found with id ${params.id}"
            redirect(action:list)
        }
        else {
            return [parent: parent, entity: entityHelperService.loggedIn]
        }
    }

    def del = {
        def parent = Entity.get(params.id)
        if(parent) {
            // delete all links
            Link.findAllBySourceOrTarget(parent, parent).each {it.delete()}
            try {
                flash.message = message(code:"parent.deleted", args:[parent.profile.lastName])
                parent.delete(flush:true)
                redirect(action:"list")
            }
            catch(org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = message(code:"parent.notDeleted", args:[parent.profile.lastName])
                redirect(action:"show",id:params.id)
            }
        }
        else {
            flash.message = "ParentProfile not found with id ${params.id}"
            redirect(action:"list")
        }
    }

    def edit = {
        def parent = Entity.get(params.id)

        if(!parent) {
            flash.message = "ParentProfile not found with id ${params.id}"
            redirect action:'list'
        }
        else {
            return [parent: parent, entity: entityHelperService.loggedIn]
        }
    }

    def update = {
      def parent = Entity.get(params.id)

      parent.profile.properties = params
      //parent.profile.birthDate = new Date(Integer.parseInt(params.birthDate_year)-1900,Integer.parseInt(params.birthDate_month)-1,Integer.parseInt(params.birthDate_day))

      if (params.showTips)
        parent.profile.showTips = true
      else
        parent.profile.showTips = false

      if (params.doesWork)
        parent.profile.doesWork = true
      else
        parent.profile.doesWork = false

      if (params.enabled)
        parent.user.enabled = true
      else
        parent.user.enabled = false

      if(!parent.profile.hasErrors() && parent.profile.save()) {
          flash.message = message(code:"parent.updated", args:[parent.profile.lastName])
          redirect action:'show', id: parent.id
      }
      else {
          render view:'edit', model:[parent: parent, entity: entityHelperService.loggedIn]
      }
    }

    def create = {
        return [entity: entityHelperService.loggedIn]
    }

    def save = {
      EntityType etParent = metaDataService.etParent
      println params

      try {
        def entity = entityHelperService.createEntityWithUserAndProfile("parent", etParent, params.email, params.lastName + " " + params.firstName) {Entity ent ->
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
        flash.message = message(code:"parent.created", args:[entity.profile.lastName])
        redirect action:'list'
      } catch (de.uenterprise.ep.EntityException ee) {
        render (view:"create", model:[parent: ee.entity, entity: entityHelperService.loggedIn])
        return
      }

    }
}
