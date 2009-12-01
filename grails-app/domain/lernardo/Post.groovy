package lernardo

import de.uenterprise.ep.Entity

class Post {

  static belongsTo = [ author: Entity]
  String content

  Date dateCreated
  Date lastUpdated

    static constraints = {
      content(blank: false, maxSize:2000)
      dateCreated(nullable: true)
      lastUpdated(nullable: true)
    }
}
