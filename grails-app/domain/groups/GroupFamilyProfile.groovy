package groups

import de.uenterprise.ep.Profile

class GroupFamilyProfile extends Profile{

    String livingConditions
    //Integer personCount - calculated by total count of members
    //Integer totalIncome - calculated by incomes of members
    String otherData

    static constraints = {
      livingConditions (maxSize: 10000)
      otherData (maxSize: 10000)
    }
}
