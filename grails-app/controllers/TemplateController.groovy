class TemplateController {
    def templateDataService

    def index = { }

    def list = {
        params.offset = params.offset ? params.offset.toInteger(): 0
        params.max = params.max ? params.max.toInteger(): 10
        def res = ['templateList': templateDataService.getTemplates (params.offset, params.max),
                   'templateCount': templateDataService.getTemplateCount ()]
        render (view:"list", model:res)
    }

    def show = {
        def template = templateDataService.findById(params.id)

        if (!template) {
            response.sendError(404, "'$params.id': no such template")
            return ;
        }

        return [template:template]
    }
}
