package lernardo

class Status {

    String type // performance, health or material
    String text
    Date date

    static constraints = {
      text (maxSize: 10000)
    }
}
