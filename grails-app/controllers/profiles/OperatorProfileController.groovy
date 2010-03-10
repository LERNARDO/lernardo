package profiles

import de.uenterprise.ep.Entity
import de.uenterprise.ep.EntityType
import de.uenterprise.ep.Link

class OperatorProfileController {
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
        return [operatorList: Entity.findAllByType(metaDataService.etOperator),
                operatorTotal: Entity.countByType(metaDataService.etOperator)]
    }

    def show = {
        def operator = Entity.get(params.id)

        if(!operator) {
            flash.message = "OperatorProfile not found with id ${params.id}"
            redirect(action:list)
        }
        else {
            return [operator: operator, entity: entityHelperService.loggedIn]
        }
    }

    def del = {
        def operator = Entity.get(params.id)
        if(operator) {
            // delete all links
            Link.findAllBySourceOrTarget(operator, operator).each {it.delete()}
            try {
                flash.message = message(code:"operator.deleted", args:[operator.profile.fullName])
                operator.delete(flush:true)
                redirect(action:"list")
            }
            catch(org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = message(code:"operator.notDeleted", args:[operator.profile.fullName])
                redirect(action:"show",id:params.id)
            }
        }
        else {
            flash.message = "OperatorProfile not found with id ${params.id}"
            redirect(action:"list")
        }
    }

    def edit = {
        def operator = Entity.get(params.id)

        if(!operator) {
            flash.message = "OperatorProfile not found with id ${params.id}"
            redirect action:'list'
        }
        else {
            return [operator: operator, entity: entityHelperService.loggedIn]
        }
    }

    def update = {
      def operator = Entity.get(params.id)

      operator.profile.properties = params

      if (params.showTips)
        operator.profile.showTips = true
      else
        operator.profile.showTips = false

      if (params.enabled)
        operator.user.enabled = true
      else
        operator.user.enabled = false

      if(!operator.profile.hasErrors() && operator.profile.save()) {
          flash.message = message(code:"operator.updated", args:[operator.profile.fullName])
          redirect action:'show', id: operator.id
      }
      else {
          render view:'edit', model:[operator: operator, entity: entityHelperService.loggedIn]
      }
    }

    def create = {
        return [entity: entityHelperService.loggedIn]
    }

    def save = {
      EntityType etOperator = metaDataService.etOperator
      println params

      try {
        def entity = entityHelperService.createEntityWithUserAndProfile("operator", etOperator, params.email, params.lastName + " " + params.firstName) {Entity ent ->
          ent.profile.properties = params
          ent.user.password = authenticateService.encodePassword("pass")
          if (params.enabled)
            ent.user.enabled = true
          else
            ent.user.enabled = false

        }
        flash.message = message(code:"operator.created", args:[entity.profile.fullName])
        redirect action:'list'
      } catch (de.uenterprise.ep.EntityException ee) {
        render (view:"create", model:[operator: ee.entity, entity: entityHelperService.loggedIn])
        return
      }

    }
}
