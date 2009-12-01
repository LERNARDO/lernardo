package posts

import lernardo.Post

class ArticlePost extends Post {

  String title
  String teaser

    static constraints = {
      title(blank:false)
      teaser(blank:true,maxSize:1000)
    }
}
