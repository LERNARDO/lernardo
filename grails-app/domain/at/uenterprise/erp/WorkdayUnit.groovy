package at.uenterprise.erp

/**
 * This class represents the workday entries (units)
 *
 * @author  Alexander Zeillinger
 */
class WorkdayUnit implements Comparable {

  Date    date1
  Date    date2
  String  category
  String  description
  Boolean confirmed = false

  static constraints = {
    description size: 0..500, maxSize: 500
    category    nullable: false
  }

  int compareTo (obj) {
    date1 <=> obj.date1
  }

}
