package lernardo

import at.openfactory.ep.Profile

class AppointmentProfile extends Profile {

    String description

    Date beginDate
    Date endDate

    Boolean allDay
    Boolean isPrivate

    static constraints = {
      fullName blank: false, size: 1..50, maxSize: 50
      description blank: false
    }

    String toString(){
      return fullName
    }
}
