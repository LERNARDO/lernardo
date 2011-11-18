package at.uenterprise.erp.profiles

import at.openfactory.ep.Profile
import at.uenterprise.erp.ECalendar

/**
 * This class represents the profile of users
 *
 * @author  Alexander Zeillinger
 */
class UserProfile extends Profile {

  List favorites
  static hasMany = [favorites: String]

  String    color
  ECalendar calendar
  String    firstName
  String    lastName
  Boolean   showTips = true

  static constraints = {
    fullName  blank: true, size: 1..100, maxSize: 100
    firstName blank: false, maxSize: 50
    lastName  blank: false, maxSize: 50
    color     nullable: true
  }

  String toString() {
    return "${lastName} ${firstName}"
  }

}
