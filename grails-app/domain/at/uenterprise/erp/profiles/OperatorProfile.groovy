package at.uenterprise.erp.profiles

import at.openfactory.ep.Profile
import at.uenterprise.erp.ECalendar

/**
 * This class represents the profile of operators
 *
 * @author  Alexander Zeillinger
 */
class OperatorProfile extends Profile {

  List favorites
  static hasMany = [favorites: String]

  ECalendar calendar
  String    zip
  String    city
  String    street
  String    phone
  String    description
  Boolean   showTips = true

  static constraints = {
    fullName    blank: false, size: 1..100, maxSize: 100
    description maxSize: 20000
    city        size: 2..50, maxSize: 50
    street      size: 2..50, maxSize: 50
    calendar    nullable: true
  }

  String toString() {
    return "${fullName}"
  }

}
