package at.uenterprise.erp.profiles

import at.uenterprise.erp.base.Profile
import at.uenterprise.erp.Label

/**
 * This class represents the profile of themes
 *
 * @author  Alexander Zeillinger
 */
class ThemeProfile extends Profile {

  static hasMany = [labels: Label]

  String  description
  Date    startDate
  Date    endDate
  Date    dateCreated

  static constraints = {
    description blank: true, maxSize: 20000
    endDate     validator: {ed, tp ->
                              return ed > tp.startDate
                           }
  }

  String toString() {
    return "${fullName}"
  }

}
