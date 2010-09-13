package profiles

import at.openfactory.ep.Profile

class PateProfile extends Profile {

  static hasMany = [languages: String]

  String firstName
  String lastName

  String country
  String zip
  String city
  String street

  String motherTongue
  Integer emails = 0

  Boolean showTips = true
  
  static constraints = {
    fullName (blank: true)
    firstName (blank: false, size: 2..50, maxSize: 50)
    lastName (blank: false, size: 2..50, maxSize: 50)
    zip (size: 4..10)
    city (size: 2..50, maxSize: 50)
    street (size: 2..50, maxSize: 50)
  }

  String toString(){
    return "${lastName}" + " " + "${firstName}"
  }
}
