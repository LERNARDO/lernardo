package posts

class TemplateComment extends Post {

  ActivityTemplate template

    static constraints = {
      template(nullable:true)
    }
}
