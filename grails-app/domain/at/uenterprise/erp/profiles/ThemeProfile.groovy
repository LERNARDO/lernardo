package at.uenterprise.erp.profiles

import at.openfactory.ep.Profile

/**
 * This class represents the profile of themes
 *
 * @author  Alexander Zeillinger
 */
class ThemeProfile extends Profile {

  String  description
  Date    startDate
  Date    endDate
  Date    dateCreated

  static constraints = {
    fullName    blank: false, size: 1..100, maxSize: 100
    description blank: true, maxSize: 20000
    endDate     validator: {ed, tp ->
                              return ed > tp.startDate
                           }
  }

  String toString() {
    return "${fullName}"
  }

}
