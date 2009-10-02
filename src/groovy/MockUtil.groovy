
/**
 * Created by IntelliJ IDEA.
 * User: mkuhl
 * Date: 22.09.2009
 * Time: 20:06:29
 * some utility functions to work with (map - based) mockup data
 */

final class MockUtil {

  /**
   *takes profile / action / etc maps and converts them to list by stripping the key and adding it as a
   * 'id' parameter to the attribute list
    */

  static List asList (Map map) {
    def result = []
    map.each {key, val->

      // the next 2 lines makes only sense for profile maps, as they don't have an ID attribute
      def idval = key[0..2] == 'id_' ? key[3..-1] : key
      val.id = idval

      result << val
    }

    return result ;
  }

  static List filter (List list, String attr, String val) {
    def result = [] ;
    list.each {Map item->
      if (item[attr] == val)
        result << item ;

    }

    return result ;
  }
}


