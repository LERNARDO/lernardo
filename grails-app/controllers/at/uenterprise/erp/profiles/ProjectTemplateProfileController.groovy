package at.uenterprise.erp.profiles

import at.uenterprise.erp.base.Entity
import at.uenterprise.erp.base.EntityType
import at.uenterprise.erp.base.EntityHelperService
import at.uenterprise.erp.base.ProfileHelperService
import at.uenterprise.erp.MetaDataService
import at.uenterprise.erp.base.Profile
import at.uenterprise.erp.base.Link
import at.uenterprise.erp.FunctionService

import at.uenterprise.erp.Live
import org.codehaus.groovy.grails.commons.ApplicationHolder
import at.uenterprise.erp.base.AssetService
import at.uenterprise.erp.Label
import at.uenterprise.erp.Publication
import at.uenterprise.erp.base.Asset
import at.uenterprise.erp.Resource
import at.uenterprise.erp.EVENT_TYPE

class ProjectTemplateProfileController {
  MetaDataService metaDataService
  EntityHelperService entityHelperService
  ProfileHelperService profileHelperService
  FunctionService functionService
  AssetService assetService

  def index = {
    redirect action: "list", params: params
  }

  // the delete, save and update actions only accept POST requests
  static allowedMethods = [delete: 'POST', save: 'POST', update: 'POST']

  def list = {
    int totalProjectTemplates = Entity.countByType(metaDataService.etProjectTemplate)
    return [allLabels: functionService.getLabels(),
        totalProjectTemplates: totalProjectTemplates]
  }

  def show = {
    Entity projectTemplate = Entity.get(params.id)

    if (!projectTemplate) {
      flash.message = message(code: "object.notFound", args: [message(code: "projectTemplate")])
      redirect(action: list)
    }
    else {
      [projectTemplate: projectTemplate, allLabels: functionService.getLabels()]
    }
  }

    def management = {
        Entity projectTemplate = Entity.get(params.id)

        // find all projectUnitTemplates linked to this projectTemplate
        //List projectUnitTemplates = functionService.findAllByLink(null, projectTemplate, metaDataService.ltProjectUnitTemplate)
        List projectUnitTemplates = projectTemplate.profile.templates.inject([]) {result, template -> result + Entity.get(template.toInteger())}

        // calculate realDuration
        int calculatedDuration = functionService.calculateDurationPUT(projectUnitTemplates)

        // find all instances of this template
        List instances = functionService.findAllByLink(projectTemplate, null, metaDataService.ltProjectTemplate)

        // get all resources of all templates
        // get all groupActivityTemplates of all projectUnitTemplates
        List groupActivityTemplates = []
        projectUnitTemplates.each { put ->
            List tempTemplates = functionService.findAllByLink(null, put, metaDataService.ltProjectUnitMember)
            tempTemplates.each { tt ->
                if (!groupActivityTemplates.contains(tt))
                    groupActivityTemplates.add(tt)
            }
        }
        List groupActivityTemplateResources = []
        List templateResources = []
        groupActivityTemplates.each { Entity groupActivityTemplate ->
            groupActivityTemplateResources.addAll(groupActivityTemplate.profile.resources)
            // get all templates linked to the groupActivityTemplate
            List templates = functionService.findAllByLink(null, groupActivityTemplate, metaDataService.ltGroupMember)
            templates.each {
                templateResources.addAll(it.profile.resources)
            }
        }

        render template: "management", model: [projectTemplate: projectTemplate, projectUnitTemplates: projectUnitTemplates,
                calculatedDuration: calculatedDuration,
                instances: instances,
                groupActivityTemplateResources: groupActivityTemplateResources,
                templateResources: templateResources,
                allLabels: functionService.getLabels()]
    }

  def delete = {
    Entity projectTemplate = Entity.get(params.id)
    if (projectTemplate) {
      functionService.deleteReferences(projectTemplate)
      try {
        flash.message = message(code: "object.deleted", args: [message(code: "projectTemplate"), projectTemplate.profile])
        projectTemplate.delete(flush: true)
        redirect(action: "list")
      }
      catch (org.springframework.dao.DataIntegrityViolationException ignore) {
        flash.message = message(code: "object.notDeleted", args: [message(code: "projectTemplate"), projectTemplate.profile])
        redirect(action: "show", id: params.id)
      }
    }
    else {
      flash.message = message(code: "object.notFound", args: [message(code: "projectTemplate")])
      redirect(action: "list")
    }
  }

