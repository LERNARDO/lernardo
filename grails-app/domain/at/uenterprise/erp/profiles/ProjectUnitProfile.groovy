package at.uenterprise.erp.profiles

import at.openfactory.ep.Profile

class ProjectUnitProfile extends Profile {

    Integer duration = 0
    Date date

    static constraints = {
      fullName (blank: false)
    }

    String toString(){
      return "${fullName}"
    }
}
