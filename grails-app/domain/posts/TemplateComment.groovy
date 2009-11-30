package posts

import lernardo.Post
import lernardo.ActivityTemplate

class TemplateComment extends Post {

  ActivityTemplate template

    static constraints = {
      template(nullable:true)
    }
}
