package at.uenterprise.erp

import grails.converters.JSON

import at.openfactory.ep.Entity
import at.openfactory.ep.Link
import at.openfactory.ep.EntityType
import at.openfactory.ep.EntityHelperService
import at.openfactory.ep.SecHelperService

import java.text.SimpleDateFormat
import org.hibernate.SessionFactory

import at.uenterprise.erp.profiles.ActivityProfile

class ProfileController {
  GeoCoderService geoCoderService
  EntityHelperService entityHelperService
  MetaDataService metaDataService
  FilterService filterService
  SessionFactory sessionFactory
  FunctionService functionService
  def securityManager
  SecHelperService secHelperService

  def index = { }

  /*
  * retrieves the total number of each entity
  */
  def overview = {
    def c = Entity.createCriteria()
    def count = c.list {
      eq("type", metaDataService.etActivity)
      profile {
        eq("type", "Themenraum")
      }
    }
    def activities = count.size()

    List temp = Entity.findAllByType(metaDataService.etResource)

    def allResources = 0
    temp.each { resource ->
      def result = functionService.findByLink(resource, null, metaDataService.ltResource)
      if (result.type.id != metaDataService.etTemplate.id)
        allResources++
    }

    [allOperators: Entity.countByType(metaDataService.etOperator),
    allUsers: Entity.countByType(metaDataService.etUser),
    allClients: Entity.countByType(metaDataService.etClient),
    allEducators: Entity.countByType(metaDataService.etEducator),
    allParents: Entity.countByType(metaDataService.etParent),
    allChilds: Entity.countByType(metaDataService.etChild),
    allPates: Entity.countByType(metaDataService.etPate),
    allPartners: Entity.countByType(metaDataService.etPartner),
    allFacilities: Entity.countByType(metaDataService.etFacility),
    allResources: allResources,
    allMethods: Method.countByType("template"),
    allThemes: Entity.countByType(metaDataService.etTheme),
    allColonias: Entity.countByType(metaDataService.etGroupColony),
    allFamilies: Entity.countByType(metaDataService.etGroupFamily),
    allPartnerGroups: Entity.countByType(metaDataService.etGroupPartner),
    allClientGroups: Entity.countByType(metaDataService.etGroupClient),
    allActivityTemplates: Entity.countByType(metaDataService.etTemplate),
    allActivities: activities,
    allActivityTemplateGroups: Entity.countByType(metaDataService.etGroupActivityTemplate),
    allActivityGroups: Entity.countByType(metaDataService.etGroupActivity),
    allProjectTemplates: Entity.countByType(metaDataService.etProjectTemplate),
    allProjects: Entity.countByType(metaDataService.etProject)]
  }

  /*
   * create an admin notification (private message)
   */
  def createNotification = {
    Msg msgInstance = new Msg()
    return [msgInstance: msgInstance]
  }

  def saveNotification = {NotificationCommand nc->

    if (nc.hasErrors()) {
      render view:'createNotification', model:[nc: nc]
      return
    }
    
    def c = Entity.createCriteria()
    def userList = c.list {
      or {
        if (params.user)
          eq("type", metaDataService.etUser)
        if (params.operator)
          eq("type", metaDataService.etOperator)
        if (params.client)
          eq("type", metaDataService.etClient)
        if (params.educator)
          eq("type", metaDataService.etEducator)
        if (params.parent)
          eq("type", metaDataService.etParent)
        if (params.child)
          eq("type", metaDataService.etChild)
        if (params.pate)
          eq("type", metaDataService.etPate)
        if (params.partner)
          eq("type", metaDataService.etPartner)
      }
    }

    Entity currentEntity = entityHelperService.loggedIn
    userList.each {
      functionService.createEvent(it, 'Du hast eine Notifikation erhalten.')
      functionService.createMessage(currentEntity, it as Entity, it as Entity, params.subject, params.content)
    }
    flash.message = message(code: "admin.notificationSuccess")
    redirect controller: currentEntity.type.supertype.name + 'Profile', action: "show", id: currentEntity.id
  }

  /*
   * uses the GeoCoderService to retrieve a location
   * NOT USED ATM
   */
  def geocode = {
    def result = geoCoderService.geocodeLocation(params.name)
    render result as JSON // IntelliJ gives a false warning here
  }

