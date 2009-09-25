class ArticleController {
    def articleDataService

    def index = {
        def res = ['articles': articleDataService.getArticles(),
                   'listTitle': 'Aktuelle Ereignisse']
        render (view:"index", model:res)
    }

    def show = { }
}
