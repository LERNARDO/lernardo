package at.uenterprise.erp

class Healths implements Comparable {

    String text
    Date date

    static constraints = {
      text (maxSize: 10000)
    }

    int compareTo (obj) {
      date <=> obj.date
    }

}
