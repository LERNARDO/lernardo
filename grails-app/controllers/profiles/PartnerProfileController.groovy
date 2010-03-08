package profiles

import de.uenterprise.ep.Entity
import de.uenterprise.ep.EntityType

class PartnerProfileController {
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
        return [partnerList: Entity.findAllByType(metaDataService.etPartner),
                partnerTotal: Entity.countByType(metaDataService.etPartner)]
    }

    def show = {
        def partner = Entity.get(params.id)

        if(!partner) {
            flash.message = "PartnerProfile not found with id ${params.id}"
            redirect(action:list)
        }
        else {
            return [partner: partner, entity: entityHelperService.loggedIn ]
        }
    }

    def del = {
        def partner = Entity.get(params.id)
        if(partner) {
            try {
                flash.message = message(code:"partner.deleted", args:[partner.profile.fullName])
                partner.delete(flush:true)
                redirect(action:"list")
            }
            catch(org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = message(code:"partner.notDeleted", args:[partner.profile.fullName])
                redirect(action:"show",id:params.id)
            }
        }
        else {
            flash.message = "PartnerProfile not found with id ${params.id}"
            redirect(action:"list")
        }
    }

    def edit = {
        def partner = Entity.get(params.id)

        if(!partner) {
            flash.message = "PartnerProfile not found with id ${params.id}"
            redirect action:'list'
        }
        else {
            return [partner: partner, entity: entityHelperService.loggedIn]
        }
    }

    def update = {
      def partner = Entity.get(params.id)

      partner.profile.properties = params

      if(!partner.profile.hasErrors() && partner.profile.save()) {
          flash.message = message(code:"partner.updated", args:[partner.profile.fullName])
          redirect action:'show', id: partner.id
      }
      else {
          render view:'edit', model:[partner: partner, entity: entityHelperService.loggedIn]
      }
    }

    def create = {
        return [entity: entityHelperService.loggedIn]
    }

    def save = {
      EntityType etPartner = metaDataService.etPartner

      try {
        def entity = entityHelperService.createEntity("partner", etPartner) {Entity ent ->
          ent.profile = profileHelperService.createProfileFor(ent)
          ent.profile.fullName = params.fullName
          ent.profile.PLZ = params.PLZ ? params.PLZ.toInteger() : 0
          ent.profile.city = params.city
          ent.profile.street = params.street
          ent.profile.description = params.description
          ent.profile.tel = params.tel
        }
        flash.message = message(code:"partner.created", args:[entity.profile.fullName])
        redirect action:'list'
      } catch (de.uenterprise.ep.EntityException ee) {
        render (view:"create", model:[partner: ee.entity, entity: entityHelperService.loggedIn])
        return
      }

    }
}
