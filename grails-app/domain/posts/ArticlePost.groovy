package posts

class ArticlePost extends Post {

  String title
  String teaser

    static constraints = {
      title(nullable:true)
      teaser(nullable:true,maxSize:1000)
    }
}
