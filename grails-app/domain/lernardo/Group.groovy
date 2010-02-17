package lernardo

import de.uenterprise.ep.Entity

class Group {

    static hasMany = [members: Entity]

    String name
    String description

    static constraints = {
      description(maxSize:1000)
    }
}
