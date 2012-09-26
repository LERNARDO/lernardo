package at.uenterprise.erp.profiles

import at.uenterprise.erp.base.Profile

/**
 * This class represents the profile of project units
 *
 * @author  Alexander Zeillinger
 */
class ProjectUnitProfile extends Profile {

  Integer duration = 0
  Date    date

  static constraints = {
  }

  String toString() {
    return "${fullName}"
  }

}
