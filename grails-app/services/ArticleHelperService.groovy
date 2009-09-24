import lernardo.Article
import de.uenterprise.ep.ubase.util.ParserTools

class ArticleHelperService {

    boolean transactional = false

    def extractTeaser (Article article) {
      if (!article?.content)
        return null

      def html = ParserTools.getHtmlSlurper().parseText(article.content)

      // extract first paragraph
      def text = html.BODY.P[0]

      return text?.toString()
    }
}
