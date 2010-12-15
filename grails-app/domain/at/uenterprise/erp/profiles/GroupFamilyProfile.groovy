package at.uenterprise.erp.profiles

import at.openfactory.ep.Profile

/*
 * used for grouping parents, clients and children together by creating a link from the group to each family member
 */

class GroupFamilyProfile extends Profile {

    static hasMany = [familyProblems: String]

    String livingConditions
    String socioeconomicData
    String otherInfo
    Integer amountHousehold
    Integer familyIncome

    static constraints = {
      fullName (blank: false, size: 2..50, maxSize: 50)
      livingConditions (blank: true, maxSize: 500)
      socioeconomicData (blank: true, maxSize: 500)
      otherInfo (blank: true, maxSize: 500)
      amountHousehold (nullable: true)
      familyIncome (nullable: true)
    }
}
