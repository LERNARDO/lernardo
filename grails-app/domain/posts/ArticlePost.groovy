package posts

import lernardo.Post

class ArticlePost extends Post {

  String title
  String teaser

    static constraints = {
      title(blank:false, maxSize: 50)
      teaser(blank:true, maxSize: 500)
    }
}
