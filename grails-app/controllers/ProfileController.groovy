import grails.converters.JSON
import de.uenterprise.ep.Entity
import de.uenterprise.ep.Link
import de.uenterprise.ep.EntityType
import profiles.FacProfile
import de.uenterprise.ep.Account

class ProfileController {
    def geoCoderService
    def networkService
    def entityHelperService
    def metaDataService
    def FilterService
    def authenticateService

    def index = { }

    def geocode = {
        def result = geoCoderService.geocodeLocation(params.name)
        render result as JSON
    }

    def create = { }

    def createOperator = {
      def entityInstance = new Entity()
      entityInstance.properties = params
      return ['entityInstance':entityInstance]
    }

    def saveOperator = {
      EntityType etOperator = metaDataService.etOperator

      Account user = Account.findByEmail (params.email)
      if (user) {
        flash.message = "user account already exists"
        redirect action:"createOperator", params:params
        return
      }

      Entity etst = Entity.findByName (params.name)
      if (etst) {
        flash.message = "nick-name already exists"
        redirect action:"createOperator", params:params
        return
      }

      entityHelperService.createEntityWithUserAndProfile (params.name, etOperator, params.email, params.fullName) {Entity ent->
        FacProfile prf = ent.profile
        prf.city = params.city ?: ""
        prf.opened = "-"
        prf.description = "-"
        prf.tel = "-"
        ent.user.password = authenticateService.encodePassword("pass")
      }
      flash.message = "user wurde angelegt"
      redirect controller:'admin', action:'index'
    }

    def search = { }

    def searchMe = {
      if (!params.name) {
        render "Bitte einen Namen eingeben!"
        return
      }
      List searchList = []
      searchList = FilterService.findUsers(params.name)
      if (searchList.size() == 0) {
        render "Keine Ergebnisse gefunden!"
        return
      }
      else {
        render(template:'searchresults', model:[searchList: searchList])
      }
    }

    def showNews = {
      Entity e = Entity.findByName(params.name)
      render template:"showNews", model:[entity:e]
    }

    def showProfile = {
      Entity e = Entity.findByName(params.name)
      render template:"showProfile", model:[entity:e]
    }

    def showCalendar = { // broken?
      Entity e = Entity.findByName(params.name)
      render template:"showCalendar", model:[entity:e,name:e.name]
    }

    def showArticleList = {
      Entity e = Entity.findByName(params.name)
      render template:"showArticleList", model:[entity:e,'articleList':Post.findAllByAuthorAndType(e,PostType.findByName('article'))]
    }

    def showActivityList = {
      Entity e = Entity.findByName(params.name)
      render template:"showActivityList", model:[entity:e,'activityList':Activity.findAllByOwner(e)]
    }

    def showLeistung = {
      Entity e = Entity.findByName(params.name)
      render template:"showLeistung", model:[entity:e]
    }

    def showLocation = { // broken?
      Entity e = Entity.findByName(params.name)
      render template:"showLocation", model:[entity:e,location:geoCoderService.geocodeLocation(e.profile.city)]
    }

    def print = {
        def image
        if (params.hort == 'Löwenzahn')
            image = "hort_loewenzahn.jpg"
        else if(params.hort == 'Kaumberg')
            image = "hort_kaumberg.jpg"
        return ['image':image, 'pdf':params,'entityList': Entity.findAllByType(EntityType.findByName('Client'))]
    }

    def attendance = {
        return ['entityList': Entity.findAllByType(EntityType.findByName('Client')),
                'entityCount': Entity.countByType(EntityType.findByName('Client'))]
    }

    def list = {
        params.entityType = params.entityType ?: "all"
        params.offset = params.offset ? params.offset.toInteger(): 0
        params.max = params.max ? params.max.toInteger(): 10
        return ['entityType': params.entityType,
                'entityList': Entity.list(params),
                'entityCount': Entity.count()]
    }

    def show = {
        def e = Entity.findByName(params.name)
        if (!e) {
            response.sendError(404, "user profile not found")
            return ;
        }
        return ['entity':e,'friendsList':networkService.findFriendsOf(e)]
    }

    def addFriend = {
      Entity e = params.name ? Entity.findByName(params.name) : null
      if (!e) {
        sendError (404)
        return
      }

      def linkInstance = new Link()
      linkInstance.source = entityHelperService.loggedIn
      linkInstance.type = metaDataService.ltFriend
      linkInstance.target = e ;

      // for now just create a back-link for mutuality - a more elaborate workflow will be in order later on
      def linkBack = new Link()
      linkBack.source = e ;
      linkBack.type = metaDataService.ltFriend
      linkBack.target = entityHelperService.loggedIn

      if(linkInstance.save(flush:true) && linkBack.save(flush:true)) {
        //flash.message = message(code:"addFriend", args:[linkInstance.target.profile.fullName])
        redirect action:'show', params:[name:linkInstance.target.name]
      }
      else {
        //flash.message = message(code:"addFriendFailed", args:[linkInstance.target.profile.fullName])
        redirect action:'show', params:[name:linkInstance.target.name]
      }
    }

    def removeFriend = {
      Entity e = Entity.findByName(params.name)
      def c = Link.createCriteria()
      def linkInstance = c.get {
        eq('source',entityHelperService.loggedIn)
        eq('target',e)
        eq('type',metaDataService.ltFriend)
      }
      def d = Link.createCriteria()
      def linkInstanceBack = d.get {
        eq('source',e)
        eq('target',entityHelperService.loggedIn)
        eq('type',metaDataService.ltFriend)
      }
      if(linkInstance && linkInstanceBack) {
            def n = linkInstance.target.name
            try {
                linkInstance.delete(flush:true)
                linkInstanceBack.delete(flush:true)
                //flash.message = message(code:"removeFriend", args:[e.profile.fullName])
                redirect action:'show', params:[name:n]
            }
            catch(org.springframework.dao.DataIntegrityViolationException ex) {
                //flash.message = message(code:"removeFriendFailed", args:[e.profile.fullName])
                redirect action:'show', params:[name:n]
            }
        }
    }

}
