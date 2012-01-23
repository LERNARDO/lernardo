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
import at.uenterprise.erp.News
import at.uenterprise.erp.Publication
import at.uenterprise.erp.WorkdayCategory
import java.util.regex.Pattern
import at.uenterprise.erp.ECalendar
import at.uenterprise.erp.Comment
import at.uenterprise.erp.Evaluation
import at.uenterprise.erp.Event

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

    EntityType etEducator = metaDataService.etEducator
    def educators = Entity.createCriteria().list {
      eq("type", etEducator)
      profile {
        order(params.sort, params.order)
      }
      maxResults(params.max)
      firstResult(params.offset)
    }
    int totalEducators = Entity.countByType(etEducator)

    return [educators: educators, totalEducators: totalEducators]
  }

  def show = {
    Entity educator = Entity.get(params.id)

    if (!educator) {
      flash.message = message(code: "object.notFound", args: [message(code: "educator")])
      redirect(action: list)
      return
    }

    // find if this educator was enlisted
    Entity enlistedBy = functionService.findByLink(educator, null, metaDataService.ltEnlisted)

    return [educator: educator, enlistedBy: enlistedBy]
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
    Entity educator = Entity.get(params.id)
    Entity entity = params.entity ? educator : entityHelperService.loggedIn

    if (!educator) {
      flash.message = message(code: "object.notFound", args: [message(code: "educator")])
      redirect action: 'list'
      return
    }

    // find if this educator was enlisted
    Entity enlistedBy = functionService.findByLink(educator, null, metaDataService.ltEnlisted)

    return [educator: educator, partner: Entity.findAllByType(metaDataService.etPartner), enlistedBy: enlistedBy, entity: entity]

  }

  def update = {
    if (Pattern.matches( "\\d{2}\\.\\s\\d{2}\\.\\s\\d{4}", params.birthDate))
      params.birthDate = Date.parse("dd. MM. yy", params.birthDate)
    else if (Pattern.matches( "\\d{2}\\.\\d{2}\\.\\d{4}", params.birthDate))
      params.birthDate = Date.parse("dd.MM.yy", params.birthDate)
    else
      params.birthDate = null

    Entity educator = Entity.get(params.id)

    educator.profile.properties = params
    // educator.profile.birthDate = functionService.convertToUTC(educator.profile.birthDate)
    educator.profile.fullName = params.lastName + " " + params.firstName
    if (!educator.profile.calendar) educator.profile.calendar = new ECalendar().save()

    educator.user.properties = params
    if (educator.id == entityHelperService.loggedIn.id)
      RequestContextUtils.getLocaleResolver(request).setLocale(request, response, educator.user.locale)

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
      render view: 'edit', model: [educator: educator, entity: educator, allColonias: Entity.findAllByType(metaDataService.etGroupColony)]
    }
  }

  def create = {
    return [partner: Entity.findAllByType(metaDataService.etPartner)]
  }

  def save = {
    EntityType etEducator = metaDataService.etEducator

    try {
      Entity entity = entityHelperService.createEntityWithUserAndProfile(functionService.createNick(params.firstName, params.lastName), etEducator, params.email, params.lastName + " " + params.firstName) {Entity ent ->
        ent.profile.properties = params
        ent.user.properties = params
        if (Pattern.matches( "\\d{2}\\.\\s\\d{2}\\.\\s\\d{4}", params.birthDate))
          ent.profile.birthDate = Date.parse("dd. MM. yy", params.birthDate)
        else if (Pattern.matches( "\\d{2}\\.\\d{2}\\.\\d{4}", params.birthDate))
          ent.profile.birthDate = Date.parse("dd.MM.yy", params.birthDate)
        ent.user.password = securityManager.encodePassword(grailsApplication.config.defaultpass)
        ent.profile.calendar = new ECalendar().save()
        // ent.profile.birthDate = functionService.convertToUTC(ent.profile.birthDate)
      }
      //RequestContextUtils.getLocaleResolver(request).setLocale(request, response, entity.user.locale)

      // create link to partner
      Link.findAllBySourceAndType(entity, metaDataService.ltEnlisted).each {it.delete()}
      if (params.enlisted) {
        new Link(source: entity, target: Entity.get(params.enlisted), type: metaDataService.ltEnlisted).save()
      }

      // link educator to colonia
      //new Link(source: entity, target: Entity.get(params.colonia), type: metaDataService.ltGroupMemberEducator).save()

      flash.message = message(code: "object.created", args: [message(code: "educator"), entity.profile.fullName])
      redirect action: 'show', id: entity.id, params: [entity: entity.id]
    } catch (at.openfactory.ep.EntityException ee) {
      render(view: "create", model: [educator: ee.entity, partner: Entity.findAllByType(metaDataService.etPartner), allColonias: Entity.findAllByType(metaDataService.etGroupColony)])
    }

  }

  def addDate = {
    Entity educator = Entity.get(params.id)

    if (params.date && Pattern.matches( "\\d{2}\\.\\s\\d{2}\\.\\s\\d{4}", params.date))
      params.date = Date.parse("dd. MM. yy", params.date)
    else if (params.date && Pattern.matches( "\\d{2}\\.\\d{2}\\.\\d{4}", params.date))
      params.date = Date.parse("dd.MM.yy", params.date)
    else
      params.date = null

    if (params.date) {
      CDate date = new CDate(params)
      // date.date = functionService.convertToUTC(date.date)
      date.type = educator.profile.dates.size() % 2 == 0 ? 'entry' : 'exit'
      educator.profile.addToDates(date)
    }
    render template: 'dates', model: [educator: educator, entity: entityHelperService.loggedIn]
  }

  def removeDate = {
    Entity educator = Entity.get(params.id)
    educator.profile.removeFromDates(CDate.get(params.date))
    render template: 'dates', model: [educator: educator, entity: entityHelperService.loggedIn]
  }

  def times = {}

  def showresult = {
    List educators = Entity.createCriteria().list {
      eq("type", metaDataService.etEducator)
      profile {
        and {
           order('employment','asc')
           order('firstName','asc')
        }
      }
    }

    List workdaycategories = WorkdayCategory.list()
    render template: 'results', model:[educators: educators, workdaycategories: workdaycategories, date1: params.date1, date2: params.date2, entity: entityHelperService.loggedIn]
  }

  def createpdf = {
    Date date1 = Date.parse("dd. MM. yy", params.date1)
    Date date2 = Date.parse("dd. MM. yy", params.date2)

    List educators = Entity.createCriteria().list {
      eq("type", metaDataService.etEducator)
      profile {
        and {
           order('employment','asc')
           order('firstName','asc')
        }
      }
    }

    List workdaycategories = WorkdayCategory.list()
    Entity currentEntity = entityHelperService.loggedIn
    renderPdf template: 'createpdf', model: [educators: educators, workdaycategories: workdaycategories, entity: currentEntity, date1: params.date1, date2: params.date2], filename: message(code: 'timeEvaluation') + '_' + formatDate(date: date1, format: "dd.MM.yyyy") + '-' + formatDate(date: date2, format: "dd.MM.yyyy") + '.pdf'
  }

  def workhours = {
    List educators = Entity.findAllByType(metaDataService.etEducator)
    return [educators: educators]
  }

  def changeWorkHours = {
    Entity educator = Entity.get(params.id)
    render template: 'editworkhours', model:[educator: educator, i: params.i]
  }

  def updateWorkHours = {
    Entity educator = Entity.get(params.id)
    educator.profile.properties = params
    educator.profile.save()
    render template: 'showworkhours', model:[educator: educator, i: params.i]
  }

  def changeWorkDays = {
    Entity educator = Entity.get(params.id)
    render template: 'editworkdays', model:[educator: educator, i: params.i]
  }

  def updateWorkDays = {
    Entity educator = Entity.get(params.id)
    educator.profile.workDays = params.int('workDays')
    educator.profile.save()
    render template: 'showworkdays', model:[educator: educator, i: params.i]
  }

  def changeHourlyWage = {
    Entity educator = Entity.get(params.id)
    render template: 'edithourlywage', model:[educator: educator, i: params.i]
  }

  def updateHourlyWage = {
    Entity educator = Entity.get(params.id)
    educator.profile.hourlyWage = params.int('hourlyWage')
    educator.profile.save()
    render template: 'showhourlywage', model:[educator: educator, i: params.i]
  }

  def changeOvertimePay = {
    Entity educator = Entity.get(params.id)
    render template: 'editovertimepay', model:[educator: educator, i: params.i]
  }

  def updateOvertimePay = {
    Entity educator = Entity.get(params.id)
    educator.profile.overtimePay = params.int('overtimePay')
    educator.profile.save()
    render template: 'showovertimepay', model:[educator: educator, i: params.i]
  }
}
