package at.uenterprise.erp

import at.openfactory.ep.Entity

class Dayroutine {

    String day
    Date dateFrom
    Date dateTo

    String title
    String description
    static belongsTo = [facility: Entity]

    static constraints = {
      title (blank: false)
    }
}
