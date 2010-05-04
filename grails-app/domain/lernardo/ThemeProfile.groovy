// WIP

package lernardo

import de.uenterprise.ep.Profile

class ThemeProfile extends Profile {

    static hasMany = [subthemes: SubTheme]

    Date startDate
    Date endDate
    String description

    static constraints = {
      fullName (blank: false, size: 2..50)
      description (blank: true, maxSize: 2000)
    }
}
