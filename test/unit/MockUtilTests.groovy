import grails.test.*
import junit.framework.TestCase

class MockUtilTests extends TestCase {
  def prfmap = [:]

    protected void setUp() {
      prfmap.id_1 = [name:'name1', addr:'addr1', nick:'nick1', gender:'female']
      prfmap.id_2 = [name:'name2', addr:'addr2', nick:'nick2', gender:'male']
      prfmap.id_3 = [name:'name3', addr:'addr3', nick:'nick3', gender:'female']
    }

    protected void tearDown() {
        super.tearDown()
    }

    void testProfileList() {
      def prflist = MockUtil.asList(prfmap)
      assertTrue prflist instanceof List
      assertEquals (prflist.size(), 3)

      // default sort order is supposed to be by id
      assertEquals ('1', prflist[0].id)
      assertEquals ('2', prflist[1].id)
      assertEquals ('3', prflist[2].id)


      println prflist
      prflist.each {println it}
    }

    void testProfileFilterOne () {
      def prflist = MockUtil.filter(MockUtil.asList(prfmap), 'name', 'name1')
      assertNotNull (prflist)
      assertEquals (1, prflist.size())
      assertEquals ("name1", prflist[0].name)
    }

    void testProfileFilterSome () {
      def prflist = MockUtil.filter(MockUtil.asList(prfmap), 'gender', 'female')
      assertNotNull (prflist)
      assertEquals (2, prflist.size())
      assertEquals ("1", prflist[0].id)
      assertEquals ("3", prflist[1].id)
    }

    void testProfileFilterNone () {
      def prflist = MockUtil.filter(MockUtil.asList(prfmap), 'addr', 'franzi')
      assertNotNull (prflist)
      assertEquals (0, prflist.size())
    }

}
