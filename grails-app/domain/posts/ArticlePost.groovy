package posts

import lernardo.Post

class ArticlePost extends Post {

  String title
  String teaser

    static constraints = {
      teaser(nullable:true,maxSize:1000)
    }
}
