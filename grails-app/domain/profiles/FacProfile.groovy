package profiles

import de.uenterprise.ep.Profile
import de.uenterprise.ep.Entity

class FacProfile extends Profile {
    Integer PLZ
    String city
    String street
    String tel
    String description
    String opened
    Entity speaker

    static constraints = {
        PLZ(nullable:false)
        city(nullable:false)
        street(nullable:false)
        tel(blank:true)
        description(blank:true,maxSize: 2000)
        opened(blank:true)
        speaker(blank:true)
    }
}
