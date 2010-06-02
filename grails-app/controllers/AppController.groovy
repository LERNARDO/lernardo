import de.uenterprise.ep.Entity
import de.uenterprise.ep.Account
import org.springframework.web.servlet.support.RequestContextUtils
import de.uenterprise.ep.SecHelperService
import de.uenterprise.ep.EntityHelperService
import org.grails.plugins.springsecurity.service.AuthenticateService

class AppController {
    SecHelperService secHelperService
    EntityHelperService entityHelperService
    AuthenticateService authenticateService

    def start = {
      Entity entity = entityHelperService.loggedIn
      if (entity) {
        Locale locale = entity.user?.locale ?: new Locale("de", "DE") ;
        RequestContextUtils.getLocaleResolver(request).setLocale(request, response, locale)

        redirect controller:'profile', action:'showNews', id:entity.id
      }
      else
        redirect action:'home'
    }

    def home = {
      redirect controller:'articlePost', action:'index'
    }

    def password = {
      return ['params':params]
    }

    // resets the password of the user and sends him a new password
    def sendPassword = {
      Account user = Account.findByEmail (params.email)
      if (user) {
        Entity e = Entity.findByUser(user)

        // generate new random password
        Random randomGenerator = new Random()
        def random = randomGenerator.nextInt(300)+100
        String pass = 'pass' + random.toString()
        user.password = authenticateService.encodePassword(pass)
        try {
          sendMail {
            to      "${user.email}"
            subject "Lernardo - Dein Passwort"
            html    g.render(template:'passwordMail', model:[entity:e,password:pass])
          }
        } catch(Exception ex) {
          log.error "Problem sending email $ex.message", ex
        }
        flash.message = message(code:"account.message", args:[params.email])
        redirect controller:'articlePost', action:'index'
      }
      else {
        flash.message = message(code:"account.notFound", args:[params.email])
        render view:'password', model:[params:params]
      }
    }
}
