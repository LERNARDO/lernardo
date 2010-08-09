package profiles

import at.openfactory.ep.Entity
import at.openfactory.ep.EntityType
import at.openfactory.ep.Link
import org.springframework.web.servlet.support.RequestContextUtils
import at.openfactory.ep.EntityHelperService
import lernardo.CDate
import standard.MetaDataService
import standard.FunctionService
import at.openfactory.ep.security.DefaultSecurityManager
import lernardo.Msg
import lernardo.Post

class EducatorProfileController {
  MetaDataService metaDataService
  EntityHelperService entityHelperService
  def securityManager
  FunctionService functionService

  def beforeInterceptor = [
          action:{params.birthDate = params.birthDate ? Date.parse("dd. MM. yy", params.birthDate) : null}, only:['save','update']
  ]
  
  def index = {
    redirect action: "list", params: params
  }

  // the delete, save and update actions only accept POST requests
  static allowedMethods = [delete: 'POST', save: 'POST', update: 'POST']

  def list = {
    params.max = Math.min(params.max ? params.int('max') : 10, 100)
    return [educatorList: Entity.findAllByType(metaDataService.etEducator),
            educatorTotal: Entity.countByType(metaDataService.etEducator),
            entity: entityHelperService.loggedIn]
  }

  def show = {
    Entity educator = Entity.get(params.id)
    Entity entity = params.entity ? educator : entityHelperService.loggedIn

    if (!educator) {
      flash.message = "EducatorProfile not found with id ${params.id}"
      redirect(action: list)
    }
    else {
      // find if this educator was enlisted
      Link link = Link.findBySourceAndType(educator, metaDataService.ltEnlisted)
      Entity enlistedBy = link?.target

      // find colonia of this educator
      link = Link.findBySourceAndType(educator, metaDataService.ltGroupMemberEducator)
      Entity colony = link?.target
      return [educator: educator, entity: entity, enlistedBy: enlistedBy, colony: colony]
    }
  }

  def del = {
    Entity educator = Entity.get(params.id)
    if (educator) {
      // delete all links
      Link.findAllBySourceOrTarget(educator, educator).each {it.delete()}
      Msg.findAllByEntity(educator).delete()
      Post.findByAuthor(educator).delete()
      try {
        flash.message = message(code: "educator.deleted", args: [educator.profile.fullName])
        educator.delete(flush: true)
        redirect(controller: "profile", action: "list")
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
    }
    else {
      return [educator: educator, entity: entityHelperService.loggedIn, partner: Entity.findAllByType(metaDataService.etPartner)]
    }
  }

  def update = {
    Entity educator = Entity.get(params.id)

    educator.profile.properties = params
    educator.profile.fullName = params.lastName + " " + params.firstName

    educator.user.properties = params
    if (educator == entityHelperService.loggedIn)
      RequestContextUtils.getLocaleResolver(request).setLocale(request, response, educator.user.locale)

    if (!educator.hasErrors() && educator.save()) {

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
      render view: 'edit', model: [educator: educator, entity: entityHelperService.loggedIn, allColonias: Entity.findAllByType(metaDataService.etGroupColony)]
    }
  }

  def create = {
    return [entity: entityHelperService.loggedIn,
            partner: Entity.findAllByType(metaDataService.etPartner),
            /*allColonias: Entity.findAllByType(metaDataService.etGroupColony)*/]
  }

  def save = {
    EntityType etEducator = metaDataService.etEducator
    println params

    try {
      Entity entity = entityHelperService.createEntityWithUserAndProfile(functionService.createNick(params.firstName, params.lastName), etEducator, params.email, params.lastName + " " + params.firstName) {Entity ent ->
        ent.profile.properties = params
        ent.user.properties = params
        ent.user.password = securityManager.encodePassword(grailsApplication.config.defaultpass)
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
      render(view: "create", model: [educator: ee.entity, entity: entityHelperService.loggedIn], partner: Entity.findAllByType(metaDataService.etPartner), allColonias: Entity.findAllByType(metaDataService.etGroupColony))
      return
    }

  }

  def addDate = {
    CDate date = new CDate(params)
    Entity educator = Entity.get(params.id)
    date.type = educator.profile.dates.size() % 2 == 0 ? 'Eintritt' : 'Austritt'
    educator.profile.addToDates(date)
    render template: 'dates', model: [educator: educator, entity: entityHelperService.loggedIn]
  }

  def removeDate = {
    Entity educator = Entity.get(params.id)
    educator.profile.removeFromDates(CDate.get(params.date))
    render template: 'dates', model: [educator: educator, entity: entityHelperService.loggedIn]
  }
}
