package at.uenterprise.erp.logbook

import at.openfactory.ep.Entity

/**
 * This class represents an attendee with the processes he has attended
 *
 * @author  Alexander Zeillinger
 */
class Attendee {

    List processes
    static hasMany = [processes: ProcessAttended]

    Entity client

  static constraints = {
  }
}
