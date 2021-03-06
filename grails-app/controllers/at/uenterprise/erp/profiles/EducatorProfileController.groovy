package at.uenterprise.erp.profiles

import at.uenterprise.erp.base.Entity
import at.uenterprise.erp.base.EntityType
import at.uenterprise.erp.base.Link
import at.uenterprise.erp.base.EntityHelperService
import at.uenterprise.erp.CDate
import at.uenterprise.erp.MetaDataService
import at.uenterprise.erp.FunctionService
import at.uenterprise.erp.Folder
import at.uenterprise.erp.FolderType

import at.uenterprise.erp.Setup
import at.uenterprise.erp.EntityDataService
import at.uenterprise.erp.LinkDataService

class EducatorProfileController {
  MetaDataService metaDataService
  EntityHelperService entityHelperService
  def securityManager
  FunctionService functionService
  EntityDataService entityDataService
  LinkDataService linkDataService

  def index = {
    redirect action: "list", params: params
  }

  // the delete, save and update actions only accept POST requests
  static allowedMethods = [delete: 'POST', save: 'POST', update: 'POST']

  def list = {
    int totalEducators = Entity.countByType(metaDataService.etEducator)
    List educations = Setup.list()[0].educations
    List employments = Setup.list()[0].employmentStatus
    List languages = Setup.list()[0].languages
    List nationalities = Setup.list()[0]?.nationalities
    List facilities = Entity.findAllByType(metaDataService.etFacility)

    return [totalEducators: totalEducators,
        educations: educations,
        employments: employments,
        languages: languages,
        nationalities: nationalities,
        facilities: facilities]
  }

  def show = {
    Entity educator = Entity.get(params.id)

    if (!educator) {
      flash.message = message(code: "object.notFound", args: [message(code: "educator")])
      redirect(action: list)
      return
    }

    Entity colony = linkDataService.getColony(educator)
    // find if this educator was enlisted
    Entity enlistedBy = functionService.findByLink(educator, null, metaDataService.ltEnlisted)

    List leadingFacilities = functionService.findAllByLink(educator, null, metaDataService.ltLeadEducator)

    return [educator: educator, enlistedBy: enlistedBy, colony: colony, ajax: params.ajax, ajaxId: params.ajaxId, leadingFacilities: leadingFacilities]
  }

    def management = {
        Entity educator = Entity.get(params.id)

        render template: "management", model: [educator: educator]
    }

  def delete = {
    Entity educator = Entity.get(params.id)
    if (educator) {
      functionService.deleteReferences(educator)
      try {
        flash.message = message(code: "object.deleted", args: [message(code: "educator"), educator.profile])
        educator.delete(flush: true)
        redirect(action: "list")
      }
      catch (org.springframework.dao.DataIntegrityViolationException ignore) {
        flash.message = message(code: "object.notDeleted", args: [message(code: "educator"), educator.profile])
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

    Entity colony = linkDataService.getColony(educator)

    def allColonies = entityDataService.getAllColonies()

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

      flash.message = message(code: "object.updated", args: [message(code: "educator"), educator.profile])
      redirect action: 'show', id: educator.id
    }
    else {
      def allColonies = entityDataService.getAllColonies()
      render view: 'edit', model: [educator: educator, entity: educator, allColonies: allColonies]
    }
  }

  def create = {
    def allColonies = entityDataService.getAllColonies()

    return [partner: Entity.findAllByType(metaDataService.etPartner),
            allColonies: allColonies]
  }

  def save = {
    EntityType etEducator = metaDataService.etEducator

    try {
      Entity entity = entityHelperService.createEntityWithUserAndProfile(functionService.createNick(params.firstName, params.lastName), etEducator, params.email, params.lastName + " " + params.firstName) {Entity ent ->
        ent.profile.properties = params
        ent.profile.birthDate = params.date('birthDate', 'dd. MM. yy') ?: params.date('birthDate', 'dd.MM.yy')
        ent.profile.favoritesFolder = new Folder(name: "root", type: FolderType.findByName("favorite")).save()
        ent.user.properties = params
        ent.user.password = securityManager.encodePassword(grailsApplication.config.defaultpass)
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

        // create entry date
        params.entryDate = params.date('entryDate', 'dd. MM. yy') ?: params.date('entryDate', 'dd.MM.yy')

        CDate date = new CDate()
        date.date = params.entryDate
        date.type = 'entry'
        entity.profile.addToDates(date)

        // change active/inactive status
        functionService.updateSingleStatus(entity)

      flash.message = message(code: "object.created", args: [message(code: "educator"), entity.profile])
      redirect action: 'show', id: entity.id
    } catch (at.uenterprise.erp.base.EntityException ee) {
      def allColonies = entityDataService.getAllColonies()
      render view: "create", model: [educator: ee.entity, partner: Entity.findAllByType(metaDataService.etPartner), allColonies: allColonies]
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
      functionService.updateSingleStatus(educator)
    }
    render template: 'dates', model: [educator: educator]
  }

  def removeDate = {
    Entity educator = Entity.get(params.id)
    CDate date = CDate.get(params.date)
    educator.profile.removeFromDates(date)

    // change active/inactive status
    functionService.updateSingleStatus(educator)

    render template: 'dates', model: [educator: educator]
  }

  def define = {
    params.sort = params.sort ?: "fullName"
    params.order = params.order ?: "asc"
    params.offset = params.int('offset') ?: 0
    params.max = Math.min(params.int('max') ?: 20, 40)

    // 1. pass - filter by object properties
    def results = Entity.createCriteria().listDistinct  {
      eq('type', metaDataService.etEducator)
      user {
        eq('enabled', params.active ? true : false)
      }
      profile {
        if (params.name)
          ilike('fullName', "%" + params.name + "%")
        if (params.gender != "0")
          eq('gender', params.int('gender'))
        if (params.originCountry)
          eq('originCountry', params.originCountry)
        if (params.education) {
          or {
            params.list('education').each {
              eq('education', it)
            }
          }
        }
        if (params.employment) {
          or {
            params.list('employment').each {
              eq('employment', it)
            }
          }
        }
        order(params.sort, params.order)
      }
    }

    // 2. pass - filter by languages
    if (params.languages) {
      List languages = params.list('languages')
      results = results.findAll {it.profile.languages.intersect(languages)}
    }

    // 3. pass - filter by facility
    if (params.facility != "") {
      results = results.findAll { Entity entity ->
        Link.createCriteria().get {
          eq('source', entity)
          eq('target', Entity.get(params.facility))
          eq('type', metaDataService.ltWorking)
        }
      }
    }

    int totalResults = results.size()
    int upperBound = params.offset + params.max < totalResults ? params.offset + params.max : totalResults
    results = results.subList(params.offset, upperBound)

    render template: '/templates/searchresults', model: [results: results, totalResults: totalResults, type: 'educator', params: params]
  }

}
