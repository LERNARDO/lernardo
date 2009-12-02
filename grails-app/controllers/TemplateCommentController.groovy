import posts.TemplateComment
import lernardo.ActivityTemplate

class TemplateCommentController {
  def entityHelperService

  def delete = {
    def postInstance = TemplateComment.get(params.id)
    if (postInstance) {
      try {
        flash.message = message(code: "comment.deleted")
        postInstance.delete(flush: true)
        redirect controller: "template", action: "show", params: [id: params.template]
      }
      catch (org.springframework.dao.DataIntegrityViolationException e) {
        flash.message = message(code: "comment.notDeleted", args: [postInstance.id])
        redirect controller: "template", action: "show", params: [id: params.template]
      }
    }
    else {
      flash.message = message(code: "comment.notFound", args: [params.id])
      redirect controller: "template", action: "show", params: [id: params.template]
    }
  }

  def create = {
    def postInstance = new TemplateComment()
    postInstance.properties = params
    render template: 'create', model: ['postInstance': postInstance, 'template_id': params.id]
  }

  def save = {
    def postInstance = new TemplateComment(params)
    postInstance.author = entityHelperService.loggedIn
    postInstance.template = ActivityTemplate.get(params.id)
    if (postInstance.save(flush: true)) {
      flash.message = message(code:"comment.created", args:[postInstance.template.name])
      redirect controller: "template", action: "show", id: params.id
    }
    else {
      redirect controller: "template", action: "show", id: params.id
    }
  }
}
