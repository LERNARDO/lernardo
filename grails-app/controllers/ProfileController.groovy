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
import lernardo.Attendance
import java.text.SimpleDateFormat
import lernardo.Group
import org.springframework.web.servlet.support.RequestContextUtils

class ProfileController {
    def geoCoderService
    def networkService
    def entityHelperService
    def metaDataService
    def filterService
    def authenticateService
    def sessionFactory
    def functionService

    def index = { }

    def geocode = {
        def result = geoCoderService.geocodeLocation(params.name)
        render result as JSON
    }

    def showUsers = {
      params.glossary = params.glossary ?: 'Alle'
      params.max = Math.min( params.max ? params.max.toInteger() : 6,  100)
      params.offset = params.offset ? params.offset.toInteger() : 0

      List users = []
      def numUsers = 0

      if (params.glossary == "Alle") {
        def c = Entity.createCriteria()
        users = c.list {
          profile {
            order("fullName", "asc")
          }
          maxResults (params.max)
          firstResult(params.offset)
        }
        numUsers = Entity.count()
      }
      else {
        log.debug ("start glossary for " + params.glossary)
        def c = Entity.createCriteria()
        users = c.list {
          profile {
            ilike('fullName',params.glossary+"%")
            order("fullName", "asc")
          }
          cacheable(true)
        }
        log.debug ("found {} glossary entries " + users.size())
        numUsers = users.size()
        def upperBound = params.offset + 6 < users.size() ? params.offset + 6 : users.size()
        users = users.subList(params.offset,upperBound)
      }

      render(template:'allusers', model:[entities: users, numEntities: numUsers, glossary: params.glossary])
    }

    def changeFacilities = {
      List horte = []
      List working = Link.findAllBySourceAndType(Entity.findByName(params.name), metaDataService.ltWorking)
      working.each {
          horte << it.target
      }
      [entity: Entity.findByName(params.name),
       hortList: Entity.findAllByType(metaDataService.etHort),
       horte: horte]
    }

