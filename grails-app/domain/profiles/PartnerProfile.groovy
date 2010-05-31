package profiles

import at.openfactory.ep.Profile
import lernardo.Contact

class PartnerProfile extends Profile {

    static hasMany = [contacts: Contact,
                      services: String]

    String description
    String country // added on 23.04.2010
    String zip // changed on 23.04.2010, before: PLZ
    String city
    String street
    String phone // changed on 23.04.2010, before: tel
    //String email // added on 23.04.2010
    String website // added on 23.04.2010

    Boolean showTips = true

    static constraints = {
      fullName (blank: false, size: 2..50)
      description (blank: true, maxSize: 500)
      zip (size: 4..10)
      city (size: 2..50)
      street (size: 2..50)
      phone (size: 2..20)
      //email (size: 2..20)
      website (blank: true, size: 2..50)
    }

    String toString(){
      return "${fullName}"
    }

}
