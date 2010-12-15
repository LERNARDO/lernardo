package at.uenterprise.erp

import at.uenterprise.erp.Publication

class PublicationType {
    static hasMany = [ publications : Publication]

    String name
    String description

    static constraints = {
      name (blank:false)
      description (nullable:true)
    }
}
