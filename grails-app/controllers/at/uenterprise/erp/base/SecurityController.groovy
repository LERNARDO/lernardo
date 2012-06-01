package at.uenterprise.erp.base

import at.uenterprise.erp.base.security.SecurityManagerException

class SecurityController {
    def securityManager

    def index = {

    }

    def login = {
      [userid:params.userid ?: "", password:params.password ?: ""]
    }

    def do_login = {
      if (!params.userid) {
        flash.message = g.message (code:"security.login.emptyuid")
        redirect (action:"login", params:params)
        return 
      }
      if (!params.password) {
        flash.message = g.message (code:"security.login.emptypwd")
        redirect (action:"login", params:params)
        return
      }

      // actually do the login
      log.info ("start login for $params.userid")
      Entity currentEntity = null
      try {
        currentEntity = securityManager.login (request, params.userid, params.password)
      }
      catch (SecurityManagerException sme) {
        flash.message =  g.message (code:sme.code, args:[params.userid])
        redirect (action:"login", params:params)
        return
      }

      log.info "login successful for $params.userid (${currentEntity?.name})"
      def startUrl = grailsApplication.config.secmgr.starturl ?: "/start"
      log.debug ("redirecting to 'starturl': $startUrl")
      redirect (uri:startUrl, args:[entity:currentEntity])
    }

    def logout = {
      Entity e = securityManager.getLoggedIn(request)
      securityManager.logout(request)
      def pubUrl = grailsApplication.config.secmgr.publicurl ?: "/"
      redirect (uri:pubUrl, args:[entity:e])
    }
}
