package at.uenterprise.erp.profiles

import at.openfactory.ep.Profile

class ResourceProfile extends Profile {

  String description
  String classification

  static constraints = {
    fullName (blank: false, size: 1..100, maxSize: 100)
    description (blank: true, maxSize: 20000)
  }

  String toString(){
    return "${fullName}"
  }

}
