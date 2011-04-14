package at.uenterprise.erp

class WorkdayCategory {

    String name
    boolean count = true

    static constraints = {
      name: blank:false
      nullable: false
    }

    String toString(){
      return "${name}"
    }
}
