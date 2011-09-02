package at.uenterprise.erp

/**
 * This class represents the contacts that can be added to
 * partners and facilities
 *
 * @author  Alexander Zeillinger
 */
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
    firstName size: 2..50
    lastName  size: 2..50
    country   size: 2..50
    zip       size: 4..10
    city      size: 2..50
    street    size: 2..50
    phone     size: 2..20
    email     size: 2..20
    function  size: 2..50
  }

  String toString() {
    return "${id}"
  }

}
