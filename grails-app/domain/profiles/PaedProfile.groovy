package profiles

import de.uenterprise.ep.Profile

class PaedProfile extends Profile {

    String title
    String fullName
    Date birthDate
    Integer PLZ
    String city
    String street
    String tel
    Integer gender
    String biography
    String training
    Boolean showTips = true

    static constraints = {
        title(nullable:true,blank:true)
        fullName(nullable:true,size:3..30)
        birthDate(nullable:true)
        PLZ(nullable:true)
        city(nullable:true)
        street(nullable:true)
        tel(nullable:true,blank:true)
        gender(nullable:true)
        biography(nullable:true,maxSize:3000)
        training(nullable:true)
    }
}
