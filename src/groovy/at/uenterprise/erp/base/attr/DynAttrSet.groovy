package at.uenterprise.erp.base.attr

/**
 * User: mkuhl
 * Date: 04.07.2010
 *
 * not strictly an set anymore since it allows key access for convinience and consistency.
 *
 */
class DynAttrSet {
  def underlying


  def DynAttrSet(def underlying) {
    this.underlying = underlying 
  }

  def getAt (String name) {
    underlying.find {it.name == name}?.value
  }

  void setAt (String name, def value) {
    DynAttr attr = underlying.find {a -> a.name == name}
    if (attr && value == null) {
      underlying.remove (attr)
      return
    }

    attr = attr ?: new DynAttr(name:name) ;
    attr.value = value
    underlying.add (attr)
  }

  void setProperty (String name, def value)  {
    setAt (name, value)
  }

  def getProperty (String name) {
    return (getAt(name))
  }

  
}
