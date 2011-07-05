package at.uenterprise.erp

class Resource {

  String name
  String description
  Integer amount = 1

  static constraints = {
    name (blank: false, size: 1..100, maxSize: 100)
    description (nullable: true, maxSize: 20000)
  }

  String toString(){
    return "${name}"
  }
}
