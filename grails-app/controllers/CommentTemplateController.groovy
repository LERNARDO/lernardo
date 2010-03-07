import de.uenterprise.ep.Entity
import de.uenterprise.ep.EntityType
import de.uenterprise.ep.Link

class CommentTemplateController {
  def entityHelperService
  def functionService
  def metaDataService
  def profileHelperService

  def delete = {
    def comment = Entity.get(params.id)
    if (comment) {
      def links = Link.findAllBySourceOrTarget(comment, comment)
      links.each {it.delete()}
      try {
        flash.message = message(code: "comment.deleted")
        comment.delete(flush: true)
        redirect controller: "template", action: "show", params: [id: params.template]
      }
      catch (org.springframework.dao.DataIntegrityViolationException e) {
        flash.message = message(code: "comment.notDeleted", args: [comment.id])
        redirect controller: "template", action: "show", params: [id: params.template]
      }
    }
    else {
      flash.message = message(code: "comment.notFound", args: [params.id])
      redirect controller: "template", action: "show", params: [id: params.template]
    }
  }

  def create = {
    render template: 'create', model: ['template_id': params.id]
  }

  def save = {
    EntityType etCommentTemplate = metaDataService.etCommentTemplate

    def entity = entityHelperService.createEntity("comment", etCommentTemplate) {Entity ent ->
      ent.profile = profileHelperService.createProfileFor(ent)
      ent.profile.fullName = "comment"
      ent.profile.content = params.content
    }

    new Link(source: entity, target: Entity.get(params.id), type: metaDataService.ltComment).save()
    new Link(source: entityHelperService.loggedIn, target: entity, type: metaDataService.ltCreator).save()

    flash.message = message(code:"comment.created", args:[entity.profile.fullName])

    functionService.createEvent(entityHelperService.loggedIn, 'Du hast die Aktivätsvorlage "'+Entity.get(params.id).profile.fullName+'" kommentiert.')
    List receiver = Entity.findAllByType(metaDataService.etPaed)
    receiver.each {
      if (it != entityHelperService.loggedIn)
        functionService.createEvent(it, entityHelperService.loggedIn.profile.fullName+'hat die Aktivätsvorlage "'+Entity.get(params.id).profile.fullName+'" kommentiert.')
    }

    redirect controller: "template", action: "show", id: params.id
  }

}
