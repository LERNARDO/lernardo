import de.uenterprise.ep.Entity

class Post {

  PostType type

  String title
  String teaser
  String content
  Entity author
  ActivityTemplate template // only used for activity template comments

  Date dateCreated
  Date lastUpdated

    static constraints = {
      title(nullable:true)
      teaser(nullable:true)
      template(nullable: true)
      dateCreated(nullable: true)
      lastUpdated(nullable: true)
    }
}
