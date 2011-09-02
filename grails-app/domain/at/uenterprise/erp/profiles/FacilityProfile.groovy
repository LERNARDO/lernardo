package at.uenterprise.erp.profiles

import at.openfactory.ep.Profile
import at.uenterprise.erp.Contact

/**
 * This class represents the profile of facilities
 *
 * @author  Alexander Zeillinger
 */
class FacilityProfile extends Profile {

  static hasMany = [contacts: Contact]

  String  description
  String  country
  String  zip
  String  city
  String  street
  Boolean showTips = true

  static constraints = {
    fullName    blank: false, size: 1..100, maxSize: 100
    description blank: true, maxSize: 20000
    country     size: 2..50
    zip         size: 4..10
    city        size: 2..50, maxSize: 50
    street      size: 2..50, maxSize: 50
  }

  String toString() {
    return "${fullName}"
  }
  
}
