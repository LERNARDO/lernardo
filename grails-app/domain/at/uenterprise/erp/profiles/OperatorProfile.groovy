package at.uenterprise.erp.profiles

import at.openfactory.ep.Profile
import at.uenterprise.erp.ECalendar

class OperatorProfile extends Profile {

    ECalendar calendar
    String zip
    String city
    String street
    String phone
    String description
    Boolean showTips = true

    static constraints = {
      fullName (blank: false, maxSize: 50)
      description (maxSize: 5000)
      city (size: 2..50, maxSize: 50)
      street (size: 2..50, maxSize: 50)
    }

    String toString(){
      return "${fullName}"
    }
}
