package lernardo

class Building {

    String name
    String zip
    String city
    String street
    String phone
    String email
    String authority

    static constraints = {
      name (size: 2..50)
      // country (size: 2..50)
      zip (size: 4..10)
      city (size: 2..50)
      street (size: 2..50)
      phone (size: 2..20)
      email (size: 2..20)
      authority (size: 2..50)
    }
}
