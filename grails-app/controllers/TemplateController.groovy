import de.uenterprise.ep.Account

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

        if (!template) {
            response.sendError(404, "'$params.id': no such template")
            return ;
        }

        return [template:template,commentList:Post.findAllByTemplate(template)]
    }

    def create = {
      def templateInstance = new ActivityTemplate()
      templateInstance.properties = params
      return ['templateInstance':templateInstance]
    }

    def save = {

      ActivityTemplate at = ActivityTemplate.findByName (params.name)
      if (at) {
        flash.message = "template already exists"
        redirect action:"create", params:params
        return
      }

      def activityInstance = new ActivityTemplate(params)
        if(!activityInstance.hasErrors() && activityInstance.save(flush:true)) {
          flash.message = "aktivitätsvorlage wurde angelegt"
          redirect controller:'template', action:'list'
        }
    }
}