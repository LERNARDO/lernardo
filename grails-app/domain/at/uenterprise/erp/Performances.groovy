package at.uenterprise.erp

class Performances implements Comparable {

    String text
    Date date

    static constraints = {
      text (maxSize: 10000)
    }

    int compareTo (obj) {
      date.compareTo(obj.date)
    }

}
