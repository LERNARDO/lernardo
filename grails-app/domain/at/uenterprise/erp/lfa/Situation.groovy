package at.uenterprise.erp.lfa

import at.uenterprise.erp.base.Entity

class Situation {

    static hasMany = [goals: Goal, // type: "sub"
                      actions: Entity] // Aktionen, nur bei "sub" goals
    static belongsTo = Goal
    String indicator
    String expectedResult

    static constraints = {
    }
}
