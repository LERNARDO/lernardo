package lernardo

class Helper {

    String title
    String content
    String type

    Date dateCreated
    Date lastUpdated

    static constraints = {
      title(blank: false, maxSize: 50)
      content(blank: false, maxSize: 2000)
      type(blank: false)
    }
}
