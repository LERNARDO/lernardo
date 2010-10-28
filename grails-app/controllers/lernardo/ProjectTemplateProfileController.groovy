package lernardo

import at.openfactory.ep.Entity
import at.openfactory.ep.EntityType
import at.openfactory.ep.EntityHelperService
import at.openfactory.ep.ProfileHelperService
import standard.MetaDataService
import at.openfactory.ep.Profile
import at.openfactory.ep.Link
import standard.FunctionService

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
    def projecttemplates = c.list {
      eq("type", metaDataService.etProjectTemplate)
      profile {
        order(params.sort, params.order)
      }
      maxResults(params.max)
      firstResult(params.offset)
    }

    return [projectTemplateList: projecttemplates,
            projectTemplateTotal: Entity.countByType(metaDataService.etProjectTemplate)]
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
          eq("status", "fertig")
        }
      }

      // calculate realDuration
      Integer calculatedDuration = calculateDuration(projectUnitTemplates)

      [projectTemplate: projectTemplate,
              entity: entity,
              projectUnitTemplates: projectUnitTemplates,
              allGroupActivityTemplates: allGroupActivityTemplates,
              calculatedDuration: calculatedDuration]
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

    if (!projectTemplate) {
      flash.message = "projectTemplateProfile not found with id ${params.id}"
      redirect action: 'list'
    }
    else {
      [projectTemplate: projectTemplate]
    }
  }

  def update = {
    Entity projectTemplate = Entity.get(params.id)

    projectTemplate.profile.properties = params

    if (!projectTemplate.hasErrors() && projectTemplate.save()) {
      flash.message = message(code: "projectTemplate.updated", args: [projectTemplate.profile.fullName])
      redirect action: 'show', id: projectTemplate.id
    }
    else {
      render view: 'edit', model: [projectTemplate: projectTemplate]
    }
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

      functionService.createEvent(currentEntity, 'Du hast die Projektvorlage <a href="' + createLink(controller: 'projectTemplateProfile', action: 'show', id: entity.id) + '">' + entity.profile.fullName + '</a> angelegt.')
      List receiver = Entity.findAllByType(metaDataService.etEducator)
      receiver.each {
        if (it.id != currentEntity.id)
          functionService.createEvent(it as Entity, '<a href="' + createLink(controller: currentEntity.type.supertype.name +'Profile', action:'show', id: currentEntity.id) + '">' + currentEntity.profile.fullName + '</a> hat die Projektvorlage <a href="' + createLink(controller: 'projectTemplateProfile', action: 'show', id: entity.id) + '">' + entity.profile.fullName + '</a> angelegt.')
      }

      flash.message = message(code: "projectTemplate.created", args: [entity.profile.fullName])
      redirect action: 'show', id: entity.id
    } catch (at.openfactory.ep.EntityException ee) {
      render(view: "create", model: [projectTemplate: ee.entity])
      return
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
    def linksc = Link.findAllByTargetAndType(projectTemplate, metaDataService.ltProjectUnitTemplate)
    List units = linksc.collect {it.source}
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
      return
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

    def blocks = Link.findAllByTargetAndType(Entity.get(params.projectUnitTemplate), metaDataService.ltProjectUnitMember)
    if (blocks)
      blocks.each {it.delete()}

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

    render '<span style="color: #0b0; padding: 0 0 5px 15px; font-size: 11px">' + groupActivityTemplate.profile.fullName + ' wurde hinzugefügt</span>'
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

    render '<span style="color: #b00; padding: 0 0 5px 15px; font-size: 11px">' + groupActivityTemplate.profile.fullName + ' wurde entfernt</span><br/>'
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
      def links = Link.findAllByTargetAndType(it as Entity, metaDataService.ltProjectUnitMember)
      if (links.size() > 0)
        groupActivityTemplates.addAll(links.collect {bla -> bla.source})
    }

    def calculatedDuration = 0
    groupActivityTemplates.each {
      calculatedDuration += it.profile.realDuration
    }

    return calculatedDuration
  }
}


