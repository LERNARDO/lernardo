package lernardo

import de.uenterprise.ep.Profile

class ProjectDayProfile extends Profile {

    Date date

    static constraints = {
      fullName (blank: false)
    }

    String toString(){
      return "${fullName}"
    }
}
