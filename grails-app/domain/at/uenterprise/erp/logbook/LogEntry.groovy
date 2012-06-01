package at.uenterprise.erp.logbook

import at.uenterprise.erp.base.Entity

/**
 * This class represents a log entry for a single day of a facility
 *
 * @author  Alexander Zeillinger
 */
class LogEntry {

    List attendees
    static hasMany = [attendees: Attendee]

    Entity facility

    Date    date
    String  comment
    Boolean isChecked = false

    static constraints = {
      comment nullable: true, maxSize:  20000
    }
}
