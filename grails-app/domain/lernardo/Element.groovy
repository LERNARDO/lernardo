package lernardo

class Element implements Comparable {

    String name
    Integer voting = 0

    static constraints = {
    }

    int compareTo (obj) {
      name.compareTo(obj.name)
    }
}
