package lernardo

import de.uenterprise.ep.Entity

class Event {

    static belongsTo = [entity:Entity]

    String content
    Date date

    Date dateCreated
    Date lastUpdated

    static constraints = {
    }
}
