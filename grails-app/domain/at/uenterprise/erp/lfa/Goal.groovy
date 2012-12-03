package at.uenterprise.erp.lfa

class Goal {

    static hasMany = [situations: Situation]
    String type
    String description
    Date dateFrom
    Date dateTo

    static constraints = {
        type inList: ["main", "sub"]
    }
}
