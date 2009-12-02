// to be used for facilities:
// - schools
// - hoards

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
        city(nullable:true)
        street(nullable:true)
        tel(nullable:true,blank:true)
        description(nullable: true,blank:true,maxSize: 2000)
        opened(nullable:true,blank:true)
        speaker(nullable: true, blank:true)
    }
}
