package groups

import de.uenterprise.ep.Profile

class GroupFamilyProfile extends Profile{

    String livingConditions
    String socioeconomicData // added on 21.04.2010
    String otherInfo // changed on 21.04.2010, before: otherData
    Integer amountHousehold // changed on 21.04.2010, before: personCount
    Integer familyIncome // changed on 21.04.2010, before: totalIncome
    String[] familyProblems // added on 21.04.2010

    static constraints = {
      fullName (blank: false, size: 2..50)
      livingConditions (blank: true, maxSize: 500)
      socioeconomicData (blank: true, maxSize: 500)
      otherInfo (blank: true, maxSize: 500)
    }
}
