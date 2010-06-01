package profiles

import de.uenterprise.ep.Entity
import de.uenterprise.ep.EntityType
import de.uenterprise.ep.Link
import org.springframework.web.servlet.support.RequestContextUtils
import de.uenterprise.ep.EntityHelperService
import org.grails.plugins.springsecurity.service.AuthenticateService
import lernardo.Contact
import standard.FunctionService
import standard.MetaDataService

class FacilityProfileController {
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
        return [facilities: Entity.findAllByType(metaDataService.etFacility),
                facilityTotal: Entity.countByType(metaDataService.etFacility),
                entity: entityHelperService.loggedIn]
    }

    def show = {
        Entity facility = Entity.get(params.id)
        Entity entity = params.entity ? facility : entityHelperService.loggedIn

        if(!facility) {
            flash.message = "FacilityProfile not found with id ${params.id}"
            redirect(action:list)
        }
        else {
          def allResources = Entity.findAllByType(metaDataService.etResource)
          // find all resources of this facility
          def links = Link.findAllByTargetAndType(entity, metaDataService.ltResource)
          List resources = links.collect {it.source}

          def allEducators = Entity.findAllByType(metaDataService.etEducator)
          // find all educators of this facility
          links = Link.findAllByTargetAndType(entity, metaDataService.ltWorking)
          List educators = links.collect {it.source}

          def allClientGroups = Entity.findAllByType(metaDataService.etGroupClient)
          // find all clientgroups of this facility
          links = Link.findAllByTargetAndType(entity, metaDataService.ltClientship)
          List clientGroups = links.collect {it.source}

          return [facility: facility,
                  entity: entity,
                  allEducators: allEducators,
                  educators: educators,
                  allClientGroups: allClientGroups,
                  clientGroups: clientGroups,
                  allResources: allResources,
                  resources: resources]
        }
    }

    def addResource = {
      Entity facility = Entity.get(params.id)
      // check if the resource isn't already linked to the facility
      def c = Link.createCriteria()
      def link = c.get {
        eq('source', Entity.get(params.resource))
        eq('target', facility)
        eq('type', metaDataService.ltResource)
      }
      if (!link)
        new Link(source:Entity.get(params.resource), target: facility, type:metaDataService.ltResource).save()
      // find all resources of this facility
      def links = Link.findAllByTargetAndType(facility, metaDataService.ltResource)
      List resources = links.collect {it.source}

      render template:'resources', model: [resources: resources, facility: facility, entity: entityHelperService.loggedIn]
    }

    def removeResource = {
      Entity facility = Entity.get(params.id)
      
      def c = Link.createCriteria()
      def link = c.get {
        eq('source', Entity.get(params.resource))
        eq('target', facility)
        eq('type', metaDataService.ltResource)
      }
      link.delete()
      // find all resources of this facility
      def links = Link.findAllByTargetAndType(facility, metaDataService.ltResource)
      List resources = links.collect {it.source}

      render template:'resources', model: [resources: resources, facility: facility, entity: entityHelperService.loggedIn]
    }

    def addEducator = {
      Entity facility = Entity.get(params.id)

      // check if the educator isn't already linked to the facility
      def c = Link.createCriteria()
      def link = c.get {
        eq('source', Entity.get(params.educator))
        eq('target', facility)
        eq('type', metaDataService.ltWorking)
      }
      if (!link)
        new Link(source:Entity.get(params.educator), target: facility, type:metaDataService.ltWorking).save()

      // find all educators of this facility
      def links = Link.findAllByTargetAndType(facility, metaDataService.ltWorking)
      List educators = links.collect {it.source}

      render template:'educators', model: [educators: educators, facility: facility, entity: entityHelperService.loggedIn]
    }

    def removeEducator = {
      Entity facility = Entity.get(params.id)

      def c = Link.createCriteria()
      def link = c.get {
        eq('source', Entity.get(params.educator))
        eq('target', facility)
        eq('type', metaDataService.ltWorking)
      }
      link.delete()

      // find all educators of this facility
      def links = Link.findAllByTargetAndType(facility, metaDataService.ltWorking)
      List educators = links.collect {it.source}

      render template:'educators', model: [educators: educators, facility: facility, entity: entityHelperService.loggedIn]
    }
  
    def addClientGroup = {
      Entity facility = Entity.get(params.id)

      // check if the client isn't already linked to the facility
      def c = Link.createCriteria()
      def link = c.get {
        eq('source', Entity.get(params.clientgroup))
        eq('target', facility)
        eq('type', metaDataService.ltClientship)
      }
      if (!link)
        new Link(source:Entity.get(params.clientgroup), target: facility, type:metaDataService.ltClientship).save()

      // find all clientgroups of this facility
      def links = Link.findAllByTargetAndType(facility, metaDataService.ltClientship)
      List clientgroups = links.collect {it.source}

      render template:'clientgroups', model: [clientgroups: clientgroups, facility: facility, entity: entityHelperService.loggedIn]
    }

    def removeClientGroup = {
      Entity facility = Entity.get(params.id)

      def c = Link.createCriteria()
      def link = c.get {
        eq('source', Entity.get(params.clientgroup))
        eq('target', facility)
        eq('type', metaDataService.ltClientship)
      }
      link.delete()

      // find all clientgroups of this facility
      def links = Link.findAllByTargetAndType(facility, metaDataService.ltClientship)
      List clientgroups = links.collect {it.source}

      render template:'clientgroups', model: [clientgroups: clientgroups, facility: facility, entity: entityHelperService.loggedIn]
    }

    def del = {
        Entity facility = Entity.get(params.id)
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
        Entity facility = Entity.get(params.id)

        if(!facility) {
            flash.message = "FacilityProfile not found with id ${params.id}"
            redirect action:'list'
        }
        else {
            return [facility: facility, entity: entityHelperService.loggedIn]
        }
    }

    def update = {
      Entity facility = Entity.get(params.id)

      facility.profile.properties = params
      facility.user.properties = params
      RequestContextUtils.getLocaleResolver(request).setLocale(request, response, facility.user.locale)

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
        Entity entity = entityHelperService.createEntityWithUserAndProfile(functionService.createNick(params.fullName), etFacility, params.email, params.fullName) {Entity ent ->
          ent.profile.properties = params
          ent.user.properties = params
          ent.user.password = authenticateService.encodePassword("pass")
        }
        RequestContextUtils.getLocaleResolver(request).setLocale(request, response, entity.user.locale)

        flash.message = message(code:"facility.created", args:[entity.profile.fullName])
        redirect action:'list'
      } catch (de.uenterprise.ep.EntityException ee) {
        render (view:"create", model:[facility: ee.entity, entity: entityHelperService.loggedIn])
        return
      }

    }

    def addContact = {
      Contact contact = new Contact()
      contact.properties = params
      Entity facility = Entity.get(params.id)
      facility.profile.addToContacts(contact)
      render template:'contacts', model: [facility: facility, entity: entityHelperService.loggedIn]
    }

    def removeContact = {
      Entity facility = Entity.get(params.id)
      facility.profile.removeFromContacts(Contact.get(params.contact))
      Contact.get(params.contact).delete()
      render template:'contacts', model: [facility: facility, entity: entityHelperService.loggedIn]
    }
}
