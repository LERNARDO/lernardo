package at.uenterprise.erp.profiles

import at.uenterprise.erp.base.Profile

/**
 * This class represents the profile of project days which are part of projects
 *
 * @author  Alexander Zeillinger
 */
class ProjectDayProfile extends Profile {

  List units
  static hasMany = [units: String]
  Boolean complete = false

  Date date

  static constraints = {
    fullName blank: false, size: 1..100, maxSize: 100
  }

  String toString() {
    return "${fullName}"
  }

}
