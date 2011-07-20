package at.uenterprise.erp.profiles

import at.openfactory.ep.Entity
import at.openfactory.ep.EntityType
import at.openfactory.ep.Link
import at.openfactory.ep.ProfileHelperService
import at.openfactory.ep.EntityHelperService
import at.uenterprise.erp.MetaDataService
import at.openfactory.ep.Profile
import at.uenterprise.erp.FunctionService
import at.openfactory.ep.EntityException
import at.uenterprise.erp.Method
import at.uenterprise.erp.Event
import at.uenterprise.erp.Live
import org.codehaus.groovy.grails.commons.ApplicationHolder
import at.openfactory.ep.AssetService
import at.uenterprise.erp.Label
import at.uenterprise.erp.Publication
import at.openfactory.ep.Asset
import at.uenterprise.erp.Resource

class GroupActivityTemplateProfileController {
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
    params.offset = params.offset ? params.int('offset') : 0
    params.max = Math.min(params.max ? params.int('max') : 15, 100)
    params.sort = params.sort ?: "fullName"
    params.order = params.order ?: "asc"

    EntityType etGroupActivityTemplate = servletContext.etGroupActivityTemplate
    def groupActivityTemplates = Entity.createCriteria().list {
      eq("type", etGroupActivityTemplate)
      profile {
        order(params.sort, params.order)
      }
      maxResults(params.max)
      firstResult(params.offset)
    }
    int totalGroupActivityTemplates = Entity.countByType(etGroupActivityTemplate)

