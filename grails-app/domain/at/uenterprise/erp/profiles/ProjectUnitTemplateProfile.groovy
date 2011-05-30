package at.uenterprise.erp.profiles

import at.openfactory.ep.Profile

class ProjectUnitTemplateProfile extends Profile {

    Integer duration = 0

    static constraints = {
      fullName (blank: false, size: 1..100, maxSize: 100)
    }

    String toString(){
      return "${fullName}"
    }
}
