package profiles

import de.uenterprise.ep.Profile

class UserProfile extends Profile {
    String title
    String firstName
    String lastName
    Date birthDate
    Integer PLZ
    String city
    String street
    String tel
    Integer gender

    static constraints = {
        title(blank:true)
        firstName(nullable:false,size:3..20)
        lastName(nullable:false,size:3..20)
        birthDate(nullable:false)
        PLZ(nullable:false)
        city(nullable:false)
        street(nullable:false)
        tel(blank:true)    
    }
}