  /*
   * adds the admin role to a given entity
   */
  def giveAdminRole = {
    Entity entity = Entity.get(params.id)
    entity?.user?.addToAuthorities(metaDataService.adminRole)
    Entity currentEntity = entityHelperService.loggedIn
    functionService.createMessage(currentEntity, entity, entity, "Rollenänderung", "Dir wurde die Rolle des Administrators gegeben.")
    render template:'listentity', model:[entity: entity, currentEntity: currentEntity, i: params.i]
  }

  /*
   * removes the admin role from a given entity
   */
  def takeAdminRole = {
    Entity entity = Entity.get(params.id)
    def role = entity.user.authorities.find { it.id == (metaDataService.adminRole.id)}
    entity.user.removeFromAuthorities(role)
    Entity currentEntity = entityHelperService.loggedIn
    functionService.createMessage(currentEntity, entity, entity, "Rollenänderung", "Dir wurde die Rolle des Administrators genommen.")
    render template:'listentity', model:[entity: entity, currentEntity: currentEntity, i: params.i]
  }

  /*
   * used by the glossary in the overview
   * either retrieves all users or those matching the given glossary letter
   */
  def showUsers = {
    params.glossary = params.glossary ?: 'Alle'
    params.max = Math.min(params.max ? params.int('max') : 16, 100)
    params.offset = params.offset ? params.int('offset') : 0

    List users
    def numUsers

    if (params.glossary == "Alle") {
      def c = Entity.createCriteria()
      users = c.list {
        ne("type", metaDataService.etActivity)
        ne("type", metaDataService.etTemplate)
        ne("type", metaDataService.etResource)
        ne("type", metaDataService.etGroupColony)
        ne("type", metaDataService.etGroupFamily)
        ne("type", metaDataService.etGroupActivity)
        ne("type", metaDataService.etGroupActivityTemplate)
        ne("type", metaDataService.etTheme)
        ne("type", metaDataService.etProject)
        ne("type", metaDataService.etProjectTemplate)
        ne("type", metaDataService.etUser)
        ne("type", metaDataService.etProjectDay)
        ne("type", metaDataService.etProjectUnit)
        ne("type", metaDataService.etProjectUnitTemplate)
        profile {
          order("lastName", "asc")
        }
      }
      numUsers = users.size()
      def upperBound = params.offset + 16 < users.size() ? params.offset + 16 : users.size()
      users = users.subList(params.offset, upperBound)
    }
    else {
      //log.debug("start glossary for " + params.glossary)
      def c = Entity.createCriteria()
      users = c.list {
        ne("type", metaDataService.etActivity)
        ne("type", metaDataService.etTemplate)
        ne("type", metaDataService.etResource)
        ne("type", metaDataService.etGroupColony)
        ne("type", metaDataService.etGroupFamily)
        ne("type", metaDataService.etGroupActivity)
        ne("type", metaDataService.etGroupActivityTemplate)
        ne("type", metaDataService.etTheme)
        ne("type", metaDataService.etProject)
        ne("type", metaDataService.etProjectTemplate)
        ne("type", metaDataService.etUser)
        ne("type", metaDataService.etProjectDay)
        ne("type", metaDataService.etProjectUnit)
        ne("type", metaDataService.etProjectUnitTemplate)
        profile {
          ilike("fullName", params.glossary + "%")
          order("fullName", "asc")
        }
        cacheable(true)
      }
      numUsers = users.size()
      def upperBound = params.offset + 16 < users.size() ? params.offset + 16 : users.size()
      users = users.subList(params.offset, upperBound)
    }

    render(template: 'allusers', model: [entities: users, numEntities: numUsers, glossary: params.glossary])
  }

  /*
   * deactivates a user so he is not able to login anymore
   */
  def disable = {
    Entity entity = Entity.get(params.id)
    if (!entity) {
      flash.message = message(code: "user.notFound", args: [params.id])
      response.sendError(404, "no such entity")
      return;
    }

    entity.user.enabled = false

    //Link.findAllBySourceOrTarget(entity, entity)?.each { it.delete() }

    render template:'listentity', model:[entity: entity, currentEntity: entityHelperService.loggedIn, i: params.i]
  }

