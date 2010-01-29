// to be used for organisations
// - operators
// - sponsors

package profiles

import de.uenterprise.ep.Profile
import de.uenterprise.ep.Entity

class OrgProfile extends Profile {
    String fullName
    Integer PLZ
    String city
    String street
    String tel
    String description
    Entity speaker
    Boolean showTips = true

    static constraints = {
        fullName(blank:false)
        PLZ(nullable: true, blank:true)
        city(nullable: true, blank:true)
        street(nullable: true, blank:true)
        tel(nullable: true, blank:true)
        description(nullable: true, blank:true,maxSize: 2000)
        speaker(nullable: true, blank: true)
    }
}
