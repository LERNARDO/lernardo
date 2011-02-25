package at.uenterprise.erp.profiles

import at.openfactory.ep.Entity
import at.openfactory.ep.EntityType
import at.openfactory.ep.EntityHelperService
import at.openfactory.ep.ProfileHelperService
import at.uenterprise.erp.MetaDataService
import at.openfactory.ep.Link
import at.openfactory.ep.Profile
import at.uenterprise.erp.FunctionService

class ThemeProfileController {
  MetaDataService metaDataService
  EntityHelperService entityHelperService
  ProfileHelperService profileHelperService
  FunctionService functionService

  def beforeInterceptor = [
          action:{
            params.startDate = params.startDate ? Date.parse("dd. MM. yy", params.startDate) : null
            params.endDate = params.endDate ? Date.parse("dd. MM. yy", params.endDate) : null},
            only:['save','update']
  ]
  
  def index = {
    redirect action: "list", params: params
  }

  // the delete, save and update actions only accept POST requests
  static allowedMethods = [delete: 'POST', save: 'POST', update: 'POST']

  def list = {
    params.offset = params.offset ? params.int('offset') : 0
    params.max = Math.min(params.max ? params.int('max') : 15, 100)
    params.sort = params.sort ?: "dateCreated"
    params.order = params.order ?: "desc"

    /*def c = Entity.createCriteria()
    def themes = c.list {
      eq("type", metaDataService.etTheme)
      profile {
        order(params.sort, params.order)
      }
      maxResults(params.max)
      firstResult(params.offset)
    }*/

    Entity currentEntity = entityHelperService.loggedIn
    List facilities = functionService.findAllByLink(currentEntity, null, metaDataService.ltLeadEducator)

    List allThemes = Entity.findAllByType(metaDataService.etTheme)
    List themes = []

    allThemes.each { theme ->
      // search for parent
      def result = functionService.findByLink(theme, null, metaDataService.ltSubTheme)
      if (!result)
        themes << theme
    }

    return [themes: themes,
            themeTotal: themes.size() /*Entity.countByType(metaDataService.etTheme)*/,
            facilities: facilities]
  }

  def show = {
    Entity theme = Entity.get(params.id)
    Entity entity = params.entity ? theme : entityHelperService.loggedIn

    if (!theme) {
      flash.message = "themeProfile not found with id ${params.id}"
      redirect(action: list)
    }
    else {
      // find all projects which are within the theme duration
      List allProjects = Entity.findAllByType(metaDataService.etProject).findAll {it.profile.startDate >= theme.profile.startDate && it.profile.endDate <= theme.profile.endDate}

      // find all projects currently linked to this theme
      List projects = functionService.findAllByLink(null, theme, metaDataService.ltGroupMember)

      // find all activity groups which are within the theme duration
      List allActivityGroups = Entity.findAllByType(metaDataService.etGroupActivity).findAll {it.profile.date >= theme.profile.startDate && it.profile.date <= theme.profile.endDate}

      // find all activity groups currently linked to this theme
      List activitygroups = functionService.findAllByLink(null, theme, metaDataService.ltGroupMemberActivityGroup)

      // find the facility linked to this theme
      Entity facility = functionService.findByLink(theme, null, metaDataService.ltThemeOfFacility)

      // find parent theme linked to this theme (if any)
      Entity parenttheme = functionService.findByLink(theme, null, metaDataService.ltSubTheme)

      def allEducators = Entity.findAllByType(metaDataService.etEducator)

      [theme: theme,
       /*allSubthemes: allSubthemes,
       subthemes: subthemes,*/
       allProjects: allProjects,
       projects: projects,
       allActivityGroups: allActivityGroups,
       activitygroups: activitygroups,
       facility: facility,
       parenttheme: parenttheme,
       entity: entity,
       allEducators: allEducators]
    }
  }

  def del = {
    Entity theme = Entity.get(params.id)
    if (theme) {
      // delete all links
      Link.findAllBySourceOrTarget(theme, theme).each {it.delete()}
      try {
        flash.message = message(code: "theme.deleted", args: [theme.profile.fullName])
        theme.delete(flush: true)
        redirect(action: "list")
      }
      catch (org.springframework.dao.DataIntegrityViolationException e) {
        flash.message = message(code: "theme.notDeleted", args: [theme.profile.fullName])
        redirect(action: "show", id: params.id)
      }
    }
    else {
      flash.message = "themeProfile not found with id ${params.id}"
      redirect(action: "list")
    }
  }

  def edit = {
    Entity theme = Entity.get(params.id)

    if (!theme) {
      flash.message = "themeProfile not found with id ${params.id}"
      redirect action: 'list'
    }
    else {

      List allThemes = Entity.findAllByType(metaDataService.etTheme)
      allThemes.remove(theme)

      [theme: theme,
       allFacilities: Entity.findAllByType(metaDataService.etFacility),
       allThemes: allThemes,
       parenttheme: functionService.findByLink(theme, null, metaDataService.ltSubTheme),
       facility: functionService.findByLink(theme, null, metaDataService.ltThemeOfFacility)]
    }
  }

