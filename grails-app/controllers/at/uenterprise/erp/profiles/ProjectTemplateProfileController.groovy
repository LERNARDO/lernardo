package at.uenterprise.erp.profiles

import at.openfactory.ep.Entity
import at.openfactory.ep.EntityType
import at.openfactory.ep.EntityHelperService
import at.openfactory.ep.ProfileHelperService
import at.uenterprise.erp.MetaDataService
import at.openfactory.ep.Profile
import at.openfactory.ep.Link
import at.uenterprise.erp.FunctionService
import at.uenterprise.erp.Event
import at.uenterprise.erp.Live

class ProjectTemplateProfileController {
  MetaDataService metaDataService
  EntityHelperService entityHelperService
  ProfileHelperService profileHelperService
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
    def projectTemplates = c.list (max: params.max, offset: params.offset) {
      eq("type", metaDataService.etProjectTemplate)
      profile {
        order(params.sort, params.order)
      }
    }

    return [projectTemplates: projectTemplates]
  }

  def show = {
    Entity projectTemplate = Entity.get(params.id)
    Entity entity = params.entity ? projectTemplate : entityHelperService.loggedIn

    if (!projectTemplate) {
      flash.message = "projectTemplateProfile not found with id ${params.id}"
      redirect(action: list)
    }
    else {
      // find all projectUnitTemplates linked to this projectTemplate
      List projectUnitTemplates = functionService.findAllByLink(null, projectTemplate, metaDataService.ltProjectUnitTemplate)

      //List allGroupActivityTemplates = Entity.findAllByType(metaDataService.etGroupActivityTemplate)

      // get all groupactivitytemplates that are set to completed
      def c = Entity.createCriteria()
      def allGroupActivityTemplates = c.list {
        eq("type", metaDataService.etGroupActivityTemplate)
        profile {
          eq("status", "done")
        }
      }

      def allEducators = Entity.findAllByType(metaDataService.etEducator)

      // calculate realDuration
      Integer calculatedDuration = calculateDuration(projectUnitTemplates)

      // find all instances of this template
      List instances = functionService.findAllByLink(projectTemplate, null, metaDataService.ltProjectTemplate)

      [projectTemplate: projectTemplate,
              entity: entity,
              projectUnitTemplates: projectUnitTemplates,
              allGroupActivityTemplates: allGroupActivityTemplates,
              calculatedDuration: calculatedDuration,
              instances: instances,
              allEducators: allEducators]
    }
  }

  def del = {
    Entity projectTemplate = Entity.get(params.id)
    if (projectTemplate) {
      // delete all links
      Link.findAllBySourceOrTarget(projectTemplate, projectTemplate).each {it.delete()}
      Event.findAllByEntity(projectTemplate).each {it.delete()}

      try {
        flash.message = message(code: "projectTemplate.deleted", args: [projectTemplate.profile.fullName])
        projectTemplate.delete(flush: true)
        redirect(action: "list")
      }
      catch (org.springframework.dao.DataIntegrityViolationException e) {
        flash.message = message(code: "projectTemplate.notDeleted", args: [projectTemplate.profile.fullName])
        redirect(action: "show", id: params.id)
      }
    }
    else {
      flash.message = "projectTemplateProfile not found with id ${params.id}"
      redirect(action: "list")
    }
  }

  def edit = {
    Entity projectTemplate = Entity.get(params.id)
    Entity entity = params.entity ? projectTemplate : entityHelperService.loggedIn

    if (!projectTemplate) {
      flash.message = "projectTemplateProfile not found with id ${params.id}"
      redirect action: 'list'
    }
    else {
      [projectTemplate: projectTemplate, entity: entity]
    }
  }

  def update = {
    Entity projectTemplate = Entity.get(params.id)

    projectTemplate.profile.properties = params

    if (projectTemplate.profile.save() && projectTemplate.save()) {
      flash.message = message(code: "projectTemplate.updated", args: [projectTemplate.profile.fullName])
      redirect action: 'show', id: projectTemplate.id
    }
    else {
      render view: 'edit', model: [projectTemplate: projectTemplate]
    }
  }

  def copy = {
    EntityType etProjectTemplate = metaDataService.etProjectTemplate

    Entity currentEntity = entityHelperService.loggedIn

    Entity original = Entity.get(params.id)

    Entity entity = entityHelperService.createEntity("projectTemplate", etProjectTemplate) {Entity ent ->
      ent.profile = profileHelperService.createProfileFor(ent) as Profile
      ent.profile.description = original.profile.description
      ent.profile.status = original.profile.status
      ent.profile.fullName = original.profile.fullName + '[Duplikat]'
    }

    // save creator
    new Link(source: currentEntity, target: entity, type: metaDataService.ltCreator).save()

    // find project unit templates linked to the original
    List projectUnitTemplates = functionService.findAllByLink(null, original, metaDataService.ltProjectUnitTemplate)

    projectUnitTemplates.each {
      // create project unit templates for the copy
      EntityType etProjectUnitTemplate = metaDataService.etProjectUnitTemplate
      Entity projectUnitTemplate = entityHelperService.createEntity("projectUnitTemplate", etProjectUnitTemplate) {Entity ent ->
        ent.profile = profileHelperService.createProfileFor(ent) as Profile
        ent.profile.duration = it.profile.duration
        ent.profile.fullName = it.profile.fullName
      }

      // link projectUnitTemplate and projectTemplate
      new Link(source: projectUnitTemplate, target: entity, type: metaDataService.ltProjectUnitTemplate).save()

      // find group activity templates linked to the original project unit
      List groupActivityTemplates = functionService.findAllByLink(null, it as Entity, metaDataService.ltProjectUnitMember)

      // link group activity templates to the project unit templates of the copy
      groupActivityTemplates.each {
        new Link(source: it as Entity, target: projectUnitTemplate, type: metaDataService.ltProjectUnitMember).save()
      }
    }

    flash.message = message(code: "projectTemplate.copied", args: [entity.profile.fullName])
    redirect action: 'show', id: entity.id
  }

  def create = {
    Entity projectTemplate = Entity.get(params.id)
    return [projectTemplate: projectTemplate]
  }

  def save = {
    EntityType etProjectTemplate = metaDataService.etProjectTemplate

    Entity currentEntity = entityHelperService.loggedIn

    try {
      Entity entity = entityHelperService.createEntity("projectTemplate", etProjectTemplate) {Entity ent ->
        ent.profile = profileHelperService.createProfileFor(ent) as Profile
        ent.profile.properties = params
      }

      new Live(content: '<a href="' + createLink(controller: currentEntity.type.supertype.name +'Profile', action:'show', id: currentEntity.id) + '">' + currentEntity.profile.fullName + '</a> hat die Projektvorlage <a href="' + createLink(controller: 'projectTemplateProfile', action: 'show', id: entity.id) + '">' + entity.profile.fullName + '</a> angelegt.').save()
      functionService.createEvent(currentEntity, 'Du hast die Projektvorlage <a href="' + createLink(controller: 'projectTemplateProfile', action: 'show', id: entity.id) + '">' + entity.profile.fullName + '</a> angelegt.')
      List receiver = Entity.findAllByType(metaDataService.etEducator)
      receiver.each {
        if (it.id != currentEntity.id)
          functionService.createEvent(it as Entity, '<a href="' + createLink(controller: currentEntity.type.supertype.name +'Profile', action:'show', id: currentEntity.id) + '">' + currentEntity.profile.fullName + '</a> hat die Projektvorlage <a href="' + createLink(controller: 'projectTemplateProfile', action: 'show', id: entity.id) + '">' + entity.profile.fullName + '</a> angelegt.')
      }

      // save creator
      new Link(source: currentEntity, target: entity, type: metaDataService.ltCreator).save()

      flash.message = message(code: "projectTemplate.created", args: [entity.profile.fullName])
      redirect action: 'show', id: entity.id
    } catch (at.openfactory.ep.EntityException ee) {
      render(view: "create", model: [projectTemplate: ee.entity])
    }

  }

  def editProjectUnitTemplate = {
    Entity projectUnitTemplate = Entity.get(params.projectUnitTemplate)
    render template: "editProjectUnitTemplate", model:[projectUnitTemplate: projectUnitTemplate, i: params.i]
  }

  def updateProjectUnitTemplate = {
    Entity projectUnitTemplate = Entity.get(params.id)
    projectUnitTemplate.profile.fullName = params.fullName
    projectUnitTemplate.save()
    render projectUnitTemplate.profile.fullName
  }

  def addProjectUnitTemplate = {
    Entity projectTemplate = Entity.get(params.id)

    // find all existing project units of this project template so we can find the unit number
    List units = functionService.findAllByLink(null, projectTemplate, metaDataService.ltProjectUnitTemplate)
    int counter = 1
    if (units)
      counter = units.size() + 1

    try {
      // create projectUnitTemplate
      EntityType etProjectUnitTemplate = metaDataService.etProjectUnitTemplate
      Entity projectUnitTemplate = entityHelperService.createEntity("projectUnitTemplate", etProjectUnitTemplate) {Entity ent ->
        ent.profile = profileHelperService.createProfileFor(ent) as Profile
        ent.profile.properties = params
        ent.profile.fullName = "Einheit " + counter
      }

      // link projectUnitTemplate and projectTemplate
      new Link(source: projectUnitTemplate, target: projectTemplate, type: metaDataService.ltProjectUnitTemplate).save()

      // find all projectUnitTemplates of this projectTemplate
      List projectUnitTemplates = functionService.findAllByLink(null, projectTemplate, metaDataService.ltProjectUnitTemplate)

      List allGroupActivityTemplates = Entity.findAllByType(metaDataService.etGroupActivityTemplate)

      // calculate realDuration
      Integer calculatedDuration = calculateDuration(projectUnitTemplates)

      render template: 'projectUnitTemplates', model: [allGroupActivityTemplates: allGroupActivityTemplates, projectUnitTemplates: projectUnitTemplates, projectTemplate: projectTemplate, entity: entityHelperService.loggedIn, calculatedDuration: calculatedDuration]
    } catch (at.openfactory.ep.EntityException ee) {
      render '<span class="red">Projekteinheitvorlage konnte nicht gespeichert werden!</span><br/>'

      // find all projectUnitTemplates of this projectTemplate
      List projectUnitTemplates = functionService.findAllByLink(null, projectTemplate, metaDataService.ltProjectUnitTemplate)

      List allGroupActivityTemplates = Entity.findAllByType(metaDataService.etGroupActivityTemplate)

      // calculate realDuration
      Integer calculatedDuration = calculateDuration(projectUnitTemplates)

      render template: 'projectUnitTemplates', model: [allGroupActivityTemplates: allGroupActivityTemplates, projectUnitTemplates: projectUnitTemplates, projectTemplate: projectTemplate, entity: entityHelperService.loggedIn, calculatedDuration: calculatedDuration]
    }
  }

  def removeProjectUnitTemplate = {
    Entity projectTemplate = Entity.get(params.id)

    // delete link
    def c = Link.createCriteria()
    def link = c.get {
      eq('source', Entity.get(params.projectUnitTemplate))
      eq('target', projectTemplate)
      eq('type', metaDataService.ltProjectUnitTemplate)
    }
    link.delete()

    // delete links of groupActivityTemplates to projectUnitTemplate
    Link.findAllByTargetAndType(Entity.get(params.projectUnitTemplate), metaDataService.ltProjectUnitMember).each {it.delete()}

    // delete projectUnitTemplate
    Entity.get(params.projectUnitTemplate).delete()

    // find all projectUnitTemplates of this projectTemplate
    List projectUnitTemplates = functionService.findAllByLink(null, projectTemplate, metaDataService.ltProjectUnitTemplate)

    // calculate realDuration
    Integer calculatedDuration = calculateDuration(projectUnitTemplates)

    render template: 'projectUnitTemplates', model: [projectUnitTemplates: projectUnitTemplates, projectTemplate: projectTemplate, entity: entityHelperService.loggedIn, calculatedDuration: calculatedDuration]
  }

  def addGroupActivityTemplate = {
    Entity groupActivityTemplate = Entity.get(params.groupActivityTemplate)
    Entity projectUnitTemplate = Entity.get(params.id)
    Entity projectTemplate = Entity.get(params.projectTemplate)

    // check if the groupActivityTemplate isn't already linked to the projectUnitTemplate
    def c = Link.createCriteria()
    def link = c.get {
      eq('source', groupActivityTemplate)
      eq('target', projectUnitTemplate)
      eq('type', metaDataService.ltProjectUnitMember)
    }
    if (!link)
      // link groupActivityTemplate to projectUnit
      new Link(source: groupActivityTemplate, target: projectUnitTemplate, type: metaDataService.ltProjectUnitMember).save()

    // find all groupActivityTemplates linked to the unit
    List groupActivityTemplates = functionService.findAllByLink(null, projectUnitTemplate, metaDataService.ltProjectUnitMember)

    // find all projectunits of this projectTemplate
    //def links = Link.findAllByTargetAndType(projectTemplate, metaDataService.ltProjectUnit)
    // List projectUnits = links.collect {it.source}

    // calculate realDuration
    //Integer calculatedDuration = calculateDuration(projectUnits)

    //render '<span style="color: #0b0; padding: 0 0 5px 15px; font-size: 11px">' + groupActivityTemplate.profile.fullName + ' wurde hinzugefügt</span>'
    render template: 'groupActivityTemplates', model: [groupActivityTemplates: groupActivityTemplates, unit: projectUnitTemplate, entity: entityHelperService.loggedIn, i: params.i, projectTemplate: projectTemplate]
  }

  def removeGroupActivityTemplate = {
    Entity groupActivityTemplate = Entity.get(params.groupActivityTemplate)
    Entity projectUnitTemplate = Entity.get(params.id)
    Entity projectTemplate = Entity.get(params.projectTemplate)

    // delete link
    def c = Link.createCriteria()
    def link = c.get {
      eq('source', groupActivityTemplate)
      eq('target', projectUnitTemplate)
      eq('type', metaDataService.ltProjectUnitMember)
    }
    link.delete()

    // find all groupActivityTemplates linked to the unit
    List groupActivityTemplates = functionService.findAllByLink(null, projectUnitTemplate, metaDataService.ltProjectUnitMember)

    // find all projectunits of this projectTemplate
    //def links = Link.findAllByTargetAndType(projectTemplate, metaDataService.ltProjectUnit)
    //List projectUnits = links.collect {it.source}

    // calculate realDuration
    //Integer calculatedDuration = calculateDuration(projectUnits)

    //render '<span style="color: #b00; padding: 0 0 5px 15px; font-size: 11px">' + groupActivityTemplate.profile.fullName + ' wurde entfernt</span><br/>'
    render template: 'groupActivityTemplates', model: [groupActivityTemplates: groupActivityTemplates, unit: projectUnitTemplate, entity: entityHelperService.loggedIn, i: params.i, projectTemplate: projectTemplate]
  }

  def updateduration = {
    Entity projectTemplate = Entity.get(params.id)

    // find all projectUnitTemplates linked to this projectTemplate
    List projectUnitTemplates = functionService.findAllByLink(null, projectTemplate, metaDataService.ltProjectUnitTemplate)

    // calculate realDuration
    Integer calculatedDuration = calculateDuration(projectUnitTemplates)

    render template:'updateduration', model:[calculatedDuration: calculatedDuration, projectTemplate: projectTemplate]   
  }

  Integer calculateDuration(List projectUnitTemplates) {
    // find all groupActivityTemplates linked to all projectUnitTemplates of this projectTemplate
    List groupActivityTemplates = []

    projectUnitTemplates.each {
      def links = functionService.findAllByLink(null, it as Entity, metaDataService.ltProjectUnitMember)
      if (links.size() > 0)
        groupActivityTemplates.addAll(links)
    }

    def calculatedDuration = 0
    groupActivityTemplates.each {
      calculatedDuration += it.profile.realDuration
    }

    return calculatedDuration
  }

  /*
   * retrieves all clients matching the search parameter
   */
  def remoteGroupActivityTemplate = {
    if (!params.value) {
      render ""
      return
    }
    else if (params.value == "*") {
      def c = Entity.createCriteria()
      def results = c.list {
        eq("type", metaDataService.etGroupActivityTemplate)
        profile {
          eq("status", "done")
        }
      }
      render(template: 'groupactivitytemplateresults', model: [results: results, projectUnitTemplate: params.id, i: params.i, projectTemplate: params.projectTemplate])
      return
    }

    def c = Entity.createCriteria()
    def results = c.list {
      eq('type', metaDataService.etGroupActivityTemplate)
      profile {
        eq('status', "done")
      }
      or {
        ilike('name', "%" + params.value + "%")
        profile {
          ilike('fullName', "%" + params.value + "%")
        }
      }
      maxResults(15)
    }

    if (results.size() == 0) {
      render '<span class="italic">'+message(code:'noResultsFound')+'</span>'
      return
    }
    else {
      render(template: 'groupactivitytemplateresults', model: [results: results, projectUnitTemplate: params.id, i: params.i, projectTemplate: params.projectTemplate])
    }
  }
}


