package at.uenterprise.erp

class WorkdayCategory {

    String name

    static constraints = {
      name: blank:false
    }

    String toString(){
      return "${name}"
    }
}
