package at.uenterprise.erp.base.security

import at.uenterprise.erp.base.Entity
import at.uenterprise.erp.base.Account

import at.uenterprise.erp.base.util.HashTools
import org.slf4j.Logger
import org.slf4j.LoggerFactory

import javax.servlet.http.HttpServletRequest
import javax.servlet.http.HttpSession
import at.uenterprise.erp.base.Entity
import at.uenterprise.erp.base.Account

/**
 * User: mkuhl
 * Date: 03.05.2010
 *
 * EP default security Manager implementation
 */
class DefaultSecurityManager {
  static final String SESSION_ATTR_CURRENT = "currentEntity"
  static final String SESSION_ATTR_LASTLOGIN = "lastLogin"
  private static ThreadLocal<Entity> currentEntity = new ThreadLocal<Entity>()

  private Logger log = LoggerFactory.getLogger(getClass()) ;
  long salt ;
  
  static Entity getCurrentEntity () {return (currentEntity.get())}

  Entity login (HttpServletRequest request, String userId, String pass) {
    HttpSession session = request.getSession()
    log.debug ("processing login request for $userId with session id $session.id")

    Entity e = session.getAttribute(SESSION_ATTR_CURRENT) ;
    if (!e) {
      Account acc = Account.findByEmail(userId) ;
      if (!acc)
        throw new SecurityManagerException("security.login.invaliduidpw", "invalid userid/password({1})", [userId, 'U'])
      if (!acc.enabled)
        throw new SecurityManagerException("security.login.accountdisabled", "user account disabled ({0})", [userId])

      if (acc.password != encodePassword(pass))
        throw new SecurityManagerException("security.login.invaliduidpw", "invalid userid/password({1})", [userId, 'P'])

      session.setAttribute (SESSION_ATTR_CURRENT, acc.entity) ;
      return acc.entity ;
    }

    // check entity to prevent easy spoofing (consider header/ip check here later)
    if (!e.user.email != userId || e.user.password != encodePassword(pass)) {
      session.removeAttribute(SESSION_ATTR_CURRENT) ;
      throw new SecurityManagerException("security.login.sessioninuse", "session already in use. please login again", [userId])
    }
    session.setAttribute (SESSION_ATTR_LASTLOGIN, new Date()) ;
    return e
  }

  Entity getLoggedIn (HttpServletRequest request) {
    HttpSession session = request.getSession(false)
    Entity e = null
    if (session)
      e = session.getAttribute(SESSION_ATTR_CURRENT)

    // if logged in, store entry in thread-Local for services, etc with no session access, clear tread-local otherwise
    if (e)
      currentEntity.set(e)
    else
      currentEntity.remove()  


    return e ;
  }

  void logout (HttpServletRequest request) {
    HttpSession session = request.getSession(false)
    if (session)
      session.removeAttribute(SESSION_ATTR_CURRENT) ;
  }

  String encodePassword (String clearText)  {
    return HashTools.SHA(clearText) ;
  }


}
