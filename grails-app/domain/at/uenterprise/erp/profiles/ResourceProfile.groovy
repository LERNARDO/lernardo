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
    fullName    blank: false, size: 1..100, maxSize: 100
    description blank: true, maxSize: 20000
  }

  String toString() {
    return "${fullName}"
  }

}
