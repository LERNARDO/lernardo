package profiles

import de.uenterprise.ep.Entity
import de.uenterprise.ep.EntityType
import de.uenterprise.ep.Link
import org.springframework.web.servlet.support.RequestContextUtils
import de.uenterprise.ep.EntityHelperService
import org.grails.plugins.springsecurity.service.AuthenticateService
import standard.FunctionService
import standard.MetaDataService

class OperatorProfileController {
    MetaDataService metaDataService
    EntityHelperService entityHelperService
    AuthenticateService authenticateService
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
          ent.user.password = authenticateService.encodePassword("pass")
        }
        RequestContextUtils.getLocaleResolver(request).setLocale(request, response, entity.user.locale)

        flash.message = message(code:"operator.created", args:[entity.profile.fullName])
        redirect action:'list'
      } catch (de.uenterprise.ep.EntityException ee) {
        render (view:"create", model:[operator: ee.entity, entity: entityHelperService.loggedIn])
        return
      }

    }

    def addFacility = {
      Entity operator = Entity.get(params.id)

      // check if the facility isn't already linked to the operator
      def c = Link.createCriteria()
      def link = c.get {
        eq('source', Entity.get(params.facility))
        eq('target', operator)
        eq('type', metaDataService.ltOperation)
      }
      if (!link)
        new Link(source:Entity.get(params.facility), target: operator, type:metaDataService.ltOperation).save()

      // find all facilities of this operator
      def links = Link.findAllByTargetAndType(operator, metaDataService.ltOperation)
      List facilities = links.collect {it.source}

      render template:'facilities', model: [facilities: facilities, operator: operator, entity: entityHelperService.loggedIn]
    }

    def removeFacility = {
      Entity operator = Entity.get(params.id)

      def c = Link.createCriteria()
      def link = c.get {
        eq('source', Entity.get(params.facility))
        eq('target', operator)
        eq('type', metaDataService.ltOperation)
      }
      link.delete()

      // find all facilities of this operator
      def links = Link.findAllByTargetAndType(operator, metaDataService.ltOperation)
      List facilities = links.collect {it.source}

      render template:'facilities', model: [facilities: facilities, operator: operator, entity: entityHelperService.loggedIn]
    }
}
