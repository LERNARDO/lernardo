package at.uenterprise.erp.logbook

import at.openfactory.ep.Entity

/**
 * This class represents a client with the processes he has paid
 *
 * @author  Alexander Zeillinger
 */
class LogClient {

    static hasMany = [processes: ProcessPaid]

    Entity client

  static constraints = {
  }
}
