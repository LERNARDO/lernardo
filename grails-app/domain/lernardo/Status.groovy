package lernardo

class Status implements Comparable {

    String type // performance, health or material
    String text
    Date date

    static constraints = {
      text (maxSize: 10000)
    }

    int compareTo (obj) {
      date.compareTo(obj.date)
    }

}
