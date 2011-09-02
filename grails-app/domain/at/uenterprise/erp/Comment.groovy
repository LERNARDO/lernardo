package at.uenterprise.erp

/**
 * This class represents the comments that can be written
 * for various entities like activities, group activities, projects, ...
 *
 * @author  Alexander Zeillinger
 */
class Comment implements Comparable {

  Integer creator
  String  content
  Date    dateCreated

  static constraints = {
    content blank: false, maxSize: 5000
  }

  int compareTo (obj) {
    dateCreated <=> obj.dateCreated
  }

}
