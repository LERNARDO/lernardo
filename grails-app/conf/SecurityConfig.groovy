security {
  log.debug ("==> Application Security config start")
  // see DefaultSecurityConfig.groovy for all settable/overridable properties
  active = true
  cacheUsers = false
  useRequestMapDomainClass = false

  loginUserDomainClass = "de.uenterprise.ep.Account"
  authorityDomainClass = "de.uenterprise.ep.Role"
  requestMapClass = "Requestmap"

  userName = "email"
  password = "password"
  enabled  = "enabled"

  loginFormUrl="/"
  defaultTargetUrl="/start"

  /*
  requestMapString = '''
    CONVERT_URL_TO_LOWERCASE_BEFORE_COMPARISON
    PATTERN_TYPE_APACHE_ANT
    /=IS_AUTHENTICATED_ANONYMOUSLY
    /js/**=IS_AUTHENTICATED_ANONYMOUSLY
    /css/**=IS_AUTHENTICATED_ANONYMOUSLY
    /styles/**=IS_AUTHENTICATED_ANONYMOUSLY
    /images/**=IS_AUTHENTICATED_ANONYMOUSLY
    /plugins/**=IS_AUTHENTICATED_ANONYMOUSLY
    /**=IS_AUTHENTICATED_FULLY
    /admin/**=ROLE_ADMIN
'''
*/

  requestMapString = '''
    CONVERT_URL_TO_LOWERCASE_BEFORE_COMPARISON
    PATTERN_TYPE_APACHE_ANT
    /dashboard/**=IS_AUTHENTICATED_REMEMBERED
    /admin/**=ROLE_ADMIN
    /entity/**=IS_AUTHENTICATED_FULLY
    /user/**=IS_AUTHENTICATED_REMEMBERED

    /profile/**=IS_AUTHENTICATED_FULLY
    /msg/**=IS_AUTHENTICATED_FULLY
    /network/**=IS_AUTHENTICATED_FULLY
    /activity/**=IS_AUTHENTICATED_FULLY
    /calendar/**=IS_AUTHENTICATED_FULLY

    /adm/**=ROLE_ADMIN
    '''

}
