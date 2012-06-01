package at.uenterprise.erp.base.security

/**
 * User: mkuhl
 * Date: 03.05.2010
 *
 * 
 */
class SecurityManagerException extends RuntimeException {
  String code ;
  List   args ;

  def SecurityManagerException(String code, String defaultMsg="no message available", List args=[]) {
    this.code = code ;
    this.args = args ;
  }

  def String toString() {
    return "$code: $message" ; 
  }


}
