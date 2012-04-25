package at.uenterprise.erp.logbook

/**
 * This class represents the log for a month with all clients and their payment status
 *
 * @author  Alexander Zeillinger
 */
class LogMonth {

    List clients
    static hasMany = [clients: LogClient]

    Date date

  static constraints = {
  }
}