  def edit = {
    Entity projectTemplate = Entity.get(params.id)
    Entity entity = params.entity ? projectTemplate : entityHelperService.loggedIn

    if (!projectTemplate) {
      flash.message = message(code: "object.notFound", args: [message(code: "projectTemplate")])
      redirect action: 'list'
    }
    else {
      [projectTemplate: projectTemplate, entity: entity]
    }
  }

  def update = {
    Entity projectTemplate = Entity.get(params.id)

    projectTemplate.profile.properties = params
    if (!params.ageFrom)
      projectTemplate.profile.ageFrom = 0
    if (!params.ageTo)
      projectTemplate.profile.ageTo = 100

    if (projectTemplate.profile.save() && projectTemplate.save()) {
      flash.message = message(code: "object.updated", args: [message(code: "projectTemplate"), projectTemplate.profile])
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
      ent.profile.educationalObjectiveText = original.profile.educationalObjectiveText
      ent.profile.fullName = original.profile.fullName + '[' + message(code: "duplicate") + ']'
    }

    // save creator
    new Link(source: currentEntity, target: entity, type: metaDataService.ltCreator).save()

    // find project unit templates linked to the original
    List projectUnitTemplates = functionService.findAllByLink(null, original, metaDataService.ltProjectUnitTemplate)

    projectUnitTemplates.each { Entity put ->
      // create project unit templates for the copy
      EntityType etProjectUnitTemplate = metaDataService.etProjectUnitTemplate
      Entity projectUnitTemplate = entityHelperService.createEntity("projectUnitTemplate", etProjectUnitTemplate) {Entity ent ->
        ent.profile = profileHelperService.createProfileFor(ent) as Profile
        ent.profile.duration = put.profile.duration
        ent.profile.fullName = put.profile.fullName
      }

      // link projectUnitTemplate and projectTemplate
      new Link(source: projectUnitTemplate, target: entity, type: metaDataService.ltProjectUnitTemplate).save()

      // find group activity templates linked to the original project unit
      List groupActivityTemplates = functionService.findAllByLink(null, put, metaDataService.ltProjectUnitMember)

      // link group activity templates to the project unit templates of the copy
      groupActivityTemplates.each { Entity gat ->
        new Link(source: gat, target: projectUnitTemplate, type: metaDataService.ltProjectUnitMember).save()
      }
    }

    // loop through all labels of the original and create them in the copy
    original.profile.labels.each { la ->
      Label label = new Label()

      label.name = la.name
      label.description = la.description
      label.type = "instance"

      label.save(flush:true)

      entity.profile.addToLabels(label)
    }

    // copy publications
    List publications = Publication.findAllByEntity(original)
    publications.each { pu ->
      new Publication(entity: entity, type: metaDataService.ptDoc1, asset: pu.asset, name: pu.name).save()
    }

    // copy profile pic
    Asset asset = Asset.findByEntityAndType(original, "profile")
    if (asset)
      new Asset(entity: entity, storage: asset.storage, type: "profile").save(flush: true)

    flash.message = message(code: "projectTemplate.copied", args: [entity.profile])
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
        if (!params.ageFrom)
          ent.profile.ageFrom = 0
        if (!params.ageTo)
          ent.profile.ageTo = 100
      }
      // add default profile image
      //File file = ApplicationHolder.application.parentContext.getResource("images/default_projecttemplate.png").getFile()
      //def result = assetService.storeAsset(entity, "profile", "image/png", file.getBytes())

      new Live(content: '<a href="' + createLink(controller: currentEntity.type.supertype.name + 'Profile', action: 'show', id: currentEntity.id) + '">' + currentEntity.profile + '</a> hat die Projektvorlage <a href="' + createLink(controller: 'projectTemplateProfile', action: 'show', id: entity.id) + '">' + entity.profile + '</a> angelegt.').save()
      functionService.createEvent(EVENT_TYPE.PROJECT_TEMPLATE_CREATED, currentEntity.id.toInteger(), entity.id.toInteger())

      // save creator
      new Link(source: currentEntity, target: entity, type: metaDataService.ltCreator).save()

