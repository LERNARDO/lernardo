package at.uenterprise.erp

import at.openfactory.ep.Entity
import at.uenterprise.erp.MetaDataService
import at.uenterprise.erp.FunctionService

class NetworkController {
  MetaDataService metaDataService
  FunctionService functionService

  /*
   * shows the network of a given entity
   * NOT USED ATM
   */
  def index = {
    Entity entity = Entity.get(params.id)
    
    return ['entity': entity,
            'friendsList': functionService.findAllByLink(entity, null, metaDataService.ltFriendship),
            'bookmarksList': functionService.findAllByLink(entity, null, metaDataService.ltBookmark),
            'operatorsList': functionService.findAllByLink(entity, null, metaDataService.ltOperation),
            'facilitiesList': functionService.findAllByLink(entity, null, metaDataService.ltWorking),
            'facilities2List': functionService.findAllByLink(entity, null, metaDataService.ltClientship),
            'clientsList': functionService.findClientsOf(entity)]
  }
}
