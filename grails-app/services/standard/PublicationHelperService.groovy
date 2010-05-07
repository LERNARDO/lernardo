package standard

import de.uenterprise.ep.Entity
import lernardo.Publication

class PublicationHelperService {

    boolean transactional = true


   /**
   * create a map that contains type and a list of publications per pubtype that has at least one pub for the owner
    */
    def findPublicationsByType(Entity owner) {
      def pubs = Publication.findAllByEntity (owner) ;

      def result = [:]
      pubs.each {p->
        if (!result[p.type]) {
          result[p.type] = []
        }
        result[p.type].add(p) ;
      }

      return result
    }
}
