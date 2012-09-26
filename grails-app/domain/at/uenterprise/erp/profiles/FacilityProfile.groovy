package at.uenterprise.erp.profiles

import at.uenterprise.erp.base.Profile
import at.uenterprise.erp.Contact

/**
 * This class represents the profile of facilities
 *
 * @author  Alexander Zeillinger
 */
class FacilityProfile extends Profile {

  List resources
  static hasMany = [contacts: Contact,
                    resources: String]

  String  description
  String  country
  String  zip
  String  city
  String  street
  String  phone
  Boolean showTips = true

  static constraints = {
    description blank: true, maxSize: 20000
    country     size: 2..50
    zip         size: 4..10
    city        size: 2..50, maxSize: 50
    street      size: 2..50, maxSize: 50
    phone       nullable: true
  }

  String toString() {
    return "${fullName}"
  }
  
}
