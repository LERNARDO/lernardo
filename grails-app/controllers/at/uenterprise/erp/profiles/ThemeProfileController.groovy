package at.uenterprise.erp.profiles

import at.uenterprise.erp.base.Entity
import at.uenterprise.erp.base.EntityType
import at.uenterprise.erp.base.EntityHelperService
import at.uenterprise.erp.base.ProfileHelperService
import at.uenterprise.erp.MetaDataService
import at.uenterprise.erp.base.Link
import at.uenterprise.erp.base.Profile
import at.uenterprise.erp.FunctionService
import at.uenterprise.erp.EVENT_TYPE
import at.uenterprise.erp.Label

class ThemeProfileController {
  MetaDataService metaDataService
  EntityHelperService entityHelperService
  ProfileHelperService profileHelperService
  FunctionService functionService

  def beforeInterceptor = [
          action:{
            params.startDate = params.date('startDate', 'dd. MM. yy')
            params.endDate = params.date('endDate', 'dd. MM. yy')},
            only:['save','update']
  ]
  
  def index = {
    redirect action: "list", params: params
  }

  // the delete, save and update actions only accept POST requests
  static allowedMethods = [delete: 'POST', save: 'POST', update: 'POST']

  def list = {
    /*params.offset = params.int('offset') ?: 0
    params.max = Math.min(params.int('max') ?: 15, 100)
    params.sort = params.sort ?: "dateCreated"
    params.order = params.order ?: "desc" */

    Entity currentEntity = entityHelperService.loggedIn
    List facilities = functionService.findAllByLink(currentEntity, null, metaDataService.ltLeadEducator)

    List allThemes = Entity.findAllByType(metaDataService.etTheme).sort {it.profile.dateCreated}.reverse()
    // find only themes without a parent
    List themes = allThemes.inject([]) { result, theme ->
      def subthemes = functionService.findByLink(theme, null, metaDataService.ltSubTheme)
      subthemes ? result : result + theme
    }

    return [themes: themes,
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
      // find the facility linked to this theme
      //Entity facility = functionService.findByLink(theme, null, metaDataService.ltThemeOfFacility)

      // find parent theme linked to this theme (if any)
      Entity parenttheme = functionService.findByLink(theme, null, metaDataService.ltSubTheme)

      [theme: theme,
       //facility: facility,
       parenttheme: parenttheme,
       allLabels: functionService.getLabels()]
    }
  }

    def management = {
        Entity theme = Entity.get(params.id)

        List responsibles = functionService.findAllByLink(null, theme, metaDataService.ltResponsible)

        // find all projects which are within the theme duration
        List allProjects = Entity.findAllByType(metaDataService.etProject).findAll {it.profile.startDate >= theme.profile.startDate && it.profile.endDate <= theme.profile.endDate}

        // find all projects currently linked to this theme
        List projects = functionService.findAllByLink(null, theme, metaDataService.ltGroupMember)

        render template: "management", model: [theme: theme,
                allProjects: allProjects,
                projects: projects,
                responsibles: responsibles]
    }

