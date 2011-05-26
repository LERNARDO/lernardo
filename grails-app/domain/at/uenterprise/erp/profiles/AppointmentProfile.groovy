package at.uenterprise.erp.profiles

import at.openfactory.ep.Profile

class AppointmentProfile extends Profile {

    String description

    Date beginDate
    Date endDate

    Boolean allDay
    Boolean isPrivate

    static constraints = {
      fullName blank: false, size: 1..100, maxSize: 100
      description (blank: true, maxSize: 5000)
    }

    String toString(){
      return fullName
    }
}
