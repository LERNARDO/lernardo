package at.uenterprise.erp

import at.openfactory.ep.Entity

class PublicationHelperService {

  boolean transactional = true

  /*
   * create a map that contains type and a list of publications per pubtype that has at least one pub for the owner
   */
  def findPublicationsByType(Entity owner) {
    def pubs = Publication.findAllByEntity(owner);

    def result = [:]
    pubs.each {p ->
      if (!result[p.type]) {
        result[p.type] = []
      }
      result[p.type].add(p);
    }

    return result
  }

  List findPublicationsOfEntity(Entity owner) {
    return Publication.findAllByEntity(owner)
  }
}
