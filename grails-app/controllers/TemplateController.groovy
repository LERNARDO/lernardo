import posts.TemplateComment

import de.uenterprise.ep.Entity
import de.uenterprise.ep.EntityType

class TemplateController {
  def entityHelperService
  def functionService
  def metaDataService
  def profileHelperService

    def index = {
      redirect action:'list', params:params
    }

    def list = {
      params.offset = params.offset ? params.offset.toInteger(): 0
      params.max = params.max ? params.max.toInteger(): 15

      return ['templateList': Entity.findAllByType(metaDataService.etTemplate),
              'templateCount': Entity.countByType(metaDataService.etTemplate),
              'entity': entityHelperService.loggedIn]
    }

    def edit = {
      def template = Entity.get(params.id)

      return ['template': template,
              'entity': entityHelperService.loggedIn]
    }

    def update = {
      // TODO: figure out why updating doesn't seem to work
      def template = Entity.get(params.id)

      //template.properties = params
      template.profile.fullName = params.name
      template.profile.attribution = params.attribution
      template.profile.description = params.description
      template.profile.duration = params.duration.toInteger()
      template.profile.socialForm = params.socialForm
      template.profile.requiredPaeds = params.requiredPaeds.toInteger()
      template.profile.qualifications = params.qualifications
      template.profile.ll = params.ll.toInteger()
      template.profile.be = params.be.toInteger()
      template.profile.pk = params.pk.toInteger()
      template.profile.si = params.si.toInteger()
      template.profile.hk = params.hk.toInteger()
      template.profile.tlt = params.tlt.toInteger()

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

      return ['template': template,
              'commentList': TemplateComment.findAllByEntity(template),
              'entity': entityHelperService.loggedIn]
    }

    def create = {
      return ['entity': entityHelperService.loggedIn]
    }

    def save = {

      if (Entity.findByName(params.name)) {
        flash.message = message(code:"template.exist", args:[params.name])
        redirect action:"create", params:params
        return
      }

      EntityType etTemplate = metaDataService.etTemplate

      try {
        def entity = entityHelperService.createEntity(params.name, etTemplate) {Entity ent ->
          ent.profile = profileHelperService.createProfileFor(ent)
          ent.profile.fullName = params.name
          ent.profile.attribution = params.attribution
          ent.profile.description = params.description
          ent.profile.duration = params.duration.toInteger()
          ent.profile.socialForm = params.socialForm
          ent.profile.requiredPaeds = params.requiredPaeds.toInteger()
          ent.profile.qualifications = params.qualifications
          ent.profile.ll = params.ll.toInteger()
          ent.profile.be = params.be.toInteger()
          ent.profile.pk = params.pk.toInteger()
          ent.profile.si = params.si.toInteger()
          ent.profile.hk = params.hk.toInteger()
          ent.profile.tlt = params.tlt.toInteger()
        }
      } catch (de.uenterprise.ep.EntityException ee) {
        render (view:"create", model:[template:ee.entity, entity: entityHelperService.loggedIn])
        return
      }

      flash.message = message(code:"template.created", args:[params.name])

      functionService.createEvent(entityHelperService.loggedIn, 'Du hast die Aktivätsvorlage "'+entity.profile.fullName+'" angelegt.')
      List receiver = Entity.findAllByType(metaDataService.etPaed)
      receiver.each {
        if (it != entityHelperService.loggedIn)
          functionService.createEvent(it, 'Es wurde die Aktivitätsvorlage "'+entity.profile.fullName+'" angelegt.')
      }

      redirect action:'show', id:entity.id
    }

    def del = {
      def template = Entity.get(params.id)
      if(template) {
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