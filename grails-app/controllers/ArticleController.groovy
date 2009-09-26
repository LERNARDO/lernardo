class ArticleController {
    def articleDataService

    def index = {
        def res = ['articles': articleDataService.getArticles(),
                   'listTitle': 'Aktuelle Ereignisse']
        render (view:"index", model:res)
    }

    def show = {
        params.id = params.id ?: 1
        def res = ['article': articleDataService.getArticle(params.id)]
        render (view:"show", model:res)
    }
}
