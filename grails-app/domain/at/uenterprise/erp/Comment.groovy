package at.uenterprise.erp

class Comment implements Comparable {

  Integer creator
  String content

  Date dateCreated

  static constraints = {
    content (blank: false, maxSize: 5000)
  }

  int compareTo (obj) {
    dateCreated.compareTo(obj.dateCreated)
  }
}
