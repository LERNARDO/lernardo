package at.uenterprise.erp

class Label {

  String name
  String description
  String type

  static constraints = {
    name maxSize: 50
    description nullable: true, maxSize: 5000
  }

  String toString(){
    return "${name}"
  }
}
