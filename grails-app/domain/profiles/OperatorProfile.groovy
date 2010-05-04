package profiles

import de.uenterprise.ep.Profile

class OperatorProfile extends Profile {

    String zip // changed on 04.05.2010, before: PLZ
    String city
    String street
    String phone // changed on 04.05.2010, before: tel
    String description
    Boolean showTips = true

    static constraints = {
      fullName (blank: false)
      description (maxSize: 2000)
    }

    String toString(){
      return "${fullName}"
    }
}
