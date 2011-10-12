package at.uenterprise.erp.logbook

import at.openfactory.ep.Entity

class Attendee {

    static hasMany = [processes: ProcessAttended]

    Entity client

  static constraints = {
  }
}
