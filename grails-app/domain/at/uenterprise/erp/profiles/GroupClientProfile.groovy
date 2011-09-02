package at.uenterprise.erp.profiles

import at.openfactory.ep.Profile

/**
 * This class represents a group of clients
 *
 * @author  Alexander Zeillinger
 */
class GroupClientProfile extends Profile {

  String description

  static constraints = {
    fullName    blank: false, size: 1..100, maxSize: 100
    description blank: true, maxSize: 20000
  }

  String toString() {
    return "${fullName}"
  }
  
}
