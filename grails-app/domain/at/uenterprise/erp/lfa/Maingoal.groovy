package at.uenterprise.erp.lfa

class Maingoal {

    List subGoals
    static hasMany = [subGoals: Subgoal]

    String name
    String description
    String indicator
    String sources

    static constraints = {
        description nullable: true
        indicator nullable: true
        sources nullable: true
    }

    static mapping = {
        description type: "text"
        indicator type: "text"
        sources type: "text"
    }

    String toString() {
        return "${name}"
    }

}
