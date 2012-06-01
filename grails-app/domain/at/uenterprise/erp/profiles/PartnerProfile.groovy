package at.uenterprise.erp.profiles

import at.uenterprise.erp.base.Profile
import at.uenterprise.erp.Contact
import at.uenterprise.erp.ECalendar

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

  ECalendar calendar
  String    description
  //String    country
  //String    zip
  //String    city
  String    street
  String    phone
  String    website
  Boolean   showTips = true

  static constraints = {
    fullName    blank: false, size: 1..100, maxSize: 100
    description blank: true, maxSize: 20000
    //zip         size: 4..10
    //city        size: 2..50, maxSize: 50
    street      size: 2..50, maxSize: 50
    phone       size: 2..20
    website     blank: true, size: 2..50
    calendar    nullable: true
  }

  String toString() {
    return "${fullName}"
  }

}
