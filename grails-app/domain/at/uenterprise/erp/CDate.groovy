package at.uenterprise.erp

class CDate implements Comparable {

    String type // either join or end
    Date date

    static constraints = {
    }

    int compareTo (obj) {
      date.compareTo(obj.date)
    }

}
