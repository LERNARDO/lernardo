package at.uenterprise.erp.profiles

import at.openfactory.ep.Profile

class ChildProfile extends Profile {

    static hasMany = [jobtypes: String]

    String firstName
    String lastName
    Date birthDate
    Byte gender

    Boolean job
    //String jobType
    Integer jobIncome
    String jobFrequency

    Boolean showTips = true
  
    static constraints = {
      fullName (blank: true)
      firstName (blank: false, size: 2..50, maxSize: 50)
      lastName (blank: false, size: 2..50, maxSize: 50)
      //jobType (nullable: true)
      jobIncome (nullable: true)
      jobFrequency (nullable: true, blank: true, maxSize: 50)
    }

    String toString(){
      return "${lastName}" + " " + "${firstName}"
    }
}
