package profiles

import de.uenterprise.ep.Profile
import de.uenterprise.ep.Entity

class FacProfile extends Profile {
    String fullName
    Integer PLZ
    String city
    String street
    String tel
    String description
    String opened
    Entity speaker

    static constraints = {
        fullName(nullable:false)
        PLZ(nullable:true)
        city(nullable:false)
        street(nullable:true)
        tel(blank:true)
        description(blank:true,maxSize: 2000)
        opened(blank:true)
        speaker(nullable: true, blank:true)
    }
}
