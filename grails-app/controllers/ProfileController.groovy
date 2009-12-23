import grails.converters.JSON
import de.uenterprise.ep.Entity
import de.uenterprise.ep.Link
import de.uenterprise.ep.EntityType
import profiles.FacProfile
import de.uenterprise.ep.Account
import profiles.UserProfile
import posts.ArticlePost
import lernardo.Event
import lernardo.Activity
import lernardo.Msg
import profiles.OrgProfile

class ProfileController {
    def geoCoderService
    def networkService
    def entityHelperService
    def metaDataService
    def FilterService
    def authenticateService
    def sessionFactory

    def index = { }

    def geocode = {
        def result = geoCoderService.geocodeLocation(params.name)
        render result as JSON
    }

    def disable = {
      Entity e = Entity.findByName(params.name)
      if (!e) {
        flash.message = message(code:"user.notFound", args:[params.name])
        response.sendError (404, "no such entity")
        return ;
      }

      e.user.enabled = false

      Link.findAllBySource(e)?.each { it.delete() }
      Link.findAllByTarget(e)?.each { it.delete() }

      flash.message = message(code:"user.deactivated", args:[e.profile.fullName])
      redirect action:'list'
    }

    def enable = {
      Entity e = Entity.findByName(params.name)
      if (!e) {
        flash.message = message(code:"user.notFound", args:[params.name])
        response.sendError (404, "no such entity")
        return ;
      }

      e.user.enabled = true
      flash.message = message(code:"user.activated", args:[e.profile.fullName])    
      redirect action:'list'
    }

    def create = { }

    def changePassword = {
      Entity e = Entity.findByName(params.name)
      return ['entity':e]
    }

    def checkPassword = {
      if (params.password == params.password2) {
        Entity e = Entity.findByName(params.name)
        e.user.password = authenticateService.encodePassword(params.password)
        e.save()
        flash.message = message(code:"pass.changed")
        redirect action:'showProfile', params:[name:e.name]
      }
      else {
        flash.message = message(code:"pass.notChanged")
        redirect action:changePassword, params:[name:params.name]
      }
    }

    def createOperator = {
      def entityInstance = new Entity()
      //entityInstance.properties = params
      return ['entityInstance':entityInstance,'entity':entityHelperService.loggedIn]
    }

    def saveOperator = {
      EntityType etOperator = metaDataService.etOperator

      Account user = Account.findByEmail (params.email)
      if (user) {
        flash.message = message(code:"user.existsMail", args:[params.email])
        redirect action:"createOperator", params:params
      }
      else {
        Entity etst = Entity.findByName (params.name)
        if (etst) {
          flash.message = message(code:"user.existsName", args:[params.name])
          redirect action:"createOperator", params:params
          return
        }

        entityHelperService.createEntityWithUserAndProfile (params.name, etOperator, params.email, params.fullName) {Entity ent->
          OrgProfile prf = ent.profile
          if (params.pass)
            ent.user.password = authenticateService.encodePassword(params.pass)
        }
        flash.message = message(code:"user.created", args:[params.name,'Admin'])
        redirect action:'showProfile', params:[name:params.name]
      }
    }

    def createHort = {
      def entityInstance = new Entity()
      entityInstance.properties = params
      return ['entityInstance':entityInstance,'entity':Entity.findByName(params.name)]
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
      new Link(source:Entity.findByName(params.name), target:Entity.findByName(params.entity), type:metaDataService.ltFriendship).save()
      new Link(source:Entity.findByName(params.entity), target:Entity.findByName(params.name), type:metaDataService.ltFriendship).save()

      flash.message = message(code:"user.created", args:[params.name,params.entity])
      redirect controller:'profile', action:'showProfile', params:[name:params.name]
    }

    def createSchool = {
      def entityInstance = new Entity()
      //entityInstance.properties = params
      return ['entityInstance':entityInstance,'entity':Entity.findByName(params.name)]
    }

    def saveSchool = {
      EntityType etFac = metaDataService.etSchool

      Account user = Account.findByEmail (params.email)
      if (user) {
        flash.message = message(code:"user.existsMail", args:[params.email])
        redirect action:"createSchool", params:params
        return
      }

      Entity etst = Entity.findByName (params.name)
      if (etst) {
        flash.message = message(code:"user.existsName", args:[params.name])
        redirect action:"createSchool", params:params
        return
      }

      entityHelperService.createEntityWithUserAndProfile (params.name, etFac, params.email, params.fullName) {Entity ent->
        FacProfile prf = ent.profile
        if (params.pass)
            ent.user.password = authenticateService.encodePassword(params.pass)
      }

      flash.message = message(code:"user.created", args:[params.name,params.entity])
      redirect controller:'profile', action:'showProfile', params:[name:params.name]
    }

