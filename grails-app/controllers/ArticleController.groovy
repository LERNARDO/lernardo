package lernardo

class ArticleController {
    def entityHelperService
    def articleHelperService

    def index = {
      def alist = Article.createCriteria().list {
        category {
          name:'news'
        }
        order('lastUpdated', 'desc')
      }

      return ([articles:alist, listTitle:'Aktuelles'])
    }

    def show = {
      if (!params.id)
        redirect (action:'index')

      def article = Article.get(params.id)
      if (!article)
        response.error (404, "article '$params.id' not found")

      return [article:article]
    }

    def edit = {
      def article

      if (params.id)  {
        article = Article.get(params.id)
        if (!article)
          response.error (404, "article '$params.id' not found")
      }

      if (!article)
        redirect (action:'index')

      return [article:article]
    }

    def save = {
      if (!params.id) {
        redirect (action:'index')
      }

      def article = Article.get(params.id)
      if (!article)
        response.error (404, "article '$params.id' not found")

      article.title  = params.title
      article.teaser = params.teaser
      article.content = params.atext

      if (params.preview) {
        article.discard()
        render  (view:'preview', model:[article:article])
      }
      else {
        article.save()
        redirect (action:'index')
      }
    }

    def create = {
      def cur = entityHelperService.loggedIn
      if (!cur)
        redirect (action:'index')

      def newscat = ArticleCategory.findByName ('news')
      def article = new Article(author:cur, category:newscat, title:'neuer artikel', teaser:'eine (kurze) einleitung, die appetit auf mehr macht...',
        content:'der gesamte text in epischer länge (kann aber auch leer bleiben)')

      if (!article.save()) {
        article.errors.each {
          log.error ("error creating article: $it")
        }
      }


      redirect (action:'edit', id:article.id)

//      chain(action:"edit",model:[article:article])

    }

  def delete = {
    def article

    if (params.id)  {
      article = Article.get(params.id)
      if (!article) {
        response.error (404, "article '$params.id' not found")
        return
      }
    }

    if (article)
      article.delete()

    redirect (action:'index')
  }

}
