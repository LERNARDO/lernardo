package at.uenterprise.erp

import at.openfactory.ep.Entity

class Attendance {

    Entity client
    Boolean didAttend
    Boolean didEat
    Date date

    static constraints = {
    }
}
