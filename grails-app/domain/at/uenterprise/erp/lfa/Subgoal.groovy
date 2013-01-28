package at.uenterprise.erp.lfa

class Subgoal {

    List results
    static hasMany = [results: Result]

    static belongsTo = [mainGoal: Maingoal]

    String name
    String description
    String indicator
    String sources
    String assumptions

    static constraints = {
        description nullable: true
        indicator nullable: true
        sources nullable: true
        assumptions nullable: true
    }

    static mapping = {
        description type: "text"
        indicator type: "text"
        sources type: "text"
        assumptions type: "text"
    }

    String toString() {
        return "${name}"
    }

}
