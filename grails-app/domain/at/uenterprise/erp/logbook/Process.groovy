package at.uenterprise.erp.logbook

import at.openfactory.ep.Entity

class Process {

  static hasMany = [facilities: Entity,
                    types: String,
                    entities: String]

  String  name
  String  unit
  Integer costs = 0

  static constraints = {
    unit nullable: true, inList: ['perDay','perMonth']
  }
}
