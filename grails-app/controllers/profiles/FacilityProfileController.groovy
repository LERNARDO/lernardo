package profiles

import de.uenterprise.ep.Entity
import de.uenterprise.ep.EntityType
import de.uenterprise.ep.Link

class FacilityProfileController {
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
        return [facilities: Entity.findAllByType(metaDataService.etFacility),
                facilityTotal: Entity.countByType(metaDataService.etFacility)]
    }

    def show = {
        def facility = Entity.get(params.id)

        if(!facility) {
            flash.message = "FacilityProfile not found with id ${params.id}"
            redirect(action:list)
        }
        else {
            return [facility: facility, entity: entityHelperService.loggedIn]
        }
    }

    def del = {
        def facility = Entity.get(params.id)
        if(facility) {
            // delete all links
            Link.findAllBySourceOrTarget(facility, facility).each {it.delete()}
            try {
                flash.message = message(code:"facility.deleted", args:[facility.profile.fullName])
                facility.delete(flush:true)
                redirect(action:"list")
            }
            catch(org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = message(code:"facility.notDeleted", args:[facility.profile.fullName])
                redirect(action:"show",id:params.id)
            }
        }
        else {
            flash.message = "FacilityProfile not found with id ${params.id}"
            redirect(action:"list")
        }
    }

    def edit = {
        def facility = Entity.get(params.id)

        if(!facility) {
            flash.message = "FacilityProfile not found with id ${params.id}"
            redirect action:'list'
        }
        else {
            return [facility: facility, entity: entityHelperService.loggedIn]
        }
    }

    def update = {
      def facility = Entity.get(params.id)

      facility.profile.properties = params

      if (params.showTips)
        facility.profile.showTips = true
      else
        facility.profile.showTips = false

      if (params.enabled)
        facility.user.enabled = true
      else
        facility.user.enabled = false

      if(!facility.profile.hasErrors() && facility.profile.save()) {
          flash.message = message(code:"facility.updated", args:[facility.profile.fullName])
          redirect action:'show', id: facility.id
      }
      else {
          render view:'edit', model:[facility: facility, entity: entityHelperService.loggedIn]
      }
    }

    def create = {
        return [entity: entityHelperService.loggedIn]
    }

    def save = {
      EntityType etFacility = metaDataService.etFacility

      try {
        def entity = entityHelperService.createEntityWithUserAndProfile("facility", etFacility, params.email, params.fullName) {Entity ent ->
          ent.profile.properties = params
          ent.user.password = authenticateService.encodePassword("pass")
          if (params.enabled)
            ent.user.enabled = true
          else
            ent.user.enabled = false
        }
        flash.message = message(code:"facility.created", args:[entity.profile.fullName])
        redirect action:'list'
      } catch (de.uenterprise.ep.EntityException ee) {
        render (view:"create", model:[facility: ee.entity, entity: entityHelperService.loggedIn])
        return
      }

    }
}
