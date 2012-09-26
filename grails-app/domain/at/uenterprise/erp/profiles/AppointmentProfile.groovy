package at.uenterprise.erp.profiles

import at.uenterprise.erp.base.Profile

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
    description blank: true, maxSize: 20000
    endDate     validator: {val, obj ->
                  return val > obj.beginDate
                }
  }

  String toString() {
    return fullName
  }

}
