package lernardo

import at.openfactory.ep.Profile

class ThemeProfile extends Profile {
   
    Date startDate
    Date endDate
    String description
    String type

    Date dateCreated

    static constraints = {
      fullName (blank: false, size: 2..50, maxSize: 50)
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
