package lernardo

import de.uenterprise.ep.Profile

class ResourceProfile extends Profile {

  String description

  static constraints = {
    description (maxSize: 2000)
  }
}
