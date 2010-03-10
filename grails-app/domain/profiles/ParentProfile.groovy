package profiles

import de.uenterprise.ep.Profile

class ParentProfile extends Profile {

  String firstName
  String lastName
  Date birthDate
  Integer gender
  Integer PLZ
  String city
  String street
  String nationality
  String familyStatus
  String qualification
  Boolean doesWork
  String work
  String languages
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
