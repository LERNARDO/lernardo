package profiles

import de.uenterprise.ep.Profile

class PartnerProfile extends Profile {

  Integer PLZ
  String city
  String street
  String tel
  String description

  static constraints = {
    description (maxSize: 2000)
  }

  String toString(){
    return "${fullName}"
  }
}
