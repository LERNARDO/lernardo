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
  Boolean showTips = true
  
  static constraints = {
    fullName (blank: true)
    firstName (blank: false)
    lastName (blank: false)
    PLZ (nullable: true)
  }

  String toString(){
    return "${lastName}" + " " + "${firstName}"
  }
}
