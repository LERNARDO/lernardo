package at.uenterprise.erp.profiles

import at.uenterprise.erp.base.Profile
import at.uenterprise.erp.ECalendar
import at.uenterprise.erp.Folder

/**
 * This class represents the profile of operators
 *
 * @author  Alexander Zeillinger
 */
class OperatorProfile extends Profile {

  List favorites
  static hasMany = [favorites: String]

  Folder    favoritesFolder
  ECalendar calendar
  String    zip
  String    city
  String    street
  String    phone
  String    description
  Boolean   showTips = true

  static constraints = {
    description maxSize: 20000
    city        size: 2..50, maxSize: 50
    street      size: 2..50, maxSize: 50
    calendar    nullable: true
    favoritesFolder nullable: true
  }

  String toString() {
    return "${fullName}"
  }

}
