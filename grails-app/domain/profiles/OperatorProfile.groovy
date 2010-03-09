// to be used for organisations
// - operators
// - sponsors
package profiles

import de.uenterprise.ep.Profile

class OperatorProfile extends Profile {

    Integer PLZ
    String city
    String street
    String tel
    String description
    Boolean showTips = true

    static constraints = {
      fullName (blank:false)
      PLZ (blank:true)
      description (maxSize: 2000)
    }

    String toString(){
      return "${fullName}"
    }
}
