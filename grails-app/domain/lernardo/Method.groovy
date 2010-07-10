package lernardo

class Method {

    SortedSet elements
    static hasMany = [elements: Element]

    String name
    String description
    String type

    static constraints = {
      name (maxSize: 50)
      description (maxSize: 2000)
    }

    String toString(){
      return "${name}"
    }
}
