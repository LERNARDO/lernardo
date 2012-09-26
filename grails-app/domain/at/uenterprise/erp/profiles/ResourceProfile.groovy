package at.uenterprise.erp.profiles

import at.uenterprise.erp.base.Profile

/**
 * This class represents (existing) resources
 *
 * @author  Alexander Zeillinger
 */
class ResourceProfile extends Profile {

  String  description
  String  classification
  String  costsUnit
  Integer amount = 1
  Integer costs = 0

  static constraints = {
    description blank: true, maxSize: 20000
  }

  String toString() {
    return "${fullName}"
  }

}
