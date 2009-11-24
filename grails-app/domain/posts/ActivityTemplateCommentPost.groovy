package posts

class ActivityTemplateCommentPost extends Post {

  ActivityTemplate template

    static constraints = {
      template(nullable:true)
    }
}
