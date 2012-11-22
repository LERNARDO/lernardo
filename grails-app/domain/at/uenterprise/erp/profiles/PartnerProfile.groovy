package at.uenterprise.erp.profiles

import at.uenterprise.erp.base.Profile
import at.uenterprise.erp.Contact
import at.uenterprise.erp.ECalendar
import at.uenterprise.erp.Folder

/**
 * This class represents the profile of partners
 *
 * @author  Alexander Zeillinger
 */
class PartnerProfile extends Profile {

  List favorites
  static hasMany = [contacts: Contact,
                    services: String,
                    favorites: String]

  Folder    favoritesFolder
  ECalendar calendar
  String    description
  String    street
  String    phone
  String    website
  Boolean   showTips = true
  String    country
  String    zip
  String    city

  static constraints = {
    description blank: true, maxSize: 20000
    street      size: 2..50, maxSize: 50
    phone       size: 2..20
    website     blank: true, size: 2..50
    calendar    nullable: true
    favoritesFolder nullable: true
    country     size: 2..50, nullable: true
    zip         size: 4..10, nullable: true
    city        size: 2..50, maxSize: 50, nullable: true
  }

  String toString() {
    return "${fullName}"
  }

}
