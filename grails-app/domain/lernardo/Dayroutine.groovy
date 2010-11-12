package lernardo

import at.openfactory.ep.Entity

class Dayroutine {

    String day
    Date dateFrom
    Date dateTo

    String title
    String description
    static belongsTo = [facility: Entity] //Entity facility

    static constraints = {
      title (blank: false)
    }
}
