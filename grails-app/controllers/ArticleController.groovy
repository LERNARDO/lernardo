class ArticleController {
    def articleDataService

    def index = {
        def res = ['articles': articleDataService.getArticles(),
                   'listTitle': 'Aktuelle Ereignisse']
        render (view:"index", model:res)
    }

    def show = {
        def res = ['article': articleDataService.getArticle(params.id)]
        render (view:"show", model:res)
    }
}
