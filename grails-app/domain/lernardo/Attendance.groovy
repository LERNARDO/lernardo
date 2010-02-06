package lernardo

import de.uenterprise.ep.Entity

class Attendance {

    static hasMany = [clients: Entity]

    Boolean[] didAttend
    Boolean[] didEat
    Date date

    static constraints = {
    }
}
