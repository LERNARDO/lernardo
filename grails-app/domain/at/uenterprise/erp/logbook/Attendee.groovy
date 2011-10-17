package at.uenterprise.erp.logbook

import at.openfactory.ep.Entity

class Attendee {

    List processes
    static hasMany = [processes: ProcessAttended]

    Entity client

  static constraints = {
  }
}
