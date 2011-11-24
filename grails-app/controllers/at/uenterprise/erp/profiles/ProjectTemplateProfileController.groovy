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
import org.codehaus.groovy.grails.commons.ApplicationHolder
import at.openfactory.ep.AssetService
import at.uenterprise.erp.Label
import at.uenterprise.erp.Publication
import at.openfactory.ep.Asset
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
    params.sort = params.sort ?: 'name'
    params.order = params.order ?: 'asc'

    return [allLabels: Label.findAllByType('template', params)]
  }

  def show = {
    Entity projectTemplate = Entity.get(params.id)
    Entity entity = params.entity ? projectTemplate : entityHelperService.loggedIn

    if (!projectTemplate) {
      flash.message = message(code: "object.notFound", args: [message(code: "projectTemplate")])
      redirect(action: list)
    }
    else {
      // find all projectUnitTemplates linked to this projectTemplate
      //List projectUnitTemplates = functionService.findAllByLink(null, projectTemplate, metaDataService.ltProjectUnitTemplate)
      List projectUnitTemplates = []
      projectTemplate.profile.templates.each {
        projectUnitTemplates.add(Entity.get(it.toInteger()))
      }

      // calculate realDuration
      int calculatedDuration = calculateDuration(projectUnitTemplates)

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

      params.sort = params.sort ?: 'name'
      params.order = params.order ?: 'asc'

      [projectTemplate: projectTemplate,
              entity: entity,
              projectUnitTemplates: projectUnitTemplates,
              calculatedDuration: calculatedDuration,
              instances: instances,
              allLabels: Label.findAllByType('template', params),
              groupActivityTemplateResources: groupActivityTemplateResources,
              templateResources: templateResources]
    }
  }

  def delete = {
    Entity projectTemplate = Entity.get(params.id)
    if (projectTemplate) {
      functionService.deleteReferences(projectTemplate)
      try {
        flash.message = message(code: "object.deleted", args: [message(code: "projectTemplate"), projectTemplate.profile.fullName])
        projectTemplate.delete(flush: true)
        redirect(action: "list")
      }
      catch (org.springframework.dao.DataIntegrityViolationException e) {
        flash.message = message(code: "object.notDeleted", args: [message(code: "projectTemplate"), projectTemplate.profile.fullName])
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

    if (projectTemplate.profile.save() && projectTemplate.save()) {
      flash.message = message(code: "object.updated", args: [message(code: "projectTemplate"), projectTemplate.profile.fullName])
      redirect action: 'show', id: projectTemplate.id, params: [entity: projectTemplate.id]
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

    flash.message = message(code: "projectTemplate.copied", args: [entity.profile.fullName])
    redirect action: 'show', id: entity.id, params: [entity: entity.id]
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
      // add default profile image
      File file = ApplicationHolder.application.parentContext.getResource("images/default_projecttemplate.png").getFile()
      def result = assetService.storeAsset(entity, "profile", "image/png", file.getBytes())

      new Live(content: '<a href="' + createLink(controller: currentEntity.type.supertype.name +'Profile', action:'show', id: currentEntity.id) + '">' + currentEntity.profile.fullName + '</a> hat die Projektvorlage <a href="' + createLink(controller: 'projectTemplateProfile', action: 'show', id: entity.id) + '">' + entity.profile.fullName + '</a> angelegt.').save()
      functionService.createEvent(EVENT_TYPE.PROJECT_TEMPLATE_CREATED, currentEntity.id.toInteger(), entity.id.toInteger())

      // save creator
      new Link(source: currentEntity, target: entity, type: metaDataService.ltCreator).save()

      flash.message = message(code: "object.created", args: [message(code: "projectTemplate"), entity.profile.fullName])
      redirect action: 'show', id: entity.id, params: [entity: entity.id]
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
      int calculatedDuration = calculateDuration(projectUnitTemplates)

      render template: 'projectUnitTemplates', model: [allGroupActivityTemplates: allGroupActivityTemplates,
                                                       projectUnitTemplates: projectUnitTemplates,
                                                       projectTemplate: projectTemplate,
                                                       entity: entityHelperService.loggedIn,
                                                       calculatedDuration: calculatedDuration,
                                                       allLabels: Label.findAllByType('template', params)]
    } catch (at.openfactory.ep.EntityException ee) {
      //render '<span class="red">Projekteinheitvorlage konnte nicht gespeichert werden!</span><br/>'
      render '<span class="red">'+message(code: "projectUnitTemplates.notSaved")+'</span><br/>'

      // find all projectUnitTemplates of this projectTemplate
      //List projectUnitTemplates = functionService.findAllByLink(null, projectTemplate, metaDataService.ltProjectUnitTemplate)
      List projectUnitTemplates = []
      projectTemplate.profile.templates.each {
        projectUnitTemplates.add(Entity.get(it.toInteger()))
      }

      List allGroupActivityTemplates = Entity.findAllByType(metaDataService.etGroupActivityTemplate)

      // calculate realDuration
      int calculatedDuration = calculateDuration(projectUnitTemplates)

      render template: 'projectUnitTemplates', model: [allGroupActivityTemplates: allGroupActivityTemplates,
                                                       projectUnitTemplates: projectUnitTemplates,
                                                       projectTemplate: projectTemplate,
                                                       entity: entityHelperService.loggedIn,
                                                       calculatedDuration: calculatedDuration,
                                                       allLabels: Label.findAllByType('template', params)]
    }
  }

  def removeProjectUnitTemplate = {
    Entity projectTemplate = Entity.get(params.id)
    Entity projectUnitTemplate = Entity.get(params.projectUnitTemplate)

    // delete link
    def c = Link.createCriteria()
    def link = c.get {
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
    int calculatedDuration = calculateDuration(projectUnitTemplates)



    render template: 'projectUnitTemplates', model: [allGroupActivityTemplates: allGroupActivityTemplates,
                                                     projectUnitTemplates: projectUnitTemplates,
                                                     projectTemplate: projectTemplate,
                                                     entity: entityHelperService.loggedIn,
                                                     calculatedDuration: calculatedDuration,
                                                     allLabels: Label.findAllByType('template', params)]
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
    //int calculatedDuration = calculateDuration(projectUnits)

    //render '<span style="color: #0b0; padding: 0 0 5px 15px; font-size: 11px">' + groupActivityTemplate.profile.fullName + ' wurde hinzugefügt</span>'
    render template: 'groupActivityTemplates', model: [groupActivityTemplates: groupActivityTemplates,
                                                       unit: projectUnitTemplate,
                                                       entity: entityHelperService.loggedIn,
                                                       i: params.i,
                                                       projectTemplate: projectTemplate]
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
    //int calculatedDuration = calculateDuration(projectUnits)

    //render '<span style="color: #b00; padding: 0 0 5px 15px; font-size: 11px">' + groupActivityTemplate.profile.fullName + ' wurde entfernt</span><br/>'
    render template: 'groupActivityTemplates', model: [groupActivityTemplates: groupActivityTemplates, unit: projectUnitTemplate, entity: entityHelperService.loggedIn, i: params.i, projectTemplate: projectTemplate]
  }

  def updateduration = {
    Entity projectTemplate = Entity.get(params.id)

    // find all projectUnitTemplates linked to this projectTemplate
    List projectUnitTemplates = functionService.findAllByLink(null, projectTemplate, metaDataService.ltProjectUnitTemplate)

    // calculate realDuration
    int calculatedDuration = calculateDuration(projectUnitTemplates)

    render template:'updateduration', model:[calculatedDuration: calculatedDuration, projectTemplate: projectTemplate]   
  }

  int calculateDuration(List projectUnitTemplates) {
    // find all groupActivityTemplates linked to all projectUnitTemplates of this projectTemplate
    List groupActivityTemplates = []

    projectUnitTemplates.each { Entity put ->
      List gats = functionService.findAllByLink(null, put, metaDataService.ltProjectUnitMember)
      if (gats.size() > 0)
        groupActivityTemplates.addAll(gats)
    }

    int calculatedDuration = groupActivityTemplates*.profile.realDuration.sum(0)
    /*groupActivityTemplates.each {
      calculatedDuration += it.profile.realDuration
    }*/

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
    render template: 'labels', model: [projectTemplate: entity, entity: entityHelperService.loggedIn]
  }

  /*
   * removes a label from a group
   */
  def removeLabel = {
    Entity group = Entity.get(params.id)
    group.profile.removeFromLabels(Label.get(params.label))
    Label.get(params.label).delete()
    render template: 'labels', model: [projectTemplate: group, entity: entityHelperService.loggedIn]
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
    def c = Entity.createCriteria()
    def allGroupActivityTemplates = c.list {
      eq("type", metaDataService.etGroupActivityTemplate)
      profile {
        eq("status", "done")
      }
    }
    render template: 'projectUnitTemplates', model: [projectTemplate: group, projectUnitTemplates: templates, entity: entityHelperService.loggedIn, allGroupActivityTemplates: allGroupActivityTemplates]
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
    def c = Entity.createCriteria()
    def allGroupActivityTemplates = c.list {
      eq("type", metaDataService.etGroupActivityTemplate)
      profile {
        eq("status", "done")
      }
    }
    render template: 'projectUnitTemplates', model: [projectTemplate: group, projectUnitTemplates: templates, entity: entityHelperService.loggedIn, allGroupActivityTemplates: allGroupActivityTemplates]
  }

  /*
   * adds a resource
   */
  def addResource = {
    Entity group = Entity.get(params.id)

    Resource resource = new Resource(params)
    group.profile.addToResources(resource)

    render template: 'resources', model: [group: group, entity: entityHelperService.loggedIn]
  }

  /*
   * removes a resource
   */
  def removeResource = {
    Entity group = Entity.get(params.id)

    Resource resource = Resource.get(params.resource)
    group.profile.removeFromResources(resource)

    render template: 'resources', model: [group: group, entity: entityHelperService.loggedIn]
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

def updateselect = {

    def numberOfAllTemplates = Entity.countByType(metaDataService.etProjectTemplate)

    def allTemplates = Entity.createCriteria().list  {
      eq('type', metaDataService.etProjectTemplate)
      if (params.name)
        or {
          ilike('name', "%" + params.name + "%")
          profile {
            ilike('fullName', "%" + params.name + "%")
          }
        }
      profile {
        if (params.sort)
          order(params.sort, params.order)
      }
    }

    List finalList = []

    if (params.labels) {
      List labels = params.list('labels')
      allTemplates.each { Entity template ->
        template.profile.labels.each { Label label ->
          if (labels.contains(label.name)) {
            if (!finalList.contains(template))
              finalList.add(template)
          }
        }
      }
    }
    else
      finalList = allTemplates

    render(template: 'searchresults', model: [allTemplates: finalList,
                                              totalTemplates: finalList.size(),
                                              numberOfAllTemplates: numberOfAllTemplates,
                                              currentEntity: entityHelperService.loggedIn,
                                              paginate: false,
                                              name: params.name])
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
       render '<span class="italic">'+message(code:'noResultsFound')+'</span>'
       return
     }
     else {
       render(template: 'groupactivitytemplateresults', model: [results: results, projectUnitTemplate: params.id, i: params.i, projectTemplate: params.projectTemplate])
     }
   }

}


