package groups

import de.uenterprise.ep.Profile

class GroupActivityProfile extends Profile {

    Integer realDuration
    Date date
    String educationalObjective
    String educationalObjectiveText

    static constraints = {
      fullName (blank: false, size: 2..50)
      educationalObjectiveText (blank: true, maxSize: 2000)
    }
}
