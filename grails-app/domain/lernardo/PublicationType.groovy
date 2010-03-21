package lernardo

class PublicationType {
    static hasMany = [ publications : Publication]

    String name
    String description

    static constraints = {
      name (blank:false)
      description (nullable:true)
    }
}
