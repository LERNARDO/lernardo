package profiles

import de.uenterprise.ep.Profile

class PartnerProfile extends Profile {

  Integer PLZ
  String city
  String street
  String tel
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
