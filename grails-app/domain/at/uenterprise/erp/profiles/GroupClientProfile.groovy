package at.uenterprise.erp.profiles

import at.uenterprise.erp.base.Profile

/**
 * This class represents a group of clients
 *
 * @author  Alexander Zeillinger
 */
class GroupClientProfile extends Profile {

  String description

  static constraints = {
    description blank: true, maxSize: 20000
  }

  String toString() {
    return "${fullName}"
  }
  
}
