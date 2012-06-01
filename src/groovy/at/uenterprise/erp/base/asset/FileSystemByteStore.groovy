/**
 * User: mkuhl
 * Date: 11.07.2009
 * Time: 14:17:33
 * Description:
 */
package at.uenterprise.erp.base.asset

import org.slf4j.Logger
import org.slf4j.LoggerFactory

class FileSystemByteStore implements IByteStore {
  Logger log = LoggerFactory.getLogger(getClass())
  File storeRoot

  def void put(String id, byte[] content) {
    assert storeRoot 
    storeRoot.mkdirs()
    def afile = new File (storeRoot, id)
    afile.withOutputStream {os-> os << content}
    log.debug "artefact stored at '$afile"
  }

  def byte[] get(String id) {
    def afile = new File (storeRoot, id)
    return afile.readBytes()
  }


}