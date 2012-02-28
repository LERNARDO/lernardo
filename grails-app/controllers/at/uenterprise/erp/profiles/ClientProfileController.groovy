package at.uenterprise.erp.profiles

import at.openfactory.ep.Entity
import at.openfactory.ep.EntityType
import at.openfactory.ep.Link
import at.openfactory.ep.EntityHelperService
import at.uenterprise.erp.Materials
import at.uenterprise.erp.MetaDataService
import at.uenterprise.erp.FunctionService
import at.uenterprise.erp.CDate
import at.uenterprise.erp.Performances
import at.uenterprise.erp.Healths
import at.openfactory.ep.EntityException
import at.uenterprise.erp.Collector
import at.uenterprise.erp.Contact
import java.util.regex.Pattern

class ClientProfileController {
  MetaDataService metaDataService
  EntityHelperService entityHelperService
  def securityManager
  FunctionService functionService

  def index = {
    redirect action: "list", params: params
  }

  // the delete, save and update actions only accept POST requests
  static allowedMethods = [delete: 'POST', save: 'POST', update: 'POST']

  def list = {
    params.offset = params.int('offset') ?: 0
    params.max = Math.min(params.int('max') ?: 15, 100)
    params.sort = params.sort ?: "fullName"
    params.order = params.order ?: "asc"

    EntityType etClient = metaDataService.etClient
    def clients = Entity.createCriteria().list {
      eq("type", etClient)
      user {
        eq('enabled', true)
      }
      profile {
        order(params.sort, params.order)
      }
      maxResults(params.max)
      firstResult(params.offset)
    }
    int totalClients = Entity.findAllByType(etClient).findAll{it.user.enabled}.size()//Entity.countByType(etClient)

    List facilities = Entity.findAllByType(metaDataService.etFacility)

    return [clients: clients, totalClients: totalClients, facilities: facilities]
  }

  def listInactive = {
    params.offset = params.int('offset') ?: 0
    params.max = Math.min(params.int('max') ?: 15, 100)
    params.sort = params.sort ?: "fullName"
    params.order = params.order ?: "asc"

    EntityType etClient = metaDataService.etClient
    def clients = Entity.createCriteria().list {
      eq("type", etClient)
      user {
        eq('enabled', false)
      }
      profile {
        order(params.sort, params.order)
      }
      maxResults(params.max)
      firstResult(params.offset)
    }
    int totalClients = Entity.findAllByType(etClient).findAll{!it.user.enabled}.size()//Entity.countByType(etEducator)

    List facilities = Entity.findAllByType(metaDataService.etFacility)

    return [clients: clients, totalClients: totalClients, facilities: facilities]
  }

  def show = {
    Entity client = Entity.get(params.id)

    if (!client) {
      flash.message = message(code: "object.notFound", args: [message(code: "client")])
      redirect(action: list)
      return
    }

    Entity colony = functionService.findByLink(null, client, metaDataService.ltColonia)
    Entity family = functionService.findByLink(client, null, metaDataService.ltGroupFamily)
    List pates = functionService.findAllByLink(client, null,  metaDataService.ltPate)
    List facilities = Entity.findAllByType(metaDataService.etFacility)

    return [client: client, colony: colony, family: family, pates: pates, facilities: facilities]

  }

  def delete = {
    Entity client = Entity.get(params.id)
    if (client) {
      functionService.deleteReferences(client)
      try {
        flash.message = message(code: "object.deleted", args: [message(code: "client"), client.profile.fullName])
        client.delete(flush: true)
        redirect(action: "list")
      }
      catch (org.springframework.dao.DataIntegrityViolationException e) {
        flash.message = message(code: "object.notDeleted", args: [message(code: "client"), client.profile.fullName])
        redirect(action: "show", id: params.id)
      }
    }
    else {
      flash.message = message(code: "object.notFound", args: [message(code: "client")])
      redirect(action: "list")
    }
  }

