package at.uenterprise.erp.profiles

import at.openfactory.ep.Profile
import at.uenterprise.erp.ECalendar

/**
 * This class represents the profile of godfathers
 *
 * @author  Alexander Zeillinger
 */
class PateProfile extends Profile {

  List favorites
  static hasMany = [languages: String,
                    favorites: String]

  String    color
  ECalendar calendar
  String    firstName
  String    lastName
  String    country
  String    zip
  String    city
  String    street
  String    motherTongue
  Integer   emails = 0
  Boolean   showTips = true
  
  static constraints = {
    fullName  blank: true, size: 1..100, maxSize: 100
    firstName blank: false, size: 2..50, maxSize: 50
    lastName  blank: false, size: 2..50, maxSize: 50
    zip       size: 4..10
    city      size: 2..50, maxSize: 50
    street    size: 2..50, maxSize: 50
    color     nullable: true
  }

  String toString() {
    return "${lastName} ${firstName}"
  }

}
