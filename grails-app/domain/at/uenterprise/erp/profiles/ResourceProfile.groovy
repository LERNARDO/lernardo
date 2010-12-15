package at.uenterprise.erp.profiles

import at.openfactory.ep.Profile

class ResourceProfile extends Profile {

  String description
  String classification

  static constraints = {
    fullName (blank: false, size: 2..50, maxSize: 50)
    description (blank: true, maxSize: 5000)
  }

  String toString(){
    return "${fullName}"
  }

}
