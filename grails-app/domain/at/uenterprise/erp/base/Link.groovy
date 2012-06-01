package at.uenterprise.erp.base

import at.uenterprise.erp.base.attr.DynAttr

public class Link {

  static hasMany = [dynattrs : DynAttr]

  Date      dateCreated
  LinkType  type
  Entity    source
  Entity    target

  static constraints = {
  }

}
