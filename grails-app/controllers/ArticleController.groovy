class ArticleController {
    def articleDataService

    def index = {
        //def today = new Date()
        //def day = today.getDay()

        def res = ['articles': Post.list(params),
                   'listTitle': 'Aktuelle Ereignisse'
                    /*'day':day*/]

        render (view:"index", model:res)
    }

    def show = {
        params.id = params.id ?: "1"
        def res = ['article': Post.findById(params.id)]
        render (view:"show", model:res)
    }
}
