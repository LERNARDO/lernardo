package profiles

import de.uenterprise.ep.Profile

class PateProfile extends Profile {

  String firstName
  String lastName
  Integer PLZ
  String city
  String street
  String nationality
  String languages
  Integer emails

    static constraints = {
    }
}
