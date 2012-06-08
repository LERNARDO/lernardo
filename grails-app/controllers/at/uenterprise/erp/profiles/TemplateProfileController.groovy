package at.uenterprise.erp.profiles

import at.uenterprise.erp.base.Entity
import at.uenterprise.erp.base.EntityType
import at.uenterprise.erp.base.Link
import at.uenterprise.erp.base.EntityHelperService
import at.uenterprise.erp.base.ProfileHelperService
import at.uenterprise.erp.FunctionService
import at.uenterprise.erp.MetaDataService

import at.uenterprise.erp.Element
import at.uenterprise.erp.base.Profile

import at.uenterprise.erp.base.AssetService
import at.uenterprise.erp.Method
import at.uenterprise.erp.Publication
import at.uenterprise.erp.Live
import org.codehaus.groovy.grails.commons.ApplicationHolder
import at.uenterprise.erp.Label
import at.uenterprise.erp.base.Asset
import at.uenterprise.erp.EVENT_TYPE

class TemplateProfileController {
  EntityHelperService entityHelperService
  FunctionService functionService
  MetaDataService metaDataService
  ProfileHelperService profileHelperService
  AssetService assetService

  // the delete, save and update actions only accept POST requests
  static allowedMethods = [delete: 'POST', save: 'POST', update: 'POST']

  def index = {
    redirect action: 'list', params: params
  }

  def list = {
    params.offset = params.int('offset') ?: 0
    params.max = Math.min(params.int('max') ?: 15, 100)
    params.sort = params.sort ?: "fullName"
    params.order = params.order ?: "asc"

    EntityType etTemplate = metaDataService.etTemplate
    def templates = Entity.createCriteria().list {
      eq("type", etTemplate)
      profile {
        order(params.sort, params.order)
      }
      maxResults(params.max)
      firstResult(params.offset)
    }
    int totalTemplates = Entity.countByType(etTemplate)

    return [allTemplates: templates,
            totalTemplates: totalTemplates,
            methods: Method.findAllByType('template'),
            allLabels: functionService.getLabels(),
            paginate: true]
  }

  def edit = {
    Entity template = Entity.get(params.id)
    Entity entity = params.entity ? template : entityHelperService.loggedIn
    return ['template': template, entity: entity]
  }

  def update = {
    Entity template = Entity.get(params.id)
    template.profile.properties = params
    if (!params.ageFrom)
      template.profile.ageFrom = 0
    if (!params.ageTo)
      template.profile.ageTo = 100

    if (template.profile.save() && template.save()) {
      flash.message = message(code: "object.updated", args: [message(code: "template"), template.profile.fullName])
      redirect action: 'show', id: template.id
    }
    else {
      render view: 'edit', model: [template: template]
    }

  }

  def show = {
    Entity template = Entity.get(params.id)

    params.sort = "name"
    params.order  = "asc"
    List allMethods = Method.findAllByType('template', params)

    return [template: template,
            allMethods: allMethods,
            allLabels: functionService.getLabels()]
  }

  def create = {}

  def copy = {
    EntityType etTemplate = metaDataService.etTemplate

    Entity currentEntity = entityHelperService.loggedIn

    Entity original = Entity.get(params.id)

    Entity entity = entityHelperService.createEntity('template', etTemplate) {Entity ent ->
      ent.profile = profileHelperService.createProfileFor(ent) as Profile
      ent.profile.description = original.profile.description
      ent.profile.chosenMaterials = original.profile.chosenMaterials
      ent.profile.socialForm = original.profile.socialForm
      ent.profile.amountEducators = original.profile.amountEducators
      ent.profile.status = original.profile.status
      ent.profile.duration = original.profile.duration
      ent.profile.type = original.profile.type
      ent.profile.fullName = original.profile.fullName + '[' + message(code: "duplicate") + ']'
      ent.profile.goal = original.profile.goal
      ent.profile.ageFrom = original.profile.ageFrom
      ent.profile.ageTo = original.profile.ageTo
    }

    // save creator
    new Link(source: currentEntity, target: entity, type: metaDataService.ltCreator).save()

    // loop through all methods of the original and create them in the copy
    original.profile.methods.each { Method me ->
      Method method = new Method()

      method.name = me.name
      method.description = me.description
      method.type = "instance"

      me.elements.each { el ->
        method.addToElements(new Element(name: el.name, voting: el.voting))
      }

      method.save(flush:true)
      entity.profile.addToMethods(method)
    }

    // loop through all labels of the original and create them in the copy
    original.profile.labels.each { Label la ->
      Label label = new Label()

      label.name = la.name
      label.description = la.description
      label.type = "instance"

      label.save(flush: true)

      entity.profile.addToLabels(label)
    }

    entity.profile.save(flush: true)

    // copy publications
    List publications = Publication.findAllByEntity(original)
    publications.each { pu ->
      new Publication(entity: entity, type: metaDataService.ptDoc1, asset: pu.asset, name: pu.name).save()
    }

    // copy profile pic
    Asset asset = Asset.findByEntityAndType(original, "profile")
    if (asset)
      new Asset(entity: entity, storage: asset.storage, type: "profile").save(flush: true)

    flash.message = message(code: "template.copied", args: [entity.profile.fullName])
    redirect action: 'show', id: entity.id
  }

