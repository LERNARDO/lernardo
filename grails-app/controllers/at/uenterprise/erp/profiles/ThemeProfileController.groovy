package at.uenterprise.erp.profiles

import at.openfactory.ep.Entity
import at.openfactory.ep.EntityType
import at.openfactory.ep.EntityHelperService
import at.openfactory.ep.ProfileHelperService
import at.uenterprise.erp.MetaDataService
import at.openfactory.ep.Link
import at.openfactory.ep.Profile
import at.uenterprise.erp.FunctionService
import at.uenterprise.erp.EVENT_TYPE

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
    params.offset = params.int('offset') ?: 0
    params.max = Math.min(params.int('max') ?: 15, 100)
    params.sort = params.sort ?: "dateCreated"
    params.order = params.order ?: "desc"

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
            themeTotal: themes.size(),
            facilities: facilities,
            allThemes: allThemes.size()]
  }

  def show = {
    Entity theme = Entity.get(params.id)

    if (!theme) {
      flash.message = message(code: "object.notFound", args: [message(code: "theme")])
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

      [theme: theme,
       allProjects: allProjects,
       projects: projects,
       allActivityGroups: allActivityGroups,
       activitygroups: activitygroups,
       facility: facility,
       parenttheme: parenttheme]
    }
  }

  def delete = {
    Entity theme = Entity.get(params.id)
    if (theme) {
      functionService.deleteReferences(theme)
      try {
        flash.message = message(code: "object.deleted", args: [message(code: "theme"), theme.profile.fullName])
        theme.delete(flush: true)
        redirect(action: "list")
      }
      catch (org.springframework.dao.DataIntegrityViolationException e) {
        flash.message = message(code: "object.notDeleted", args: [message(code: "theme"), theme.profile.fullName])
        redirect(action: "show", id: params.id)
      }
    }
    else {
      flash.message = message(code: "object.notFound", args: [message(code: "theme")])
      redirect(action: "list")
    }
  }

  def edit = {
    Entity theme = Entity.get(params.id)

    if (!theme) {
      flash.message = message(code: "object.notFound", args: [message(code: "theme")])
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
          List subthemes = functionService.findAllByLink(null, current, metaDataService.ltSubTheme)
          if (subthemes) {
            excludedThemes.addAll(subthemes)
            temp.addAll(subthemes)
          }
        }
      }

      // get all themes
      List allThemes = Entity.findAllByType(metaDataService.etTheme)

      // remove all themes that are excluded
      excludedThemes.each {
        if (allThemes.contains(it))
          allThemes.remove(it)
      }

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
    //theme.profile.startDate = functionService.convertToUTC(theme.profile.startDate)
    //theme.profile.endDate = functionService.convertToUTC(theme.profile.endDate)

    if (theme.profile.save() && theme.save()) {

      // delete current link to facility
      Link.findBySourceAndType(theme, metaDataService.ltThemeOfFacility)?.delete()

      // link theme to facility
      functionService.linkEntities(theme.id.toString(), params.facility, metaDataService.ltThemeOfFacility)

      // delete current link to parent theme if any
      Link.findBySourceAndType(theme, metaDataService.ltSubTheme)?.delete()

      // link theme to new parent if any
      if (params.parenttheme != "null")
        functionService.linkEntities(theme.id.toString(), params.parenttheme, metaDataService.ltSubTheme)

      flash.message = message(code: "object.updated", args: [message(code: "theme"), theme.profile.fullName])
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
          List subthemes = functionService.findAllByLink(null, current, metaDataService.ltSubTheme)
          if (subthemes) {
            excludedThemes.addAll(subthemes)
            temp.addAll(subthemes)
          }
        }
      }

      // get all themes
      List allThemes = Entity.findAllByType(metaDataService.etTheme)

      // remove all themes that are excluded
      excludedThemes.each {
        if (allThemes.contains(it))
          allThemes.remove(it)
      }

      render view: 'edit', model: [theme: theme,
                                   allFacilities: Entity.findAllByType(metaDataService.etFacility),
                                   allThemes: allThemes,
                                   parenttheme: functionService.findByLink(theme, null, metaDataService.ltSubTheme),
                                   facility: functionService.findByLink(theme, null, metaDataService.ltThemeOfFacility)]
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
        // ent.profile.startDate = functionService.convertToUTC(ent.profile.startDate)
        // ent.profile.endDate = functionService.convertToUTC(ent.profile.endDate)
      }

      // link theme to facility
      new Link(source: entity, target: Entity.get(params.facility), type: metaDataService.ltThemeOfFacility).save()

      // link theme to parent theme if one was selected
      if (params.parenttheme != "null")
        functionService.linkEntities(entity.id.toString(), params.parenttheme, metaDataService.ltSubTheme)

      functionService.createEvent(EVENT_TYPE.THEME_CREATED, currentEntity.id.toInteger(), entity.id.toInteger())

      // save creator
      new Link(source: currentEntity, target: entity, type: metaDataService.ltCreator).save()

      flash.message = message(code: "object.created", args: [message(code: "theme"), entity.profile.fullName])
      redirect action: 'show', id: entity.id, params: [entity: entity.id]
    } catch (at.openfactory.ep.EntityException ee) {
      render(view: "create", model: [theme: ee.entity, allFacilities: Entity.findAllByType(metaDataService.etFacility)])
    }

  }

  def addProject = {
    def linking = functionService.linkEntities(params.project, params.id, metaDataService.ltGroupMember)
    if (linking.duplicate)
      render '<p class="red italic">"' + linking.source.profile.fullName + '" '+message(code: "alreadyAssignedTo")+'</p>'
    render template: 'projects', model: [projects: linking.results, theme: linking.target, entity: entityHelperService.loggedIn]
  }

  def removeProject = {
    def breaking = functionService.breakEntities(params.project, params.id, metaDataService.ltGroupMember)
    render template: 'projects', model: [projects: breaking.results, theme: breaking.target, entity: entityHelperService.loggedIn]
  }

  def addActivityGroup = {
    def linking = functionService.linkEntities(params.activitygroup, params.id, metaDataService.ltGroupMemberActivityGroup)
    if (linking.duplicate)
      render '<p class="red italic">"' + linking.source.profile.fullName + '" '+message(code: "alreadyAssignedTo")+'</p>'
    render template: 'activitygroups', model: [activitygroups: linking.results, theme: linking.target, entity: entityHelperService.loggedIn]
  }

  def removeActivityGroup = {
    def breaking = functionService.breakEntities(params.activitygroup, params.id, metaDataService.ltGroupMemberActivityGroup)
    render template: 'activitygroups', model: [activitygroups: breaking.results, theme: breaking.target, entity: entityHelperService.loggedIn]
  }
}