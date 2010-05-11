import de.uenterprise.ep.Entity
import de.uenterprise.ep.EntityType
import de.uenterprise.ep.Link
import de.uenterprise.ep.EntityHelperService
import de.uenterprise.ep.ProfileHelperService
import standard.FunctionService
import standard.MetaDataService

class TemplateController {
  EntityHelperService entityHelperService
  FunctionService functionService
  MetaDataService metaDataService
  ProfileHelperService profileHelperService

    def index = {
      redirect action:'list', params:params
    }

    def list = {
      params.offset = params.offset ? params.int('offset'): 0
      params.max = params.max ? params.int('max'): 15

      return ['templateList': Entity.findAllByType(metaDataService.etTemplate),
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

      // delete old links
      //Link.findAllByTargetAndType(template, metaDataService.ltResource).each {it.delete()}

      // create new links
/*      if (params.materials) {
        def materials = params.materials
        if (materials.class.isArray()) {
          materials.each {
            new Link(source: Entity.get(it), target: template, type: metaDataService.ltResource).save()
          }
        }
        else {
          new Link(source: Entity.get(materials), target: template, type: metaDataService.ltResource).save()
        }
      }*/
      
/*      functionService.getParamAsList(params.materials).each {
        new Link(source: Entity.get(it), target: template, type: metaDataService.ltResource).save()
      }

      if(!template.hasErrors() && template.save()) {
          flash.message = message(code:"template.updated", args:[template.profile.fullName])
          redirect action:'show', id: template.id
      }
      else {
          render view:'edit', model:[template: template, entity: entityHelperService.loggedIn]
      }*/

    }

    def show = {
      Entity template = Entity.get(params.id)
      def links = Link.findAllByTargetAndType(template, metaDataService.ltComment)
      def commentList = links.collect {it.source}

      List allResources = Entity.findAllByType(metaDataService.etResource)
      // find all resources of this facility
      links = Link.findAllByTargetAndType(template, metaDataService.ltResource)
      List resources = links.collect {it.source}

      return ['template': template,
              'commentList': commentList,
              'entity': entityHelperService.loggedIn,
              'allResources': allResources,
              'resources': resources]
    }

    def create = {
      return ['entity': entityHelperService.loggedIn,
              'resources': Entity.findAllByType(metaDataService.etResource)]
    }

    def save = {
      EntityType etTemplate = metaDataService.etTemplate

      try {
        Entity entity = entityHelperService.createEntity('template', etTemplate) {Entity ent ->
          ent.profile = profileHelperService.createProfileFor(ent)
          ent.profile.properties = params
        }

        // create new links
/*        if (params.materials) {
          def materials = params.materials
          if (materials.class.isArray()) {
            materials.each {
              new Link(source: Entity.get(it), target: entity, type: metaDataService.ltResource).save()
            }
          }
          else {
            new Link(source: Entity.get(materials), target: entity, type: metaDataService.ltResource).save()
          }
        }*/

/*        functionService.getParamAsList(params.materials).each {
          new Link(source: Entity.get(it), target: entity, type: metaDataService.ltResource).save()
        }*/

        flash.message = message(code:"template.created", args:[entity.profile.fullName])

        functionService.createEvent(entityHelperService.loggedIn, 'Du hast die Aktivitätsvorlage "'+entity.profile.fullName+'" angelegt.')
        List receiver = Entity.findAllByType(metaDataService.etEducator)
        receiver.each {
          if (it != entityHelperService.loggedIn)
            functionService.createEvent(it, 'Es wurde die Aktivitätsvorlage "'+entity.profile.fullName+'" angelegt.')
        }

        redirect action:'show', id:entity.id

      } catch (de.uenterprise.ep.EntityException ee) {
        render (view:"create", model:[template: ee.entity, entity: entityHelperService.loggedIn, resources: Entity.findAllByType(metaDataService.etResource)])
        return
      }

    }

    def del = {
      Entity template = Entity.get(params.id)
      if(template) {
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
              flash.message = message(code:"template.deleted", args:[template.profile.fullName])
              template.delete(flush:true)
              redirect action:"list"
          }
          catch(org.springframework.dao.DataIntegrityViolationException ex) {
              flash.message = message(code:"template.notDeleted", args:[template.profile.fullName])
              redirect action:"show", id:params.id
          }
      }
      else {
          flash.message = message(code:"template.notFound", args:[params.id])
          redirect action:"list"
      }
    }

    def addResource = {
      Entity template = Entity.get(params.id)

      // check if the resource isn't already linked to the template
      def c = Link.createCriteria()
      def link = c.get {
        eq('source', Entity.get(params.resource))
        eq('target', template)
        eq('type', metaDataService.ltResource)
      }
      if (!link)
        new Link(source:Entity.get(params.resource), target: template, type:metaDataService.ltResource).save()

      // find all resources of this template
      def links = Link.findAllByTargetAndType(template, metaDataService.ltResource)
      List resources = links.collect {it.source}

      render template:'resources', model: [resources: resources, template: template, entity: entityHelperService.loggedIn]
    }

    def removeResource = {
      Entity template = Entity.get(params.id)

      def c = Link.createCriteria()
      def link = c.get {
        eq('source', Entity.get(params.resource))
        eq('target', template)
        eq('type', metaDataService.ltResource)
      }
      link.delete()

      // find all resources of this template
      def links = Link.findAllByTargetAndType(template, metaDataService.ltResource)
      List resources = links.collect {it.source}

      render template:'resources', model: [resources: resources, template: template, entity: entityHelperService.loggedIn]
    }
}