  def delete = {
    Entity theme = Entity.get(params.id)
    if (theme) {
      functionService.deleteReferences(theme)
      try {
        flash.message = message(code: "object.deleted", args: [message(code: "theme"), theme.profile])
        theme.delete(flush: true)
        redirect(action: "list")
      }
      catch (org.springframework.dao.DataIntegrityViolationException ignore) {
        flash.message = message(code: "object.notDeleted", args: [message(code: "theme"), theme.profile])
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
       //allFacilities: Entity.findAllByType(metaDataService.etFacility),
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
      //Link.findBySourceAndType(theme, metaDataService.ltThemeOfFacility)?.delete()

      // link theme to facility
      //functionService.linkEntities(theme.id.toString(), params.facility, metaDataService.ltThemeOfFacility)

      // delete current link to parent theme if any
      Link.findBySourceAndType(theme, metaDataService.ltSubTheme)?.delete()

      // link theme to new parent if any
      if (params.parenttheme != "null")
        functionService.linkEntities(theme.id.toString(), params.parenttheme, metaDataService.ltSubTheme)

      flash.message = message(code: "object.updated", args: [message(code: "theme"), theme.profile])
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

    //Entity currentEntity = entityHelperService.loggedIn

    //List allFacilities

    // if the current entity is an educator only return facilities he is linked to, else all facilities
    /*if (currentEntity.type.id == metaDataService.etEducator.id)
      allFacilities = functionService.findAllByLink(currentEntity, null, metaDataService.ltLeadEducator)
    else
      allFacilities = Entity.findAllByType(metaDataService.etFacility)*/

    return [//allFacilities: allFacilities,
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

      flash.message = message(code: "object.created", args: [message(code: "theme"), entity.profile])
      redirect action: 'show', id: entity.id
    } catch (at.uenterprise.erp.base.EntityException ee) {
      render view: "create", model: [theme: ee.entity, allFacilities: Entity.findAllByType(metaDataService.etFacility)]
    }

  }

  def addProject = {
    def linking = functionService.linkEntities(params.project, params.id, metaDataService.ltGroupMember)
    if (linking.duplicate)
        render {p(class: 'red italic', message(code: "alreadyAssignedTo", args: [linking.source.profile]))}
    render template: 'projects', model: [projects: linking.sources, theme: linking.target]
  }

  def removeProject = {
    def breaking = functionService.breakEntities(params.project, params.id, metaDataService.ltGroupMember)
    render template: 'projects', model: [projects: breaking.sources, theme: breaking.target]
  }

    /*
    * adds a label to an entity by creating a new label instance and copying the properties from the given "label template"
    */
  def addLabel = {
    Entity entity = Entity.get(params.id)
    Label labelTemplate = Label.get(params.label)

    // make sure a label can only be added once
    Boolean canBeAdded = true
    entity.profile.labels.each {
      if (it.name == labelTemplate.name)
        canBeAdded = false
    }
    if (canBeAdded) {
      Label label = new Label()

      label.name = labelTemplate.name
      label.description = labelTemplate.description
      label.type = "instance"

      entity.profile.addToLabels(label)
    }
    render template: 'labels', model: [theme: entity]
  }

  /*
  * removes a label from a template
  */
  def removeLabel = {
    Entity theme = Entity.get(params.id)
    theme.profile.removeFromLabels(Label.get(params.label))
    Label.get(params.label).delete()
    render template: 'labels', model: [theme: theme]
  }

    /*
    * retrieves all entities matching the search parameter
    */
    def remoteResponsible = {
        if (!params.value) {
            render ""
            return
        }
        else if (params.value.size() < 2) {
            render {span(class: 'gray', message(code: 'minChars'))}
            return
        }

        def results = Entity.createCriteria().listDistinct {
            user {
                eq('enabled', true)
            }
            eq('type', metaDataService.etEducator)
            profile {
                ilike('fullName', "%" + params.value + "%")
                order('fullName','asc')
            }
            maxResults(15)
        }

        if (results.size() == 0) {
            render {span(class: 'italic', message(code: 'noResultsFound'))}
            return
        }
        else {
            render template: 'responsibleresults', model: [results: results, themeID: params.id]
        }
    }

    def addResponsible = {
        def linking = functionService.linkEntities(params.entity, params.id, metaDataService.ltResponsible)
        if (linking.duplicate)
            render {p(class: 'red italic', message(code: "alreadyAssignedTo", args: [linking.source.profile]))}
        render template: 'responsible', model: [responsibles: linking.sources, theme: linking.target]

    }

    def removeResponsible = {
        def breaking = functionService.breakEntities(params.responsible, params.id, metaDataService.ltResponsible)
        render template: 'responsible', model: [responsibles: breaking.sources, theme: breaking.target]
    }
}