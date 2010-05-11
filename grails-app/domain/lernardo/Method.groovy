package lernardo

class Method {

    static hasMany = [elements: Element]

    String name
    String description

    static constraints = {
      description (maxSize: 2000)
    }
}