      flash.message = message(code: "object.created", args: [message(code: "projectTemplate"), entity.profile])
      redirect action: 'show', id: entity.id
    } catch (at.uenterprise.erp.base.EntityException ee) {
      render view: "create", model: [projectTemplate: ee.entity]
    }

  }

  def editProjectUnitTemplate = {
    Entity projectUnitTemplate = Entity.get(params.projectUnitTemplate)
    render template: "editProjectUnitTemplate", model: [projectUnitTemplate: projectUnitTemplate, i: params.i]
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
        //ent.profile.fullName = "Einheit " + counter
        ent.profile.fullName = message(code: "unit")+ " " + counter
      }

      // link projectUnitTemplate and projectTemplate
      new Link(source: projectUnitTemplate, target: projectTemplate, type: metaDataService.ltProjectUnitTemplate).save()

      projectTemplate.profile.addToTemplates(projectUnitTemplate.id.toString())

      // find all projectUnitTemplates of this projectTemplate
      List projectUnitTemplates = []
      projectTemplate.profile.templates.each {
        projectUnitTemplates.add(Entity.get(it.toInteger()))
      }

      List allGroupActivityTemplates = Entity.findAllByType(metaDataService.etGroupActivityTemplate)

      // calculate realDuration
      int calculatedDuration = functionService.calculateDurationPUT(projectUnitTemplates)

      render template: 'projectUnitTemplates', model: [allGroupActivityTemplates: allGroupActivityTemplates,
                                                       projectUnitTemplates: projectUnitTemplates,
                                                       projectTemplate: projectTemplate,
                                                       calculatedDuration: calculatedDuration,
                                                       allLabels: Label.findAllByType('template', params)]
    } catch (at.uenterprise.erp.base.EntityException ee) {
      //render '<span class="red">Projekteinheitvorlage konnte nicht gespeichert werden!</span><br/>'
      render '<span class="red">'+message(code: "projectUnitTemplates.notSaved")+ '</span><br/>'

      // find all projectUnitTemplates of this projectTemplate
      //List projectUnitTemplates = functionService.findAllByLink(null, projectTemplate, metaDataService.ltProjectUnitTemplate)
      List projectUnitTemplates = []
      projectTemplate.profile.templates.each {
        projectUnitTemplates.add(Entity.get(it.toInteger()))
      }

      List allGroupActivityTemplates = Entity.findAllByType(metaDataService.etGroupActivityTemplate)

      // calculate realDuration
      int calculatedDuration = functionService.calculateDurationPUT(projectUnitTemplates)

      render template: 'projectUnitTemplates', model: [allGroupActivityTemplates: allGroupActivityTemplates,
                                                       projectUnitTemplates: projectUnitTemplates,
                                                       projectTemplate: projectTemplate,
                                                       calculatedDuration: calculatedDuration,
                                                       allLabels: Label.findAllByType('template', params)]
    }
  }

  def removeProjectUnitTemplate = {
    Entity projectTemplate = Entity.get(params.id)
    Entity projectUnitTemplate = Entity.get(params.projectUnitTemplate)

    // delete link
    def link = Link.createCriteria().get {
      eq('source', projectUnitTemplate)
      eq('target', projectTemplate)
      eq('type', metaDataService.ltProjectUnitTemplate)
    }
    link.delete()

    // delete links of groupActivityTemplates to projectUnitTemplate
    Link.findAllByTargetAndType(projectUnitTemplate, metaDataService.ltProjectUnitMember).each {it.delete()}

    projectTemplate.profile.removeFromTemplates(params.projectUnitTemplate)

    // delete projectUnitTemplate
    projectUnitTemplate.delete()

    // find all projectUnitTemplates of this projectTemplate
    //List projectUnitTemplates = functionService.findAllByLink(null, projectTemplate, metaDataService.ltProjectUnitTemplate)
    List projectUnitTemplates = []
    projectTemplate.profile.templates.each {
      projectUnitTemplates.add(Entity.get(it.toInteger()))
    }

    List allGroupActivityTemplates = Entity.findAllByType(metaDataService.etGroupActivityTemplate)

    // calculate realDuration
    int calculatedDuration = functionService.calculateDurationPUT(projectUnitTemplates)



    render template: 'projectUnitTemplates', model: [allGroupActivityTemplates: allGroupActivityTemplates,
                                                     projectUnitTemplates: projectUnitTemplates,
                                                     projectTemplate: projectTemplate,
                                                     calculatedDuration: calculatedDuration,
                                                     allLabels: Label.findAllByType('template', params)]
  }

  def addGroupActivityTemplate = {
    Entity groupActivityTemplate = Entity.get(params.groupActivityTemplate)
    Entity projectUnitTemplate = Entity.get(params.id)
    Entity projectTemplate = Entity.get(params.projectTemplate)

    // check if the groupActivityTemplate isn't already linked to the projectUnitTemplate
    def link = Link.createCriteria().get {
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
    //int calculatedDuration = functionService.calculateDurationPU(projectUnits)

    //render '<span style="color: #0b0; padding: 0 0 5px 15px; font-size: 11px">' + groupActivityTemplate.profile + ' wurde hinzugefügt</span>'
    render template: 'groupActivityTemplates', model: [groupActivityTemplates: groupActivityTemplates,
                                                       unit: projectUnitTemplate,
                                                       i: params.i,
                                                       projectTemplate: projectTemplate]
  }

  def removeGroupActivityTemplate = {
    Entity groupActivityTemplate = Entity.get(params.groupActivityTemplate)
    Entity projectUnitTemplate = Entity.get(params.id)
    Entity projectTemplate = Entity.get(params.projectTemplate)

    // delete link
    def link = Link.createCriteria().get {
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
    //int calculatedDuration = functionService.calculateDurationPU(projectUnits)

    //render '<span style="color: #b00; padding: 0 0 5px 15px; font-size: 11px">' + groupActivityTemplate.profile + ' wurde entfernt</span><br/>'
    render template: 'groupActivityTemplates', model: [groupActivityTemplates: groupActivityTemplates, unit: projectUnitTemplate, i: params.i, projectTemplate: projectTemplate]
  }

    def addActivityTemplate = {
        Entity activityTemplate = Entity.get(params.activityTemplate)
        Entity projectUnitTemplate = Entity.get(params.id)
        Entity projectTemplate = Entity.get(params.projectTemplate)

        // check if the activityTemplate isn't already linked to the projectUnitTemplate
        def link = Link.createCriteria().get {
            eq('source', activityTemplate)
            eq('target', projectUnitTemplate)
            eq('type', metaDataService.ltGroupMember)
        }
        if (!link)
        // link groupActivityTemplate to projectUnit
            new Link(source: activityTemplate, target: projectUnitTemplate, type: metaDataService.ltGroupMember).save()

        // find all activityTemplates linked to the unit
        List activityTemplates = functionService.findAllByLink(null, projectUnitTemplate, metaDataService.ltGroupMember)

        render template: 'activityTemplates', model: [activityTemplates: activityTemplates,
                unit: projectUnitTemplate,
                i: params.i,
                projectTemplate: projectTemplate]
    }

    def removeActivityTemplate = {
        Entity activityTemplate = Entity.get(params.activityTemplate)
        Entity projectUnitTemplate = Entity.get(params.id)
        Entity projectTemplate = Entity.get(params.projectTemplate)

        // delete link
        def link = Link.createCriteria().get {
            eq('source', activityTemplate)
            eq('target', projectUnitTemplate)
            eq('type', metaDataService.ltGroupMember)
        }
        link.delete()

        // find all groupActivityTemplates linked to the unit
        List activityTemplates = functionService.findAllByLink(null, projectUnitTemplate, metaDataService.ltGroupMember)

        render template: 'activityTemplates', model: [activityTemplates: activityTemplates, unit: projectUnitTemplate, i: params.i, projectTemplate: projectTemplate]
    }

  def updateduration = {
    Entity projectTemplate = Entity.get(params.id)

    // find all projectUnitTemplates linked to this projectTemplate
    List projectUnitTemplates = functionService.findAllByLink(null, projectTemplate, metaDataService.ltProjectUnitTemplate)

    // calculate realDuration
    int calculatedDuration = functionService.calculateDurationPUT(projectUnitTemplates)

    render template: 'updateduration', model: [calculatedDuration: calculatedDuration, projectTemplate: projectTemplate]
  }

  /*
   * retrieves all group activity templates matching the search parameter
   */
  def remoteGroupActivityTemplate = {
    if (!params.value) {
      render ""
      return
    }
    else if (params.value == "*") {
      def results = Entity.createCriteria().list {
        eq("type", metaDataService.etGroupActivityTemplate)
        profile {
          eq("status", "done")
        }
      }
      render template: 'groupactivitytemplateresults', model: [results: results, projectUnitTemplate: params.id, i: params.i, projectTemplate: params.projectTemplate]
      return
    }

    def results = Entity.createCriteria().list {
      eq('type', metaDataService.etGroupActivityTemplate)
      profile {
        eq('status', "done")
      }
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
      render template: 'groupactivitytemplateresults', model: [results: results, projectUnitTemplate: params.id, i: params.i, projectTemplate: params.projectTemplate]
    }
  }

    /*
    * retrieves all group activity templates matching the search parameter
    */
    def remoteActivityTemplate = {
        if (!params.value) {
            render ""
            return
        }
        else if (params.value == "*") {
            def results = Entity.createCriteria().list {
                eq("type", metaDataService.etTemplate)
                profile {
                    eq("status", "done")
                }
            }
            render template: 'activitytemplateresults', model: [results: results, projectUnitTemplate: params.id, i: params.i, projectTemplate: params.projectTemplate]
            return
        }

        def results = Entity.createCriteria().list {
            eq('type', metaDataService.etTemplate)
            profile {
                eq('status', "done")
            }
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
            render template: 'activitytemplateresults', model: [results: results, projectUnitTemplate: params.id, i: params.i, projectTemplate: params.projectTemplate]
        }
    }

  def templateHover = {
    Entity entity = Entity.get(params.id)
    render template: "hover", model: [entity: entity]
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
    render template: 'labels', model: [projectTemplate: entity]
  }

  /*
   * removes a label from a group
   */
  def removeLabel = {
    Entity group = Entity.get(params.id)
    group.profile.removeFromLabels(Label.get(params.label))
    Label.get(params.label).delete()
    render template: 'labels', model: [projectTemplate: group]
  }

  def moveUp = {
    Entity group = Entity.get(params.projectTemplate)
    if (group.profile.templates.indexOf(params.id) > 0) {
      int i = group.profile.templates.indexOf(params.id)
      use(Collections){ group.profile.templates.swap(i, i - 1) }
    }
    List templates = []
    group.profile.templates.each {
      templates.add(Entity.get(it.toInteger()))
    }
    // get all groupactivitytemplates that are set to completed
    def allGroupActivityTemplates = Entity.createCriteria().list {
      eq("type", metaDataService.etGroupActivityTemplate)
      profile {
        eq("status", "done")
      }
    }
    render template: 'projectUnitTemplates', model: [projectTemplate: group, projectUnitTemplates: templates, allGroupActivityTemplates: allGroupActivityTemplates]
  }

  def moveDown = {
    Entity group = Entity.get(params.projectTemplate)
    if (group.profile.templates.indexOf(params.id) < group.profile.templates.size() - 1) {
      int i = group.profile.templates.indexOf(params.id)
      use(Collections){ group.profile.templates.swap(i, i + 1) }
    }
    List templates = []
    group.profile.templates.each {
      templates.add(Entity.get(it.toInteger()))
    }
    // get all groupactivitytemplates that are set to completed
    def allGroupActivityTemplates = Entity.createCriteria().list {
      eq("type", metaDataService.etGroupActivityTemplate)
      profile {
        eq("status", "done")
      }
    }
    render template: 'projectUnitTemplates', model: [projectTemplate: group, projectUnitTemplates: templates, allGroupActivityTemplates: allGroupActivityTemplates]
  }

  def refreshtemplateresources = {
    Entity projectTemplate = Entity.get(params.id)

    // find all projectUnitTemplates linked to this projectTemplate
    List projectUnitTemplates = []
    projectTemplate.profile.templates.each {
      projectUnitTemplates.add(Entity.get(it.toInteger()))
    }

    // get all resources of all templates
    // get all groupActivityTemplates of all projectUnitTemplates
    List groupActivityTemplates = []
      projectUnitTemplates.each { put ->
        List tempTemplates = functionService.findAllByLink(null, put, metaDataService.ltProjectUnitMember)
        tempTemplates.each { tt ->
          if (!groupActivityTemplates.contains(tt))
            groupActivityTemplates.add(tt)
        }
      }
      List groupActivityTemplateResources = []
      List templateResources = []
      groupActivityTemplates.each { Entity groupActivityTemplate ->
        groupActivityTemplateResources.addAll(groupActivityTemplate.profile.resources)
        // get all templates linked to the groupActivityTemplate
        List templates = functionService.findAllByLink(null, groupActivityTemplate, metaDataService.ltGroupMember)
        templates.each {
          templateResources.addAll(it.profile.resources)
        }
      }

    render template: 'templateresources', model: [templateResources: templateResources, groupActivityTemplateResources: groupActivityTemplateResources, projectTemplate: projectTemplate]
  }

  def define = {
    params.sort = params.sort ?: "fullName"
    params.order = params.order ?: "asc"
    params.offset = params.int('offset') ?: 0
    params.max = Math.min(params.int('max') ?: 20, 40)

    // swap age values if necessary
    if (params.int('ageTo') < params.int('ageFrom')) {
      def temp = params.ageTo
      params.ageTo = params.ageFrom
      params.ageFrom = temp
    }

    // 1. pass - filter by object properties
    def results = Entity.createCriteria().list  {
      eq('type', metaDataService.etProjectTemplate)
      profile {
        if (params.name)
          ilike('fullName', "%" + params.name + "%")
        if (params.ageFrom)
          le('ageFrom', params.ageFrom.toInteger())
        if (params.ageTo)
          ge('ageTo', params.ageTo.toInteger())
        order(params.sort, params.order)
      }
    }

    // 2. pass - filter by creator
    if (params.creator != "") {
      results = results.findAll { Entity entity ->
        Link.createCriteria().get {
          eq('source', Entity.get(params.int('creator')))
          eq('target', entity)
          eq('type', metaDataService.ltCreator)
        }
      }
    }

    // 3. filter by labels
    List thirdPass = []

    if (params.labels) {
      List labels = params.list('labels')
      results.each { Entity template ->
        template.profile.labels.each { Label label ->
          if (labels.contains(label.name)) {
            if (!thirdPass.contains(template))
              thirdPass.add(template)
          }
        }
      }
    }
    else
      thirdPass = results

    results = thirdPass

    int totalResults = results.size()
    int upperBound = params.offset + params.max < totalResults ? params.offset + params.max : totalResults
    results = results.subList(params.offset, upperBound)

    render template: '/templates/searchresults', model: [results: results, totalResults: totalResults, type: 'projectTemplate', params: params]
  }

   def remoteGroupActivityTemplateByLabel = {
     List labels = params.list('labels')
     
     List results = []

     List groupActivityTemplates = Entity.createCriteria().list {
       eq("type", metaDataService.etGroupActivityTemplate)
       profile {
         eq("status", "done")
       }
     }
     
     labels.each { String label ->
       groupActivityTemplates.each { Entity gat ->
         if (gat.profile.labels.find {it.name == label})
           results.add(gat)
       }
     }
     
     if (results.size() == 0) {
       render {span(class: 'italic', message(code: 'noResultsFound'))}
       return
     }
     else {
       render template: 'groupactivitytemplateresults', model: [results: results, projectUnitTemplate: params.id, i: params.i, projectTemplate: params.projectTemplate]
     }
   }

    def remoteActivityTemplateByLabel = {
        List labels = params.list('labels')

        List results = []

        List activityTemplates = Entity.createCriteria().list {
            eq("type", metaDataService.etTemplate)
            profile {
                eq("status", "done")
            }
        }

        labels.each { String label ->
            activityTemplates.each { Entity at ->
                if (at.profile.labels.find {it.name == label})
                    results.add(at)
            }
        }

        if (results.size() == 0) {
            render {span(class: 'italic', message(code: 'noResultsFound'))}
            return
        }
        else {
            render template: 'activitytemplateresults', model: [results: results, projectUnitTemplate: params.id, i: params.i, projectTemplate: params.projectTemplate]
        }
    }

    def createpdf = {
        Entity template = Entity.get(params.id)
        Entity currentEntity = entityHelperService.loggedIn

        renderPdf template: 'createpdf', model: [pageformat: params.pageformat,
                entity: currentEntity,
                template: template],
                filename: message(code: 'projectTemplate') + '_' + template.profile + '.pdf'
    }

}


