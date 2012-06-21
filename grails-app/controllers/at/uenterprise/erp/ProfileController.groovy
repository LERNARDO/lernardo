package at.uenterprise.erp

import at.uenterprise.erp.base.Entity
import at.uenterprise.erp.base.EntityType
import at.uenterprise.erp.base.EntityHelperService
import at.uenterprise.erp.base.SecHelperService
import at.uenterprise.erp.profiles.ActivityProfile
import org.springframework.web.multipart.MultipartFile
import org.springframework.web.servlet.support.RequestContextUtils

class ProfileController {
  EntityHelperService entityHelperService
  MetaDataService metaDataService
  FunctionService functionService
  def securityManager
  SecHelperService secHelperService

  static allowedMethods = [changePassword: 'POST']

  def index = { }

  def getTooltip() {
    Entity entity = Entity.get(params.id)
    if (entity)
      render template: "/tooltip/tooltip" + entity.type.supertype.name, model: [entity: entity]
    else
      render ""
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
      render view: 'createNotification', model: [nc: nc]
      return
    }
    
    def userList = Entity.createCriteria().list {
      user {
        eq("enabled", true)
      }
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
    render template: 'listentity', model: [entity: entity, i: params.i]
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
    render template: 'listentity', model: [entity: entity, i: params.i]
  }

  /*
   * deactivates a user so he is not able to login anymore
   */
  def disable = {
    Entity entity = Entity.get(params.id)
    if (!entity) {
      flash.message = message(code: "object.notFound", args: [message(code: "user")])
      response.sendError(404, "no such entity")
      return
    }

    entity.user.enabled = false

    render template: 'listentity', model: [entity: entity, i: params.i]
  }

  /*
   * activates a user so he is able to login
   */
  def enable = {
    Entity entity = Entity.get(params.id)
    if (!entity) {
      flash.message = message(code: "object.notFound", args: [message(code: "user")])
      response.sendError(404, "no such entity")
      return
    }

    entity.user.enabled = true

    render template: 'listentity', model: [entity: entity, i: params.i]
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
      render view: 'changePassword', model: [entity: Entity.get(params.id), error: 'true']
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
   * shows a list of news the entity has contributed
   */
  def showNewsList = {
    params.offset = params.int('offset') ?: 0
    params.max = params.int('max') ?: 10

    Entity entity = Entity.get(params.id)
    List news = News.findAllByAuthor(entity, params)
    return ['entity': entity,
            'news': news,
            'newsCount': news.size()]
  }

  /*
   * shows a list of all activites of a given entity
   */
  def showActivityList = {
    params.offset = params.int('offset') ?: 0
    params.max = params.int('max') ?: 10

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
    params.offset = params.int('offset') ?: 0
    params.max = params.int('max') ?: 10
    params.sort = params.sort ?: "name"

    EntityType entityType = null
    if (params.entityType == 'operator')
      entityType = metaDataService.etOperator
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
      entities = Entity.createCriteria().list {
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
          ne("type", metaDataService.etFacility)
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
        flash.message = message(code: "profile.picture.select.ok")
        functionService.storeAsset(entity, params.type, asset)
        redirect controller: entity.type.supertype.name + 'Profile', action: 'show', id: entity.id
      }
    }
  }

  def saveProfilePic = {
    forward action: "savePic", params: [type: "profile"]
  }
  
  def addFavorite = {
    //String favorite = params.id.toString()

    Entity currentEntity = entityHelperService.loggedIn

    /*if (!currentEntity.profile.favorites.contains(favorite)) {
      currentEntity.profile.addToFavorites(favorite)
    }*/
    Favorite favorite = new Favorite(entity: Entity.get(params.id), description: " ", folder: currentEntity.profile.favoritesFolder).save(failOnError: true)
    currentEntity.profile.favoritesFolder.addToFavorites(favorite)

    render template: 'favbuttons', model: [type: 'remove', favorite: params.id]
  }
  
  def removeFavorite = {
    //String favorite = params.id.toString()

    Entity currentEntity = entityHelperService.loggedIn

    Entity ent = Entity.get(params.id)

    /*if (currentEntity.profile.favorites.contains(favorite)) {
      currentEntity.profile.removeFromFavorites(favorite)
    }*/
    //if (currentEntity.profile.favoritesFolder.contains(Entity.get(params.id)))
    //  currentEntity.profile.favoritesFolder.removeFromFavorites(Entity.get(params.id))
    deleteFavorite(currentEntity.profile.favoritesFolder, ent)

    render template: 'favbuttons', model: [type: 'add', favorite: params.id]
  }

  Boolean deleteFavorite(Folder folder, Entity entity) {
    //println "---"
    //println "folder: " + folder.name
    //folder.favorites.each {println it.entity.profile.fullName}
    //println "entity: " + entity.profile.fullName
    def fav = folder.favorites.find {it.entity.id == entity.id}

    def found = false
    if (fav) {
      //println "found favorite in folder"
      //println fav.entity.profile.fullName
      fav.folder.removeFromFavorites(fav)
      fav.delete(flush: true)
      return true
    }
    else {
      //println "didn't find favorite in folder, searching subfolders"
      folder.folders.each { Folder f ->
        if (deleteFavorite(f, entity)) {
          //println "found favorite in subfolder"
          found = true
        }
      }
    }
    return found
  }

  def updateFavorites = {
    Entity currentEntity = entityHelperService.loggedIn
    render template: 'favorites', model: [entity: currentEntity]
  }
  
  def updateColor = {
    Entity entity = Entity.get(params.id)
    entity.profile.color = params.color
    entity.profile.save()
    redirect controller: 'calendar'
  }

  def changeLanguage = {
    Entity currentEntity = entityHelperService.loggedIn
    
    currentEntity.user.locale = new Locale(params.locale)
    currentEntity.user.save(flush: true)

    RequestContextUtils.getLocaleResolver(request).setLocale(request, response, currentEntity.user.locale)
    redirect controller: "app", action: "start"
  }

  def updateonline = {
    render template: "/templates/onlineUsers"
  }

  /*
  * retrieves all creators matching the search parameter
  */
  def remoteCreators = {

    if (!params.value) {
      render ""
      return
    }
    else if (params.value.size() < 2) {
      render '<span class="gray">Bitte mindestens 2 Zeichen eingeben!</span>'
      return
    }

    def results = Entity.createCriteria().list {
      user {
        eq("enabled", true)
      }
      or {
        eq('type', metaDataService.etUser)
        eq('type', metaDataService.etEducator)
        eq('type', metaDataService.etOperator)
      }
      profile {
        ilike('fullName', "%" + params.value + "%")
        order('fullName','asc')
      }
      maxResults(15)
    }

    if (results.size() == 0) {
      render '<span class="italic">'+message(code:'noResultsFound')+ '</span>'
      return
    }
    else {
      render template: 'creatorresults', model: [results: results]
    }
  }

  def addCreator = {
    Entity creator = Entity.get(params.id)

    //render ("<span class='gray'>" + message(code: 'creator') + "</span> ${creator.profile.fullName}")
    render ("${creator.profile.fullName}")
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
    subject   blank: false
    content   blank: false
    selection validator: {val, obj ->
                            return !(!obj.user && !obj.operator && !obj.client && !obj.educator && !obj.parent && !obj.child && !obj.pate && !obj.partner)
                         }
  }

}