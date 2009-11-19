import de.uenterprise.ep.Entity

class PostController {
    def entityHelperService

    def index = {
        params.offset = params.offset ?: 0
        return ['articleList': Post.findAllByType(PostType.findByName('article'),[max:10, sort:"dateCreated", order:"desc", offset:params.offset]),
                'listTitle': 'Aktuelle Ereignisse']
    }

    def show = {
        def postInstance = Post.get( params.id )
        if (postInstance)
          return ['article': postInstance]
        else
          redirect action:index
    }

    def createArticlePost = {
      def postInstance = new Post()
      postInstance.properties = params
      Entity e = Entity.findByName(params.name)
      render template:'createArticlePost', model:['postInstance':postInstance, entity:e ]
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

    def createtemplatecomment = {
        def postInstance = new Post()
        postInstance.properties = params
        render(template:'createtemplatecomment', model:['postInstance':postInstance,'template_id':params.id])
    }

    def save = {
        def postInstance = new Post(params)
        postInstance.author = entityHelperService.loggedIn
        postInstance.template = ActivityTemplate.get(params.id)
        postInstance.type = PostType.findByName('templateComment')
        //def name = postInstance.name
        if(postInstance.save(flush:true)) {
            //flash.message = message(code:"event.created", args:[name])
            redirect controller:"template", action:"show", id:params.id
        }
        else {
            redirect controller:"template", action:"show", id:params.id
        }
    }

    def saveArticle = {
        def postInstance = new Post(params)
        postInstance.author = entityHelperService.loggedIn
        postInstance.type = PostType.findByName('article')
        //def name = postInstance.name
        if(postInstance.save(flush:true)) {
            //flash.message = message(code:"event.created", args:[name])
            redirect controller:"profile", action:"show", params:[name:entityHelperService.loggedIn.name]
        }
        else {
            redirect controller:"profile", action:"show", params:[name:entityHelperService.loggedIn.name]
        }
    }
}
