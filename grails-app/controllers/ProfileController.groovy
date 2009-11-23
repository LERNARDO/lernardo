import grails.converters.JSON
import de.uenterprise.ep.Entity
import de.uenterprise.ep.Link
import de.uenterprise.ep.EntityType
import profiles.FacProfile
import de.uenterprise.ep.Account
import profiles.UserProfile

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
        flash.message = message(code:"user.existsMail", args:[params.email])
        redirect action:"createOperator", params:params
        return
      }

      Entity etst = Entity.findByName (params.name)
      if (etst) {
        flash.message = message(code:"user.existsName", args:[params.name])
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
      flash.message = message(code:"user.created", args:[params.name])
      redirect action:'show', params:[name:params.name]
    }

    def createHort = {
      def entityInstance = new Entity()
      entityInstance.properties = params
      return ['entityInstance':entityInstance]
    }

    def saveHort = {
      EntityType etFac = metaDataService.etHort

      Account user = Account.findByEmail (params.email)
      if (user) {
        flash.message = message(code:"user.existsMail", args:[params.email])
        redirect action:"createHort", params:params
        return
      }

      Entity etst = Entity.findByName (params.name)
      if (etst) {
        flash.message = message(code:"user.existsName", args:[params.name])
        redirect action:"createHort", params:params
        return
      }

      entityHelperService.createEntityWithUserAndProfile (params.name, etFac, params.email, params.fullName) {Entity ent->
        FacProfile prf = ent.profile
        prf.city = params.city ?: ""
        prf.opened = "-"
        prf.description = "-"
        prf.tel = "-"
        ent.user.password = authenticateService.encodePassword("pass")
      }

      // create mutual relationship between Hort and Operator
      new Link(source:Entity.findByName(params.name), target:Entity.findByName(entityHelperService.loggedIn), type:metaDataService.ltFriend).save()
      new Link(source:Entity.findByName(entityHelperService.loggedIn), target:Entity.findByName(params.name), type:metaDataService.ltFriend).save()

      flash.message = message(code:"user.created", args:[params.name])
      redirect controller:'profile', action:'show', params:[name:entityHelperService.loggedIn.name]
    }

    def createPaed = {
      def entityInstance = new Entity()
      entityInstance.properties = params
      return ['entityInstance':entityInstance]
    }

    def savePaed = {
      EntityType etPaed = metaDataService.etPaed

      Account user = Account.findByEmail (params.email)
      if (user) {
        flash.message = message(code:"user.existsMail", args:[params.email])
        redirect action:"createPaed", params:params
        return
      }

      Entity etst = Entity.findByName (params.name)
      if (etst) {
        flash.message = message(code:"user.existsName", args:[params.name])
        redirect action:"createPaed", params:params
        return
      }

      entityHelperService.createEntityWithUserAndProfile (params.name, etPaed, params.email, params.fullName) {Entity ent->
        UserProfile prf = ent.profile
        prf.city = params.city ?: ""
        ent.user.password = authenticateService.encodePassword("pass")
      }

      // create mutual relationship between Paed and Hort
      new Link(source:Entity.findByName(params.name), target:Entity.findByName(entityHelperService.loggedIn), type:metaDataService.ltFriend).save()
      new Link(source:Entity.findByName(entityHelperService.loggedIn), target:Entity.findByName(params.name), type:metaDataService.ltFriend).save()

      flash.message = message(code:"user.created", args:[params.name])
      redirect controller:'profile', action:'show', params:[name:entityHelperService.loggedIn.name]
    }

    def createClient = {
      def entityInstance = new Entity()
      entityInstance.properties = params
      return ['entityInstance':entityInstance]
    }

    def saveClient = {
      EntityType etClient = metaDataService.etClient

      Account user = Account.findByEmail (params.email)
      if (user) {
        flash.message = message(code:"user.existsMail", args:[params.email])
        redirect action:"createClient", params:params
        return
      }

      Entity etst = Entity.findByName (params.name)
      if (etst) {
        flash.message = message(code:"user.existsName", args:[params.name])
        redirect action:"createClient", params:params
        return
      }

      entityHelperService.createEntityWithUserAndProfile (params.name, etClient, params.email, params.fullName) {Entity ent->
        UserProfile prf = ent.profile
        prf.city = params.city ?: ""
        ent.user.password = authenticateService.encodePassword("pass")
      }

      // create mutual relationship between Client and Hort
      new Link(source:Entity.findByName(params.name), target:Entity.findByName(entityHelperService.loggedIn), type:metaDataService.ltFriend).save()
      new Link(source:Entity.findByName(entityHelperService.loggedIn), target:Entity.findByName(params.name), type:metaDataService.ltFriend).save()

      flash.message = message(code:"user.created", args:[params.name])
      redirect controller:'profile', action:'show', params:[name:entityHelperService.loggedIn.name]
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
        params.sort = "type"
        return ['entityType': params.entityType,
                'entityList': Entity.list(params),
                'entityCount': Entity.count()]
    }

    def show = {
        def e = Entity.findByName(params.name)
        if (!e) {
            flash.message = message(code:"user.notFound", args:[params.name])
            return
        }
        return ['entity':e,'friendsList':networkService.findFriendsOf(e)]
    }

    def addFriend = {
      Entity e = params.name ? Entity.findByName(params.name) : null
      if (!e) {
        flash.message = message(code:"user.notFound", args:[params.name])
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
        flash.message = message(code:"user.addFriend", args:[linkInstance.target.profile.fullName])
        redirect action:'show', params:[name:linkInstance.target.name]
      }
      else {
        flash.message = message(code:"user.addFriendFailed", args:[linkInstance.target.profile.fullName])
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
                flash.message = message(code:"user.removeFriend", args:[e.profile.fullName])
                redirect action:'show', params:[name:n]
            }
            catch(org.springframework.dao.DataIntegrityViolationException ex) {
                flash.message = message(code:"user.removeFriendFailed", args:[e.profile.fullName])
                redirect action:'show', params:[name:n]
            }
        }
    }

    def edit = {
        def entityInstance = Entity.findByName(params.name)

        if(!entityInstance) {
            flash.message = message(code:"user.notFound", args:[params.name])
            redirect action:'show', model:[name:params.name]
        }
        else {
            return [ entityInstance : entityInstance ]
        }
    }

  def update = {
       def entityInstance = Entity.get( params.id )
       if(entityInstance) {
           if(params.version) {
               def version = params.version.toLong()
               if(entityInstance.version > version) {

                   msgInstance.errors.rejectValue("version", "msg.optimistic.locking.failure", "Another user has updated this Msg while you were editing.")

                   render view:'edit', model:[entityInstance:entityInstance]
                   return
               }
           }
           entityInstance.properties = params
           entityInstance.profile.title = params.title
           entityInstance.profile.fullName = params.fullName
           entityInstance.profile.birthDate = new Date(Integer.parseInt(params.birthDate_year)-1900,Integer.parseInt(params.birthDate_month)-1,Integer.parseInt(params.birthDate_day))
           entityInstance.profile.PLZ = params.PLZ.toInteger()
           entityInstance.profile.city = params.city
           entityInstance.profile.street = params.street
           entityInstance.profile.tel = params.tel
           entityInstance.profile.gender = params.gender
           entityInstance.profile.biography = params.biography
         if(!entityInstance.hasErrors() && entityInstance.save()) {
               flash.message = message(code:"user.updated", args:[entityInstance.name])

               redirect action:'show', params:[name:entityInstance.name]
           }
           else {
               render view:'edit', model:[entityInstance:entityInstance]
           }
       }
       else {
           flash.message = message(code:"user.notFound", args:[params.id])
           redirect action:'show', params:[name:entityHelperService.loggedIn.name]
       }
   }


}
