package profiles

import at.openfactory.ep.Entity
import at.openfactory.ep.EntityType
import at.openfactory.ep.Link
import org.springframework.web.servlet.support.RequestContextUtils
import at.openfactory.ep.EntityHelperService
import lernardo.Materials
import standard.MetaDataService
import standard.FunctionService
import lernardo.CDate
import lernardo.Performances
import lernardo.Healths
import at.openfactory.ep.EntityException

class ClientProfileController {
  MetaDataService metaDataService
  EntityHelperService entityHelperService
  FunctionService functionService

  def index = {
    redirect action: "list", params: params
  }

  // the delete, save and update actions only accept POST requests
  static allowedMethods = [delete: 'POST', save: 'POST', update: 'POST']

  def list = {
    params.max = Math.min(params.max ? params.int('max') : 10, 100)

    return [clientList: Entity.findAllByType(metaDataService.etClient),
            clientTotal: Entity.countByType(metaDataService.etClient),
            entity: entityHelperService.loggedIn]
  }

  def show = {
    Entity client = Entity.get(params.id)
    Entity entity = params.entity ? client : entityHelperService.loggedIn

    if (!client) {
      flash.message = "ClientProfile not found with id ${params.id}"
      redirect(action: list)
    }
    else {
      def link = Link.findByTargetAndType(client, metaDataService.ltColonia)
      Entity colonia = link?.source ?: null
      link = Link.findByTargetAndType(client, metaDataService.ltFacility)
      Entity school = link?.source ?: null

      // check if the client belongs to a family
      link = Link.findBySourceAndType(client, metaDataService.ltGroupFamily)
      Entity family = link?.target

      return [client: client, entity: entity, colonia: colonia, school: school, family: family]
    }
  }

  def del = {
    Entity client = Entity.get(params.id)
    if (client) {
      // delete all links
      Link.findAllBySourceOrTarget(client, client).each {it.delete()}
      try {
        flash.message = message(code: "client.deleted", args: [client.profile.fullName])
        client.delete(flush: true)
        redirect(controller: "profile", action: "list")
      }
      catch (org.springframework.dao.DataIntegrityViolationException e) {
        flash.message = message(code: "client.notDeleted", args: [client.profile.fullName])
        redirect(action: "show", id: params.id)
      }
    }
    else {
      flash.message = "ClientProfile not found with id ${params.id}"
      redirect(action: "list")
    }
  }

  def edit = {
    Entity client = Entity.get(params.id)

    if (!client) {
      flash.message = "ClientProfile not found with id ${params.id}"
      redirect action: 'list'
    }
    else {
      def link = Link.findByTargetAndType(client, metaDataService.ltColonia)
      Entity colonia = link?.source ?: null
      return [client: client,
              entity: entityHelperService.loggedIn,
              colonia: colonia,
              allColonias: Entity.findAllByType(metaDataService.etGroupColony),
              allFacilities: Entity.findAllByType(metaDataService.etFacility)]
    }
  }

  def update = {
    Entity client = Entity.get(params.id)

    client.profile.properties = params
    client.profile.fullName = params.lastName + " " + params.firstName

    client.user.properties = params
    RequestContextUtils.getLocaleResolver(request).setLocale(request, response, client.user.locale)

    // check and (brute force) update link to colonia
    def link = Link.findByTargetAndType(client, metaDataService.ltColonia)
    if (link?.source) {
      link.delete()   // update else new link ?? hf
    }
    new Link(source: Entity.get(params.currentColonia), target: client, type: metaDataService.ltColonia).save()

    // check and (brute force) update link to school
    link = Link.findByTargetAndType(client, metaDataService.ltFacility)
    if (link?.source) {
      link.delete()
    }
    new Link(source: Entity.get(params.school), target: client, type: metaDataService.ltFacility).save()

    if (!client.hasErrors() && client.save()) {
      flash.message = message(code: "client.updated", args: [client.profile.fullName])
      redirect action: 'show', id: client.id
    }
    else {
      render view: 'edit', model: [client: client, entity: entityHelperService.loggedIn]
    }
  }

  def create = {
    return [entity: entityHelperService.loggedIn,
            allColonias: Entity.findAllByType(metaDataService.etGroupColony),
            allFacilities: Entity.findAllByType(metaDataService.etFacility)]
  }

  def save = {
    EntityType etClient = metaDataService.etClient

    try {
      Entity entity = entityHelperService.createEntityWithUserAndProfile(functionService.createNick(params.firstName, params.lastName), etClient, params.email, params.lastName + " " + params.firstName) {Entity ent ->
        ent.profile.properties = params
        ent.user.properties = params
        ent.user.password = securityManager.encodePassword(grailsApplication.config.defaultpass)
      }
      RequestContextUtils.getLocaleResolver(request).setLocale(request, response, entity.user.locale)

      // create link to colonia
      new Link(source: Entity.get(params.currentColonia), target: entity, type: metaDataService.ltColonia).save()

      // create link to school
      new Link(source: Entity.get(params.school), target: entity, type: metaDataService.ltFacility).save()

      flash.message = message(code: "client.created", args: [entity.profile.fullName])
      redirect action: 'list'
    } catch (EntityException ee) {
      render(view: "create", model: [client: ee.entity,
              entity: entityHelperService.loggedIn,
              allColonias: Entity.findAllByType(metaDataService.etGroupColony),
              allFacilities: Entity.findAllByType(metaDataService.etFacility)])
      return
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
    CDate date = new CDate(params)
    Entity client = Entity.get(params.id)
    date.type = client.profile.dates.size() % 2 == 0 ? 'Eintritt' : 'Austritt'
    client.profile.addToDates(date)
    render template: 'dates', model: [client: client, entity: entityHelperService.loggedIn]
  }

  def removeDate = {
    Entity client = Entity.get(params.id)
    client.profile.removeFromDates(CDate.get(params.date))
    render template: 'dates', model: [client: client, entity: entityHelperService.loggedIn]
  }
}
