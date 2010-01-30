package lernardo

import de.uenterprise.ep.Entity

class Evaluation {

    static belongsTo = [owner:Entity]

    String description
    String method
    Entity writer

    Date  dateCreated
    Date  lastUpdated

    static constraints = {
      description(blank: false)
      method(blank: false, maxSize: 2000)
      writer(nullable: false)
    }
}