  def edit = {
    params.sort = params.sort ?: "fullName"
    params.order = params.order ?: "asc"

    Entity client = Entity.get(params.id)

    if (!client) {
      flash.message = message(code: "object.notFound", args: [message(code: "client")])
      redirect action: 'list'
      return
    }

    Entity colony = functionService.findByLink(null, client, metaDataService.ltColonia)

    def c = Entity.createCriteria()
    def allColonies = c.list {
      eq("type", metaDataService.etGroupColony)
      profile {
        order(params.sort, params.order)
      }
    }

    def d = Entity.createCriteria()
    def allFacilities = d.list {
      eq("type", metaDataService.etFacility)
      profile {
        order(params.sort, params.order)
      }
    }

    return [client: client,
            colony: colony,
            allColonies: allColonies,
            allFacilities: allFacilities]
  }

  def update = {
    params.birthDate = params.date('birthDate', 'dd. MM. yy') ?: params.date('birthDate', 'dd.MM.yy')
    params.schoolDropoutDate = params.date('schoolDropoutDate', 'dd. MM. yy') ?: params.date('schoolDropoutDate', 'dd.MM.yy')
    params.schoolRestartDate = params.date('schoolRestartDate', 'dd. MM. yy') ?: params.date('schoolRestartDate', 'dd.MM.yy')

    Entity client = Entity.get(params.id)

    client.profile.properties = params
    client.profile.fullName = params.lastName + " " + params.firstName
    client.user.properties = params

    // update link to colony
    Link.findByTargetAndType(client, metaDataService.ltColonia)?.delete()
    new Link(source: Entity.get(params.currentColony), target: client, type: metaDataService.ltColonia).save()

    // update link to school
    //Link.findByTargetAndType(client, metaDataService.ltFacility)?.delete()
    //new Link(source: Entity.get(params.school), target: client, type: metaDataService.ltFacility).save()

    if (client.profile.save() && client.user.save() && client.save()) {
      flash.message = message(code: "object.updated", args: [message(code: "client"), client.profile.fullName])
      redirect action: 'show', id: client.id, params: [entity: client.id]
    }
    else {
      params.sort = params.sort ?: "fullName"
      params.order = params.order ?: "asc"
      Entity colony = functionService.findByLink(null, client, metaDataService.ltColonia)
      //Entity school = functionService.findByLink(null, client, metaDataService.ltFacility)

      def c = Entity.createCriteria()
      def allColonies = c.list {
        eq("type", metaDataService.etGroupColony)
        profile {
          order(params.sort, params.order)
        }
      }

      def d = Entity.createCriteria()
      def allFacilities = d.list {
        eq("type", metaDataService.etFacility)
        profile {
          order(params.sort, params.order)
        }
      }
      render view: 'edit', model: [client: client, colony: colony, allColonies: allColonies, allFacilities: allFacilities]
    }
  }

  def create = {
    params.sort = params.sort ?: "fullName"
    params.order = params.order ?: "asc"

    def c = Entity.createCriteria()
    def allColonies = c.list {
      eq("type", metaDataService.etGroupColony)
      profile {
        order(params.sort, params.order)
      }
    }

    def d = Entity.createCriteria()
    def allFacilities = d.list {
      eq("type", metaDataService.etFacility)
      profile {
        order(params.sort, params.order)
      }
    }

    return [allColonies: allColonies,
            allFacilities: allFacilities]
  }

  def save = {
    EntityType etClient = metaDataService.etClient

    try {
      Entity entity = entityHelperService.createEntityWithUserAndProfile(functionService.createNick(params.firstName, params.lastName), etClient, params.email, params.lastName + " " + params.firstName) {Entity ent ->

        ent.profile.properties = params
        ent.user.properties = params
        ent.profile.birthDate = params.date('birthDate', 'dd. MM. yy') ?: params.date('birthDate', 'dd.MM.yy')
        ent.profile.schoolDropoutDate = params.date('schoolDropoutDate', 'dd. MM. yy') ?: params.date('schoolDropoutDate', 'dd.MM.yy')
        ent.profile.schoolRestartDate = params.date('schoolRestartDate', 'dd. MM. yy') ?: params.date('schoolRestartDate', 'dd.MM.yy')
        ent.user.password = securityManager.encodePassword(grailsApplication.config.defaultpass)
      }

      // create link to colony
      new Link(source: Entity.get(params.currentColony), target: entity, type: metaDataService.ltColonia).save()

      // create link to school
      //new Link(source: Entity.get(params.school), target: entity, type: metaDataService.ltFacility).save()

      flash.message = message(code: "object.created", args: [message(code: "client"), entity.profile.fullName])
      redirect action: 'show', id: entity.id, params: [entity: entity.id]
    } catch (EntityException ee) {
      params.sort = params.sort ?: "fullName"
      params.order = params.order ?: "asc"

      def c = Entity.createCriteria()
      def allColonies = c.list {
        eq("type", metaDataService.etGroupColony)
        profile {
          order(params.sort, params.order)
        }
      }

      def d = Entity.createCriteria()
      def allFacilities = d.list {
        eq("type", metaDataService.etFacility)
        profile {
          order(params.sort, params.order)
        }
      }

      render(view: "create", model: [client: ee.entity, allColonies: allColonies, allFacilities: allFacilities])
    }
  }

