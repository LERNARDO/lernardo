import de.uenterprise.ep.Entity
import de.uenterprise.ep.EntityType
import de.uenterprise.ep.Link
import lernardo.ResourceProfile

class TemplateController {
  def entityHelperService
  def functionService
  def metaDataService
  def profileHelperService

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
      def template = Entity.get(params.id)

      return ['template': template,
              'entity': entityHelperService.loggedIn,
              'resources': Entity.findAllByType(metaDataService.etResource)]
    }

    def update = {
      def template = Entity.get(params.id)

      template.profile.properties = params

      // delete old links
      Link.findAllByTargetAndType(template, metaDataService.ltResource).each {
        log.info "link deleted: "+it
        it.delete()}

      // create new links
      if (params.materials) {
        def materials = params.materials
        if (materials.class.isArray()) {
          materials.each {
            new Link(source: Entity.get(it), target: template, type: metaDataService.ltResource).save()
          }
        }
        else {
          new Link(source: Entity.get(materials), target: template, type: metaDataService.ltResource).save()
        }
      }

      if(!template.hasErrors() && template.save()) {
          flash.message = message(code:"template.updated", args:[template.profile.fullName])
          redirect action:'show', id: template.id
      }
      else {
          render view:'edit', model:[template: template, entity: entityHelperService.loggedIn]
      }

    }

    def show = {
      def template = Entity.get(params.id)

      def links = Link.findAllByTargetAndType(template, metaDataService.ltComment)

      def commentList = []
      links.each {
        commentList << it.source
      }

      return ['template': template,
              'commentList': commentList,
              'entity': entityHelperService.loggedIn]
    }

    def create = {
      return ['entity': entityHelperService.loggedIn,
              'resources': Entity.findAllByType(metaDataService.etResource)]
    }

    def save = {

      EntityType etTemplate = metaDataService.etTemplate

      try {
        def entity = entityHelperService.createEntity('template', etTemplate) {Entity ent ->
          ent.profile = profileHelperService.createProfileFor(ent)
          // TODO: find out if this works
          ent.profile.properties = params
          /*ent.profile.fullName = params.fullName
          ent.profile.attribution = params.attribution
          ent.profile.description = params.description
          ent.profile.duration = params.duration ? params.duration.toInteger() : 0
          ent.profile.socialForm = params.socialForm
          ent.profile.requiredEducators = params.requiredEducators.toInteger()
          ent.profile.qualifications = params.qualifications
          ent.profile.ll = params.ll.toInteger()
          ent.profile.be = params.be.toInteger()
          ent.profile.pk = params.pk.toInteger()
          ent.profile.si = params.si.toInteger()
          ent.profile.hk = params.hk.toInteger()
          ent.profile.tlt = params.tlt.toInteger()*/
        }

        // create new links
        if (params.materials) {
          def materials = params.materials
          if (materials.class.isArray()) {
            materials.each {
              log.info Entity.get(it)
              new Link(source: Entity.get(it), target: entity, type: metaDataService.ltResource).save()
            }
          }
          else {
            log.info Entity.get(materials)
            new Link(source: Entity.get(materials), target: entity, type: metaDataService.ltResource).save()
          }
        }

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
      def template = Entity.get(params.id)
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
}