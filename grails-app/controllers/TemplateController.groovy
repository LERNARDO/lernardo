import de.uenterprise.ep.Account
import posts.ActivityTemplateCommentPost

class TemplateController {

    def index = { }

    def list = {
        params.offset = params.offset ? params.offset.toInteger(): 0
        params.max = params.max ? params.max.toInteger(): 10
        return ['templateList': ActivityTemplate.list(params),
                'templateCount': ActivityTemplate.count()]
    }

    def show = {
        def template = ActivityTemplate.get(params.id)
        if (!template)
          template = ActivityTemplate.findByName(params.name)

        if (!template) {
            flash.message = message(code:"template.notFound", args:[params.id])
            return
        }

        return [template:template,commentList:ActivityTemplateCommentPost.findAllByTemplate(template)]
    }

    def create = {
      def templateInstance = new ActivityTemplate()
      templateInstance.properties = params
      return ['templateInstance':templateInstance]
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
          redirect controller:'template', action:'list'
        }
    }
}