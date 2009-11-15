import de.uenterprise.ep.Entity

class Post {

  PostType type

  String title
  String teaser
  String content
  Entity author

  Date dateCreated
  Date lastUpdated

    static constraints = {
    }
}