  def addPerformance = {
    Performances performance = new Performances(params)
    Entity client = Entity.get(params.id)
    client.profile.addToPerformances(performance)
    render template: 'performances', model: [client: client, currentEntity: entityHelperService.loggedIn]
  }

  def removePerformance = {
    Entity client = Entity.get(params.id)
    client.profile.removeFromPerformances(Performances.get(params.performance))
    render template: 'performances', model: [client: client, currentEntity: entityHelperService.loggedIn]
  }

  def addHealth = {
    Healths health = new Healths(params)
    Entity client = Entity.get(params.id)
    client.profile.addToHealths(health)
    render template: 'healths', model: [client: client, currentEntity: entityHelperService.loggedIn]
  }

  def removeHealth = {
    Entity client = Entity.get(params.id)
    client.profile.removeFromHealths(Healths.get(params.health))
    render template: 'healths', model: [client: client, currentEntity: entityHelperService.loggedIn]
  }

  def addMaterial = {
    Materials material = new Materials(params)
    // material.date = functionService.convertToUTC(material.date)
    Entity client = Entity.get(params.id)
    client.profile.addToMaterials(material)
    render template: 'materials', model: [client: client, currentEntity: entityHelperService.loggedIn]
  }

  def removeMaterial = {
    Entity client = Entity.get(params.id)
    client.profile.removeFromMaterials(Materials.get(params.material))
    render template: 'materials', model: [client: client, currentEntity: entityHelperService.loggedIn]
  }

  def addDate = {
    Entity client = Entity.get(params.id)

    params.date = params.date('date', 'dd. MM. yy') ?: params.date('date', 'dd.MM.yy')

    if (params.date) {
      CDate date = new CDate(params)
      date.type = client.profile.dates.size() % 2 == 0 ? 'entry' : 'exit'
      client.profile.addToDates(date)

      // change active/inactive status
      client.user.enabled = date.type == 'exit'
      client.user.save()
    }
    render template: 'dates', model: [client: client, entity: entityHelperService.loggedIn]
  }

  def removeDate = {
    Entity client = Entity.get(params.id)
    CDate date = CDate.get(params.date)
    client.profile.removeFromDates(date)

    // change active/inactive status
    client.user.enabled = date.type == 'exit'
    client.user.save()

    render template: 'dates', model: [client: client, entity: entityHelperService.loggedIn]
  }

  def addCollector = {
    Collector collector = new Collector(params)
    Entity client = Entity.get(params.id)
    client.profile.addToCollectors(collector)
    render template: 'collectors', model: [client: client, currentEntity: entityHelperService.loggedIn]
  }

  def removeCollector = {
    Entity client = Entity.get(params.id)
    client.profile.removeFromCollectors(Collector.get(params.collector))
    render template: 'collectors', model: [client: client, currentEntity: entityHelperService.loggedIn]
  }

  def addContact = {ContactCommand cc ->
    Entity client = Entity.get(params.id)
    if (cc.hasErrors()) {
      render '<p class="italic red">'+message(code: "client.profile.name.insert")+'</p>'
      render template: 'contacts', model: [client: client, entity: entityHelperService.loggedIn]
      return
    }
    Contact contact = new Contact(params)
    client.profile.addToContacts(contact)
    render template: 'contacts', model: [client: client, entity: entityHelperService.loggedIn]
  }

  def removeContact = {
    Entity client = Entity.get(params.id)
    client.profile.removeFromContacts(Contact.get(params.contact))
    Contact.get(params.contact).delete()
    render template: 'contacts', model: [client: client, entity: entityHelperService.loggedIn]
  }

}
