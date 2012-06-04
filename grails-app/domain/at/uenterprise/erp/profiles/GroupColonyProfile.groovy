package at.uenterprise.erp.profiles

import at.uenterprise.erp.base.Profile
import at.uenterprise.erp.Contact
import at.uenterprise.erp.Building

/**
 * This class represents a colony
 *
 * @author  Alexander Zeillinger
 */
class GroupColonyProfile extends Profile{

  List resources
  static hasMany = [representatives: Contact,
                    buildings: Building,
                    resources: String]

  String description
  String zip
  String country

  static constraints = {
    fullName    blank: false, size: 1..100, maxSize: 100
    description blank: true, maxSize: 20000
    zip         nullable: true
    country     nullable: true
  }

  String toString() {
    return "${fullName}"
  }

}
