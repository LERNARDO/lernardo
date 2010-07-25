import at.openfactory.ep.Entity
import at.openfactory.ep.Account
import org.springframework.web.servlet.support.RequestContextUtils
import at.openfactory.ep.SecHelperService
import at.openfactory.ep.EntityHelperService

class AppController {
  SecHelperService secHelperService
  EntityHelperService entityHelperService
  def securityManager

  /*
   * this should forward the exception to the developer then render the 500 view
   * TODO: complete the mail part
   */
  def error500 = {
    println params

    /*try {
      sendMail {
        to      "aaz@uenterprise.de"
        subject "Lernardo - Fehler 500"
        html    g.render(template:'/errortemplate', model:[request:params.request, exception: params.exception])
      }
    } catch(Exception ex) {
      log.error "Problem sending email $ex.message", ex
    }*/

    render view: '/500'
  }

  /*
   * this is the private start
   */
  def start = {
    Entity entity = entityHelperService.loggedIn
    if (entity) {
      Locale locale = entity.user?.locale ?: new Locale("de", "DE");
      RequestContextUtils.getLocaleResolver(request).setLocale(request, response, locale)

      redirect controller: 'profile', action: 'showNews', id: entity.id
    }
    else
      redirect action: 'home'
  }

  /*
   * this is the public start
   */
  def home = {
    redirect controller: 'articlePost', action: 'index'
  }

  /*
   * renders a view where the user can change his password
   */
  def password = {
    return ['params': params]
  }

  /*
   * resets the password of the user and sends him a new password
   */
  def sendPassword = {
    Account user = Account.findByEmail(params.email)
    if (user) {
      Entity e = Entity.findByUser(user)

      // generate new random password
      Random randomGenerator = new Random()
      def random = randomGenerator.nextInt(300) + 100
      String pass = 'pass' + random.toString()
      user.password = securityManager.encodePassword(pass)
      try {
        sendMail {
          to "${user.email}"
          subject "Lernardo - Dein Passwort"
          html g.render(template: 'passwordemail', model: [entity: e, password: pass])
        }
      } catch (Exception ex) {
        log.error "Problem sending email $ex.message", ex
      }
      flash.message = message(code: "account.message", args: [params.email])
      redirect controller: 'articlePost', action: 'index'
    }
    else {
      flash.message = message(code: "account.notFound", args: [params.email])
      render view: 'password', model: [params: params]
    }
  }
}
