package at.uenterprise.erp

/**
 * This class represents the workday categories for workday entries
 *
 * @author  Alexander Zeillinger
 */
class WorkdayCategory {

  String  name
  Boolean counts = true
  Date    beginDate
  Date    endDate

  static constraints = {
    name blank: false
  }

  String toString() {
    return "${name}"
  }

}
