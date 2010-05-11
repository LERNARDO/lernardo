import de.uenterprise.ep.Entity
import de.uenterprise.ep.EntityType
import de.uenterprise.ep.Link
import de.uenterprise.ep.EntityHelperService
import de.uenterprise.ep.ProfileHelperService
import standard.MetaDataService
import standard.FunctionService

class CommentTemplateController {
  EntityHelperService entityHelperService
  FunctionService functionService
  MetaDataService metaDataService
  ProfileHelperService profileHelperService

  def delete = {
    Entity comment = Entity.get(params.id)
    if (comment) {
      Link.findAllBySourceOrTarget(comment, comment).each {it.delete()}
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
    Entity template = Entity.get(params.id)
    EntityType etCommentTemplate = metaDataService.etCommentTemplate

    Entity entity = entityHelperService.createEntity("comment", etCommentTemplate) {Entity ent ->
      ent.profile = profileHelperService.createProfileFor(ent)
      ent.profile.fullName = "comment"
      ent.profile.content = params.content
    }

    new Link(source: entity, target: template, type: metaDataService.ltComment).save()
    new Link(source: entityHelperService.loggedIn, target: entity, type: metaDataService.ltCreator).save()

    flash.message = message(code:"comment.created", args:[template.profile.fullName])

    functionService.createEvent(entityHelperService.loggedIn, 'Du hast die Aktivitätsvorlage "'+template.profile.fullName+'" kommentiert.')
    List receiver = Entity.findAllByType(metaDataService.etEducator)
    receiver.each {
      if (it != entityHelperService.loggedIn)
        functionService.createEvent(it, entityHelperService.loggedIn.profile.fullName+'hat die Aktivitätsvorlage "'+template.profile.fullName+'" kommentiert.')
    }

    redirect controller: "template", action: "show", id: params.id
  }

}