  def update = {
    Entity theme = Entity.get(params.id)

    theme.profile.properties = params

    if (!theme.profile.hasErrors() && theme.profile.save()) {

      // delete current link to facility
      Link.findBySourceAndType(theme, metaDataService.ltThemeOfFacility)?.delete()

      // link theme to facility
      functionService.linkEntities(theme.id.toString(), params.facility, metaDataService.ltThemeOfFacility)

      // delete current link to parent theme if any
      Link.findBySourceAndType(theme, metaDataService.ltSubTheme)?.delete()

      // link theme to new parent if any
      if (params.parenttheme != "null")
        functionService.linkEntities(theme.id.toString(), params.parenttheme, metaDataService.ltSubTheme)

      flash.message = message(code: "theme.updated", args: [theme.profile.fullName])
      redirect action: 'show', id: theme.id
    }
    else {
      render view: 'edit', model: [theme: theme, allFacilities: Entity.findAllByType(metaDataService.etFacility), parenttheme: functionService.findByLink(theme, null, metaDataService.ltSubTheme)]
    }
  }

  def create = {

    Entity currentEntity = entityHelperService.loggedIn

    List allFacilities

    // if the current entity is an educator only return facilities he is linked to, else all facilities
    if (currentEntity.type.id == metaDataService.etEducator.id)
      allFacilities = functionService.findAllByLink(currentEntity, null, metaDataService.ltLeadEducator)
    else
      allFacilities = Entity.findAllByType(metaDataService.etFacility)

    return [allFacilities: allFacilities,
            allThemes: Entity.findAllByType(metaDataService.etTheme)]
  }

  def save = {
    EntityType etTheme = metaDataService.etTheme

    Entity currentEntity = entityHelperService.loggedIn

    try {
      Entity entity = entityHelperService.createEntity("theme", etTheme) {Entity ent ->
        ent.profile = profileHelperService.createProfileFor(ent) as Profile
        ent.profile.properties = params
      }

      // link theme to facility
      new Link(source: entity, target: Entity.get(params.facility), type: metaDataService.ltThemeOfFacility).save()

      // link theme to parent theme if one was selected
      if (params.parenttheme != "null")
        functionService.linkEntities(entity.id.toString(), params.parenttheme, metaDataService.ltSubTheme)

      functionService.createEvent(currentEntity, 'Du hast das Thema <a href="' + createLink(controller: 'themeProfile', action: 'show', id: entity.id) + '">' + entity.profile.fullName + '</a> angelegt.')
      List receiver = Entity.findAllByType(metaDataService.etEducator)
      receiver.each {
        if (it.id != currentEntity.id)
          functionService.createEvent(it as Entity, '<a href="' + createLink(controller: currentEntity.type.supertype.name +'Profile', action:'show', id: currentEntity.id) + '">' + currentEntity.profile.fullName + '</a> hat das Thema <a href="' + createLink(controller: 'themeProfile', action: 'show', id: entity.id) + '">' + entity.profile.fullName + '</a> angelegt.')
      }

      // save creator
      new Link(source: currentEntity, target: entity, type: metaDataService.ltCreator).save()

      flash.message = message(code: "theme.created", args: [entity.profile.fullName])
      redirect action: 'show', id: entity.id
    } catch (at.openfactory.ep.EntityException ee) {
      render(view: "create", model: [theme: ee.entity, allFacilities: Entity.findAllByType(metaDataService.etFacility)])
    }

  }

  def addProject = {
    def linking = functionService.linkEntities(params.project, params.id, metaDataService.ltGroupMember)
    if (linking.duplicate)
      render '<span class="red italic">"' + linking.source.profile.fullName + '" wurde bereits zugewiesen!</span>'
    render template: 'projects', model: [projects: linking.results, theme: linking.target, entity: entityHelperService.loggedIn]
  }

  def removeProject = {
    def breaking = functionService.breakEntities(params.project, params.id, metaDataService.ltGroupMember)
    render template: 'projects', model: [projects: breaking.results, theme: breaking.target, entity: entityHelperService.loggedIn]
  }

  def addActivityGroup = {
    def linking = functionService.linkEntities(params.activitygroup, params.id, metaDataService.ltGroupMemberActivityGroup)
    if (linking.duplicate)
      render '<span class="red italic">"' + linking.source.profile.fullName + '" wurde bereits zugewiesen!</span>'
    render template: 'activitygroups', model: [activitygroups: linking.results, theme: linking.target, entity: entityHelperService.loggedIn]
  }

  def removeActivityGroup = {
    def breaking = functionService.breakEntities(params.activitygroup, params.id, metaDataService.ltGroupMemberActivityGroup)
    render template: 'activitygroups', model: [activitygroups: breaking.results, theme: breaking.target, entity: entityHelperService.loggedIn]
  }
}