package profiles

import de.uenterprise.ep.Profile

class PateProfile extends Profile {

  String firstName
  String lastName
  //String[] languages // changed on 23.04.2010, before: string languages  
  static hasMany = [languages: String]

  //String nationality - removed on 23.04.2010
  String country // added on 23.04.2010
  String zip // changed on 23.04.2010, before: PLZ
  String city
  String street

  String motherTongue // added on 23.04.2010 
  Integer emails = 0

  Boolean showTips = true
  
  static constraints = {
    fullName (blank: true)
    firstName (blank: false, size: 2..50)
    lastName (blank: false, size: 2..50)
    country (size: 2..50)
    zip (size: 4..10)
    city (size: 2..50)
    street (size: 2..50)
  }

  String toString(){
    return "${lastName}" + " " + "${firstName}"
  }
}
