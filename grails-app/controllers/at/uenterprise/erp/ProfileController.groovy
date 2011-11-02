package at.uenterprise.erp

import at.openfactory.ep.Entity
import at.openfactory.ep.Link
import at.openfactory.ep.EntityType
import at.openfactory.ep.EntityHelperService
import at.openfactory.ep.SecHelperService

import java.text.SimpleDateFormat
import org.hibernate.SessionFactory

import at.uenterprise.erp.profiles.ActivityProfile
import org.springframework.web.multipart.MultipartFile
import at.openfactory.ep.AssetService

class ProfileController {
  EntityHelperService entityHelperService
  MetaDataService metaDataService
  SessionFactory sessionFactory
  FunctionService functionService
  def securityManager
  SecHelperService secHelperService
  AssetService assetService

  static allowedMethods = [changePassword: 'POST']

  def index = { }

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
    userList.each { Entity user ->
      if (currentEntity.id != user.id)
        functionService.createMessage(currentEntity, user, user, params.subject, params.content).save()
    }
    flash.message = message(code: "admin.notificationSuccess")
    redirect controller: currentEntity.type.supertype.name + 'Profile', action: "show", id: currentEntity.id
  }

  /*
   * adds the admin role to a given entity
   */
  def giveAdminRole = {
    Entity entity = Entity.get(params.id)
    entity?.user?.addToAuthorities(metaDataService.adminRole)
    Entity currentEntity = entityHelperService.loggedIn
    functionService.createMessage(currentEntity, entity, entity, "Rollenänderung", "Dir wurde die Rolle des Administrators gegeben.").save()
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
    functionService.createMessage(currentEntity, entity, entity, "Rollenänderung", "Dir wurde die Rolle des Administrators genommen.").save()
    render template:'listentity', model:[entity: entity, currentEntity: currentEntity, i: params.i]
  }

  /*
   * deactivates a user so he is not able to login anymore
   */
  def disable = {
    Entity entity = Entity.get(params.id)
    if (!entity) {
      flash.message = message(code: "object.notFound", args: [message(code: "user")])
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
      flash.message = message(code: "object.notFound", args: [message(code: "user")])
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
    return [entity: entity]
  }

  /*
   * check password and update it
   */
  def checkPassword = {
    if (!params.password || !params.password2) {
      render view: 'changePassword', model:[ entity: Entity.get(params.id), error: 'true']
      return
    }
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
   * shows the news page listing events
   */
  def news = {
    params.max = 2
    Entity entity = Entity.get(params.id)

    Calendar calendar = Calendar.getInstance()

    SimpleDateFormat tdf = new SimpleDateFormat("yyyy-MM-dd", new Locale("en"))

    List allEvents = Event.list([sort: 'dateCreated', order: 'desc'])

    List eventsToday = allEvents.findAll {tdf.format(it.date) == tdf.format(calendar.getTime())}

    calendar.add(Calendar.DATE, -1)
    List eventsYesterday = allEvents.findAll {tdf.format(it.date) == tdf.format(calendar.getTime())}

    calendar.add(Calendar.DATE, 2)
    List eventsTomorrow = allEvents.findAll {tdf.format(it.date) == tdf.format(calendar.getTime())}

    List news = ArticlePost.list([max: params.max, sort: "dateCreated", order: "desc", offset: params.offset])

    return ['entity': entity,
            'eventsToday': eventsToday,
            'eventsYesterday': eventsYesterday,
            'eventsTomorrow': eventsTomorrow,
            'news': news,
            'newsCount': ArticlePost.count()]
  }

  def getNews = {
    params.max = 2
    List news = ArticlePost.list([max: params.max, sort: "dateCreated", order: "desc", offset: params.offset])

    render template: "newsitems", model: [news: news, newsCount: ArticlePost.count(), currentEntity: entityHelperService.loggedIn]
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
   * lists all users
   */
  def list = {
    params.entityType = params.entityType ?: "all"
    params.offset = params.offset ? params.int('offset') : 0
    params.max = params.max ? params.int('max') : 10
    params.sort = params.sort ?: "name"

    EntityType entityType = null
    if (params.entityType == 'operator')
      entityType = metaDataService.etOperator
    else if (params.entityType == 'facility')
      entityType = metaDataService.etFacility
    else if (params.entityType == 'educator')
      entityType = metaDataService.etEducator
    else if (params.entityType == 'client')
      entityType = metaDataService.etClient
    else if (params.entityType == 'user')
      entityType = metaDataService.etUser
    else if (params.entityType == 'partner')
      entityType = metaDataService.etPartner
    else if (params.entityType == 'pate')
      entityType = metaDataService.etPate
    else if (params.entityType == 'parent')
      entityType = metaDataService.etParent
    else if (params.entityType == 'child')
      entityType = metaDataService.etChild

    List entities
    int count
    if (params.entityType == 'all') {
      def c = Entity.createCriteria()
      entities = c.list {
        and {
          ne("type", metaDataService.etActivity)
          ne("type", metaDataService.etTemplate)
          ne("type", metaDataService.etResource)
          ne("type", metaDataService.etGroupActivity)
          ne("type", metaDataService.etGroupActivityTemplate) // TODO: find out why this is ignored on TEST environment?!
          ne("type", metaDataService.etGroupClient)
          ne("type", metaDataService.etGroupColony) // TODO: find out why this is ignored on TEST environment?!
          ne("type", metaDataService.etGroupFamily)
          ne("type", metaDataService.etGroupPartner)
          ne("type", metaDataService.etProject)
          ne("type", metaDataService.etProjectTemplate)
          ne("type", metaDataService.etTheme)
          ne("type", metaDataService.etProjectDay)
          ne("type", metaDataService.etProjectUnit)
          ne("type", metaDataService.etProjectUnitTemplate)
          ne("type", metaDataService.etAppointment)
          if (!secHelperService.isAdmin()) {
            ne("name", "admin")
            ne("type", metaDataService.etUser)
          }
        }
        order(params.sort, "desc")
      }

      count = entities.size()
      def upperBound = params.offset + 10 < entities.size() ? params.offset + 10 : entities.size()
      entities = entities.subList(params.offset, upperBound)
    }
    else {
      entities = Entity.findAllByType(entityType, params)
      count = Entity.countByType(entityType)
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
      flash.message = message(code: "object.notFound", args: [message(code: "user")])
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

  def uploadProfileImage = {
    Entity entity = Entity.get(params.id)

    return [entity: entity]
    }

  def savePic = {
    Entity entity = Entity.get(params.id)

    MultipartFile asset = request.getFile ('asset')
    if (asset && !asset.empty) {
      if (asset.getSize() / 1024 > 150) {
        flash.message = message(code: "profile.picture.tooLarge", args: ['150'])
        redirect action: 'uploadProfileImage', id: params.id
      }
      else {
        def result = functionService.storeAsset(entity, params.type, asset)
        [asset: result, entity: entity]
      }
    }
  }

  def saveProfilePic = {
    forward(action:"savePic", params:[type:"profile"])
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

  // TODO: wrong IDE warnings of command object constraints will be gone in IDEA 11, see: http://youtrack.jetbrains.net/issue/IDEA-71680
  static constraints = {
    subject   blank: false
    content   blank: false
    selection validator: {val, obj ->
                            return !(!obj.user && !obj.operator && !obj.client && !obj.educator && !obj.parent && !obj.child && !obj.pate && !obj.partner)
                         }
  }

}