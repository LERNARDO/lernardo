package lernardo

import de.uenterprise.ep.Profile

class ProjectTemplateProfile extends Profile {

    String description
    String status

    static constraints = {
      fullName (blank: false)
      description (blank: true, maxSize: 2000)
    }

    String toString(){
      return "${fullName}"
    }
}
