package at.uenterprise.erp.profiles

import at.uenterprise.erp.base.Entity
import at.uenterprise.erp.base.EntityType
import at.uenterprise.erp.base.EntityHelperService
import at.uenterprise.erp.MetaDataService
import at.uenterprise.erp.FunctionService
import at.uenterprise.erp.base.Link
import at.uenterprise.erp.Folder
import at.uenterprise.erp.FolderType
import at.uenterprise.erp.Setup
import at.uenterprise.erp.EntityDataService
import at.uenterprise.erp.LinkDataService
import at.uenterprise.erp.CDate

class ParentProfileController {
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
    int totalParents = Entity.countByType(metaDataService.etParent)
    List colonies = Entity.findAllByType(metaDataService.etGroupColony)
    List maritalStatus = Setup.list()[0]?.maritalStatus
    List languages = Setup.list()[0]?.languages
    List schoolLevels = Setup.list()[0]?.schoolLevels

    return [totalParents: totalParents, colonies: colonies, maritalStatus: maritalStatus, languages: languages, schoolLevels: schoolLevels]
  }

    def management = {
        Entity parent = Entity.get(params.id)

        render template: "management", model: [parent: parent]
    }

  def show = {
    Entity parent = Entity.get(params.id)

    if (!parent) {
      flash.message = message(code: "object.notFound", args: [message(code: "parent")])
      redirect(action: list)
      return
    }

    Entity colony = linkDataService.getColony(parent)
    Entity family = linkDataService.getFamily(parent)

    return [parent: parent, family: family, colony: colony, ajax: params.ajax]

  }

  def delete = {
    Entity parent = Entity.get(params.id)
    if (parent) {
      functionService.deleteReferences(parent)
      try {
        flash.message = message(code: "object.deleted", args: [message(code: "parent"), parent.profile])
        parent.delete(flush: true)
        redirect(action: "list")
      }
      catch (org.springframework.dao.DataIntegrityViolationException ignore) {
        flash.message = message(code: "object.notDeleted", args: [message(code: "parent"), parent.profile])
        redirect(action: "show", id: params.id)
      }
    }
    else {
      flash.message = message(code: "object.notFound", args: [message(code: "parent")])
      redirect(action: "list")
    }
  }

  def edit = {
    Entity parent = Entity.get(params.id)

    if (!parent) {
      flash.message = message(code: "object.notFound", args: [message(code: "parent")])
      redirect action: 'list'
      return
    }

    Entity colony = linkDataService.getColony(parent)

    def allColonies = entityDataService.getAllColonies()

    return [parent: parent, colony: colony, allColonies: allColonies]
  }

  def update = {
    params.birthDate = params.date('birthDate', 'dd. MM. yy') ?: params.date('birthDate', 'dd.MM.yy')

    Entity parent = Entity.get(params.id)

    parent.profile.properties = params
    parent.profile.fullName = params.lastName + " " + params.firstName
    parent.user.properties = params

    // TODO: find out how to properly handle this cascading validation stuff
    // "parent.hasErrors()" returns false even though properties in the nested class "profile" did not validate
    
    // when validating a parent object it should check validation of nested objects as well because right now nested
    // properties that failed validation are not saved and the "show" view is called as if everything worked fine

    //if (!parent.hasErrors() && parent.save() && !parent.profile.hasErrors()) {
    //println "parent object has errors? " + parent.hasErrors()
    //println parent.errors.each {println it}
    //println "child object has errors? " + parent.profile.hasErrors()
    //println parent.profile.errors.each {println it}

    // update link to colony
    Link.findByTargetAndType(parent, metaDataService.ltColonia)?.delete()
    new Link(source: Entity.get(params.currentColony), target: parent, type: metaDataService.ltColonia).save()

    if (parent.profile.save() && parent.user.save() && parent.save()) {
      flash.message = message(code: "object.updated", args: [message(code: "parent"), parent.profile])
      redirect action: 'show', id: parent.id
    }
    else {
      Entity colony = linkDataService.getColony(parent)
      def allColonies = entityDataService.getAllColonies()
      render view: 'edit', model: [parent: parent, colony: colony, allColonies: allColonies]
    }
  }

  def create = {
    def allColonies = entityDataService.getAllColonies()

    return [allColonies: allColonies]
  }

  def save = {
    EntityType etParent = metaDataService.etParent

    try {
      Entity entity = entityHelperService.createEntityWithUserAndProfile(functionService.createNick(params.firstName,params.lastName), etParent, params.email, params.lastName + " " + params.firstName) {Entity ent ->
        ent.profile.properties = params
        ent.user.properties = params
        ent.profile.birthDate = params.date('birthDate', 'dd. MM. yy') ?: params.date('birthDate', 'dd.MM.yy')
        ent.user.password = securityManager.encodePassword(grailsApplication.config.defaultpass)
        ent.profile.favoritesFolder = new Folder(name: "root", type: FolderType.findByName("favorite")).save()
      }

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
      
      flash.message = message(code: "object.created", args: [message(code: "parent"), entity.profile])
      redirect action: 'show', id: entity.id
    } catch (at.uenterprise.erp.base.EntityException ee) {
      def allColonies = entityDataService.getAllColonies()
      render view: "create", model: [parent: ee.entity, allColonies: allColonies]
    }

  }

  def define = {
    params.sort = params.sort ?: "fullName"
    params.order = params.order ?: "asc"
    params.offset = params.int('offset') ?: 0
    params.max = Math.min(params.int('max') ?: 20, 40)

    // 1. pass - filter by object properties
    def results = Entity.createCriteria().listDistinct  {
      eq('type', metaDataService.etParent)
      user {
        eq('enabled', params.active ? true : false)
      }
      profile {
        if (params.name)
          ilike('fullName', "%" + params.name + "%")
        if (params.gender != "0")
          eq('gender', params.int('gender'))
        if (params.maritalStatus)
          eq('maritalStatus', params.maritalStatus)
        if (params.education)
          eq('education', params.education)
        order(params.sort, params.order)
      }
    }

    // 2. pass - filter by languages
    if (params.languages) {
      List languages = params.list('languages')
      results = results.findAll {it.profile.languages.intersect(languages)}
    }

    // 3. pass - filter by colony
    if (params.colony != "") {
      results = results.findAll { Entity entity ->
        Link.createCriteria().get {
          eq('source', Entity.get(params.colony))
          eq('target', entity)
          eq('type', metaDataService.ltColonia)
        }
      }
    }

    int totalResults = results.size()
    int upperBound = params.offset + params.max < totalResults ? params.offset + params.max : totalResults
    results = results.subList(params.offset, upperBound)

    render template: '/templates/searchresults', model: [results: results, totalResults: totalResults, type: 'parent', params: params]
  }

    def addDate = {
        Entity parent = Entity.get(params.id)

        params.date = params.date('date', 'dd. MM. yy') ?: params.date('date', 'dd.MM.yy')

        if (params.date) {
            CDate date = new CDate(params)
            date.type = parent.profile.dates.size() % 2 == 0 ? 'entry' : 'exit'
            parent.profile.addToDates(date)

            // change active/inactive status
            functionService.updateSingleStatus(parent)
        }
        render template: 'dates', model: [parent: parent]
    }

    def removeDate = {
        Entity parent = Entity.get(params.id)
        CDate date = CDate.get(params.date)
        parent.profile.removeFromDates(date)

        // change active/inactive status
        functionService.updateSingleStatus(parent)

        render template: 'dates', model: [parent: parent]
    }
}
