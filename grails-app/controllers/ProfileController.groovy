import grails.converters.JSON
import de.uenterprise.ep.Entity
import de.uenterprise.ep.Link
import de.uenterprise.ep.EntityType

import posts.ArticlePost
import lernardo.Event
import lernardo.Msg

import lernardo.Attendance
import java.text.SimpleDateFormat

import de.uenterprise.ep.EntityHelperService
import org.grails.plugins.springsecurity.service.AuthenticateService
import org.hibernate.SessionFactory
import standard.GeoCoderService
import standard.MetaDataService
import standard.NetworkService
import standard.FunctionService
import standard.FilterService

class ProfileController {
    GeoCoderService geoCoderService
    NetworkService networkService
    EntityHelperService entityHelperService
    MetaDataService metaDataService
    FilterService filterService
    AuthenticateService authenticateService
    SessionFactory sessionFactory
    FunctionService functionService

    def index = { }

    def createNotification = {
        Msg msgInstance = new Msg()
        return [msgInstance:msgInstance,
                entity: entityHelperService.loggedIn]
    }

    def saveNotification = {
       def c = Entity.createCriteria()
        def userList = c.list {
          ne("type", metaDataService.etCommentTemplate)
          ne("type", metaDataService.etActivity)
          ne("type", metaDataService.etTemplate)
          ne("type", metaDataService.etResource)
          ne("type", metaDataService.etGroupColony)
          ne("type", metaDataService.etGroupFamily)
          ne("type", metaDataService.etGroupLevel)
          ne("type", metaDataService.etGroupNetwork)
        }

       userList.each {
          functionService.createEvent(it, 'Du hast eine Administrator-Nachricht erhalten.')
          Msg msgInstance = new Msg(params)
          msgInstance.entity = it
          msgInstance.dateCreated = new Date()
          msgInstance.sender = Entity.findByName('lernardoadmin')
          msgInstance.receiver = it

          if(!msgInstance.save(flush:true)) {
              log.debug ("Notification for user" + msgInstance.entity.profile.fullName + "could not be saved")
          }
       }
       flash.message = message(code:"admin.notificationSuccess")
       redirect controller: entityHelperService.loggedIn.type.supertype.name + 'Profile', action:"show", id: entityHelperService.loggedIn.id
    }

    def geocode = {
        def result = geoCoderService.geocodeLocation(params.name)
        render result as JSON
    }

    def giveAdminRole = {
      Entity entity = Entity.get(params.id)
      entity?.user?.addToAuthorities (metaDataService.adminRole)
      redirect action:'list'
    }

    def takeAdminRole = {
      Entity entity = Entity.get(params.id)
      entity?.user?.removeFromAuthorities (metaDataService.adminRole)
      redirect action:'list'
    }

    def showUsers = {
      params.glossary = params.glossary ?: 'Alle'
      params.max = Math.min(params.max ? params.int('max') : 6,  100)
      params.offset = params.offset ? params.int('offset') : 0

      List users = []
      def numUsers = 0

      if (params.glossary == "Alle") {
        def c = Entity.createCriteria()
        users = c.list {
          ne("type", metaDataService.etCommentTemplate)
          ne("type", metaDataService.etActivity)
          ne("type", metaDataService.etTemplate)
          ne("type", metaDataService.etResource)
          ne("type", metaDataService.etGroupColony)
          ne("type", metaDataService.etGroupFamily)
          ne("type", metaDataService.etGroupLevel)
          ne("type", metaDataService.etGroupNetwork)
          profile {
            order("lastName", "asc")
          }
        }
        numUsers = users.size()
        def upperBound = params.offset + 6 < users.size() ? params.offset + 6 : users.size()
        users = users.subList(params.offset,upperBound)
      }
      else {
        log.debug ("start glossary for " + params.glossary)
        def c = Entity.createCriteria()
        users = c.list {
          ne("type", metaDataService.etCommentTemplate)
          ne("type", metaDataService.etActivity)
          ne("type", metaDataService.etTemplate)
          ne("type", metaDataService.etResource)
          ne("type", metaDataService.etGroupColony)
          ne("type", metaDataService.etGroupFamily)
          ne("type", metaDataService.etGroupLevel)
          ne("type", metaDataService.etGroupNetwork)
          profile {
            ilike("fullName",params.glossary+"%")
            order("fullName", "asc")
          }
          cacheable(true)
        }
        numUsers = users.size()
        def upperBound = params.offset + 6 < users.size() ? params.offset + 6 : users.size()
        users = users.subList(params.offset,upperBound)
      }

      render(template:'allusers', model:[entities: users, numEntities: numUsers, glossary: params.glossary])
    }

