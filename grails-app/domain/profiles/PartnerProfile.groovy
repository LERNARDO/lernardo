package profiles

import de.uenterprise.ep.Profile

class PartnerProfile extends Profile {

  Integer PLZ
  String city
  String street
  String tel
  String description

  static constraints = {
    fullName (blank: false)
    PLZ (blank: true)
    description (maxSize: 2000)
  }

  String toString(){
    return "${fullName}"
  }
}
