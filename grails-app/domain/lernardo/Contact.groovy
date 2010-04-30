// this class is used by PartnerProfile and FacilityProfile

package lernardo

class Contact {

    String firstName
    String lastName
    String country
    String zip
    String city
    String street
    String phone
    String email
    String function
  
    static constraints = {
      firstName (size: 2..50)
      lastName (size: 2..50)
      country (size: 2..50)
      zip (size: 4..10)
      city (size: 2..50)
      street (size: 2..50)
      phone (size: 2..20)
      email (size: 2..20)
      function (size: 2..50)
    }

    String toString(){
      return "${id}"
    }
}
