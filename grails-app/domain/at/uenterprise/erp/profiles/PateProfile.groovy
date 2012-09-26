package at.uenterprise.erp.profiles

import at.uenterprise.erp.base.Profile
import at.uenterprise.erp.ECalendar
import at.uenterprise.erp.Folder

/**
 * This class represents the profile of godfathers
 *
 * @author  Alexander Zeillinger
 */
class PateProfile extends Profile {

  List favorites
  static hasMany = [languages: String,
                    favorites: String]

  Folder    favoritesFolder
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
    firstName blank: false, size: 2..50, maxSize: 50
    lastName  blank: false, size: 2..50, maxSize: 50
    zip       size: 4..10
    city      size: 2..50, maxSize: 50
    street    size: 2..50, maxSize: 50
    calendar  nullable: true
    favoritesFolder nullable: true
  }

  String toString() {
    return "${lastName} ${firstName}"
  }

}
