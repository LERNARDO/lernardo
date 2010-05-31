package lernardo

import at.openfactory.ep.Entity

class Post {

  static belongsTo = [ author: Entity]
  String content

  Date dateCreated
  Date lastUpdated

    static constraints = {
      content(blank: false, maxSize:20000)
      dateCreated(nullable: true)
      lastUpdated(nullable: true)
    }
}
