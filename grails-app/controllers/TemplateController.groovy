class TemplateController {

    def index = { }

    def list = {
        params.offset = params.offset ? params.offset.toInteger(): 0
        params.max = params.max ? params.max.toInteger(): 10
        return ['templateList': ActivityTemplate.list(params),
                'templateCount': ActivityTemplate.count()]
    }

    def show = {
        def template = ActivityTemplate.findById(params.id)

        if (!template) {
            response.sendError(404, "'$params.id': no such template")
            return ;
        }

        return [template:template]
    }
}