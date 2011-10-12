package at.uenterprise.erp.logbook

class LogMonth {

    static hasMany = [clients: LogClient]

    Date date

  static constraints = {
  }
}
