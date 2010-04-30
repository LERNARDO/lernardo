package profiles

import de.uenterprise.ep.Profile
import lernardo.Contact

class FacilityProfile extends Profile {

    static hasMany = [contacts: Contact]

    String description
    String country // added on 20.04.2010
    String zip // changed on 20.04.2010, before: PLZ
    String city // changed on 20.04.2010, before: city
    String street // changed on 20.04.2010, before: street
    // String tel - removed on 20.04.2010

    Boolean showTips = true

    static constraints = {
      fullName (blank: false, size: 2..50)
      description (blank: true, maxSize: 500)
      country (size: 2..50)
      zip (size: 4..10)
      city (size: 2..50)
      street (size: 2..50)
    }

    String toString(){
      return "${fullName}"
    }
  
}
