package at.uenterprise.erp.base

import at.uenterprise.erp.base.attr.DynAttrSet
import at.uenterprise.erp.base.attr.DynAttr
import at.uenterprise.erp.base.attr.DynAttrSet

/**
 * User: mkuhl
 * Date: 04.06.2010
 *
 * 
 */
class LinkHelperService {
  static transactional = true

  Link createLink (Entity source, Entity target, LinkType linkType, Closure c) {
    def link = new Link (source:source, target:target, type:linkType)

    HashSet daset = new HashSet()
    def das = new DynAttrSet (daset)
    if (c) {
      c.call (link, das)
      daset.each {def a->
        link.addToDynattrs (a)
      }
    }

    if (link.save())
      return link

    ent.errors.allErrors.each {
      log.error ("create Link $linkType.name: field: '$it.field' code: $it.code, rejectedValue: $it.rejectedValue")
    }
    throw new EntityException(entity:ent, message:"failed to create link $linkType.name")

  }

  def getDynAttrs (Link link) {
    // we're returning an immutable set for convenience if there are no dynattrs defined.
    return (new DynAttrSet(link.dynattrs ?: new HashSet().asImmutable()))      
  }

}
