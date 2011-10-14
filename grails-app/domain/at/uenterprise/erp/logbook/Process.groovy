package at.uenterprise.erp.logbook

import at.openfactory.ep.Entity

class Process {

  static hasMany = [facilities: Entity]

  String  name
  Integer costs = 0

  static constraints = {
  }
}
