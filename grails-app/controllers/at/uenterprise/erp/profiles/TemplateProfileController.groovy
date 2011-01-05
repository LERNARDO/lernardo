package at.uenterprise.erp.profiles

import at.openfactory.ep.Entity
import at.openfactory.ep.EntityType
import at.openfactory.ep.Link
import at.openfactory.ep.EntityHelperService
import at.openfactory.ep.ProfileHelperService
import at.uenterprise.erp.FunctionService
import at.uenterprise.erp.MetaDataService

import at.uenterprise.erp.Element
import at.openfactory.ep.Profile

import at.openfactory.ep.AssetService
import at.uenterprise.erp.Method
import at.uenterprise.erp.Publication
import at.uenterprise.erp.Live

class TemplateProfileController {
  EntityHelperService entityHelperService
  FunctionService functionService
  MetaDataService metaDataService
  ProfileHelperService profileHelperService
  AssetService assetService

  def index = {
    redirect action: 'list', params: params
  }

  def list = {
    params.offset = params.offset ? params.int('offset') : 0
    params.max = Math.min(params.max ? params.int('max') : 15, 100)
    params.sort = params.sort ?: "fullName"
    params.order = params.order ?: "asc"

    def c = Entity.createCriteria()
    def templates = c.list {
      eq("type", metaDataService.etTemplate)
      profile {
        order(params.sort, params.order)
      }
      maxResults(params.max)
      firstResult(params.offset)
    }

    return [allTemplates: templates,
            methods: Method.findAllByType('template')]
  }

  def edit = {
    Entity template = Entity.get(params.id)
    return ['template': template]
  }

  def update = {
    Entity template = Entity.get(params.id)
    template.profile.properties = params

    if (!template.hasErrors() && !template.profile.hasErrors() && template.save() && template.profile.save()) {
      flash.message = message(code: "template.updated", args: [template.profile.fullName])
      redirect action: 'show', id: template.id
    }
    else {
      render view: 'edit', model: [template: template]
    }

  }

  def show = {
    Entity template = Entity.get(params.id)
    Entity entity = params.entity ? template : entityHelperService.loggedIn

    def commentList = functionService.findAllByLink(null, template, metaDataService.ltComment)
    def resources = functionService.findAllByLink(null, template, metaDataService.ltResource)
    def allMethods = Method.findAllByType('template')

    return ['template': template,
            'commentList': commentList,
            'entity': entity,
            'resources': resources,
            'allMethods': allMethods]
  }

  def create = {
    return ['resources': Entity.findAllByType(metaDataService.etResource)]
  }

  def copy = {
    EntityType etTemplate = metaDataService.etTemplate

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
      ent.profile.fullName = original.profile.fullName + '[Duplikat]'
    }

    // find all resources created in the original and create them in the copy
    List resources = functionService.findAllByLink(null, original, metaDataService.ltResource)

    EntityType etResource = metaDataService.etResource
    resources.each {

      Entity resource = entityHelperService.createEntity("resource", etResource) {Entity ent ->
        ent.profile = profileHelperService.createProfileFor(ent) as Profile
        ent.profile.classification = it.profile.classification
        ent.profile.description = it.profile.description
        ent.profile.fullName = it.profile.fullName
      }

      new Link(source: resource, target: entity, type: metaDataService.ltResource).save()
    }

    // loop through all methods of the original and create them in the copy
    original.profile.methods.each { me ->
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
      }
      // TODO: find out why this doesn't work properly
      //File file = ApplicationHolder.application.parentContext.getResource("images/sueninos/static/entities/Chrysanthemum.jpg").getFile()
      //assetService.storeAsset(entity, "profile", "image/jpeg", file.getBytes())

      new Live(content: '<a href="' + createLink(controller: currentEntity.type.supertype.name +'Profile', action:'show', id: currentEntity.id) + '">' + currentEntity.profile.fullName + '</a> hat die Aktivitätsvorlage <a href="' + createLink(controller: 'templateProfile', action: 'show', id: entity.id) + '">' + entity.profile.fullName + '</a> angelegt.').save()
      functionService.createEvent(currentEntity, 'Du hast die Aktivitätsvorlage <a href="' + createLink(controller: 'templateProfile', action: 'show', id: entity.id) + '">' + entity.profile.fullName + '</a> angelegt.')
      List receiver = Entity.findAllByType(metaDataService.etEducator)
      receiver.each {
        if (it.id != currentEntity.id)
          functionService.createEvent(it as Entity, '<a href="' + createLink(controller: currentEntity.type.supertype.name +'Profile', action:'show', id: currentEntity.id) + '">' + currentEntity.profile.fullName + '</a> hat die Aktivitätsvorlage <a href="' + createLink(controller: 'templateProfile', action: 'show', id: entity.id) + '">' + entity.profile.fullName + '</a> angelegt.')
      }