  /*
   * activates a user so he is able to login
   */
  def enable = {
    Entity entity = Entity.get(params.id)
    if (!entity) {
      flash.message = message(code: "user.notFound", args: [params.id])
      response.sendError(404, "no such entity")
      return;
    }

    entity.user.enabled = true

    render template:'listentity', model:[entity: entity, currentEntity: entityHelperService.loggedIn, i: params.i]
  }

  /*
   * change password
   */
  def changePassword = {
    Entity entity = Entity.get(params.id)
    return ['entity': entity]
  }

  /*
   * check password and update it
   */
  def checkPassword = {
    if (params.password == params.password2) {
      Entity entity = Entity.get(params.id)
      entity.user.password = securityManager.encodePassword(params.password)
      entity.save()
      flash.message = message(code: "pass.changed")
      redirect controller: entity.type.supertype.name + 'Profile', action: 'show', id: entity.id
    }
    else {
      flash.message = message(code: "pass.notChanged")
      redirect action: changePassword, params: [name: params.name]
    }
  }

  /*
   * retrieves users matching the search parameter of the instant search
   */
  def searchMe = {
    if (!params.name) {
      render ""
      return
    }
    List searchList = filterService.findUsers(params.name)
    if (searchList.size() == 0) {
      // render '<span class="italic">Keine Ergebnisse gefunden!</span>'
      render '<span class="italic">' + message(code: "searchMe.empty") +  '</span>'    // hafo
      return
    }
    else {
      render(template: 'searchresults', model: [searchList: searchList])
    }
  }

  /*
   * shows the news page listing events
   */
  def showNews = {
    Entity entity = Entity.get(params.id)

    Calendar calendar = Calendar.getInstance()
    TimeZone timeZone = calendar.getTimeZone()

    SimpleDateFormat tdf = new SimpleDateFormat("yyyy-MM-dd")

    List allEvents = Event.findAllByEntity(entity, [sort: 'dateCreated', order: 'desc'])

    List eventsToday = allEvents.findAll {tdf.format(it.date) == tdf.format(calendar.getTime())}

    calendar.add(Calendar.DATE, -1)
    List eventsYesterday = allEvents.findAll {tdf.format(it.date) == tdf.format(calendar.getTime())}

    calendar.add(Calendar.DATE, 2)
    List eventsTomorrow = allEvents.findAll {tdf.format(it.date) == tdf.format(calendar.getTime())}

    return ['entity': entity,
            'eventsToday': eventsToday,
            'eventsYesterday': eventsYesterday,
            'eventsTomorrow': eventsTomorrow,
            'timeZone': timeZone]
  }

  /*
   * shows a list of articles the entity has contributed to the front page
   */
  def showArticleList = {
    params.offset = params.offset ? params.int('offset') : 0
    params.max = params.max ? params.int('max') : 10

    Entity entity = Entity.get(params.id)
    List articles = ArticlePost.findAllByAuthor(entity, params)
    return ['entity': entity,
            'articleList': articles,
            'articleCount': articles.size()]
  }

