class PostController {

    def index = {
        return ['articles': Post.list(params),
                'listTitle': 'Aktuelle Ereignisse']
    }

    def show = {
        def postInstance = Post.get( params.id )
        if (postInstance)
          return ['article': postInstance]
        else
          redirect action:index
    }

    def delete = {
        def postInstance = Post.get( params.id )
        if(postInstance) {
            try {
                flash.message = message(code:"article.deleted", args:[postInstance.title])
                postInstance.delete(flush:true)
                redirect(action:"index")
            }
            catch(org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = message(code:"article.notDeleted", args:[postInstance.title])
                redirect(action:"index")
            }
        }
        else {
            flash.message = message(code:"article.notFound", args:[params.id])
            redirect(action:"index")
        }
    }
}
