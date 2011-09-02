package at.uenterprise.erp

/**
 * This class represents the blog entries that can be created
 * on the public start of the application
 *
 * @author  Alexander Zeillinger
 */
class ArticlePost extends Post {

  String title
  String teaser

  static constraints = {
    title   blank: false, maxSize: 50
    teaser  blank: true, maxSize: 500
  }

}
