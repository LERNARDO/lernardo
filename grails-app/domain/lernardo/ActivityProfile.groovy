package lernardo

import de.uenterprise.ep.Profile

class ActivityProfile extends Profile {

  Date date
  Integer duration

  Date dateCreated
  Date lastUpdated

  static constraints = {
    fullName (blank: false)
  }
}
