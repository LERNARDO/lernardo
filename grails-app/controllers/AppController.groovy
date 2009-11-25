import de.uenterprise.ep.Entity

class AppController {
    def secHelperService ;
    def entityHelperService ;

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
}
