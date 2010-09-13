package profiles

import at.openfactory.ep.Profile
import lernardo.Contact

class FacilityProfile extends Profile {

    static hasMany = [contacts: Contact]

    String description
    String country
    String zip
    String city
    String street

    Boolean showTips = true

    static constraints = {
      fullName (blank: false, size: 2..50, maxSize: 50)
      description (blank: true, maxSize: 2000)
      country (size: 2..50)
      zip (size: 4..10)
      city (size: 2..50, maxSize: 50)
      street (size: 2..50, maxSize: 50)
    }

    String toString(){
      return "${fullName}"
    }
  
}
