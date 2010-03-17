package profiles

import de.uenterprise.ep.Entity
import de.uenterprise.ep.EntityType
import de.uenterprise.ep.Link
import org.springframework.web.servlet.support.RequestContextUtils

class OperatorProfileController {
    def metaDataService
    def entityHelperService
    def authenticateService
    def functionService

    def index = {
        redirect action:"list", params:params
    }

    // the delete, save and update actions only accept POST requests
    static allowedMethods = [delete:'POST', save:'POST', update:'POST']

    def list = {
        params.max = Math.min( params.max ? params.int('max') : 10,  100)
        return [operatorList: Entity.findAllByType(metaDataService.etOperator),
                operatorTotal: Entity.countByType(metaDataService.etOperator)]
    }

    def show = {
        def operator = Entity.get(params.id)
        def entity = params.entity ? operator : entityHelperService.loggedIn

        if(!operator) {
            flash.message = "OperatorProfile not found with id ${params.id}"
            redirect(action:list)
        }
        else {
          def allFacilities = Entity.findAllByType(metaDataService.etFacility)

          // find all facilities of this operator
          List facilities = []
          def links = Link.findAllByTargetAndType(entity, metaDataService.ltOperation)
          links.each {
              facilities << it.source
          }
          return [operator: operator, entity: entity, facilities: facilities, allFacilities: allFacilities]
        }
    }

    def addFacility = {
      // check if the facility isn't already linked to the operator
      def c = Link.createCriteria()
      def link = c.get {
        eq('source', Entity.get(params.facility))
        eq('target', entityHelperService.loggedIn)
        eq('type', metaDataService.ltOperation)
      }
      if (!link)
        new Link(source:Entity.get(params.facility), target: entityHelperService.loggedIn, type:metaDataService.ltOperation).save()
      // find all facilities of this operator
      List facilities = []
      def links = Link.findAllByTargetAndType(entityHelperService.loggedIn, metaDataService.ltOperation)
      links.each {
          facilities << it.source
      }
      render template:'facilities', model: [facilities: facilities, entity: entityHelperService.loggedIn]
    }

    def removeFacility = {
      def c = Link.createCriteria()
      def link = c.get {
        eq('source', Entity.get(params.id))
        eq('target', entityHelperService.loggedIn)
        eq('type', metaDataService.ltOperation)
      }
      link.delete()
      // find all facilities of this operator
      List facilities = []
      def links = Link.findAllByTargetAndType(entityHelperService.loggedIn, metaDataService.ltOperation)
      links.each {
          facilities << it.source
      }
      render template:'facilities', model: [facilities: facilities, entity: entityHelperService.loggedIn]
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

      operator.profile.showTips = params.showTips ?: false
      operator.user.enabled = params.enabled ?: false

      if (params.lang == '1') {
        operator.user.locale = new Locale ("de", "DE")
        Locale locale = operator.user.locale
        RequestContextUtils.getLocaleResolver(request).setLocale(request, response, locale)
      }
      if (params.lang == '2') {
        operator.user.locale = new Locale ("ES", "ES")
        Locale locale = operator.user.locale
        RequestContextUtils.getLocaleResolver(request).setLocale(request, response, locale)
      }

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
        def entity = entityHelperService.createEntityWithUserAndProfile(functionService.createNick(params.fullName), etOperator, params.email, params.fullName) {Entity ent ->
          ent.profile.properties = params
          ent.user.password = authenticateService.encodePassword("pass")
          ent.user.enabled = params.enabled ?: false
        }
        if (params.lang == '1') {
          entity.user.locale = new Locale ("de", "DE")
          Locale locale = entity.user.locale
          RequestContextUtils.getLocaleResolver(request).setLocale(request, response, locale)
        }
        if (params.lang == '2') {
          entity.user.locale = new Locale ("ES", "ES")
          Locale locale = entity.user.locale
          RequestContextUtils.getLocaleResolver(request).setLocale(request, response, locale)
        }
        flash.message = message(code:"operator.created", args:[entity.profile.fullName])
        redirect action:'list'
      } catch (de.uenterprise.ep.EntityException ee) {
        render (view:"create", model:[operator: ee.entity, entity: entityHelperService.loggedIn])
        return
      }

    }
}