    def createPaed = {
      def entityInstance = new Entity()
      //entityInstance.properties = params
      return ['entityInstance':entityInstance,'entity':entityHelperService.loggedIn]
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
        if (params.pass)
            ent.user.password = authenticateService.encodePassword(params.pass)
      }

      flash.message = message(code:"user.created", args:[params.name,'Admin'])
      redirect controller:'profile', action:'showProfile', params:[name:params.name]
    }

    def createClient = {
      def entityInstance = new Entity()
      entityInstance.properties = params
      return ['entityInstance':entityInstance,'entity':Entity.findByName(params.name)]
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
      new Link(source:Entity.findByName(params.name), target:Entity.findByName(params.entity), type:metaDataService.ltFriendship).save()
      new Link(source:Entity.findByName(params.entity), target:Entity.findByName(params.name), type:metaDataService.ltFriendship).save()

      flash.message = message(code:"user.created", args:[params.name,params.entity])
      redirect controller:'profile', action:'showProfile', params:[name:params.name]
    }

    def search = {
      return [entity:Entity.findByName(params.name)]
    }

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
      return [entity:e,eventList:Event.findAllByEntity(e,[sort:'dateCreated',order:'desc'])]
    }

    def showProfile = {
      Entity e = Entity.findByName(params.name)
      return [entity:e]
    }

    def showCalendar = {
      Entity e = Entity.findByName(params.name)
      return [entity:e,name:e.name]
    }

    def showArticleList = {
      params.offset = params.offset ? params.offset.toInteger(): 0
      params.max = params.max ? params.max.toInteger(): 10

      Entity e = Entity.findByName(params.name)
      return [entity:e,'articleList':ArticlePost.findAllByAuthor(e,params),'articleCount':ArticlePost.countByAuthor(e)]
    }

    def showActivityList = {
      params.offset = params.offset ? params.offset.toInteger(): 0
      params.max = params.max ? params.max.toInteger(): 10

      Entity e = Entity.findByName(params.name)
      return [entity:e,'activityList':Activity.findAllByOwner(e,params),'activityCount':Activity.countByOwner(e)]
    }

    def showLeistung = {
      Entity e = Entity.findByName(params.name)
      return [entity:e]
    }

    def showLocation = { // broken?
      Entity e = Entity.findByName(params.name)
      return [entity:e,location:geoCoderService.geocodeLocation(e.profile.city)]
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
      params.date = params.date ?: new Date()
        return ['entityList': Entity.findAllByType(EntityType.findByName('Client')),
                'entityCount': Entity.countByType(EntityType.findByName('Client')),
                'entity':entityHelperService.loggedIn,
                'date':params.date]
    }

    def list = {
        params.entityType = params.entityType ?: "all"
        params.offset = params.offset ? params.offset.toInteger(): 0
        params.max = params.max ? params.max.toInteger(): 10
        params.sort = params.sort

        println params

        List entities
        int count
        if (params.entityType == 'all') {
          entities = Entity.list(params)
          count = Entity.count() }
        else {
          entities = Entity.findAllByType(EntityType.findByName(params.entityType))
          count = entities.size() }
        return ['entityType': params.entityType,
                'entityList': entities,
                'entityCount': count,
                'entity':entityHelperService.loggedIn]
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
      linkInstance.type = metaDataService.ltFriendship
      linkInstance.target = e ;

      // for now just create a back-link for mutuality - a more elaborate workflow will be in order later on
      def linkBack = new Link()
      linkBack.source = e ;
      linkBack.type = metaDataService.ltFriendship
      linkBack.target = entityHelperService.loggedIn

      if(linkInstance.save(flush:true) && linkBack.save(flush:true)) {
        flash.message = message(code:"user.addFriend", args:[linkInstance.target.profile.fullName])

        new Event(entity:entityHelperService.loggedIn,
              content:'Du hast '+e.profile.fullName+' als Freund hinzugefügt.',
              date: new Date()).save()
        new Event(entity:e,
              content:entityHelperService.loggedIn.profile.fullName+' hat dich als Freund hinzugefügt',
              date: new Date()).save()

        redirect action:'showProfile', params:[name:linkInstance.target.name]
      }
      else {
        flash.message = message(code:"user.addFriendFailed", args:[linkInstance.target.profile.fullName])
        redirect action:'showProfile', params:[name:linkInstance.target.name]
      }
    }

    def removeFriend = {
      Entity e = Entity.findByName(params.name)
      def c = Link.createCriteria()
      def linkInstance = c.get {
        eq('source',entityHelperService.loggedIn)
        eq('target',e)
        eq('type',metaDataService.ltFriendship)
      }
      def d = Link.createCriteria()
      def linkInstanceBack = d.get {
        eq('source',e)
        eq('target',entityHelperService.loggedIn)
        eq('type',metaDataService.ltFriendship)
      }
      if(linkInstance && linkInstanceBack) {
            def n = linkInstance.target.name
            try {
                linkInstance.delete(flush:true)
                linkInstanceBack.delete(flush:true)
                flash.message = message(code:"user.removeFriend", args:[e.profile.fullName])
                redirect action:'showProfile', params:[name:n]
            }
            catch(org.springframework.dao.DataIntegrityViolationException ex) {
                flash.message = message(code:"user.removeFriendFailed", args:[e.profile.fullName])
                redirect action:'showProfile', params:[name:n]
            }
        }
    }

    def addBookmark = {
      Entity e = params.name ? Entity.findByName(params.name) : null
      if (!e) {
        flash.message = message(code:"user.notFound", args:[params.name])
        return
      }

      def linkInstance = new Link()
      linkInstance.source = entityHelperService.loggedIn
      linkInstance.type = metaDataService.ltBookmark
      linkInstance.target = e ;

      if(linkInstance.save(flush:true)) {
        flash.message = message(code:"user.addBookmark", args:[linkInstance.target.profile.fullName])
        redirect action:'showProfile', params:[name:linkInstance.target.name]
      }
      else {
        flash.message = message(code:"user.addBookmarkFailed", args:[linkInstance.target.profile.fullName])
        redirect action:'showProfile', params:[name:linkInstance.target.name]
      }
    }

    def removeBookmark = {
      Entity e = Entity.findByName(params.name)
      def c = Link.createCriteria()
      def linkInstance = c.get {
        eq('source',entityHelperService.loggedIn)
        eq('target',e)
        eq('type',metaDataService.ltBookmark)
      }
      if(linkInstance) {
            def n = linkInstance.target.name
            try {
                linkInstance.delete(flush:true)
                flash.message = message(code:"user.removeBookmark", args:[e.profile.fullName])
                redirect action:'showProfile', params:[name:n]
            }
            catch(org.springframework.dao.DataIntegrityViolationException ex) {
                flash.message = message(code:"user.removeBookmarkFailed", args:[e.profile.fullName])
                redirect action:'showProfile', params:[name:n]
            }
        }
    }

    def edit = {
        def entityInstance = Entity.findByName(params.name)

        if(!entityInstance) {
            flash.message = message(code:"user.notFound", args:[params.name])
            redirect action:'showProfile', model:[name:params.name]
        }
        else {
            return [ entityInstance : entityInstance ]
        }
    }

    def editFacility = {
        def entityInstance = Entity.findByName(params.name)

        if(!entityInstance) {
            flash.message = message(code:"user.notFound", args:[params.name])
            redirect action:'showProfile', model:[name:params.name]
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

                   msgInstance.errors.rejectValue("version", "msg.optimistic.locking.failure", "Another user has updated this lernardo.Msg while you were editing.")

                   render view:'edit', model:[entityInstance:entityInstance]
                   return
               }
           }
           entityInstance.properties = params
           if (params.title)
             entityInstance.profile.title = params.title
           entityInstance.profile.fullName = params.fullName
           if (params.birthDate)
             entityInstance.profile.birthDate = new Date(Integer.parseInt(params.birthDate_year)-1900,Integer.parseInt(params.birthDate_month)-1,Integer.parseInt(params.birthDate_day))
           if (params.PLZ)
             entityInstance.profile.PLZ = params.PLZ.toInteger()
           entityInstance.profile.city = params.city
           entityInstance.profile.street = params.street
           entityInstance.profile.tel = params.tel
           if (params.gender)
             entityInstance.profile.gender = params.gender.toInteger()
           if (params.biography)
             entityInstance.profile.biography = params.biography
           if (params.description)
             entityInstance.profile.description = params.description
         if(!entityInstance.hasErrors() && entityInstance.save()) {
               flash.message = message(code:"user.updated", args:[entityInstance.profile.fullName])

               redirect action:'showProfile', params:[name:entityInstance.name]
           }
           else {
               render view:'edit', model:[entityInstance:entityInstance]
           }
       }
       else {
           flash.message = message(code:"user.notFound", args:[params.id])
           redirect action:'showProfile', params:[name:entityHelperService.loggedIn.name]
       }
   }


}
