package profiles

import de.uenterprise.ep.Profile

class PateProfile extends Profile {

  String firstName
  String lastName
  Integer PLZ
  String city
  String street
  String nationality
  String languages
  Integer emails = 0

  static constraints = {
    fullName (blank: true)
    firstName (blank: false)
    lastName (blank: false)
    PLZ (blank: true)
  }

  String toString(){
    return "${fullName}"
  }
}
