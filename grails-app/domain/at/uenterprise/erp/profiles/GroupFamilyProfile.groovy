package at.uenterprise.erp.profiles

import at.uenterprise.erp.base.Profile

/**
 * This class represents a family
 *
 * @author  Alexander Zeillinger
 */
class GroupFamilyProfile extends Profile {

  static hasMany = [familyProblems: String]

  String  livingConditions
  String  socioeconomicData
  String  otherInfo
  Integer amountHousehold
  Integer familyIncome

  static constraints = {
    fullName          blank: false, size: 1..100, maxSize: 100
    livingConditions  blank: true, maxSize: 500
    socioeconomicData blank: true, maxSize: 500
    otherInfo         blank: true, maxSize: 500
    amountHousehold   nullable: true
    familyIncome      nullable: true
  }

  String toString() {
    return "${fullName}"
  }

}