  /*
   * shows a list of all activites of a given entity
   */
  def showActivityList = {
    params.offset = params.offset ? params.int('offset') : 0
    params.max = params.max ? params.int('max') : 10

    Entity entity = Entity.get(params.id)

    // find all activities the entity is owner, or in the educator or client list
    // Unfortunately we loose control over sort and max, need to find a workaround
    def activityList = ActivityProfile.findAllByOwner(entity)
    ActivityProfile.list().each {
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

  /*
   * creates a PDF with client statistics
   * NOT USED ATM
   */
  def print = {
    // find out if this works without this workaround now
    //params.date = new Date(params.year.toInteger()-1900,params.month.toInteger()-1,params.day.toInteger())
    def image = "hort_" + entityHelperService.loggedIn.name + ".jpg"

    int sumAttend = 0
    int sumEat = 0

    List clients = []
    List attend = at.uenterprise.erp.Attendance().findAllByDate(params.date)
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

  /*
   * finds all attendances of a given date
   */
  def attendance = {
    //params.date = params.date ? new Date(Integer.parseInt(params.date_year)-1900,Integer.parseInt(params.date_month)-1,Integer.parseInt(params.date_day),00,00): new Date()
    params.date = params.date ?: new Date()

    SimpleDateFormat sd = new SimpleDateFormat("yyyy-MM-dd");
    String dateString = sd.format(params.date)
    log.debug "param date: " + dateString
    Date date = sd.parse(dateString)

    int year = date.getYear()
    int month = date.getMonth() // 0 to 11
    int day = date.getDate()

    List clients = at.uenterprise.erp.Attendance().findAllByDate(date)*.client

    if (clients) {
      log.debug "attendances found!"
    }
    else {
      // find all clients of a facility
      clients = functionService.findAllByLink(null, Entity.get(params.id), metaDataService.ltClientship)
    }

    return ['entityList': clients,
            'entityCount': clients.size(),
            'entity': entityHelperService.loggedIn,
            'date': params.date,
            'year': year,
            'month': month,
            'day': day,
            'attend': attend]
  }

  /*
   * saves an attendance
   * NOT USED ATM
   */
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
    flash.message = message(code: "attendance.saved", args: [dateString])

    Date date = sd.parse(dateString)

    int year = date.getYear() + 1900
    int month = date.getMonth() + 1 // 0 to 11
    int day = date.getDate()

    redirect action: 'attendance', params: [name: params.name, date: date, date_year: year, date_month: month, date_day: day]
  }

  /*
   * lists all users
   */
  def list = {
    params.entityType = params.entityType ?: "all"
    params.offset = params.offset ? params.int('offset') : 0
    params.max = params.max ? params.int('max') : 10

    List entities
    int count
    if (params.entityType == 'all') {
      def c = Entity.createCriteria()
      entities = c.list {
        ne("type", metaDataService.etActivity)
        ne("type", metaDataService.etTemplate)
        ne("type", metaDataService.etResource)
        ne("type", metaDataService.etGroupActivity)
        ne("type", metaDataService.etGroupActivityTemplate)
        ne("type", metaDataService.etGroupClient)
        ne("type", metaDataService.etGroupColony) // TODO: find out why this is ignored on TEST environment?!
        ne("type", metaDataService.etGroupFamily)
        ne("type", metaDataService.etGroupPartner)
        ne("type", metaDataService.etProject)
        ne("type", metaDataService.etProjectTemplate)
        ne("type", metaDataService.etTheme)
        ne("type", metaDataService.etProjectDay)
        ne("type", metaDataService.etProjectUnit)
        if (!secHelperService.isAdmin()) {
          ne("name", "admin")
          ne("type", metaDataService.etUser)
        }
      }

      count = entities.size()
      def upperBound = params.offset + 10 < entities.size() ? params.offset + 10 : entities.size()
      entities = entities.subList(params.offset, upperBound)
    }
    else {
      entities = Entity.findAllByType(EntityType.findByName(params.entityType), params)
      count = Entity.countByType(EntityType.findByName(params.entityType))
    }

    return ['entityType': params.entityType,
            'entityList': entities,
            'entityCount': count]
  }

  /*
   * adds a friendship
   */
  def addFriend = {
    Entity entity = Entity.get(params.id)
    Entity currentEntity = entityHelperService.loggedIn

    def linkInstance = new Link()
    linkInstance.source = currentEntity
    linkInstance.type = metaDataService.ltFriendship
    linkInstance.target = entity

    // for now just create a back-link for mutuality - a more elaborate workflow will be in order later on
    def linkBack = new Link()
    linkBack.source = entity
    linkBack.type = metaDataService.ltFriendship
    linkBack.target = currentEntity

    if (linkInstance.save(flush: true) && linkBack.save(flush: true)) {
      def name = linkInstance.target.profile.fullName ?: linkInstance.target.profile.lastName + " " + linkInstance.target.profile.firstName
      flash.message = message(code: "user.addFriend", args: [name])

      functionService.createEvent(currentEntity, 'Du hast ' + name + ' als Freund hinzugefügt.')
      functionService.createEvent(entity, currentEntity.profile.id + ' hat dich als Freund hinzugefügt.')

      redirect controller: entity.type.supertype.name + 'Profile', action: 'show', params: [id: entity.id, entity: entity.id]
    }
    else {
      flash.message = message(code: "user.addFriendFailed", args: [linkInstance.target.profile.id])
      redirect controller: entity.type.supertype.name + 'Profile', action: 'show', id: linkInstance.target.id
    }
  }

  /*
   * removes a friendship
   */
  def removeFriend = {
    Entity entity = Entity.get(params.id)
    Entity currentEntity = entityHelperService.loggedIn

    def c = Link.createCriteria()
    def linkInstance = c.get {
      eq('source', currentEntity)
      eq('target', entity)
      eq('type', metaDataService.ltFriendship)
    }
    def d = Link.createCriteria()
    def linkInstanceBack = d.get {
      eq('source', entity)
      eq('target', currentEntity)
      eq('type', metaDataService.ltFriendship)
    }
    if (linkInstance && linkInstanceBack) {
      try {
        linkInstance.delete(flush: true)
        linkInstanceBack.delete(flush: true)
        def name = entity.profile.fullName ?: entity.profile.lastName + " " + entity.profile.firstName
        flash.message = message(code: "user.removeFriend", args: [name])

        functionService.createEvent(currentEntity, 'Du hast ' + name + ' als Freund entfernt.')
        functionService.createEvent(entity, currentEntity.profile.id + ' hat dich als Freund entfernt.')

        redirect controller: entity.type.supertype.name + 'Profile', action: 'show', params: [id: entity.id, entity: entity.id]
      }
      catch (org.springframework.dao.DataIntegrityViolationException ex) {
        flash.message = message(code: "user.removeFriendFailed", args: [entity.profile.id])
        redirect controller: entity.type.supertype.name + 'Profile', action: 'show', id: linkInstance.target.id
      }
    }
  }

  /*
   * adds a bookmark
   */
  def addBookmark = {
    Entity entity = Entity.get(params.id)
    if (!entity) {
      flash.message = message(code: "user.notFound", args: [params.id])
      return
    }

    Link linkInstance = new Link()
    linkInstance.source = entityHelperService.loggedIn
    linkInstance.type = metaDataService.ltBookmark
    linkInstance.target = entity

    if (linkInstance.save(flush: true)) {
      flash.message = message(code: "user.addBookmark", args: [linkInstance.target.profile.fullName])
      redirect controller: entity.type.supertype.name + 'Profile', action: 'show', id: linkInstance.target.id
    }
    else {
      flash.message = message(code: "user.addBookmarkFailed", args: [linkInstance.target.profile.fullName])
      redirect controller: entity.type.supertype.name + 'Profile', action: 'show', id: linkInstance.target.id
    }
  }

  /*
   * removes a bookmark
   */
  def removeBookmark = {
    Entity entity = Entity.get(params.id)

    def c = Link.createCriteria()
    def linkInstance = c.get {
      eq('source', entityHelperService.loggedIn)
      eq('target', entity)
      eq('type', metaDataService.ltBookmark)
    }
    if (linkInstance) {
      //def n = linkInstance.target.name
      try {
        linkInstance.delete(flush: true)
        flash.message = message(code: "user.removeBookmark", args: [entity.profile.fullName])
        redirect controller: entity.type.supertype.name + 'Profile', action: 'show', id: linkInstance.target.id
      }
      catch (org.springframework.dao.DataIntegrityViolationException ex) {
        flash.message = message(code: "user.removeBookmarkFailed", args: [entity.profile.fullName])
        redirect controller: entity.type.supertype.name + 'Profile', action: 'show', id: linkInstance.target.id
      }
    }
  }

  def uploadprf = {
    Entity entity = Entity.get(params.id)

    render view:'/asset/uploadprf', model:[entity: entity]
    }

}

/*
* command object to handle validation of a notification
*/
class NotificationCommand {

  String subject
  String content

  String user
  String operator
  String client
  String educator
  String parent
  String child
  String pate
  String partner

  Boolean selection

  static constraints = {
    subject(blank: false)
    content(blank: false)
    selection(validator: {sel, nc ->
      return !(!nc.user && !nc.operator && !nc.client && !nc.educator && !nc.parent && !nc.child && !nc.pate && !nc.partner)})
  }

}