  def save = {
    EntityType etTemplate = metaDataService.etTemplate

    Entity currentEntity = entityHelperService.loggedIn

    try {
      Entity entity = entityHelperService.createEntity('template', etTemplate) {Entity ent ->
        ent.profile = profileHelperService.createProfileFor(ent) as Profile
        ent.profile.properties = params
        ent.profile.type = "default"
        if (!params.ageFrom)
          ent.profile.ageFrom = 0
        if (!params.ageTo)
          ent.profile.ageTo = 100
      }
      // add default profile image
      File file = ApplicationHolder.application.parentContext.getResource("images/default_activitytemplate.png").getFile()
      def result = assetService.storeAsset(entity, "profile", "image/png", file.getBytes())

      new Live(content: '<a href="' + createLink(controller: currentEntity.type.supertype.name + 'Profile', action: 'show', id: currentEntity.id) + '">' + currentEntity.profile.fullName + '</a> hat die Aktivitätsvorlage <a href="' + createLink(controller: 'templateProfile', action: 'show', id: entity.id) + '">' + entity.profile.fullName + '</a> angelegt.').save()
      functionService.createEvent(EVENT_TYPE.ACTIVITY_TEMPLATE_CREATED, currentEntity.id.toInteger(), entity.id.toInteger())

      // save creator
      new Link(source: currentEntity, target: entity, type: metaDataService.ltCreator).save()

      flash.message = message(code: "object.created", args: [message(code: "template"), entity.profile.fullName])
      redirect action: 'show', id: entity.id

    } catch (at.uenterprise.erp.base.EntityException ee) {
      render view: "create", model: [template: ee.entity, resources: Entity.findAllByType(metaDataService.etResource)]
    }

  }

  def delete = {
    Entity template = Entity.get(params.id)
    if (template) {
      functionService.deleteReferences(template)
      try {
        flash.message = message(code: "object.deleted", args: [message(code: "activityTemplate"), template.profile.fullName])
        template.delete(flush: true)
        redirect action: "list"
      }
      catch (org.springframework.dao.DataIntegrityViolationException e) {
        flash.message = message(code: "object.notDeleted", args: [message(code: "activityTemplate"), template.profile.fullName])
        redirect action: "show", id: params.id
      }
    }
    else {
      flash.message = message(code: "object.notFound", args: [message(code: "activityTemplate")])
      redirect action: "list"
    }
  }

  /*
   * adds a method to the template by creating a new method instance and copying the properties from the given "method template"
   */
  def addMethod = {
    Entity template = Entity.get(params.id)
    Method methodTemplate = Method.get(params.method)

    // make sure a method can only be added once
    Boolean canBeAdded = true
    template.profile.methods.each {
        if (it.name == methodTemplate.name)
            canBeAdded = false
    }
    if (canBeAdded) {
        Method method = new Method()

        method.name = methodTemplate.name
        method.description = methodTemplate.description
        method.type = "instance"

        methodTemplate.elements.each {
          method.addToElements(new Element(name: it.name).save())
        }

        template.profile.addToMethods(method)
    }
    render template: 'methods', model: [template: template]
  }

  /*
   * removes a method from a template
   */
  def removeMethod = {
    Entity template = Entity.get(params.id)
    template.profile.removeFromMethods(Method.get(params.method))
    Method.get(params.method).delete()
    render template: 'methods', model: [template: template]
  }

