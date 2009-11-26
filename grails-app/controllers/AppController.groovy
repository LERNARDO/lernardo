import de.uenterprise.ep.Entity
import de.uenterprise.ep.Account

class AppController {
    def secHelperService
    def entityHelperService
    def authenticateService

    def index = { }

    def start = {
        Entity e = entityHelperService.loggedIn
        if (e)
          redirect (controller:'profile', action:'showProfile', params:[name:e.name, content:'profile'])
        else
          redirect (action:'sorry') 
    }

    def home = {
      redirect (controller:'articlePost', action:'index')
    }

    def password = {
      return [params:params]
    }

    def sendPassword = {
      Account user = Account.findByEmail (params.email)
      if (user) {
        Entity e = Entity.findByUser(user)

        // generate new random password
        Random randomGenerator = new Random()
        def random = randomGenerator.nextInt(300)+100
        def pass = 'pass' + random.toString()
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
        redirect (controller:'articlePost', action:'index')
      }
      else {
        flash.message = message(code:"account.notFound", args:[params.email])
        render view:'password', model:[params:params]
      }
    }
}
