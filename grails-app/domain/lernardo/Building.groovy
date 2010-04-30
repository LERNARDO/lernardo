package lernardo

class Building {

    String name // added on 21.04.2010
    String country // added on 21.04.2010
    String zip // added on 21.04.2010
    String city // added on 21.04.2010
    String street // added on 21.04.2010
    String phone // added on 21.04.2010
    String email // added on 21.04.2010
    String authority // added on 21.04.2010

    static constraints = {
      name (size: 2..50)
      country (size: 2..50)
      zip (size: 4..10)
      city (size: 2..50)
      street (size: 2..50)
      phone (size: 2..20)
      email (size: 2..20)
      authority (size: 2..50)
    }
}
