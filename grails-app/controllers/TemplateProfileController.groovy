import at.openfactory.ep.Entity
import at.openfactory.ep.EntityType
import at.openfactory.ep.Link
import at.openfactory.ep.EntityHelperService
import at.openfactory.ep.ProfileHelperService
import standard.FunctionService
import standard.MetaDataService
import lernardo.Method
import lernardo.Element
import at.openfactory.ep.Profile

class TemplateProfileController {
  EntityHelperService entityHelperService
  FunctionService functionService
  MetaDataService metaDataService
  ProfileHelperService profileHelperService

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

    return ['templateList': templates,
            'templateCount': Entity.countByType(metaDataService.etTemplate),
            'entity': entityHelperService.loggedIn]
  }

  def edit = {
    Entity template = Entity.get(params.id)
    return ['template': template,
            'entity': entityHelperService.loggedIn]
  }

  def update = {
    Entity template = Entity.get(params.id)
    template.profile.properties = params

    if (!template.hasErrors() && template.save()) {
      flash.message = message(code: "template.updated", args: [template.profile.fullName])
      redirect action: 'show', id: template.id
    }
    else {
      render view: 'edit', model: [template: template, entity: entityHelperService.loggedIn]
    }

  }

  def show = {
    Entity template = Entity.get(params.id)
    Entity entity = params.entity ? template : entityHelperService.loggedIn

    def links = Link.findAllByTargetAndType(template, metaDataService.ltComment)
    def commentList = links.collect {it.source}

    def c = Entity.createCriteria()
    def allResources = c.list {
      eq("type", metaDataService.etResource)
      profile {
        eq("type", "planbar")
      }
    }

    // find all resources of this facility
    links = Link.findAllByTargetAndType(template, metaDataService.ltResource)
    List resources = links.collect {it.source}

    List methods = Method.findAllByType('template')

    return ['template': template,
            'commentList': commentList,
            'entity': entity,
            'allResources': allResources,
            'resources': resources,
            'allMethods': methods]
  }

  def create = {
    Entity template = Entity.get(params.id)
    return ['entity': entityHelperService.loggedIn,
            'resources': Entity.findAllByType(metaDataService.etResource),
            'template': template]
  }

  def save = {
    EntityType etTemplate = metaDataService.etTemplate

    try {
      Entity entity = entityHelperService.createEntity('template', etTemplate) {Entity ent ->
        ent.profile = profileHelperService.createProfileFor(ent) as Profile
        ent.profile.properties = params
      }

      functionService.createEvent(entityHelperService.loggedIn, 'Du hast die Aktivitätsvorlage "' + entity.profile.fullName + '" angelegt.')
      List receiver = Entity.findAllByType(metaDataService.etEducator)
      receiver.each {
        if (it != entityHelperService.loggedIn)
          functionService.createEvent(it as Entity, 'Es wurde die Aktivitätsvorlage "' + entity.profile.fullName + '" angelegt.')
      }

      flash.message = message(code: "template.created", args: [entity.profile.fullName])
      redirect action: 'show', id: entity.id

    } catch (at.openfactory.ep.EntityException ee) {
      render view: "create", model: [template: ee.entity, entity: entityHelperService.loggedIn, resources: Entity.findAllByType(metaDataService.etResource)]
      return
    }

  }

  def del = {
    Entity template = Entity.get(params.id)
    if (template) {
      // first delete any comments posted on this template
      def links = Link.findAllBySourceOrTarget(template, template)
      if (links) {
        List commentsToDelete = []
        links.each {
          commentsToDelete << it.source
          it.delete()
        }
        commentsToDelete.each {it.delete()}
      }
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
      ent.profile.type = "planbar"
      ent.profile.classification = ""
    }
    new Link(source: entity, target: template, type: metaDataService.ltResource).save()

    // find all resources of this template
    def links = Link.findAllByTargetAndType(template, metaDataService.ltResource)
    List resources = links.collect {it.source}

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
    def links = Link.findAllByTargetAndType(template, metaDataService.ltResource)
    List resources = links.collect {it.source}

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
}