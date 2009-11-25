import de.uenterprise.ep.Account
import posts.TemplateComment
import de.uenterprise.ep.Entity

class TemplateController {
  def entityHelperService

    def index = { }

    def list = {
        params.offset = params.offset ? params.offset.toInteger(): 0
        params.max = params.max ? params.max.toInteger(): 10

        return ['templateList': ActivityTemplate.list(params),
                'templateCount': ActivityTemplate.count(),
                'entity':entityHelperService.loggedIn]
    }

    def show = {
        def template = ActivityTemplate.get(params.id)
        if (!template)
          template = ActivityTemplate.findByName(params.name)

        if (!template) {
            flash.message = message(code:"template.notFound", args:[params.id])
            return
        }

        return ['template':template,
                'commentList':TemplateComment.findAllByTemplate(template),
                'entity':entityHelperService.loggedIn]
    }

    def create = {
      def templateInstance = new ActivityTemplate()
      templateInstance.properties = params
      return ['templateInstance':templateInstance,'entity':entityHelperService.loggedIn]
    }

    def save = {

      ActivityTemplate at = ActivityTemplate.findByName (params.name)
      if (at) {
        flash.message = message(code:"template.exist", args:[params.name])
        redirect action:"create", params:params
        return
      }

      def activityInstance = new ActivityTemplate(params)
        if(!activityInstance.hasErrors() && activityInstance.save(flush:true)) {
          flash.message = message(code:"template.created", args:[params.name])
          redirect action:'show', id:activityInstance.id
        }
    }
}