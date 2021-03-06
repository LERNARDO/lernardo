package at.uenterprise.erp.logbook

import at.uenterprise.erp.base.Entity

/**
 * This class represents a process used in the logbook
 *
 * @author  Alexander Zeillinger
 */
class Process {

  static hasMany = [facilities: Entity,
                    types: String,
                    entities: String]

  String  name
  String  unit
  BigDecimal costs = 0

  static constraints = {
    unit  inList: ['perHour','perDay','perMonth']
  }
}
