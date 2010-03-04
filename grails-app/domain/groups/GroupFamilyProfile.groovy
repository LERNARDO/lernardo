package groups

import de.uenterprise.ep.Profile

class GroupFamilyProfile extends Profile{

    String livingConditions
    Integer personCount
    //Integer totalIncome - calculated by incomes of group members
    String otherData

    static constraints = {
      livingConditions (maxSize: 10000)
      otherData (maxSize: 10000)
    }
}
