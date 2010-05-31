package lernardo

import at.openfactory.ep.Profile

class ProjectUnitProfile extends Profile {

    Integer duration = 0

    static constraints = {
      fullName (blank: false)
    }

    String toString(){
      return "${fullName}"
    }
}
