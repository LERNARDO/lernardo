package at.uenterprise.erp.profiles

import at.openfactory.ep.Profile

/**
 * This class represents the profile of appointments
 *
 * @author  Alexander Zeillinger
 */
class AppointmentProfile extends Profile {

  String  description
  Date    beginDate
  Date    endDate
  Boolean allDay
  Boolean isPrivate

  static constraints = {
    fullName    blank: false, size: 1..100, maxSize: 100
    description blank: true, maxSize: 20000
    endDate     validator: {val, obj ->
                  return val > obj.beginDate
                }
  }

  String toString() {
    return fullName
  }

}