      flash.message = message(code: "template.created", args: [entity.profile.fullName])
      redirect action: 'show', id: entity.id

    } catch (at.openfactory.ep.EntityException ee) {
      render view: "create", model: [template: ee.entity, resources: Entity.findAllByType(metaDataService.etResource)]
    }

  }

  def del = {
    Entity template = Entity.get(params.id)
    if (template) {
      // first delete any comments posted on this template
      Link.findAllBySourceOrTarget(template, template).each {it.delete()}
      Publication.findAllByEntity(template).each {it.delete()}
      /*if (links) {
        List commentsToDelete = []
        links.each {
          commentsToDelete << it.source
          it.delete()
        }
        commentsToDelete.each {it.delete()}
      }*/
      try {
        flash.message = message(code: "template.deleted", args: [template.profile.fullName])
        template.delete(flush: true)
        redirect action: "list"
      }
      catch (org.springframework.dao.DataIntegrityViolationException ex) {
        flash.message = message(code: "template.notDeleted", args: [template.profile.fullName])
        redirect action: "show", id: params.id
      }
    }
    else {
      flash.message = message(code: "template.notFound", args: [params.id])
      redirect action: "list"
    }
  }

  /*
   * creates a new resource and then links it to the template
   */
  def addResource = {
    Entity template = Entity.get(params.id)

    EntityType etResource = metaDataService.etResource
    Entity entity = entityHelperService.createEntity("resource", etResource) {Entity ent ->
      ent.profile = profileHelperService.createProfileFor(ent) as Profile
      ent.profile.properties = params
      ent.profile.classification = ""
    }
    new Link(source: entity, target: template, type: metaDataService.ltResource).save()

    // find all resources of this template
    List resources = functionService.findAllByLink(null, template, metaDataService.ltResource)

    render template: 'resources', model: [resources: resources, template: template, entity: entityHelperService.loggedIn]
  }

  /*
   * removes the link to a resource and then deletes the resource
   */
  def removeResource = {
    Entity template = Entity.get(params.id)

    def c = Link.createCriteria()
    def link = c.get {
      eq('source', Entity.get(params.resource))
      eq('target', template)
      eq('type', metaDataService.ltResource)
    }
    link.delete()

    // delete resource as well
    Entity.get(params.resource).delete()

    // find all resources of this template
    List resources = functionService.findAllByLink(null, template, metaDataService.ltResource)

    render template: 'resources', model: [resources: resources, template: template, entity: entityHelperService.loggedIn]
  }

  /*
   * adds a method to the template by creating a new method instance and copying the properties from the given "method template"
   */
  def addMethod = {
    // TODO: make sure a method can only be added once
    Method methodTemplate = Method.get(params.method)
    Method method = new Method()

    method.name = methodTemplate.name
    method.description = methodTemplate.description
    method.type = "instance"

    methodTemplate.elements.each {
      method.addToElements(new Element(name: it.name))
    }

    Entity template = Entity.get(params.id)
    template.profile.addToMethods(method)
    render template: 'methods', model: [template: template, entity: entityHelperService.loggedIn]
  }

  /*
   * removes a method from a template
   */
  def removeMethod = {
    Entity template = Entity.get(params.id)
    template.profile.removeFromMethods(Method.get(params.method))
    Method.get(params.method).delete()
    render template: 'methods', model: [template: template, entity: entityHelperService.loggedIn]
  }

  /*
   * voting of the starboxes of a method element
   */
  def vote = {
    Element element = Element.get(params.element)
    if (element.voting == params.val as Integer)
      element.voting = 0
    else
      element.voting = params.val as Integer

    render app.starBox(element: element.id)
  }

  def updateselect = {
    //println params
    //def allTemplates = Entity.findAllByType(metaDataService.etTemplate)
    def method1lower = params.list('method1lower')
    def method1upper = params.list('method1upper')

    def method2lower = params.list('method2lower')
    def method2upper = params.list('method2upper')

    def method3lower = params.list('method3lower')
    def method3upper = params.list('method3upper')

    def c = Entity.createCriteria()
    def allTemplates = c.list {
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
      }
      maxResults(30)
    }

    List finalList = allTemplates
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

    render(template: 'searchresults', model: [allTemplates: finalList, currentEntity: entityHelperService.loggedIn])
  }

}