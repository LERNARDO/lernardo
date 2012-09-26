package at.uenterprise.erp.profiles

import at.uenterprise.erp.base.Profile

/**
 * This class represents the profile of project unit templates
 *
 * @author  Alexander Zeillinger
 */
class ProjectUnitTemplateProfile extends Profile {

  Integer duration = 0

  static constraints = {
  }

  String toString() {
    return "${fullName}"
  }

}
