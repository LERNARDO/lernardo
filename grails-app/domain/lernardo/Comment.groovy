package lernardo

class Comment {

  Integer creator
  String content

  Date dateCreated

  static constraints = {
    content (blank: false, maxSize: 5000)
  }
}
