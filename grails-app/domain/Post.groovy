import de.uenterprise.ep.Entity

class Post {

  PostType type

  String title
  String teaser
  String content
  Entity author
  ActivityTemplate template // only used for activity template comments
  Post post

  Date dateCreated
  Date lastUpdated

    static constraints = {
      title(nullable:true)
      teaser(nullable:true,maxSize:1000)
      content(maxSize:2000)
      template(nullable: true)
      post(nullable:true)
      dateCreated(nullable: true)
      lastUpdated(nullable: true)
    }
}
