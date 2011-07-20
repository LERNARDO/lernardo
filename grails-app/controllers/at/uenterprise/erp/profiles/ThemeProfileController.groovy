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
      eq("type", servletContext.etTheme)
      profile {
        order(params.sort, params.order)
      }
      maxResults(params.max)
      firstResult(params.offset)
    }*/

    Entity currentEntity = entityHelperService.loggedIn
    List facilities = functionService.findAllByLink(currentEntity, null, servletContext.ltLeadEducator)

    List allThemes = Entity.findAllByType(servletContext.etTheme)
    List themes = []

    allThemes.each { theme ->
      // search for parent
      def result = functionService.findByLink(theme, null, servletContext.ltSubTheme)
      if (!result)
        themes << theme
    }

    return [themes: themes,
            themeTotal: themes.size() /*Entity.countByType(servletContext.etTheme)*/,
            facilities: facilities]
  }

  def show = {
    Entity theme = Entity.get(params.id)
    Entity entity = params.entity ? theme : entityHelperService.loggedIn

    if (!theme) {
      //flash.message = "themeProfile not found with id ${params.id}"
      flash.message = message(code: "theme.idNotFound", args: [params.id])
      redirect(action: list)
    }
    else {
      // find all projects which are within the theme duration
      List allProjects = Entity.findAllByType(servletContext.etProject).findAll {it.profile.startDate >= theme.profile.startDate && it.profile.endDate <= theme.profile.endDate}

      // find all projects currently linked to this theme
      List projects = functionService.findAllByLink(null, theme, servletContext.ltGroupMember)

      // find all activity groups which are within the theme duration
      List allActivityGroups = Entity.findAllByType(servletContext.etGroupActivity).findAll {it.profile.date >= theme.profile.startDate && it.profile.date <= theme.profile.endDate}

      // find all activity groups currently linked to this theme
      List activitygroups = functionService.findAllByLink(null, theme, servletContext.ltGroupMemberActivityGroup)

      // find the facility linked to this theme
      Entity facility = functionService.findByLink(theme, null, servletContext.ltThemeOfFacility)

      // find parent theme linked to this theme (if any)
      Entity parenttheme = functionService.findByLink(theme, null, servletContext.ltSubTheme)

      [theme: theme,
       allProjects: allProjects,
       projects: projects,
       allActivityGroups: allActivityGroups,
       activitygroups: activitygroups,
       facility: facility,
       parenttheme: parenttheme,
       entity: entity]
    }
  }

  def delete = {
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
      //flash.message = "themeProfile not found with id ${params.id}"
      flash.message = message(code: "theme.idNotFound", args: [params.id])
      redirect(action: "list")
    }
  }

  def edit = {
    Entity theme = Entity.get(params.id)

    if (!theme) {
      //flash.message = "themeProfile not found with id ${params.id}"
      flash.message = message(code: "theme.idNotFound", args: [params.id])
      redirect action: 'list'
    }
    else {

      // find all themes that are not the current theme itself and are not subthemes (recursively)
      List excludedThemes = []
      excludedThemes.add(theme)
      List temp = []
      temp.addAll(excludedThemes)
      List toCheck

      while (temp.size() > 0) {
        toCheck = []
        toCheck.addAll(temp)
        temp = []
        toCheck.each { current ->
          List subthemes = functionService.findAllByLink(null, current, servletContext.ltSubTheme)
          if (subthemes) {
            excludedThemes.addAll(subthemes)
            temp.addAll(subthemes)
          }
        }
      }

      // get all themes
      List allThemes = Entity.findAllByType(servletContext.etTheme)

      // remove all themes that are excluded
      excludedThemes.each {
        if (allThemes.contains(it))
          allThemes.remove(it)
      }

      [theme: theme,
       allFacilities: Entity.findAllByType(servletContext.etFacility),
       allThemes: allThemes,
       parenttheme: functionService.findByLink(theme, null, servletContext.ltSubTheme),
       facility: functionService.findByLink(theme, null, servletContext.ltThemeOfFacility)]
    }
  }

  def update = {
    Entity theme = Entity.get(params.id)

    theme.profile.properties = params
    //theme.profile.startDate = functionService.convertToUTC(theme.profile.startDate)
    //theme.profile.endDate = functionService.convertToUTC(theme.profile.endDate)

    if (theme.profile.save() && theme.save()) {

      // delete current link to facility
      Link.findBySourceAndType(theme, servletContext.ltThemeOfFacility)?.delete()

      // link theme to facility
      functionService.linkEntities(theme.id.toString(), params.facility, servletContext.ltThemeOfFacility)

      // delete current link to parent theme if any
      Link.findBySourceAndType(theme, servletContext.ltSubTheme)?.delete()

      // link theme to new parent if any
      if (params.parenttheme != "null")
        functionService.linkEntities(theme.id.toString(), params.parenttheme, servletContext.ltSubTheme)

      flash.message = message(code: "theme.updated", args: [theme.profile.fullName])
      redirect action: 'show', id: theme.id
    }
    else {

      // find all themes that are not the current theme itself and are not subthemes (recursively)
      List excludedThemes = []
      excludedThemes.add(theme)
      List temp = []
      temp.addAll(excludedThemes)
      List toCheck

      while (temp.size() > 0) {
        toCheck = []
        toCheck.addAll(temp)
        temp = []
        toCheck.each { current ->
          List subthemes = functionService.findAllByLink(null, current, servletContext.ltSubTheme)
          if (subthemes) {
            excludedThemes.addAll(subthemes)
            temp.addAll(subthemes)
          }
        }
      }

      // get all themes
      List allThemes = Entity.findAllByType(servletContext.etTheme)

      // remove all themes that are excluded
      excludedThemes.each {
        if (allThemes.contains(it))
          allThemes.remove(it)
      }

      render view: 'edit', model: [theme: theme,
                                   allFacilities: Entity.findAllByType(servletContext.etFacility),
                                   allThemes: allThemes,
                                   parenttheme: functionService.findByLink(theme, null, servletContext.ltSubTheme),
                                   facility: functionService.findByLink(theme, null, servletContext.ltThemeOfFacility)]
    }
  }

  def create = {

    Entity currentEntity = entityHelperService.loggedIn

    List allFacilities

    // if the current entity is an educator only return facilities he is linked to, else all facilities
    if (currentEntity.type.id == servletContext.etEducator.id)
      allFacilities = functionService.findAllByLink(currentEntity, null, servletContext.ltLeadEducator)
    else
      allFacilities = Entity.findAllByType(servletContext.etFacility)

    return [allFacilities: allFacilities,
            allThemes: Entity.findAllByType(servletContext.etTheme)]
  }

  def save = {
    EntityType etTheme = servletContext.etTheme

    Entity currentEntity = entityHelperService.loggedIn

    try {
      Entity entity = entityHelperService.createEntity("theme", etTheme) {Entity ent ->
        ent.profile = profileHelperService.createProfileFor(ent) as Profile
        ent.profile.properties = params
        // ent.profile.startDate = functionService.convertToUTC(ent.profile.startDate)
        // ent.profile.endDate = functionService.convertToUTC(ent.profile.endDate)
      }

      // link theme to facility
      new Link(source: entity, target: Entity.get(params.facility), type: servletContext.ltThemeOfFacility).save()

      // link theme to parent theme if one was selected
      if (params.parenttheme != "null")
        functionService.linkEntities(entity.id.toString(), params.parenttheme, servletContext.ltSubTheme)

      functionService.createEvent("THEME_CREATED", currentEntity.id.toInteger(), entity.id.toInteger())

      // save creator
      new Link(source: currentEntity, target: entity, type: servletContext.ltCreator).save()

      flash.message = message(code: "theme.created", args: [entity.profile.fullName])
      redirect action: 'show', id: entity.id, params: [entity: entity.id]
    } catch (at.openfactory.ep.EntityException ee) {
      render(view: "create", model: [theme: ee.entity, allFacilities: Entity.findAllByType(servletContext.etFacility)])
    }

  }

  def addProject = {
    def linking = functionService.linkEntities(params.project, params.id, servletContext.ltGroupMember)
    if (linking.duplicate)
      //render '<span class="red italic">"' + linking.source.profile.fullName + '" wurde bereits zugewiesen!</span>'
      render '<p class="red italic">"' + linking.source.profile.fullName + '" '+message(code: "alreadyAssignedTo")+'</p>'
    render template: 'projects', model: [projects: linking.results, theme: linking.target, entity: entityHelperService.loggedIn]
  }

  def removeProject = {
    def breaking = functionService.breakEntities(params.project, params.id, servletContext.ltGroupMember)
    render template: 'projects', model: [projects: breaking.results, theme: breaking.target, entity: entityHelperService.loggedIn]
  }

  def addActivityGroup = {
    def linking = functionService.linkEntities(params.activitygroup, params.id, servletContext.ltGroupMemberActivityGroup)
    if (linking.duplicate)
      //render '<span class="red italic">"' + linking.source.profile.fullName + '" wurde bereits zugewiesen!</span>'
      render '<p class="red italic">"' + linking.source.profile.fullName + '" '+message(code: "alreadyAssignedTo")+'</p>'
    render template: 'activitygroups', model: [activitygroups: linking.results, theme: linking.target, entity: entityHelperService.loggedIn]
  }

  def removeActivityGroup = {
    def breaking = functionService.breakEntities(params.activitygroup, params.id, servletContext.ltGroupMemberActivityGroup)
    render template: 'activitygroups', model: [activitygroups: breaking.results, theme: breaking.target, entity: entityHelperService.loggedIn]
  }
}