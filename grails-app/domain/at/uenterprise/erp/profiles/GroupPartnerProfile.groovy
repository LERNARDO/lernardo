package at.uenterprise.erp.profiles

import at.uenterprise.erp.base.Profile

/**
 * This class represents a group of partners
 *
 * @author  Alexander Zeillinger
 */
class GroupPartnerProfile extends Profile {

  String description
  String service

  static constraints = {
    description blank: true, maxSize: 20000
  }

  String toString() {
    return "${fullName}"
  }
  
}
