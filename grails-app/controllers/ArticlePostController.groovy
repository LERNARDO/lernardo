import posts.ArticlePost
import de.uenterprise.ep.Entity

class ArticlePostController {
  def entityHelperService

  def index = {
    params.offset = params.offset ?: 0
    return ['articleList': ArticlePost.list([max: 10, sort: "dateCreated", order: "desc", offset: params.offset]),
            'listTitle': 'Aktuelle Ereignisse']
  }

  def show = {
    def postInstance = ArticlePost.get(params.id)
    if (postInstance)
      return ['article': postInstance]
    else
      redirect action: index
    return
  }

  def preview = {
    def postInstance = ArticlePost.get(params.id)
    return ['postInstance':postInstance]
  }

  def edit = {
    def postInstance = ArticlePost.get(params.id)
    return ['postInstance': postInstance]
  }

  def create = {
    def postInstance = new ArticlePost()
    postInstance.properties = params
    return ['postInstance': postInstance]
  }

  def delete = {
    def postInstance = ArticlePost.get(params.id)
    if (postInstance) {
      try {
        flash.message = message(code: "article.deleted", args: [postInstance.title])
        postInstance.delete(flush: true)
        redirect(action: "index")
      }
      catch (org.springframework.dao.DataIntegrityViolationException e) {
        flash.message = message(code: "article.notDeleted", args: [postInstance.title])
        redirect(action: "index")
      }
    }
    else {
      flash.message = message(code: "article.notFound", args: [params.id])
      redirect(action: "index")
    }
  }

  def save = {
    def postInstance = new ArticlePost(params)
    postInstance.author = entityHelperService.loggedIn
    if (postInstance.save(flush: true)) {
      flash.message = message(code: "article.created", args: [postInstance.title])
      redirect action: "index", params: [name: entityHelperService.loggedIn.name]
    }
    else {
      redirect action: "index", params: [name: entityHelperService.loggedIn.name]
    }
  }

  def update = {
    def postInstance = ArticlePost.get(params.id)
    if (postInstance) {
      if (params.version) {
        def version = params.version.toLong()
        if (postInstance.version > version) {

          postInstance.errors.rejectValue("version", "post.optimistic.locking.failure", "Another user has updated this Post while you were editing.")

          redirect action: 'index'
          return
        }
      }
      postInstance.properties = params
      if (!postInstance.hasErrors() && postInstance.save()) {
        flash.message = message(code: "article.updated", args: [postInstance.title])

        redirect action: 'index'
      }
      else {
        render view: 'edit', model: [postInstance: postInstance]
      }
    }
    else {
      flash.message = message(code: "post.notFound", args: [params.id])
      redirect action: 'index'
    }
  }
  
}
