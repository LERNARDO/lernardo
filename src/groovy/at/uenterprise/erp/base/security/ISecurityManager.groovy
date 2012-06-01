package at.uenterprise.erp.base.security

/**
 * User: mkuhl
 * Date: 02.05.2010
 *
 * defines the security manager public interface, which is used taglibs and controllers in the plugin and perhaps
 * in the application as well. An instance is supposed to be registered as "securityManager" spring bean via
 * "resource.groovy",etc. Has no inherent Grails dependencies and might well be moved to a separate library sometimes
 * 
 */
public interface ISecurityManager {
  /*
  AuthStat login(def request, String userId, String passWord) ;
  void logout(def request) ;
  AuthStat getLoggedIn(request) ;
  Set<AuthStat> getLoggedInUsers () ;

  void addLoginHandler (Closure c) ;
  void removeLoginHandler (Closure c) ;

  void addLogoutHandler (Closure c)
  void removeLogoutHandler (Closure c)

  Set<String> getRoles() ;
  */
}





