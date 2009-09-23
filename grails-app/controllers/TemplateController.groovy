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
}
