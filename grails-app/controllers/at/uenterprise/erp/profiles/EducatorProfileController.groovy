package at.uenterprise.erp.profiles

import at.openfactory.ep.Entity
import at.openfactory.ep.EntityType
import at.openfactory.ep.Link
import at.openfactory.ep.EntityHelperService
import at.uenterprise.erp.CDate
import at.uenterprise.erp.MetaDataService
import at.uenterprise.erp.FunctionService
import at.uenterprise.erp.WorkdayCategory
import java.util.regex.Pattern

class EducatorProfileController {
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

    EntityType etEducator = metaDataService.etEducator
    def educators = Entity.createCriteria().list {
      eq("type", etEducator)
      user {
        eq('enabled', true)
      }
      profile {
        order(params.sort, params.order)
      }
      maxResults(params.max)
      firstResult(params.offset)
    }
    int totalEducators = Entity.findAllByType(etEducator).findAll{it.user.enabled}.size()

    return [educators: educators, totalEducators: totalEducators]
  }

  def listInactive = {
    params.offset = params.int('offset') ?: 0
    params.max = Math.min(params.int('max') ?: 15, 100)
    params.sort = params.sort ?: "fullName"
    params.order = params.order ?: "asc"

    EntityType etEducator = metaDataService.etEducator
    def educators = Entity.createCriteria().list {
      eq("type", etEducator)
      user {
        eq('enabled', false)
      }
      profile {
        order(params.sort, params.order)
      }
      maxResults(params.max)
      firstResult(params.offset)
    }
    int totalEducators = Entity.findAllByType(etEducator).findAll{!it.user.enabled}.size()

    return [educators: educators, totalEducators: totalEducators]
  }

  def show = {
    Entity educator = Entity.get(params.id)

    if (!educator) {
      flash.message = message(code: "object.notFound", args: [message(code: "educator")])
      redirect(action: list)
      return
    }

    Entity colony = functionService.findByLink(null, educator, metaDataService.ltColonia)
    // find if this educator was enlisted
    Entity enlistedBy = functionService.findByLink(educator, null, metaDataService.ltEnlisted)

    return [educator: educator, enlistedBy: enlistedBy, colony: colony]
  }

  def delete = {
    Entity educator = Entity.get(params.id)
    if (educator) {
      functionService.deleteReferences(educator)
      try {
        flash.message = message(code: "object.deleted", args: [message(code: "educator"), educator.profile.fullName])
        educator.delete(flush: true)
        redirect(action: "list")
      }
      catch (org.springframework.dao.DataIntegrityViolationException e) {
        flash.message = message(code: "object.notDeleted", args: [message(code: "educator"), educator.profile.fullName])
        redirect(action: "show", id: params.id)
      }
    }
    else {
      flash.message = message(code: "object.notFound", args: [message(code: "educator")])
      redirect(action: "list")
    }
  }

  def edit = {
    params.sort = params.sort ?: "fullName"
    params.order = params.order ?: "asc"

    Entity educator = Entity.get(params.id)
    Entity entity = params.entity ? educator : entityHelperService.loggedIn

    if (!educator) {
      flash.message = message(code: "object.notFound", args: [message(code: "educator")])
      redirect action: 'list'
      return
    }

    Entity colony = functionService.findByLink(null, educator, metaDataService.ltColonia)

    def c = Entity.createCriteria()
    def allColonies = c.list {
      eq("type", metaDataService.etGroupColony)
      profile {
        order(params.sort, params.order)
      }
    }

    // find if this educator was enlisted
    Entity enlistedBy = functionService.findByLink(educator, null, metaDataService.ltEnlisted)

    return [educator: educator,
            partner: Entity.findAllByType(metaDataService.etPartner),
            enlistedBy: enlistedBy,
            entity: entity,
            colony: colony,
            allColonies: allColonies]

  }

  def update = {
    params.birthDate = params.date('birthDate', 'dd. MM. yy') ?: params.date('birthDate', 'dd.MM.yy')

    Entity educator = Entity.get(params.id)

    educator.profile.properties = params
    educator.profile.fullName = params.lastName + " " + params.firstName
    educator.user.properties = params

    // update link to colony
    Link.findByTargetAndType(educator, metaDataService.ltColonia)?.delete()
    new Link(source: Entity.get(params.currentColony), target: educator, type: metaDataService.ltColonia).save()

    if (educator.profile.save() && educator.user.save() && educator.save()) {

      // create link to partner
      Link.findAllBySourceAndType(educator, metaDataService.ltEnlisted).each {it.delete()}
      if (params.enlisted) {
        new Link(source: educator, target: Entity.get(params.enlisted), type: metaDataService.ltEnlisted).save()
      }

      flash.message = message(code: "object.updated", args: [message(code: "educator"), educator.profile.fullName])
      redirect action: 'show', id: educator.id, params: [entity: educator.id]
    }
    else {
      params.sort = params.sort ?: "fullName"
      params.order = params.order ?: "asc"

      def c = Entity.createCriteria()
      def allColonies = c.list {
        eq("type", metaDataService.etGroupColony)
        profile {
          order(params.sort, params.order)
        }
      }
      render view: 'edit', model: [educator: educator, entity: educator, allColonies: allColonies]
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

    return [partner: Entity.findAllByType(metaDataService.etPartner),
            allColonies: allColonies]
  }

  def save = {
    EntityType etEducator = metaDataService.etEducator

    try {
      Entity entity = entityHelperService.createEntityWithUserAndProfile(functionService.createNick(params.firstName, params.lastName), etEducator, params.email, params.lastName + " " + params.firstName) {Entity ent ->
        ent.profile.properties = params
        ent.user.properties = params
        ent.profile.birthDate = params.date('birthDate', 'dd. MM. yy') ?: params.date('birthDate', 'dd.MM.yy')
        ent.user.password = securityManager.encodePassword(grailsApplication.config.defaultpass)
        ent.profile.save()
      }

      // create link to partner
      Link.findAllBySourceAndType(entity, metaDataService.ltEnlisted).each {it.delete()}
      if (params.enlisted) {
        new Link(source: entity, target: Entity.get(params.enlisted), type: metaDataService.ltEnlisted).save()
      }

      // link educator to colony
      //new Link(source: entity, target: Entity.get(params.colonia), type: metaDataService.ltGroupMemberEducator).save()

      // create link to colony
      new Link(source: Entity.get(params.currentColony), target: entity, type: metaDataService.ltColonia).save()

      flash.message = message(code: "object.created", args: [message(code: "educator"), entity.profile.fullName])
      redirect action: 'show', id: entity.id, params: [entity: entity.id]
    } catch (at.openfactory.ep.EntityException ee) {
      params.sort = params.sort ?: "fullName"
      params.order = params.order ?: "asc"

      def c = Entity.createCriteria()
      def allColonies = c.list {
        eq("type", metaDataService.etGroupColony)
        profile {
          order(params.sort, params.order)
        }
      }
      render(view: "create", model: [educator: ee.entity, partner: Entity.findAllByType(metaDataService.etPartner), allColonies: allColonies])
    }

  }

  def addDate = {
    Entity educator = Entity.get(params.id)

    params.date = params.date('date', 'dd. MM. yy') ?: params.date('date', 'dd.MM.yy')

    if (params.date) {
      CDate date = new CDate(params)
      date.type = educator.profile.dates.size() % 2 == 0 ? 'entry' : 'exit'
      educator.profile.addToDates(date)
      
      // change active/inactive status
      educator.user.enabled = date.type == 'entry'
      educator.user.save()
    }
    render template: 'dates', model: [educator: educator]
  }

  def removeDate = {
    Entity educator = Entity.get(params.id)
    CDate date = CDate.get(params.date)
    educator.profile.removeFromDates(date)

    // change active/inactive status
    educator.user.enabled = date.type == 'exit'
    educator.user.save()

    render template: 'dates', model: [educator: educator]
  }
}
