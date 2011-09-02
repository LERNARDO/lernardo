package at.uenterprise.erp.profiles

import at.openfactory.ep.Profile
import at.uenterprise.erp.Contact
import at.uenterprise.erp.Building

/**
 * This class represents a colony
 *
 * @author  Alexander Zeillinger
 */
class GroupColonyProfile extends Profile{

  static hasMany = [representatives: Contact,
                    buildings: Building]

  String description

  static constraints = {
    fullName    blank: false, size: 1..100, maxSize: 100
    description blank: true, maxSize: 20000
  }

  String toString() {
    return "${fullName}"
  }

}