    def saveFacilities = {

      // delete old links
      Link.findAllBySourceAndType(Entity.findByName(params.name), metaDataService.ltWorking)?.each { it.delete() }

      def fac = params.facilities
      if (fac.class.isArray()) {
        fac.each {
            println it
            new Link(source: Entity.findByName(params.name), target: Entity.findById(it), type: metaDataService.ltWorking).save()
          }
      }
      else
        new Link(source: Entity.findByName(params.name), target: Entity.findById(params.facilities), type: metaDataService.ltWorking).save()      
      
      redirect action:'showProfile', params:[name:params.name]
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

      try {
        entityHelperService.createEntityWithUserAndProfile (params.name, etFac, params.email, params.fullName) {Entity ent->
          FacProfile prf = ent.profile
          prf.city = params.city ?: ""
          prf.opened = "-"
          prf.description = "-"
          prf.tel = "-"
          ent.user.password = authenticateService.encodePassword("pass")
        }
      } catch (de.uenterprise.ep.EntityException ee) {
        render (view:"createHort", model:[entityInstance:ee.entity, entity:entityHelperService.loggedIn])
        return
      }

      // add relationship to operator
      new Link(source:Entity.findByName(params.name), target:Entity.findByName(params.entity), type:metaDataService.ltOperation).save()

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

      try {
        entityHelperService.createEntityWithUserAndProfile (params.name, etFac, params.email, params.fullName) {Entity ent->
          FacProfile prf = ent.profile
          if (params.pass)
              ent.user.password = authenticateService.encodePassword(params.pass)
        }
      } catch (de.uenterprise.ep.EntityException ee) {
        render (view:"createSchool", model:[entityInstance:ee.entity, entity:entityHelperService.loggedIn])
        return
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

      try {
        entityHelperService.createEntityWithUserAndProfile (params.name, etPaed, params.email, params.fullName) {Entity ent->
          UserProfile prf = ent.profile
          if (params.pass)
              ent.user.password = authenticateService.encodePassword(params.pass)
        }
      } catch (de.uenterprise.ep.EntityException ee) {
        render (view:"createPaed", model:[entityInstance:ee.entity, entity:entityHelperService.loggedIn])
        return
      }

      // add relationship to facility
      new Link(source:Entity.findByName(params.name), target:Entity.findByName(params.entity), type:metaDataService.ltWorking).save()

      flash.message = message(code:"user.created", args:[params.name,'Admin'])
      redirect controller:'profile', action:'showProfile', params:[name:params.name]
    }

    def createClient = {
      def entityInstance = new Entity()
      entityInstance.properties = params
      entityInstance.name = ""
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

      try {
        entityHelperService.createEntityWithUserAndProfile (params.name, etClient, params.email, params.fullName) {Entity ent->
          UserProfile prf = ent.profile
          prf.birthDate = new Date(Integer.parseInt(params.birthDate_year)-1900,Integer.parseInt(params.birthDate_month)-1,Integer.parseInt(params.birthDate_day))
          prf.PLZ = params.PLZ != "" ? params.PLZ.toInteger() : null
          prf.city = params.city ?: ""
          prf.street = params.street ?: ""
          prf.tel = params.tel ?: ""
          prf.gender = params.gender
          ent.user.password = authenticateService.encodePassword("pass")
        }
      } catch (de.uenterprise.ep.EntityException ee) {
        render (view:"createClient", model:[entityInstance:ee.entity, entity:entityHelperService.loggedIn])
        return
      }

      // add relationship to facility
      new Link(source:Entity.findByName(params.name), target:Entity.findByName(params.entity), type:metaDataService.ltClientship).save()

      flash.message = message(code:"user.created", args:[params.name,params.entity])
      redirect controller:'profile', action:'showProfile', params:[name:params.name]
    }

    def search = {
      return [entity:Entity.findByName(params.name),
              glossary: '-']
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
      return [entity:e,eventList:Event.findAllByEntity(e,[sort:'dateCreated',order:'asc'])]
    }

    def showProfile = {
      params.name = params.name ?: entityHelperService.loggedIn.name
      Entity e = Entity.findByName(params.name)

      List horte = []
      List working = Link.findAllBySourceAndType(e, metaDataService.ltWorking)
      working.each {
          horte << it.target.profile.fullName
      }
      def ret = horte.join(', ')

      def groups = []
      Group.list().each {
        for (a in it.members) {
          if (a == Entity.findByName(params.name))
            groups << it
        }
      }

      return [entity:e,
              horte:ret,
              groups: groups]
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

      // find all activities the entity is owner, or in the paed or client list
      // Unfortunately we loose control over sort and max, need to find a workaround
      def activityList = Activity.findAllByOwner(e)
      Activity.list().each {
        for (a in it.paeds) {
          if (a == Entity.findByName(params.name))
            activityList << it
        }
        for (a in it.clients) {
          if (a == Entity.findByName(params.name))
            activityList << it
        }
      }
  
      return [entity:e,'activityList':activityList,'activityCount':activityList.size()]
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
        params.date = new Date(params.year.toInteger()-1900,params.month.toInteger()-1,params.day.toInteger())
        Entity entity = entityHelperService.loggedIn
        def image = "hort_" + entity.name + ".jpg"

        int sumAttend = 0
        int sumEat = 0

        List clients = []
        List attend = Attendance.findAllByDate(params.date)
        attend.each {
          clients << it.client
          if (it.didAttend) sumAttend++
          if (it.didEat) sumEat++
        }
      
        return ['image': image,
                'pdf': params,
                'entityList': clients,
                'date': params.date,
                'attend': attend,
                'sumAttend': sumAttend,
                'sumEat': sumEat]
    }

    def attendance = {
      println params
      params.date = params.date ? new Date(Integer.parseInt(params.date_year)-1900,Integer.parseInt(params.date_month)-1,Integer.parseInt(params.date_day),00,00): new Date()

      SimpleDateFormat sd = new SimpleDateFormat("yyyy-MM-dd");
      String dateString = sd.format(params.date)       
      log.debug "param date: "+dateString
      Date date = sd.parse(dateString)

      int year = date.getYear()
      int month = date.getMonth() // 0 to 11
      int day = date.getDate()

      List clients = []
      List attend = Attendance.findAllByDate(date)
      attend.each {
        clients << it.client
      }

      if (clients) {
        log.debug "attendances found!"
      }
      else {
        // find all clients of a facility
        List result = Link.findAllByTargetAndType(Entity.findByName(params.name),metaDataService.ltClientship)
        result.each {
          clients << it.source
        }
      }
      
      return ['entityList': clients,
              'entityCount': clients.size(),
              'entity':entityHelperService.loggedIn,
              'date':params.date,
              'year':year,
              'month':month,
              'day':day,
              'attend':attend]
    }

    def saveAttendance = {
      println params

      int counter = 0
      params.entities.each {

        Boolean tempAttend = false
        Boolean tempEat = false

        // ugly but works
        if (counter == 0) {tempAttend = params.anwesend0 ?: false; tempEat = params.essen0 ?: false}
        if (counter == 1) {tempAttend = params.anwesend1 ?: false; tempEat = params.essen1 ?: false}
        if (counter == 2) {tempAttend = params.anwesend2 ?: false; tempEat = params.essen2 ?: false}
        if (counter == 3) {tempAttend = params.anwesend3 ?: false; tempEat = params.essen3 ?: false}
        if (counter == 4) {tempAttend = params.anwesend4 ?: false; tempEat = params.essen4 ?: false}
        if (counter == 5) {tempAttend = params.anwesend5 ?: false; tempEat = params.essen5 ?: false}
        if (counter == 6) {tempAttend = params.anwesend6 ?: false; tempEat = params.essen6 ?: false}
        if (counter == 7) {tempAttend = params.anwesend7 ?: false; tempEat = params.essen7 ?: false}
        if (counter == 8) {tempAttend = params.anwesend8 ?: false; tempEat = params.essen8 ?: false}
        if (counter == 9) {tempAttend = params.anwesend9 ?: false; tempEat = params.essen9 ?: false}
        if (counter == 10) {tempAttend = params.anwesend10 ?: false; tempEat = params.essen10 ?: false}
        if (counter == 11) {tempAttend = params.anwesend11 ?: false; tempEat = params.essen11 ?: false}
        if (counter == 12) {tempAttend = params.anwesend12 ?: false; tempEat = params.essen12 ?: false}
        if (counter == 13) {tempAttend = params.anwesend13 ?: false; tempEat = params.essen13 ?: false}
        if (counter == 14) {tempAttend = params.anwesend14 ?: false; tempEat = params.essen14 ?: false}
        if (counter == 15) {tempAttend = params.anwesend15 ?: false; tempEat = params.essen15 ?: false}
        if (counter == 16) {tempAttend = params.anwesend16 ?: false; tempEat = params.essen16 ?: false}
        if (counter == 17) {tempAttend = params.anwesend17 ?: false; tempEat = params.essen17 ?: false}
        if (counter == 18) {tempAttend = params.anwesend18 ?: false; tempEat = params.essen18 ?: false}
        if (counter == 19) {tempAttend = params.anwesend19 ?: false; tempEat = params.essen19 ?: false}
        if (counter == 20) {tempAttend = params.anwesend20 ?: false; tempEat = params.essen20 ?: false}
        if (counter == 21) {tempAttend = params.anwesend21 ?: false; tempEat = params.essen21 ?: false}
        if (counter == 22) {tempAttend = params.anwesend22 ?: false; tempEat = params.essen22 ?: false}
        if (counter == 23) {tempAttend = params.anwesend23 ?: false; tempEat = params.essen23 ?: false}
        if (counter == 24) {tempAttend = params.anwesend24 ?: false; tempEat = params.essen24 ?: false}

        def a = new Attendance(client: Entity.findByName(it), didAttend: tempAttend, didEat: tempEat, date: new Date(Integer.parseInt(params.year), Integer.parseInt(params.month), Integer.parseInt(params.day)))

        log.debug "created attendance"

        log.debug a.client
        log.debug a.didAttend
        log.debug a.didEat
        log.debug a.date

        a.save()

        counter++
      }

      SimpleDateFormat sd = new SimpleDateFormat("dd.MM.yyyy")
      String dateString = sd.format(new Date(Integer.parseInt(params.year), Integer.parseInt(params.month), Integer.parseInt(params.day)))
      flash.message = message(code:"attendance.saved", args:[dateString])

      Date date = sd.parse(dateString)

      int year = date.getYear()+1900
      int month = date.getMonth()+1 // 0 to 11
      int day = date.getDate()

      redirect action: 'attendance', params: [name: params.name, date: date, date_year: year, date_month: month, date_day: day]
    }

    def list = {
        params.entityType = params.entityType ?: "all"
        params.offset = params.offset ? params.offset.toInteger(): 0
        params.max = params.max ? params.max.toInteger(): 10

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
      linkBack.source = e
      linkBack.type = metaDataService.ltFriendship
      linkBack.target = entityHelperService.loggedIn

      if(linkInstance.save(flush:true) && linkBack.save(flush:true)) {
        flash.message = message(code:"user.addFriend", args:[linkInstance.target.profile.fullName])

        functionService.createEvent(entityHelperService.loggedIn, 'Du hast '+e.profile.fullName+' als Freund hinzugefügt.')
        functionService.createEvent(e, entityHelperService.loggedIn.profile.fullName+' hat dich als Freund hinzugefügt.')

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

                functionService.createEvent(entityHelperService.loggedIn, 'Du hast '+e.profile.fullName+' als Freund entfernt.')
                functionService.createEvent(e, entityHelperService.loggedIn.profile.fullName+' hat dich als Freund entfernt.')

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
        def entity = Entity.findByName(params.name)

        if(!entity) {
            flash.message = message(code:"user.notFound", args:[params.name])
            redirect action:'showProfile', model:[name:params.name]
        }
        else {
            return ['entity': entity]
        }
    }

    def editFacility = {
        def entityInstance = Entity.findByName(params.name)

        if(!entityInstance) {
            flash.message = message(code:"user.notFound", args:[params.name])
            redirect action:'showProfile', model:[name:params.name]
        }
        else {
            return [ entityInstance : entityInstance, entity: entityInstance ]
        }
    }

    def update = {
       def entity = Entity.get( params.id )
       if(entity) {

           entity.properties = params
           if (params.title)
             entity.profile.title = params.title
           entity.profile.fullName = params.fullName
           if (params.birthDate)
             entity.profile.birthDate = new Date(Integer.parseInt(params.birthDate_year)-1900,Integer.parseInt(params.birthDate_month)-1,Integer.parseInt(params.birthDate_day))
           if (params.PLZ)
             entity.profile.PLZ = params.PLZ.toInteger()
           entity.profile.city = params.city
           entity.profile.street = params.street
           entity.profile.tel = params.tel
           if (params.gender)
             entity.profile.gender = params.gender.toInteger()
           if (params.biography)
             entity.profile.biography = params.biography
           if (params.description)
             entity.profile.description = params.description
           if (params.showTips)
             entity.profile.showTips = true
           else
             entity.profile.showTips = false
           if (params.foodCosts)
             entity.profile.foodCosts = params.foodCosts.toInteger()
           if (params.lang == '1') {
               entity.user.locale = new Locale ("de", "DE")
               Locale locale = entity.user.locale
               RequestContextUtils.getLocaleResolver(request).setLocale(request, response, locale)
           }
           if (params.lang == '2') {
               entity.user.locale = new Locale ("ES", "ES")
               Locale locale = entity.user.locale
               RequestContextUtils.getLocaleResolver(request).setLocale(request, response, locale)
           }
           if(!entity.hasErrors() && entity.save()) {
               flash.message = message(code:"user.updated", args:[entity.profile.fullName])

               redirect action:'showProfile', params:[name:entity.name]
           }
           else {
               render view:'edit', model:[entityInstance:entity]
           }
       }
       else {
           flash.message = message(code:"user.notFound", args:[params.id])
           redirect action:'showProfile', params:[name:entityHelperService.loggedIn.name]
       }
   }

}