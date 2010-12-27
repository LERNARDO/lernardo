package lernardo

import at.openfactory.ep.Link
import at.uenterprise.erp.MetaDataService
import at.openfactory.ep.Entity
import at.openfactory.ep.attr.DynAttr
import at.openfactory.ep.attr.DynAttrSet

/**
 * User: mkuhl
 * Date: 04.06.2010
 *
 * 
 */
class LinkAttrTests extends GroovyTestCase  {
  def mylink
  MetaDataService metaDataService

  protected void setUp() {
    def src = Entity.findByName ("sueninos") 
    def dst = Entity.findByName ("sueninoszentrum")
    mylink = new Link(source:src, target:dst, type:metaDataService.ltFacility)
    mylink.addToDynattrs (new DynAttr(name:"test1", value:"val1"))
    mylink.addToDynattrs (new DynAttr(name:"test2", value:""))
    mylink.save(failOnError:true)

    if (!mylink) {
      mylink.errors.each {
        println ("create Link err: field: '$it.field' code: $it.code, rejectedValue: $it.rejectedValue")
      }

    }
    println "all done: $mylink"
    
  }

  void testLinkAttrSimple () {
    def link1 = Link.get (mylink.id)
    assert link1
    assert link1.dynattrs
    assert link1.dynattrs.size() == 2

    def das = new DynAttrSet (link1.dynattrs)
    assert das["test1"] != null
    assert das["test1"] == "val1"
    assert das["test2"] == ""

    das["test2"] = "val2"
    assert das["test2"] != null
    assert das["test2"] == "val2"

    link1.save(flush:true)

    //def link2 = Link.get(mylink.id)
    def das2 = new DynAttrSet (link1.dynattrs)
    assert das2.test2 == "val2"
  }

  void testDynamic () {
    def link2 = Link.get (mylink.id)

    assert link2
    assert link2.das
    assert link2.das.test1
    assert link2.das.test1 == 'val1'

    println "DAS: $link2.das.test1"
  }

  protected void tearDown() {
  }


}
