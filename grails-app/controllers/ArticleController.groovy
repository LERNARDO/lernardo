class ArticleController {
    def articleDataService

    def index = {
        //def today = new Date()
        //def day = today.getDay()

        def res = ['articles': articleDataService.getArticles(),
                   'listTitle': 'Aktuelle Ereignisse'
                    /*'day':day*/]

        render (view:"index", model:res)
    }

    def show = {
        params.id = params.id ?: "1"
        def res = ['article': articleDataService.getArticle(params.id)]
        render (view:"show", model:res)
    }
}
