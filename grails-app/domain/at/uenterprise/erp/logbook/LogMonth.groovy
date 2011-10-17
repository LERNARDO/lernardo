package at.uenterprise.erp.logbook

class LogMonth {

    List clients
    static hasMany = [clients: LogClient]

    Date date

  static constraints = {
  }
}
