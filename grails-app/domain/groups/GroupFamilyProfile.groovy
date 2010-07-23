package groups

import at.openfactory.ep.Profile

/*
 * used for grouping parents, clients and children together by creating a link from the group to each family member
 */

class GroupFamilyProfile extends Profile {

    static hasMany = [familyProblems: String] // added on 21.04.2010

    String livingConditions
    String socioeconomicData // added on 21.04.2010
    String otherInfo // changed on 21.04.2010, before: otherData
    Integer amountHousehold // changed on 21.04.2010, before: personCount
    Integer familyIncome // changed on 21.04.2010, before: totalIncome

    static constraints = {
      fullName (blank: false, size: 2..50, maxSize: 50)
      livingConditions (blank: true, maxSize: 500)
      socioeconomicData (blank: true, maxSize: 500)
      otherInfo (blank: true, maxSize: 500)
      amountHousehold (nullable: true)
      familyIncome (nullable: true)
    }
}
