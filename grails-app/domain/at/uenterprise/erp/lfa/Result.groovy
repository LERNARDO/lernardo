package at.uenterprise.erp.lfa

class Result {

    //List actions
    //static hasMany = [actions: Action]

    static belongsTo = [subgoal: Subgoal]

    String description
    String indicator
    String sources
    String assumptions

    static constraints = {
        indicator nullable: true
        sources nullable: true
        assumptions nullable: true
    }

    static mapping = {
        indicator type: "text"
        sources type: "text"
        assumptions type: "text"
    }
}
