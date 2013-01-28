package at.uenterprise.erp.lfa

class Result {

    //List actions
    //static hasMany = [actions: Action]

    static belongsTo = [subgoal: Subgoal]

    String description
    String resources
    String costs
    String requirements

    static constraints = {
        resources nullable: true
        costs nullable: true
        requirements nullable: true
    }

    static mapping = {
        resources type: "text"
        costs type: "text"
        requirements type: "text"
    }
}
