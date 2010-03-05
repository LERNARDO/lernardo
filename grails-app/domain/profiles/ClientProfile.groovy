package profiles

import de.uenterprise.ep.Profile
import de.uenterprise.ep.Entity

class ClientProfile extends Profile {

    String fullName
    Date birthDate
    Integer PLZ
    String city
    String street
    String tel
    Integer gender
    List guardians
    Entity school
    Entity schoolclass
    String allergies
    String illnesses
    String limitations
    Boolean comesAlone
    Boolean goesAlone
    Boolean showTips = true

    static constraints = {
        fullName(nullable:true,size:3..30)
        birthDate(nullable:true)
        PLZ(nullable:true)
        city(nullable:true)
        street(nullable:true)
        tel(nullable:true,blank:true)
        gender(nullable:true)
        guardians(nullable:false)
        school(nullable:false)
        school(nullable:false)
        allergies(nullable:true)
        illnesses(nullable:true)
        limitations(nullable:true)
        comesAlone(nullable:true)
        goesAlone(nullable:true)
    }

    /*String firstName
    String lastName
    Date birthDate
    String country
    Integer PLZ
    String city
    String street
    String country2 // used for additional address
    Integer PLZ2
    String city2
    String street2
    String nationality
    String languages
    Integer schoolLevel
    Boolean dropout
    String dropoutReason
    String notes
    String interests
    String personalDetails
    Date joinDate
    Date endDate
    Date rejoinDate
    Date endDate2
    Date rejoinDate2
    String attendance
    Boolean doesWork
    String work
    Integer gender
    Integer income*/

}
