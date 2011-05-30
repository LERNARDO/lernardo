package at.uenterprise.erp.profiles

import at.openfactory.ep.Profile

class ThemeProfile extends Profile {

    Date startDate
    Date endDate
    String description

    Date dateCreated

    static constraints = {
      fullName (blank: false, size: 1..100, maxSize: 100)
      description (blank: true, maxSize: 5000)
      startDate(nullable: false)
      endDate(nullable: false, validator: {ed, tp ->
        return ed > tp.startDate
      })
    }

    String toString(){
      return "${fullName}"
    }
}