    def changeFacilities = {
      List links = Link.findAllBySourceAndType(Entity.findByName(params.name), metaDataService.ltWorking)
      List facilities = links.collect {it.target}
      return [entity: Entity.findByName(params.name),
              facilityList: Entity.findAllByType(metaDataService.etFacility),
              facilities: facilities]
    }

    def saveFacilities = {

      // delete old links
      Link.findAllBySourceAndType(Entity.get(params.id), metaDataService.ltWorking)?.each { it.delete() }

      def fac = params.facilities
      if (fac.class.isArray()) {
        fac.each {
            new Link(source: Entity.get(params.id), target: Entity.findById(it), type: metaDataService.ltWorking).save()
          }
      }
      else
        new Link(source: Entity.get(params.id), target: Entity.findById(params.facilities), type: metaDataService.ltWorking).save()      
      
      redirect controller: entity.type.supertype.name + 'Profile', action:'show', id: params.id
    }

    def disable = {
      Entity e = Entity.get(params.id)
      if (!e) {
        flash.message = message(code:"user.notFound", args:[params.id])
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
      Entity e = Entity.get(params.id)
      if (!e) {
        flash.message = message(code:"user.notFound", args:[params.id])
        response.sendError (404, "no such entity")
        return ;
      }

      e.user.enabled = true
      flash.message = message(code:"user.activated", args:[e.profile.fullName])    
      redirect action:'list'
    }

    def create = { }

    def changePassword = {
      Entity entity = Entity.get(params.id)
      return ['entity': entity]
    }

    def checkPassword = {
      if (params.password == params.password2) {
        Entity entity = Entity.get(params.id)
        entity.user.password = authenticateService.encodePassword(params.password)
        entity.save()
        flash.message = message(code:"pass.changed")
        redirect controller: entity.type.supertype.name + 'Profile', action:'show', id:entity.id
      }
      else {
        flash.message = message(code:"pass.notChanged")
        redirect action:changePassword, params:[name:params.name]
      }
    }

    def search = {
      return ['entity': Entity.get(params.id),
              'glossary': '-']
    }

    def searchMe = {
      if (!params.name) {
        render "Bitte einen Namen eingeben!"
        return
      }
      List searchList = filterService.findUsers(params.name)
      if (searchList.size() == 0) {
        render "Keine Ergebnisse gefunden!"
        return
      }
      else {
        render(template:'searchresults', model:[searchList: searchList])
      }
    }

    def showNews = {
      Entity entity = Entity.get(params.id)
      return ['entity': entity,
              'eventList': Event.findAllByEntity(entity, [sort:'dateCreated',order:'asc'])]
    }

    def showProfile = {
      params.name = params.name ?: entityHelperService.loggedIn.name
      Entity e = Entity.findByName(params.name)

      List links = Link.findAllBySourceAndType(e, metaDataService.ltWorking)
      List facilities = links.collect {it.target.profile.fullName}
      def ret = facilities.join(', ')

      // find groups the entity belongs to
      links = Link.findAllBySourceAndType(e, metaDataService.ltGroup)

      List groups = links.collect {it.target}

/*      Group.list().each {
        for (a in it.members) {
          if (a == Entity.findByName(params.name))
            groups << it
        }
      }*/

      return [entity: e,
              facilities: ret,
              groups: groups]
    }

    def showCalendar = {
      Entity entity = Entity.get(params.id)
      return ['entity': entity,
              'name': entity.name]
    }

    def showArticleList = {
      params.offset = params.offset ? params.int('offset'): 0
      params.max = params.max ? params.int('max'): 10

      Entity entity = Entity.get(params.id)
      return ['entity': entity,
              'articleList': ArticlePost.findAllByAuthor(entity, params),
              'articleCount': ArticlePost.countByAuthor(entity)]
    }

    def showActivityList = {
      params.offset = params.offset ? params.int('offset'): 0
      params.max = params.max ? params.int('max'): 10

      Entity entity = Entity.get(params.id)

      // find all activities the entity is owner, or in the educator or client list
      // Unfortunately we loose control over sort and max, need to find a workaround
      def activityList = Activity.findAllByOwner(entity)
      Activity.list().each {
        for (a in it.educators) {
          if (a == entity)
            activityList << it
        }
        for (a in it.clients) {
          if (a == entity)
            activityList << it
        }
      }
  
      return ['entity': entity,
              'activityList': activityList,
              'activityCount': activityList.size()]
    }

    def showLocation = { // broken?
      Entity entity = Entity.get(params.id)
      return ['entity': entity,
              'location': geoCoderService.geocodeLocation(entity.profile.city)]
    }

    def print = {
        // find out if this works without this workaround now
        //params.date = new Date(params.year.toInteger()-1900,params.month.toInteger()-1,params.day.toInteger())
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
      //params.date = params.date ? new Date(Integer.parseInt(params.date_year)-1900,Integer.parseInt(params.date_month)-1,Integer.parseInt(params.date_day),00,00): new Date()
      params.date = params.date ?: new Date()

      SimpleDateFormat sd = new SimpleDateFormat("yyyy-MM-dd");
      String dateString = sd.format(params.date)       
      log.debug "param date: "+dateString
      Date date = sd.parse(dateString)

      int year = date.getYear()
      int month = date.getMonth() // 0 to 11
      int day = date.getDate()

      List attend = Attendance.findAllByDate(date)
      List clients = attend.collect {it.client}

      if (clients) {
        log.debug "attendances found!"
      }
      else {
        // find all clients of a facility
        List links = Link.findAllByTargetAndType(Entity.get(params.id),metaDataService.ltClientship)
        clients = links.collect {it.source}
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

        Attendance a = new Attendance(client: Entity.get(it), didAttend: tempAttend, didEat: tempEat, date: new Date(Integer.parseInt(params.year), Integer.parseInt(params.month), Integer.parseInt(params.day)))

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
        params.offset = params.offset ? params.int('offset'): 0
        params.max = params.max ? params.int('max'): 10

        List entities
        int count
        if (params.entityType == 'all') {
          def c = Entity.createCriteria()
          entities = c.list {
            ne("type", metaDataService.etCommentTemplate)
            ne("type", metaDataService.etActivity)
            ne("type", metaDataService.etTemplate)
            ne("type", metaDataService.etResource)
            ne("type", metaDataService.etGroupColony)
            ne("type", metaDataService.etGroupFamily)
            ne("type", metaDataService.etGroupLevel)
            ne("type", metaDataService.etGroupNetwork)
            if (!authenticateService.ifAllGranted('ROLE_SYSTEMADMIN'))
              ne("name", "lernardoadmin")
              ne("type", metaDataService.etUser)
          }

          //entities = Entity.list(params)
          count = entities.size()
          def upperBound = params.offset + 10 < entities.size() ? params.offset + 10 : entities.size()
          entities = entities.subList(params.offset,upperBound)
        }
        else {
          entities = Entity.findAllByType(EntityType.findByName(params.entityType))
          count = entities.size() }
        return ['entityType': params.entityType,
                'entityList': entities,
                'entityCount': count,
                'entity':entityHelperService.loggedIn]
    }

    def addFriend = {
      Entity entity = Entity.get(params.id)

      def linkInstance = new Link()
      linkInstance.source = entityHelperService.loggedIn
      linkInstance.type = metaDataService.ltFriendship
      linkInstance.target = entity

      // for now just create a back-link for mutuality - a more elaborate workflow will be in order later on
      def linkBack = new Link()
      linkBack.source = entity
      linkBack.type = metaDataService.ltFriendship
      linkBack.target = entityHelperService.loggedIn

      if(linkInstance.save(flush:true) && linkBack.save(flush:true)) {
        def name = linkInstance.target.profile.fullName ?: linkInstance.target.profile.lastName + " " + linkInstance.target.profile.firstName
        flash.message = message(code:"user.addFriend", args:[name])

        functionService.createEvent(entityHelperService.loggedIn, 'Du hast '+name+' als Freund hinzugefügt.')
        functionService.createEvent(entity, entityHelperService.loggedIn.profile.id+' hat dich als Freund hinzugefügt.')

        redirect controller: entity.type.supertype.name + 'Profile', action:'show', params:[id:entity.id, entity:entity.id]
      }
      else {
        flash.message = message(code:"user.addFriendFailed", args:[linkInstance.target.profile.id])
        redirect controller: entity.type.supertype.name + 'Profile', action:'show', id:linkInstance.target.id
      }
    }

    def removeFriend = {
      Entity entity = Entity.get(params.id)

      def c = Link.createCriteria()
      def linkInstance = c.get {
        eq('source',entityHelperService.loggedIn)
        eq('target',entity)
        eq('type',metaDataService.ltFriendship)
      }
      def d = Link.createCriteria()
      def linkInstanceBack = d.get {
        eq('source',entity)
        eq('target',entityHelperService.loggedIn)
        eq('type',metaDataService.ltFriendship)
      }
      if(linkInstance && linkInstanceBack) {
            def n = linkInstance.target.name
            try {
                linkInstance.delete(flush:true)
                linkInstanceBack.delete(flush:true)
                def name = entity.profile.fullName ?: entity.profile.lastName + " " + entity.profile.firstName
                flash.message = message(code:"user.removeFriend", args:[name])

                functionService.createEvent(entityHelperService.loggedIn, 'Du hast '+name+' als Freund entfernt.')
                functionService.createEvent(entity, entityHelperService.loggedIn.profile.id+' hat dich als Freund entfernt.')

                redirect controller: entity.type.supertype.name + 'Profile', action:'show', params:[id:entity.id, entity:entity.id]
            }
            catch(org.springframework.dao.DataIntegrityViolationException ex) {
                flash.message = message(code:"user.removeFriendFailed", args:[entity.profile.id])
                redirect controller: entity.type.supertype.name + 'Profile', action:'show', id:linkInstance.target.id
            }
        }
    }

    def addBookmark = {
      Entity entity = Entity.get(params.id)
      if (!entity) {
        flash.message = message(code:"user.notFound", args:[params.id])
        return
      }

      Link linkInstance = new Link()
      linkInstance.source = entityHelperService.loggedIn
      linkInstance.type = metaDataService.ltBookmark
      linkInstance.target = entity

      if(linkInstance.save(flush:true)) {
        flash.message = message(code:"user.addBookmark", args:[linkInstance.target.profile.fullName])
        redirect controller: entity.type.supertype.name + 'Profile', action:'show', id:linkInstance.target.id
      }
      else {
        flash.message = message(code:"user.addBookmarkFailed", args:[linkInstance.target.profile.fullName])
        redirect controller: entity.type.supertype.name + 'Profile', action:'show', id:linkInstance.target.id
      }
    }

    def removeBookmark = {
      Entity entity = Entity.get(params.id)
      def c = Link.createCriteria()
      def linkInstance = c.get {
        eq('source',entityHelperService.loggedIn)
        eq('target',entity)
        eq('type',metaDataService.ltBookmark)
      }
      if(linkInstance) {
            def n = linkInstance.target.name
            try {
                linkInstance.delete(flush:true)
                flash.message = message(code:"user.removeBookmark", args:[entity.profile.fullName])
                redirect controller: entity.type.supertype.name + 'Profile', action:'show', id:linkInstance.target.id
            }
            catch(org.springframework.dao.DataIntegrityViolationException ex) {
                flash.message = message(code:"user.removeBookmarkFailed", args:[entity.profile.fullName])
                redirect controller: entity.type.supertype.name + 'Profile', action:'show', id:linkInstance.target.id
            }
        }
    }

}