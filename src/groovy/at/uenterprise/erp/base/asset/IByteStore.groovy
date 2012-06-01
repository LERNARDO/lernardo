/**
 * User: mkuhl
 * Date: 11.07.2009
 * Time: 14:18:36
 * Description: Interface for providers to store a (potentially large) bunch of binary data in whatever way
 * it sees fit (filesystem, blob, AmazonS3, ...)
 */
package at.uenterprise.erp.base.asset

interface IByteStore {
  /**
   * stores the given content under the given id. if content under the given id already exists, it will be overwritten
   */
  void put (String id, byte[] content)

  /**
  * retrieves the content with the given id, returns if it does not exist.
  */
  byte[] get(String id)

}