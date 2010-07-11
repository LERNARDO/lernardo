package profiles

import at.openfactory.ep.Profile

class OperatorProfile extends Profile {

    String zip // changed on 04.05.2010, before: PLZ
    String city
    String street
    String phone // changed on 04.05.2010, before: tel
    String description
    Boolean showTips = true

    static constraints = {
      fullName (blank: false, maxSize: 50)
      description (maxSize: 2000)
      city (size: 2..50, maxSize: 50)
      street (size: 2..50, maxSize: 50)
    }

    String toString(){
      return "${fullName}"
    }
}