  /*
   * voting of the starboxes of a method element
   */
  def vote = {
    Element element = Element.get(params.element)
    if (element.voting == params.int('val'))
      element.voting = 0
    else
      element.voting = params.int('val')

    render erp.starBox(element: element.id)
  }

  def updateselect = {
    def method1lower = params.list('method1lower')
    def method1upper = params.list('method1upper')

    def method2lower = params.list('method2lower')
    def method2upper = params.list('method2upper')

    def method3lower = params.list('method3lower')
    def method3upper = params.list('method3upper')

    params.sort = params.sort ?: "fullName"
    params.order = params.order ?: "asc"

    // swap age values if necessary
    if (params.int('ageTo') < params.int('ageFrom')) {
      def temp = params.ageTo
      params.ageTo = params.ageFrom
      params.ageFrom = temp
    }

    def numberOfAllTemplates = Entity.countByType(metaDataService.etTemplate)

    // 1. pass - filter by object properties
    def firstPass = Entity.createCriteria().list  {
      eq('type', metaDataService.etTemplate)
      if (params.name)
        or {
          ilike('name', "%" + params.name + "%")
          profile {
            ilike('fullName', "%" + params.name + "%")
          }
        }
      profile {
        if (params.duration1 != 'all')
          between('duration', params.duration1.toInteger(), params.duration2.toInteger())
        if (params.ageFrom) {
          le('ageFrom', params.ageFrom.toInteger())
        }
        if (params.ageTo)
            ge('ageTo', params.ageTo.toInteger())
        if (params.sort)
          order(params.sort, params.order)
      }
    }

    // 2. pass - filter by creator
    List secondPass = []

    if (params.creator != "") {
      firstPass.each { Entity template ->
        def creator = Link.createCriteria().get {
          eq('source', Entity.get(params.int('creator')))
          eq('target', template)
          eq('type', metaDataService.ltCreator)
        }
        if (creator) {
          secondPass.add(template)
        }
      }
    }
    else
      secondPass = firstPass

    // 3. filter by labels
    List thirdPass = []

    if (params.labels) {
      List labels = params.list('labels')
      secondPass.each { Entity template ->
        template.profile.labels.each { Label label ->
          if (labels.contains(label.name)) {
            if (!thirdPass.contains(template))
              thirdPass.add(template)
          }
        }
      }
    }
    else
      thirdPass = secondPass

    // 4. filter by methods
    List fourthPass = []

    if (params.method1 != 'none' || params.method2 != 'none' || params.method3 != 'none') {
      List list1 = []
      List list2 = []
      List list3 = []

      if (params.method1 != 'none') {
        // now check each template for their correct element values
        thirdPass.each { a ->
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
        thirdPass.each { a ->
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
        thirdPass.each { a ->
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
      thirdPass.each { a ->
        if (params.method1 != 'none' && params.method2 == 'none' && params.method3 == 'none') {
        if (list1.contains(a))
          fourthPass << a
        }
        else if (params.method1 != 'none' && params.method2 != 'none' && params.method3 == 'none') {
        if (list1.contains(a) && list2.contains(a))
          fourthPass << a
        }
        else if (params.method1 != 'none' && params.method2 != 'none' && params.method3 != 'none') {
        if (list1.contains(a) && list2.contains(a) && list3.contains(a))
          fourthPass << a
        }
      }

    }
    else
      fourthPass = thirdPass

    render template: 'searchresults', model: [allTemplates: fourthPass,
                                              totalTemplates: fourthPass.size(),
                                              numberOfAllTemplates: numberOfAllTemplates,
                                              paginate: false,
                                              method1: params.method1,
                                              method2: params.method2,
                                              method3: params.method3,
                                              method1lower: params.method1lower,
                                              method1upper: params.method1upper,
                                              method2lower: params.method2lower,
                                              method2upper: params.method2upper,
                                              method3lower: params.method3lower,
                                              method3upper: params.method3upper,
                                              name: params.name,
                                              duration1: params.duration1,
                                              duration2: params.duration2,
                                              ageFrom: params.ageFrom,
                                              ageTo: params.ageTo]
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
    render template: 'labels', model: [template: entity]
  }

    /*
   * removes a label from a template
   */
  def removeLabel = {
    Entity template = Entity.get(params.id)
    template.profile.removeFromLabels(Label.get(params.label))
    Label.get(params.label).delete()
    render template: 'labels', model: [template: template]
  }

}