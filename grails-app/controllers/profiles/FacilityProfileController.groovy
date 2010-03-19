package profiles

import de.uenterprise.ep.Entity
import de.uenterprise.ep.EntityType
import de.uenterprise.ep.Link
import org.springframework.web.servlet.support.RequestContextUtils

class FacilityProfileController {
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
        return [facilities: Entity.findAllByType(metaDataService.etFacility),
                facilityTotal: Entity.countByType(metaDataService.etFacility)]
    }

    def show = {
        def facility = Entity.get(params.id)
        def entity = params.entity ? facility : entityHelperService.loggedIn

        if(!facility) {
            flash.message = "FacilityProfile not found with id ${params.id}"
            redirect(action:list)
        }
        else {
          def allEducators = Entity.findAllByType(metaDataService.etEducator)

          // find all facilities of this operator
          List educators = []
          def links = Link.findAllByTargetAndType(entity, metaDataService.ltWorking)
          links.each {
              educators << it.source
          }

          def allClients = Entity.findAllByType(metaDataService.etClient)

          // find all facilities of this operator
          List clients = []
          links = Link.findAllByTargetAndType(entity, metaDataService.ltClientship)
          links.each {
              clients << it.source
          }
          return [facility: facility, entity: entity, allEducators: allEducators, educators: educators, allClients: allClients, clients: clients]
        }
    }

    def addEducator = {
      // check if the educator isn't already linked to the facility
      def c = Link.createCriteria()
      def link = c.get {
        eq('source', Entity.get(params.educator))
        eq('target', entityHelperService.loggedIn)
        eq('type', metaDataService.ltWorking)
      }
      if (!link)
        new Link(source:Entity.get(params.educator), target: entityHelperService.loggedIn, type:metaDataService.ltWorking).save()
      // find all educators of this facility
      List educators = []
      def links = Link.findAllByTargetAndType(entityHelperService.loggedIn, metaDataService.ltWorking)
      links.each {
          educators << it.source
      }
      render template:'educators', model: [educators: educators, entity: entityHelperService.loggedIn]
    }

    def removeEducator = {
      def c = Link.createCriteria()
      def link = c.get {
        eq('source', Entity.get(params.id))
        eq('target', entityHelperService.loggedIn)
        eq('type', metaDataService.ltWorking)
      }
      link.delete()
      // find all educators of this facility
      List educators = []
      def links = Link.findAllByTargetAndType(entityHelperService.loggedIn, metaDataService.ltWorking)
      links.each {
          educators << it.source
      }
      render template:'educators', model: [educators: educators, entity: entityHelperService.loggedIn]
    }
  
    def addClient = {
      // check if the client isn't already linked to the facility
      def c = Link.createCriteria()
      def link = c.get {
        eq('source', Entity.get(params.client))
        eq('target', entityHelperService.loggedIn)
        eq('type', metaDataService.ltClientship)
      }
      if (!link)
        new Link(source:Entity.get(params.client), target: entityHelperService.loggedIn, type:metaDataService.ltClientship).save()
      // find all clients of this facility
      List clients = []
      def links = Link.findAllByTargetAndType(entityHelperService.loggedIn, metaDataService.ltClientship)
      links.each {
          clients << it.source
      }
      render template:'clients', model: [clients: clients, entity: entityHelperService.loggedIn]
    }

    def removeClient = {
      def c = Link.createCriteria()
      def link = c.get {
        eq('source', Entity.get(params.id))
        eq('target', entityHelperService.loggedIn)
        eq('type', metaDataService.ltClientship)
      }
      link.delete()
      // find all clients of this facility
      List clients = []
      def links = Link.findAllByTargetAndType(entityHelperService.loggedIn, metaDataService.ltClientship)
      links.each {
          clients << it.source
      }
      render template:'clients', model: [clients: clients, entity: entityHelperService.loggedIn]
    }

    def del = {
        def facility = Entity.get(params.id)
        if(facility) {
            // delete all links
            Link.findAllBySourceOrTarget(facility, facility).each {it.delete()}
            try {
                flash.message = message(code:"facility.deleted", args:[facility.profile.fullName])
                facility.delete(flush:true)
                redirect(controller:"profile", action:"list")
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
      facility.user.properties = params

      facility.profile.showTips = params.showTips ?: false
      facility.user.enabled = params.enabled ?: false

      if (params.lang == '1') {
        facility.user.locale = new Locale ("de", "DE")
        Locale locale = facility.user.locale
        RequestContextUtils.getLocaleResolver(request).setLocale(request, response, locale)
      }
      if (params.lang == '2') {
        facility.user.locale = new Locale ("ES", "ES")
        Locale locale = facility.user.locale
        RequestContextUtils.getLocaleResolver(request).setLocale(request, response, locale)
      }

      if(!facility.hasErrors() && facility.save()) {
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
        def entity = entityHelperService.createEntityWithUserAndProfile(functionService.createNick(params.fullName), etFacility, params.email, params.fullName) {Entity ent ->
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
        flash.message = message(code:"facility.created", args:[entity.profile.fullName])
        redirect action:'list'
      } catch (de.uenterprise.ep.EntityException ee) {
        render (view:"create", model:[facility: ee.entity, entity: entityHelperService.loggedIn])
        return
      }

    }
}
