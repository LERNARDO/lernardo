package at.uenterprise.erp.profiles

import at.openfactory.ep.Profile

/**
 * This class represents the profile of project units
 *
 * @author  Alexander Zeillinger
 */
class ProjectUnitProfile extends Profile {

  Integer duration = 0
  Date    date

  static constraints = {
    fullName blank: false, size: 1..100, maxSize: 100
  }

  String toString() {
    return "${fullName}"
  }

}
