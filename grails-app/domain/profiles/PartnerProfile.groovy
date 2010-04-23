package profiles

import de.uenterprise.ep.Profile

class PartnerProfile extends Profile {

    String description
    String[] services // // added on 23.04.2010

    String country // added on 23.04.2010
    String zip // changed on 23.04.2010, before: PLZ
    String city
    String street
    String phone // changed on 23.04.2010, before: tel
    String email // added on 23.04.2010
    String website // added on 23.04.2010

    String[] representativeFirstName // added on 23.04.2010
    String[] representativeLastName // added on 23.04.2010
    String[] representativeCountry // added on 23.04.2010
    String[] representativeZip // added on 23.04.2010
    String[] representativeCity // added on 23.04.2010
    String[] representativeStreet // added on 23.04.2010
    String[] representativePhone // added on 23.04.2010
    String[] representativeEmail // added on 23.04.2010
    String[] representativeFunction // added on 23.04.2010
  
    Boolean showTips = true

    static constraints = {
      fullName (blank: false, size: 2..50)
      description (blank: true, maxSize: 500)
      country (size: 2..50)
      zip (size: 4..10)
      city (size: 2..50)
      street (size: 2..50)
      phone (size: 2..20)
      email (size: 2..20)
      website (size: 2..50)
    }

    String toString(){
      return "${fullName}"
    }

}
