import posts.ArticlePost

class ArticlePostController {
  def entityHelperService

  def index = {
    params.offset = params.offset ?: 0
    return ['articleList': ArticlePost.list([max: 10, sort: "dateCreated", order: "desc", offset: params.offset]),
            'listTitle': 'Aktuelle Ereignisse']
  }

  def show = {
    def article = ArticlePost.get(params.id)
    if (article)
      return ['article': article]
    else
      redirect action: index
    return
  }

  def edit = {
    def article = ArticlePost.get(params.id)
    return ['postInstance': article]
  }

  def create = {
    def article = new ArticlePost()
    article.properties = params
    return ['postInstance': article]
  }

  def delete = {
    def article = ArticlePost.get(params.id)
    if (article) {
      try {
        flash.message = message(code: "article.deleted", args: [article.title])
        article.delete(flush: true)
        redirect action: "index"
      }
      catch (org.springframework.dao.DataIntegrityViolationException e) {
        flash.message = message(code: "article.notDeleted", args: [article.title])
        redirect action: "index"
      }
    }
    else {
      flash.message = message(code: "article.notFound", args: [params.id])
      redirect action: "index"
    }
  }

  def save = {
    def article = new ArticlePost(params)
    article.author = entityHelperService.loggedIn
    if (!article.hasErrors() && article.save()) {
      flash.message = message(code: "article.created", args: [article.title])
      redirect action: "index", params: [name: entityHelperService.loggedIn.name]
    }
    else {
      render view:"create", model:[postInstance:article]
    }
  }

  def update = {
    def article = ArticlePost.get(params.id)
    if (article) {
      article.properties = params
      if (!article.hasErrors() && article.save()) {
        flash.message = message(code: "article.updated", args: [article.title])
        redirect action: 'index'
      }
      else {
        render view: 'edit', model: [postInstance: article]
      }
    }
    else {
      flash.message = message(code: "post.notFound", args: [params.id])
      redirect action: 'index'
    }
  }
  
}
