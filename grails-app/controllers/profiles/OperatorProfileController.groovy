package profiles

import at.openfactory.ep.Entity
import at.openfactory.ep.EntityType
import at.openfactory.ep.Link
import org.springframework.web.servlet.support.RequestContextUtils
import at.openfactory.ep.EntityHelperService
import standard.FunctionService
import standard.MetaDataService
import at.openfactory.ep.security.DefaultSecurityManager

class OperatorProfileController {
    MetaDataService metaDataService
    EntityHelperService entityHelperService
    def securityManager
    FunctionService functionService

    def index = {
        redirect action:"list", params:params
    }

    // the delete, save and update actions only accept POST requests
    static allowedMethods = [delete:'POST', save:'POST', update:'POST']

    def list = {
        params.max = Math.min( params.max ? params.int('max') : 10,  100)
        return [operatorList: Entity.findAllByType(metaDataService.etOperator),
                operatorTotal: Entity.countByType(metaDataService.etOperator),
                entity: entityHelperService.loggedIn]
    }

    def show = {
        Entity operator = Entity.get(params.id)
        Entity entity = params.entity ? operator : entityHelperService.loggedIn

        if(!operator) {
            flash.message = "OperatorProfile not found with id ${params.id}"
            redirect(action:list)
        }
        else {
          def allFacilities = Entity.findAllByType(metaDataService.etFacility)
          // find all facilities of this operator
          def links = Link.findAllByTargetAndType(entity, metaDataService.ltOperation)
          List facilities = links.collect {it.source}

          return [operator: operator, entity: entity, facilities: facilities, allFacilities: allFacilities]
        }
    }

    def del = {
        Entity operator = Entity.get(params.id)
        if(operator) {
            // delete all links
            Link.findAllBySourceOrTarget(operator, operator).each {it.delete()}
            try {
                flash.message = message(code:"operator.deleted", args:[operator.profile.fullName])
                operator.delete(flush:true)
                redirect(controller:"profile", action:"list")
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
        Entity operator = Entity.get(params.id)

        if(!operator) {
            flash.message = "OperatorProfile not found with id ${params.id}"
            redirect action:'list'
        }
        else {
            return [operator: operator, entity: entityHelperService.loggedIn]
        }
    }

    def update = {
      Entity operator = Entity.get(params.id)

      operator.profile.properties = params
      operator.user.properties = params
      RequestContextUtils.getLocaleResolver(request).setLocale(request, response, operator.user.locale)

      if(!operator.hasErrors() && operator.save()) {
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

      try {
        Entity entity = entityHelperService.createEntityWithUserAndProfile(functionService.createNick(params.fullName), etOperator, params.email, params.fullName) {Entity ent ->
          ent.profile.properties = params
          ent.user.properties = params
          ent.user.password = securityManager.encodePassword("pass")
        }
        RequestContextUtils.getLocaleResolver(request).setLocale(request, response, entity.user.locale)

        flash.message = message(code:"operator.created", args:[entity.profile.fullName])
        redirect action:'list'
      } catch (at.openfactory.ep.EntityException ee) {
        render (view:"create", model:[operator: ee.entity, entity: entityHelperService.loggedIn])
        return
      }

    }

    def addFacility = {
      def linking = functionService.linkEntities(params.facility, params.id, metaDataService.ltOperation)
      if (linking.duplicate)
        render '<span class="red italic">"' + linking.source.profile.fullName + '" wurde bereits zugewiesen!</span>'
      render template:'facilities', model: [facilities: linking.results, operator: linking.target, entity: entityHelperService.loggedIn]
    }

    def removeFacility = {
      def breaking = functionService.breakEntities(params.facility, params.id, metaDataService.ltOperation)
      render template:'facilities', model: [facilities: breaking.results, operator: breaking.target, entity: entityHelperService.loggedIn]
    }
}