    return [groups: groupActivityTemplates, totalGroupActivityTemplates: totalGroupActivityTemplates]
  }

  def show = {
    def group = Entity.get(params.id)
    Entity entity = params.entity ? group : entityHelperService.loggedIn

    if (!group) {
      //flash.message = "groupProfile not found with id ${params.id}"
      flash.message = message(code: "group.idNotFound", args: [params.id])
      redirect(action: list)
      return
    }

    // get all activity templates that are set to completed
    def c = Entity.createCriteria()
    def allTemplates = c.list {
      eq("type", servletContext.etTemplate)
      profile {
        eq("status", "done")
      }
    }

    // find all activity templates linked to this group
    //List templates = functionService.findAllByLink(null, group, servletContext.ltGroupMember)
    List templates = []
    group.profile.templates.each {
      templates.add(Entity.get(it))
    }

    def calculatedDuration = 0
    templates.each {
      calculatedDuration += it.profile.duration
    }

    // find all instances of this template
    List instances = functionService.findAllByLink(group, null, servletContext.ltTemplate)

    // get all resources of all templates
    List templateResources = []
    templates.each {
      templateResources.addAll(it.profile.resources)
    }

    return [group: group,
            entity: entity,
            allTemplates: allTemplates,
            templates: templates,
            calculatedDuration: calculatedDuration,
            methods: Method.findAllByType('template'),
            allLabels: Label.findAllByType('template'),
            instances: instances,
            templateResources: templateResources]

  }

  def delete = {
    Entity group = Entity.get(params.id)
    if (group) {
      // delete all links
      Link.findAllBySourceOrTarget(group, group).each {it.delete()}

      try {
        flash.message = message(code: "group.deleted", args: [group.profile.fullName])
        group.delete(flush: true)
        redirect(action: "list")
      }
      catch (org.springframework.dao.DataIntegrityViolationException e) {
        flash.message = message(code: "group.notDeleted", args: [group.profile.fullName])
        redirect(action: "show", id: params.id)
      }
    }
    else {
      //flash.message = "groupProfile not found with id ${params.id}"
      flash.message = message(code: "group.idNotFound", args: [params.id])
      redirect(action: "list")
    }
  }

  def edit = {
    Entity group = Entity.get(params.id)
    Entity entity = params.entity ? group : entityHelperService.loggedIn

    if (!group) {
      // flash.message = "groupProfile not found with id ${params.id}"
      flash.message = message(code: "group.idNotFound", args: [params.id])
      redirect action: 'list'
    }
    else {
      [group: group, entity: entity]
    }
  }

  def update = {
    Entity group = Entity.get(params.id)

    group.profile.properties = params

    if (group.profile.save() && group.save()) {
      flash.message = message(code: "group.updated", args: [group.profile.fullName])
      redirect action: 'show', id: group.id, params: [entity: group.id]
    }
    else {
      render view: 'edit', model: [group: group, entity: group]
    }
  }

  def copy = {
    EntityType etGroupActivityTemplate = servletContext.etGroupActivityTemplate

    Entity currentEntity = entityHelperService.loggedIn

    Entity original = Entity.get(params.id)

    Entity entity = entityHelperService.createEntity("group", etGroupActivityTemplate) {Entity ent ->
      ent.profile = profileHelperService.createProfileFor(ent) as Profile
      ent.profile.description = original.profile.description
      ent.profile.status = original.profile.status
      ent.profile.realDuration = original.profile.realDuration
      ent.profile.fullName = original.profile.fullName + '[Duplikat]'
    }

    // save creator
    new Link(source: currentEntity, target: entity, type: servletContext.ltCreator).save()

    // find all activity templates linked to the original and link them to the copy
    List templates = functionService.findAllByLink(null, original, servletContext.ltGroupMember)

    templates.each {
      new Link(source: it as Entity, target: entity, type: servletContext.ltGroupMember).save()
    }

    // loop through all labels of the original and create them in the copy
    original.profile.labels.each { la->
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
    new Asset(entity: entity, storage: asset.storage, type: "profile").save(flush: true)

    flash.message = message(code: "group.copied", args: [entity.profile.fullName])
    redirect action: 'show', id: entity.id, params: [entity: entity.id]

  }

  def create = {
    Entity group = Entity.get(params.id)
       
    return [group: group]
  }

  def save = {
    EntityType etGroupActivityTemplate = servletContext.etGroupActivityTemplate

    Entity currentEntity = entityHelperService.loggedIn

    try {
      Entity entity = entityHelperService.createEntity("group", etGroupActivityTemplate) {Entity ent ->
        ent.profile = profileHelperService.createProfileFor(ent) as Profile
        ent.profile.properties = params
      }
      // add default profile image
      File file = ApplicationHolder.application.parentContext.getResource("images/default_groupactivitytemplate.png").getFile()
      def result = assetService.storeAsset(entity, "profile", "image/png", file.getBytes())

      // save creator
      new Link(source: currentEntity, target: entity, type: servletContext.ltCreator).save()

      new Live(content: '<a href="' + createLink(controller: currentEntity.type.supertype.name +'Profile', action:'show', id: currentEntity.id) + '">'
              + currentEntity.profile.fullName + '</a> hat die Aktivitätsblockvorlage <a href="'
              + createLink(controller: 'groupActivityTemplateProfile', action: 'show', id: entity.id) + '">' + entity.profile.fullName + '</a> angelegt.').save()

      functionService.createEvent("GROUP_ACTIVITY_TEMPLATE_CREATED", currentEntity.id.toInteger(), entity.id.toInteger())

      flash.message = message(code: "group.created", args: [entity.profile.fullName])
      redirect action: 'show', id: entity.id, params: [entity: entity.id]
    } catch (EntityException ee) {
      render(view: "create", model: [group: ee.entity])
    }

  }

  def addTemplate = {
    Entity groupActivityTemplate = Entity.get(params.id)

    if (!params.templates)
      //render '<p class="italic red">Bitte zumindest eine Vorlage auswählen!</p>'
      render '<p class="italic red">'+message(code: "groupActivityTemplate.select.least")+'</p>'
    else {
      def bla = params.list('templates')

      bla.each {
        def linking = functionService.linkEntities(it.toString(), params.id, servletContext.ltGroupMember)

        if (!linking.duplicate)
          groupActivityTemplate.profile.addToTemplates(it)
        if (linking.duplicate)
          //render '<p class="red italic">"' + linking.source.profile.fullName + '" wurde bereits zugewiesen!</p>'
          render '<p class="red italic">"' + linking.source.profile.fullName + '" '+message(code: "alreadyAssignedTo")+'</p>'
      }
    }

    def calculatedDuration = 0

    List templates = []
    groupActivityTemplate.profile.templates.each {
      templates.add(Entity.get(it))
    }

    templates.each {
      calculatedDuration += it.profile.duration
    }

    render template: 'templates', model: [templates: templates, group: Entity.get(params.id), entity: entityHelperService.loggedIn, calculatedDuration: calculatedDuration]
  }

  def removeTemplate = {
    Entity groupActivityTemplate = Entity.get(params.id)
    def breaking = functionService.breakEntities(params.template, params.id, servletContext.ltGroupMember)
    groupActivityTemplate.profile.removeFromTemplates(params.template)

    List templates = []
    groupActivityTemplate.profile.templates.each {
      templates.add(Entity.get(it.toInteger()))
    }

    def calculatedDuration = 0
    templates.each {
      calculatedDuration += it.profile.duration
    }

    render template: 'templates', model: [templates: templates, group: breaking.target, entity: entityHelperService.loggedIn, calculatedDuration: calculatedDuration]
  }

  def updateselect = {
    //println params
    //def allTemplates = Entity.findAllByType(servletContext.etTemplate)
    def method1lower = params.list('method1lower')
    def method1upper = params.list('method1upper')

    def method2lower = params.list('method2lower')
    def method2upper = params.list('method2upper')

    def method3lower = params.list('method3lower')
    def method3upper = params.list('method3upper')

    def allTemplates = Entity.createCriteria().list {
      eq('type', servletContext.etTemplate)
      if (params.name)
        or {
          ilike('name', "%" + params.name + "%")
          profile {
            ilike('fullName', "%" + params.name + "%")
          }
        }
      profile {
        eq('status',"done")
        if (params.duration1 != 'all')
          between('duration', params.duration1.toInteger(), params.duration2.toInteger())
        if (params.ageFrom)
          le('ageFrom', params.ageFrom.toInteger())
        if (params.ageTo)
          ge('ageTo', params.ageTo.toInteger())
      }
    }

    List finalList = []

    if (params.labels) {
      List labels = params.list('labels')
      allTemplates.each { Entity template ->
        template.profile.labels.each { Label label ->
          if (labels.contains(label.name))
            finalList.add(template)
        }
      }
    }
    else
      finalList = allTemplates

    List list1 = []
    List list2 = []
    List list3 = []

    // if at least one method is used reset the lists
    if (params.method1 != 'none' || params.method2 != 'none' || params.method3 != 'none') {
      finalList = []
    }

    if (params.method1 != 'none') {
      // now check each template for their correct element values
      allTemplates.each { a ->
        //println '----------'
        //println a
        a.profile.each { b ->
          //println 'Profile: ' + b
          b.methods.each { d ->
            //println 'Method: ' + d
            if (d.name == Method.get(params.method1).name) {
              def counter = 0
              def correct = 0
              d.elements.each { e ->
                //println e.name + ' - ' + method1lower[counter] + ' to ' + method1upper[counter]
                if (method1lower[counter] != 'all' && method1upper[counter] != 'all') {

                  if (e.voting >= method1lower[counter].toInteger() && e.voting <= method1upper[counter].toInteger()) {
                    //println counter + '# element OK, is ' + e.voting
                    correct++
                  }
                  //else {
                  //  println counter + '# element not OK, is ' + e.voting
                  //}
                }
                else {
                  //println counter + '# element OK'
                  correct++
                }
                //println '#correct ' + correct + ' of ' + method1lower.size()
                if (correct == method1lower.size())
                  if (!list1.contains(a))
                    list1 << a
                counter++
              }
            }
          }
        }
      }
      //println finalList
    }

    if (params.method2 != 'none') {
      allTemplates.each { a ->
        a.profile.each { b ->
          b.methods.each { d ->
            if (d.name == Method.get(params.method2).name) {
              def counter = 0
              def correct = 0
              d.elements.each { e ->
                if (method2lower[counter] != 'all' && method2upper[counter] != 'all') {
                  if (e.voting >= method2lower[counter].toInteger() && e.voting <= method2upper[counter].toInteger()) {
                    correct++
                  }
                }
                else {
                  correct++
                }
                if (correct == method2lower.size())
                  if (!list2.contains(a))
                    list2 << a
                counter++
              }
            }
          }
        }
      }
    }

    if (params.method3 != 'none') {
      allTemplates.each { a ->
        a.profile.each { b ->
          b.methods.each { d ->
            if (d.name == Method.get(params.method3).name) {
              def counter = 0
              def correct = 0
              d.elements.each { e ->
                if (method3lower[counter] != 'all' && method3upper[counter] != 'all') {
                  if (e.voting >= method3lower[counter].toInteger() && e.voting <= method3upper[counter].toInteger()) {
                    correct++
                  }
                }
                else {
                  correct++
                }
                if (correct == method3lower.size())
                  if (!list3.contains(a))
                    list3 << a
                counter++
              }
            }
          }
        }
      }
    }

    // if the template is in all lists which means it passed all 3 method validations then add it to the final list
    allTemplates.each { a ->
      if (params.method1 != 'none' && params.method2 == 'none' && params.method3 == 'none') {
      if (list1.contains(a))
        finalList << a
      }
      else if (params.method1 != 'none' && params.method2 != 'none' && params.method3 == 'none') {
      if (list1.contains(a) && list2.contains(a))
        finalList << a
      }
      else if (params.method1 != 'none' && params.method2 != 'none' && params.method3 != 'none') {
      if (list1.contains(a) && list2.contains(a) && list3.contains(a))
        finalList << a
      }
    }

    render(template: 'searchresults', model: [allTemplates: finalList])
  }

  def listMethods = {

    if (params.id == 'none') {
      render ''
      return
    }

    Method method = Method.get(params.id)

    render(template: 'methods', model: [method: method, dropdown: params.dropdown])
  }

  def secondselect = {
    if (params.currentvalue == 'undefined')
      params.currentvalue = 0

    if (params.value == "all")
      render '<span id="duration2" style="display: none">0</span>'
    else {
      int value = params.int('value')
      int currentvalue = params.int('currentvalue')

      if (currentvalue <= value)
       currentvalue = value + 1
      render template: 'secondselect', model:[value: value + 1, currentvalue: currentvalue]
    }
  }

  def templateHover = {
    Entity entity = Entity.get(params.id)
    render template: "hover", model: [entity: entity]
  }

  /*
   * adds a label to the group by creating a new label instance and copying the properties from the given "label template"
   */
  def addLabel = {
    Entity group = Entity.get(params.id)
    Label labelTemplate = Label.get(params.label)

    // make sure a label can only be added once
    Boolean canBeAdded = true
    group.profile.labels.each {
        if (it.name == labelTemplate.name)
            canBeAdded = false
    }
    if (canBeAdded) {
        Label label = new Label()

        label.name = labelTemplate.name
        label.description = labelTemplate.description
        label.type = "instance"

        group.profile.addToLabels(label)
    }
    render template: 'labels', model: [group: group, entity: entityHelperService.loggedIn]
  }

  /*
   * removes a label from a group
   */
  def removeLabel = {
    Entity group = Entity.get(params.id)
    group.profile.removeFromLabels(Label.get(params.label))
    Label.get(params.label).delete()
    render template: 'labels', model: [group: group, entity: entityHelperService.loggedIn]
  }

   def moveUp = {
    Entity group = Entity.get(params.group)
    if (group.profile.templates.indexOf(params.id) > 0) {
      int i = group.profile.templates.indexOf(params.id)
      use(Collections){ group.profile.templates.swap(i, i - 1) }
    }
    List templates = []
    group.profile.templates.each {
      templates.add(Entity.get(it.toInteger()))
    }
    render template: 'templates2', model: [group: group, templates: templates, entity: entityHelperService.loggedIn]
  }

  def moveDown = {
    Entity group = Entity.get(params.group)
    if (group.profile.templates.indexOf(params.id) < group.profile.templates.size() - 1) {
      int i = group.profile.templates.indexOf(params.id)
      use(Collections){ group.profile.templates.swap(i, i + 1) }
    }
    List templates = []
    group.profile.templates.each {
      templates.add(Entity.get(it.toInteger()))
    }
    render template: 'templates2', model: [group: group, templates: templates, entity: entityHelperService.loggedIn]
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

}
