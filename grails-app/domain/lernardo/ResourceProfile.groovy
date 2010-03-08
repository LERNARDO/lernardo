package lernardo

import de.uenterprise.ep.Profile

class ResourceProfile extends Profile {

  String description

  static constraints = {
    fullName (blank: false)
    description (blank: false, maxSize: 2000)
  }

  String toString(){
    return "${fullName}"
  }

}
