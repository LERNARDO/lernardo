package at.uenterprise.erp.logbook

import at.openfactory.ep.Entity

class LogClient {

    static hasMany = [processes: ProcessPaid]

    Entity client

  static constraints = {
  }
}
