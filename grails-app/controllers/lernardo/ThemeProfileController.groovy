package lernardo

import at.openfactory.ep.Entity
import at.openfactory.ep.EntityType
import at.openfactory.ep.EntityHelperService
import at.openfactory.ep.ProfileHelperService
import standard.MetaDataService
import at.openfactory.ep.Link
import at.openfactory.ep.Profile
import standard.FunctionService

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
    params.sort = params.sort ?: "fullName"
    params.order = params.order ?: "asc"

    def c = Entity.createCriteria()
    def themes = c.list {
      eq("type", metaDataService.etTheme)
      profile {
        order(params.sort, params.order)
      }
      maxResults(params.max)
      firstResult(params.offset)
    }

    return [themeList: themes,
            themeTotal: Entity.countByType(metaDataService.etTheme),
            entity: entityHelperService.loggedIn]
  }

  def show = {
    Entity theme = Entity.get(params.id)

    if (!theme) {
      flash.message = "themeProfile not found with id ${params.id}"
      redirect(action: list)
    }
    else {
      def c = Entity.createCriteria()
      def allSubthemes = c.list {
        eq("type", metaDataService.etTheme)
        profile {
          eq("type", "Subthema")
          //eq('type', metaDataService.ltSubTheme)  //hf ?
        }
      }
      // find all subthemes of this theme
      def links = Link.findAllByTargetAndType(theme, metaDataService.ltSubTheme)
      List subthemes = links.collect {it.source}

      def allProjects = Entity.findAllByType(metaDataService.etProject)
      // find all projects linked to this theme
      links = Link.findAllByTargetAndType(theme, metaDataService.ltGroupMember)
      List projects = links.collect {it.source}

      // find facility the theme is linked to
      def link = Link.findBySourceAndType(theme, metaDataService.ltThemeOfFacility)
      Entity facility = link?.target

      [theme: theme,
              entity: entityHelperService.loggedIn,
              allSubthemes: allSubthemes,
              subthemes: subthemes,
              allProjects: allProjects,
              projects: projects,
              facility: facility]
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
      [theme: theme, entity: entityHelperService.loggedIn, allFacilities: Entity.findAllByType(metaDataService.etFacility)]
    }
  }

  def update = {
    Entity theme = Entity.get(params.id)

    theme.profile.properties = params

    if (!theme.profile.hasErrors() && theme.profile.save()) {

      // delete current link
      Link.findBySourceAndType(theme, metaDataService.ltThemeOfFacility)?.delete()

      // link theme to facility
      new Link(source: theme, target: Entity.get(params.facility), type: metaDataService.ltThemeOfFacility).save()

      flash.message = message(code: "theme.updated", args: [theme.profile.fullName])
      redirect action: 'show', id: theme.id
    }
    else {
      render view: 'edit', model: [theme: theme, entity: entityHelperService.loggedIn, allFacilities: Entity.findAllByType(metaDataService.etFacility)]
    }
  }

  def create = {
    return [entity: entityHelperService.loggedIn, allFacilities: Entity.findAllByType(metaDataService.etFacility)]
  }

  def save = {

    EntityType etTheme = metaDataService.etTheme

    try {
      Entity entity = entityHelperService.createEntity("theme", etTheme) {Entity ent ->
        ent.profile = profileHelperService.createProfileFor(ent) as Profile
        ent.profile.properties = params
      }

      // link theme to facility
      new Link(source: entity, target: Entity.get(params.facility), type: metaDataService.ltThemeOfFacility).save()

      flash.message = message(code: "theme.created", args: [entity.profile.fullName])
      redirect action: 'show', id: entity.id
    } catch (at.openfactory.ep.EntityException ee) {
      render(view: "create", model: [theme: ee.entity, entity: entityHelperService.loggedIn, allFacilities: Entity.findAllByType(metaDataService.etFacility)])
      return
    }

  }

  def addSubTheme = {
    def linking = functionService.linkEntities(params.subtheme, params.id, metaDataService.ltSubTheme)
    if (linking.duplicate)
      render '<span class="red italic">"' + linking.source.profile.fullName + '" wurde bereits zugewiesen!</span>'
    render template: 'subthemes', model: [subthemes: linking.results, theme: linking.target, entity: entityHelperService.loggedIn]
  }

  def removeSubTheme = {
    def breaking = functionService.breakEntities(params.subtheme, params.id, metaDataService.ltSubTheme)
    render template: 'subthemes', model: [subthemes: breaking.results, theme: breaking.target, entity: entityHelperService.loggedIn]
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
}