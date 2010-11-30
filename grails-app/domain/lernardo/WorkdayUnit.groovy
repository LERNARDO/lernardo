package lernardo

import at.openfactory.ep.Entity

class WorkdayUnit implements Comparable {

    Date date1
    Date date2

    String category
    String description

    static constraints = {
      description (size: 0..500, maxSize: 500)
    }

    int compareTo (obj) {
      date1.compareTo(obj.date1)
    }
}
