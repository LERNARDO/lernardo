package lernardo

class Method {

    static hasMany = [elements: Element]

    String name
    String description
    String type

    static constraints = {
      description (maxSize: 2000)
    }

    String toString(){
      return "${name}"
    }
}
