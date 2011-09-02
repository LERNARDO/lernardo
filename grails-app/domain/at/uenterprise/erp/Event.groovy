package at.uenterprise.erp

/**
 * This class represents global events that can be seen right after logging in
 *
 * @author  Alexander Zeillinger
 */
class Event {

  String  name
  Integer who
  Integer what
  Date    date
  Date    dateCreated
  Date    lastUpdated

  static constraints = {

  }

}
