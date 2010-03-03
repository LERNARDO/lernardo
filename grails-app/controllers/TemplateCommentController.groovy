import posts.TemplateComment
import lernardo.ActivityTemplate
import de.uenterprise.ep.Entity

class TemplateCommentController {
  def entityHelperService
  def functionService
  def metaDataService

  def delete = {
    def comment = TemplateComment.get(params.id)
    if (comment) {
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
    def comment = new TemplateComment()
    comment.properties = params
    render template: 'create', model: ['postInstance': comment, 'template_id': params.id]
  }

  def save = {
    def comment = new TemplateComment(params)
    comment.author = entityHelperService.loggedIn
    comment.template = ActivityTemplate.get(params.id)
    if (comment.save(flush: true)) {
      flash.message = message(code:"comment.created", args:[comment.template.name])

      functionService.createEvent(postInstance.author, 'Du hast die Aktivätsvorlage "'+comment.template.name+'" kommentiert.')
      List receiver = Entity.findAllByType(metaDataService.etPaed)
      receiver.each {
        if (it != comment.author)
          functionService.createEvent(it, comment.author.profile.fullName+'hat die Aktivätsvorlage "'+comment.template.name+'" kommentiert.')
      }

      redirect controller: "template", action: "show", id: params.id
    }
    else {
      redirect controller: "template", action: "show", id: params.id
    }
  }
}
