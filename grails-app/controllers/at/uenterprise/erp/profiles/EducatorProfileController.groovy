package at.uenterprise.erp.profiles

import at.openfactory.ep.Entity
import at.openfactory.ep.EntityType
import at.openfactory.ep.Link
import org.springframework.web.servlet.support.RequestContextUtils
import at.openfactory.ep.EntityHelperService
import at.uenterprise.erp.CDate
import at.uenterprise.erp.MetaDataService
import at.uenterprise.erp.FunctionService
import at.uenterprise.erp.Msg
import at.uenterprise.erp.Post
import at.uenterprise.erp.Event
import at.uenterprise.erp.Publication
import at.uenterprise.erp.WorkdayCategory
import java.util.regex.Pattern
import at.uenterprise.erp.ECalendar

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
    params.offset = params.offset ? params.int('offset') : 0
    params.max = Math.min(params.max ? params.int('max') : 15, 100)
    params.sort = params.sort ?: "fullName"
    params.order = params.order ?: "asc"

    def c = Entity.createCriteria()
    def educators = c.list (max: params.max, offset: params.offset) {
      eq("type", metaDataService.etEducator)
      profile {
        order(params.sort, params.order)
      }
    }

    return [educators: educators]
  }

  def show = {
    Entity educator = Entity.get(params.id)
    Entity entity = params.entity ? educator : entityHelperService.loggedIn

    if (!educator) {
      flash.message = "EducatorProfile not found with id ${params.id}"
      redirect(action: list)
      return
    }

    // find if this educator was enlisted
    Entity enlistedBy = functionService.findByLink(educator, null, metaDataService.ltEnlisted)

    // find colonia of this educator
    //Entity colony = functionService.findByLink(educator, null, metaDataService.ltGroupMemberEducator)

    return [/*colony: colony,*/
            educator: educator,
            entity: entity,
            enlistedBy: enlistedBy]
  }

  def del = {
    Entity educator = Entity.get(params.id)
    if (educator) {
      // delete all links
      Link.findAllBySourceOrTarget(educator, educator).each {it.delete()}
      Msg.findAllByEntity(educator).each {it.delete()}
      Post.findByAuthor(educator).each {it.delete()}
      Event.findAllByEntity(educator).each {it.delete()}
      Publication.findAllByEntity(educator).each {it.delete()}
      try {
        flash.message = message(code: "educator.deleted", args: [educator.profile.fullName])
        educator.delete(flush: true)
        redirect(action: "list")
      }
      catch (org.springframework.dao.DataIntegrityViolationException e) {
        flash.message = message(code: "educator.notDeleted", args: [educator.profile.fullName])
        redirect(action: "show", id: params.id)
      }
    }
    else {
      flash.message = "EducatorProfile not found with id ${params.id}"
      redirect(action: "list")
    }
  }

  def edit = {
    Entity educator = Entity.get(params.id)

    if (!educator) {
      flash.message = "EducatorProfile not found with id ${params.id}"
      redirect action: 'list'
      return
    }

    // find if this educator was enlisted
    Entity enlistedBy = functionService.findByLink(educator, null, metaDataService.ltEnlisted)

    return [educator: educator, partner: Entity.findAllByType(metaDataService.etPartner), enlistedBy: enlistedBy]

  }

  def update = {
    if (Pattern.matches( "\\d{2}\\.\\s\\d{2}\\.\\s\\d{4}", params.birthDate))
      params.birthDate = Date.parse("dd. MM. yy", params.birthDate)
    else
      params.birthDate = null

    Entity educator = Entity.get(params.id)

    educator.profile.properties = params
    educator.profile.fullName = params.lastName + " " + params.firstName

    educator.user.properties = params
    if (educator.id == entityHelperService.loggedIn.id)
      RequestContextUtils.getLocaleResolver(request).setLocale(request, response, educator.user.locale)

    if (!educator.hasErrors() && educator.save() && !educator.profile.hasErrors()) {

      // create link to partner
      Link.findAllBySourceAndType(educator, metaDataService.ltEnlisted).each {it.delete()}
      if (params.enlisted) {
        new Link(source: educator, target: Entity.get(params.enlisted), type: metaDataService.ltEnlisted).save()
      }

      /*// delete current link
      def c = Link.createCriteria()
      def link = c.get {
        eq('source', educator)
        eq('target', Entity.get(params.colonia))
        eq('type', metaDataService.ltGroupMemberEducator)
      }
      if (link)
        link.delete()

      // link educator to colonia
      new Link(source: educator, target: Entity.get(params.colonia), type: metaDataService.ltGroupMemberEducator).save()*/

      flash.message = message(code: "educator.updated", args: [educator.profile.fullName])
      redirect action: 'show', id: educator.id
    }
    else {
      render view: 'edit', model: [educator: educator, allColonias: Entity.findAllByType(metaDataService.etGroupColony)]
    }
  }

  def create = {
    return [partner: Entity.findAllByType(metaDataService.etPartner),
            /*allColonias: Entity.findAllByType(metaDataService.etGroupColony)*/]
  }

  def save = {
    EntityType etEducator = metaDataService.etEducator

    try {
      Entity entity = entityHelperService.createEntityWithUserAndProfile(functionService.createNick(params.firstName, params.lastName), etEducator, params.email, params.lastName + " " + params.firstName) {Entity ent ->
        ent.profile.properties = params
        ent.user.properties = params
        if (Pattern.matches( "\\d{2}\\.\\s\\d{2}\\.\\s\\d{4}", params.birthDate))
          ent.profile.birthDate = Date.parse("dd. MM. yy", params.birthDate)
        ent.user.password = securityManager.encodePassword(grailsApplication.config.defaultpass)
        ent.profile.calendar = new ECalendar().save()
      }
      //RequestContextUtils.getLocaleResolver(request).setLocale(request, response, entity.user.locale)

      // create link to partner
      Link.findAllBySourceAndType(entity, metaDataService.ltEnlisted).each {it.delete()}
      if (params.enlisted) {
        new Link(source: entity, target: Entity.get(params.enlisted), type: metaDataService.ltEnlisted).save()
      }

      // link educator to colonia
      //new Link(source: entity, target: Entity.get(params.colonia), type: metaDataService.ltGroupMemberEducator).save()

      flash.message = message(code: "educator.created", args: [entity.profile.fullName])
      redirect action: 'show', id: entity.id
    } catch (at.openfactory.ep.EntityException ee) {
      render(view: "create", model: [educator: ee.entity, partner: Entity.findAllByType(metaDataService.etPartner), allColonias: Entity.findAllByType(metaDataService.etGroupColony)])
    }

  }

  def addDate = {
    CDate date = new CDate(params)
    Entity educator = Entity.get(params.id)
    date.type = educator.profile.dates.size() % 2 == 0 ? 'entry' : 'exit'
    educator.profile.addToDates(date)
    render template: 'dates', model: [educator: educator, entity: entityHelperService.loggedIn]
  }

  def removeDate = {
    Entity educator = Entity.get(params.id)
    educator.profile.removeFromDates(CDate.get(params.date))
    render template: 'dates', model: [educator: educator, entity: entityHelperService.loggedIn]
  }

  def times = {
    List educators = Entity.findAllByType(metaDataService.etEducator)
    List workdaycategories = WorkdayCategory.list()
    return [educators: educators, workdaycategories: workdaycategories]
  }

  def showresult = {
    List educators = Entity.findAllByType(metaDataService.etEducator)
    List workdaycategories = WorkdayCategory.list()
    render template: 'results', model:[educators: educators, workdaycategories: workdaycategories, date1: params.date1, date2: params.date2, entity: entityHelperService.loggedIn]
  }
}
