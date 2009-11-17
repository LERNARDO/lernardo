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
    String biography

    static constraints = {
        title(nullable:true,blank:true)
        firstName(nullable:true,size:3..20)
        lastName(nullable:true,size:3..20)
        birthDate(nullable:true)
        PLZ(nullable:true)
        city(nullable:true)
        street(nullable:true)
        tel(nullable:true,blank:true)
        gender(nullable:true)
        biography(nullable:true)
    }
}
