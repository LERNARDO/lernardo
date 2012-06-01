package at.uenterprise.erp

import at.uenterprise.erp.base.Entity
import at.uenterprise.erp.base.Account
import at.uenterprise.erp.base.EntityHelperService
import at.uenterprise.erp.base.Tag
import at.uenterprise.erp.base.TagLinkType
import at.uenterprise.erp.base.EntityTagLink
import at.uenterprise.erp.base.Asset
import at.uenterprise.erp.base.Link

import org.springframework.web.servlet.support.RequestContextUtils

import javax.servlet.http.Cookie
import at.uenterprise.erp.base.AssetStorage
import at.uenterprise.erp.base.security.SecurityManagerException
//import grails.util.GrailsUtil

class AppController {
  EntityHelperService entityHelperService
  def securityManager
  FunctionService functionService
  MetaDataService metaDataService
  def assetService

  /*
   * renders an image
   */
  def getImage = {
    Entity ent = Entity.get (params.entity)
    if (!ent) {
      response.sendError(404, "no such entity: '$params.entity")
      return
    }

    AssetStorage store = AssetStorage.get(params.store)

    try {
      assetService.withContent(store) {content, contentType->
        log.debug ("render asset $store.storageId ($store.contentType) to response")
        response.contentType = contentType
        response.contentLength = content.size()
        response.outputStream << content
        response.outputStream.flush ()
      }
    }
    catch (RuntimeException e) {
      response.sendError (500, e.message)
    }

  }

  def error404 = {
    render view: '/404'
  }

  def hideticker = {
    def c = new Cookie("ticker", "hidden")
    c.maxAge = 60*60 // 1 hour
    response.addCookie(c)

    //render template: 'livetickersmall'

    params.max = 10
    params.sort = "dateCreated"
    params.order = "desc"

    TimeZone timeZone = TimeZone.getTimeZone(grailsApplication.config.timeZone.toString())

    List events = Live.list().findAll {(new Date().getTime() - it.dateCreated.getTime()) / 1000 / 60 <= 5} //Live.list(params)
    render template: 'livetickersmall', model: [events: events, timeZone: timeZone]
  }

  def showticker = {
    def c = new Cookie("ticker", "visible")
    c.maxAge = 60*60 // 1 hour
    response.addCookie(c)

    params.max = 10
    params.sort = "dateCreated"
    params.order = "desc"

    List events = Live.list().findAll {(new Date().getTime() - it.dateCreated.getTime()) / 1000 / 60 <= 5} //Live.list(params)
    events.sort() {it.dateCreated}
    events = events.reverse()
    render template: 'liveticker', model: [events: events]
  }

  def liveticker = {
    //println "ticker: " + g.cookie(name: "ticker")

    if (!g.cookie(name: "ticker")) {
      def c = new Cookie("ticker", "visible")
      c.maxAge = 60*60 // 1 hour
      response.addCookie(c)
    }

    if (g.cookie(name: "ticker") == "hidden") {
      forward action: 'hideticker'
    }
    else
      forward action: 'showticker'

  }

  /*
   * finds all links of a certain type to a given entity
   */
  def updatelinks = {

    Entity entity = Entity.get(params.id)

    if (params.type == 'groupActivities') {
      List groupActivities = []
      if (entity.type.id == metaDataService.etEducator.id)
        groupActivities = functionService.findAllByLink(entity, null, metaDataService.ltGroupMemberEducator)
      else if (entity.type.id == metaDataService.etParent.id) {
        List temp = functionService.findAllByLink(entity, null, metaDataService.ltGroupMemberParent)
        temp.each {
          if (it.type.id == metaDataService.etGroupActivity.id) groupActivities << it
        }
      }
      else if (entity.type.id == metaDataService.etPartner.id) {
        List temp = functionService.findAllByLink(entity, null, metaDataService.ltGroupMemberPartner)
        temp.each {
          if (it.type.id == metaDataService.etGroupActivity.id) groupActivities << it
        }
      }
      else if (entity.type.id == metaDataService.etFacility.id) {
        List temp = functionService.findAllByLink(null, entity, metaDataService.ltGroupMemberFacility)
        temp.each {
          if (it.type.id == metaDataService.etGroupActivity.id) groupActivities << it
        }
      }
      else if (entity.type.id == metaDataService.etClient.id) {
        List temp = functionService.findAllByLink(entity, null, metaDataService.ltGroupMemberClient)
        temp.each {
          if (it.type.id == metaDataService.etGroupActivity.id) groupActivities << it
        }
      }
      render template: "/templates/linkscontent", model: [list: groupActivities]
    }

    if (params.type == 'projects') {
      List projects = []
      if (entity.type.id == metaDataService.etEducator.id) {
        List days = functionService.findAllByLink(entity, null, metaDataService.ltProjectDayEducator)
        days.each { Entity day ->
          projects << functionService.findByLink(day, null, metaDataService.ltProjectMember)
        }
      }
      else if (entity.type.id == metaDataService.etFacility.id) {
        List temp = functionService.findAllByLink(entity, null, metaDataService.ltGroupMemberFacility)
        temp.each {
          if (it.type.id == metaDataService.etProject.id) projects << it
        }
      }
      else if (entity.type.id == metaDataService.etClient.id) {
        List temp = functionService.findAllByLink(entity, null, metaDataService.ltGroupMemberClient)
        temp.each {
          if (it.type.id == metaDataService.etProject.id) projects << it
        }
      }
      else if (entity.type.id == metaDataService.etParent.id) {
        // find all project units the entity is linked to
        List projectUnits = functionService.findAllByLink(entity, null, metaDataService.ltProjectUnitParent)

        // for each project unit find all project days they are linked to
        List projectDays = []
        projectUnits.each { Entity pu ->
          def result = functionService.findByLink(pu, null, metaDataService.ltProjectDayUnit)
          if (result && !projectDays.contains(result))
            projectDays << result
        }

        // for each project day find all projects they are linked to
        projectDays.each { Entity pd ->
          def result = functionService.findByLink(pd, null, metaDataService.ltProjectMember)
          if (result)
            projects.add(result)
        }
      }
      else if (entity.type.id == metaDataService.etPartner.id) {
        List projectUnits = functionService.findAllByLink(entity, null, metaDataService.ltProjectUnitParent)

        List projectDays = []
        projectUnits.each { Entity pu ->
          def result = functionService.findByLink(pu, null, metaDataService.ltProjectDayUnit)
          if (!projectDays.contains(result))
            projectDays << result
        }

        projectDays.each { Entity pd ->
          projects << functionService.findByLink(pd, null, metaDataService.ltProjectMember)
        }
      }
      render template: "/templates/linkscontent", model: [list: projects]
    }

    if (params.type == 'activities') {
      List activities = []
      if (entity.type.id == metaDataService.etClient.id)
        activities = functionService.findAllByLink(entity, null, metaDataService.ltActClient)
      else if (entity.type.id == metaDataService.etEducator.id)
        activities = functionService.findAllByLink(entity, null, metaDataService.ltActEducator)
      else if (entity.type.id == metaDataService.etFacility.id)
        activities = functionService.findAllByLink(entity, null, metaDataService.ltActFacility)
      render template: "/templates/linkscontent", model: [list: activities]
    }

    if (params.type == 'families') {
      List families = []
      if (entity.type.id == metaDataService.etParent.id) {
        List temp = functionService.findAllByLink(entity, null, metaDataService.ltGroupMemberParent)
        temp.each {
          if (it.type.id == metaDataService.etGroupFamily.id) families << it
        }
      }
      else if (entity.type.id == metaDataService.etClient.id)
        families = functionService.findAllByLink(entity, null, metaDataService.ltGroupFamily)
      else if (entity.type.id == metaDataService.etChild.id)
        families = functionService.findAllByLink(entity, null, metaDataService.ltGroupMemberChild)
      render template: "/templates/linkscontent", model: [list: families]
    }

    if (params.type == 'colonies') {
      List colonies = []
      if (entity.type.id == metaDataService.etFacility.id) {
        List temp = functionService.findAllByLink(entity, null, metaDataService.ltGroupMemberFacility)
        temp.each {
          if (it.type.id == metaDataService.etGroupColony.id) colonies << it
        }
      }
      else if (entity.type.id == metaDataService.etPartner.id) {
        List temp = functionService.findAllByLink(entity, null, metaDataService.ltGroupMemberPartner)
        temp.each {
          if (it.type.id == metaDataService.etGroupColony.id) colonies << it
        }
      }
      render template: "/templates/linkscontent", model: [list: colonies]
    }

    if (params.type == 'facilities') {
      List facilities = []
      if (entity.type.id == metaDataService.etEducator.id) {
        facilities = functionService.findAllByLink(entity, null, metaDataService.ltWorking)
        facilities.addAll(functionService.findAllByLink(entity, null, metaDataService.ltLeadEducator))
      }
      else if (entity.type.id == metaDataService.etClient.id) {
        List temp = functionService.findAllByLink(entity, null, metaDataService.ltGroupMemberClient)
        temp.each {
          if (it.type.id == metaDataService.etFacility.id) facilities << it
        }
      }
      render template: "/templates/linkscontent", model: [list: facilities]
    }

    if (params.type == 'clientgroups') {
      List clientgroups = []
      List temp = functionService.findAllByLink(entity, null, metaDataService.ltGroupMemberClient)
      temp.each {
          if (it.type.id == metaDataService.etGroupClient.id) clientgroups << it
        }
      render template: "/templates/linkscontent", model: [list: clientgroups]
    }

    if (params.type == 'partnergroups') {
      List partnergroups = functionService.findAllByLink(entity, null, metaDataService.ltGroupMember)
      render template: "/templates/linkscontent", model: [list: partnergroups]
    }

  }

  /*
   * this custom exception handler forward the exception to the developer then renders the 500 view
   */
  def error500 = {

    // AAZ: deactivated since it caused a exception loop, TODO: fix when there is time
    /*
    if (GrailsUtil.environment != "development") {
      sendMail {
        to      "error@uenterprise.de"
        subject grailsApplication.config.application.name + " - Error 500"
        html    g.render(template: '/errortemplate', model: [request:request, exception: request.exception])
      }
      log.info "Notification email sent to developers!"
    }*/

    render view: '/500'
  }

  /*
   * this is the private start
   */
  def start = {
    Entity currentEntity = entityHelperService.loggedIn
    log.info "current entity: " + currentEntity
    if (currentEntity) {
      Locale locale = currentEntity.user?.locale ?: new Locale("de", "DE");
      RequestContextUtils.getLocaleResolver(request).setLocale(request, response, locale)

      // create a calendar object for user if it doesn't exist already (added on 16.02.2011)
      if (!currentEntity.profile.calendar) currentEntity.profile.calendar = functionService.createDefaultCalendar(currentEntity)

      redirect controller: 'event', action: 'index'
    }
    else
      redirect controller: "public", action: "start"
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

      sendMail {
        to "${user.email}"
        subject grailsApplication.config.application.name + " - Dein Passwort"
        html g.render(template: 'passwordemail', model: [entity: e, password: pass])
      }

      flash.message = message(code: "account.message", args: [params.email])
      redirect controller: 'public', action: 'start'
    }
    else {
      flash.message = message(code: "account.notFound", args: [params.email])
      render view: 'password', model: [params: params]
    }
  }

  /*
   * adds a tag to an entity
   */
  def addTag = {
    Entity entity = Entity.get(params.entity)
    Tag tag = Tag.findByName(params.tag)

    // make sure the entity isn't already marked with this tag
    if (!EntityTagLink.findByTagAndEntity(tag, entity)) {
      TagLinkType tlt = new TagLinkType(name: 'default').save()

      EntityTagLink etl = new EntityTagLink(tag: tag, entity: entity, type: tlt).save()
      entity.addToTagslinks(etl)
      tag.addToEntityLinks(etl)

    }

    // get all tags of the entity
    List tags = entity.tagslinks*.tag

    render template: '/app/tags', model: [tags: tags, entity: entity, update: params.update]
  }

  /*
   * adds a local tag to an entity
   */
  def addLocalTag = {
    Entity entity = Entity.get(params.entity)
    Entity target = Entity.get(params.target)

    def c = Link.createCriteria()

    if (params.tag == 'absent') {
      def result = c.get {
        eq('source', entity)
        eq('target', target)
        eq('type', metaDataService.ltAbsent)
      }
      if (!result)
        new Link(source: entity, target: target, type: metaDataService.ltAbsent).save()
    }
    if (params.tag == 'ill') {
      def result = c.get {
        eq('source', entity)
        eq('target', target)
        eq('type', metaDataService.ltIll)
      }
      if (!result)
        new Link(source: entity, target: target, type: metaDataService.ltIll).save()
    }

    List tags = []

    def resulta = Link.createCriteria().get {
      eq('source', entity)
      eq('target', target)
      eq('type', metaDataService.ltAbsent)
    }
    if (resulta)
      tags.add(true)
    else
      tags.add(false)

    def resultb = Link.createCriteria().get {
      eq('source', entity)
      eq('target', target)
      eq('type', metaDataService.ltIll)
    }
    if (resultb)
      tags.add(true)
    else
      tags.add(false)

    render template: '/app/localtags', model: [tags: tags, entity: entity, target: target, update: params.update]
  }

  /*
   * removes a tag from an entity
   */
  def removeTag = {
    Entity entity = Entity.get(params.entity)
    Tag tag = Tag.get(params.tag)

    EntityTagLink etl = EntityTagLink.findByTagAndEntity(tag, entity)

    entity.removeFromTagslinks(etl)
    tag.removeFromEntityLinks(etl)

    etl.delete()

    List tags = entity.tagslinks*.tag

    render template: '/app/tags', model: [tags: tags, entity: entity, update: params.update]
  }

  /*
   * removes a tag from an entity
   */
  def removeLocalTag = {
    Entity entity = Entity.get(params.entity)
    Entity target = Entity.get(params.target)

    def c = Link.createCriteria()

    if (params.tag == 'absent') {
      def result = c.get {
        eq('source', entity)
        eq('target', target)
        eq('type', metaDataService.ltAbsent)
      }
      result.delete(flush:true)
    }
    if (params.tag == 'ill') {
      def result = c.get {
        eq('source', entity)
        eq('target', target)
        eq('type', metaDataService.ltIll)
      }
      result.delete(flush:true)
    }

    List tags = []

    def resulta = Link.createCriteria().get {
      eq('source', entity)
      eq('target', target)
      eq('type', metaDataService.ltAbsent)
    }
    if (resulta)
      tags.add(true)
    else
      tags.add(false)

    def resultb = Link.createCriteria().get {
      eq('source', entity)
      eq('target', target)
      eq('type', metaDataService.ltIll)
    }
    if (resultb)
      tags.add(true)
    else
      tags.add(false)

    render template: '/app/localtags', model: [tags: tags, entity: entity, target: target, update: params.update]
  }

  /*
   * deletes the profile pic of a given entity
   */
  def deleteProfilePic = {
    Entity entity = Entity.get(params.id)

    Asset asset = Asset.findByEntity(entity)
    entity.removeFromAssets(asset)
    asset.delete()

    flash.message = message(code: 'profile.picture.deleted')
    redirect controller: entity.type.supertype.name + 'Profile', action: 'show', id: entity.id
  }

  def changeCreator = {
      Entity target = Entity.get(params.id)
      Link.findByTargetAndType(target, metaDataService.ltCreator)?.delete()

      new Link(source: Entity.get(params.creator), target: target, type: metaDataService.ltCreator).save(flush: true)

      render template: "/templates/creator", model: [entity: target]
  }

  def removetarget = {
    Entity entity = Entity.get(params.entity)
    Entity target = Entity.get(params.id)
    Link.findBySourceAndTarget(entity, target)?.delete()
    render "<span style='text-decoration: line-through'>" + target.profile.fullName + "</span>"
  }

  def removesource = {
    Entity entity = Entity.get(params.entity)
    Entity source = Entity.get(params.id)
    Link.findBySourceAndTarget(source, entity)?.delete()
    render "<span style='text-decoration: line-through'>" + source.profile.fullName + "</span>"
  }

/*
   * retrieves all educators, users and operators matching the search parameter
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
        eq("type", metaDataService.etUser)
        eq("type", metaDataService.etEducator)
        eq("type", metaDataService.etOperator)
      }
      or {
        ilike('name', "%" + params.value + "%")
        profile {
          ilike('fullName', "%" + params.value + "%")
          order('fullName','asc')
        }
      }
      maxResults(15)
    }

    if (results.size() == 0) {
      render '<span class="italic">'+message(code:'noResultsFound')+ '</span>'
      return
    }
    else {
      render template: 'creatorresults', model: [results: results, changed: params.id]
    }
  }

  def logout = {
    Entity e = securityManager.getLoggedIn(request)
    securityManager.logout(request)
    redirect controller: "public", action: "start"
  }

  def do_login = {
      if (!params.userid) {
        flash.message = message(code: "security.login.emptyuid")
        redirect (controller: "public", action: "start")
        return
      }
      if (!params.password) {
        flash.message = message(code: "security.login.emptypwd")
        redirect (controller: "public", action: "start")
        return
      }

      Entity currentEntity = null
      try {
        currentEntity = securityManager.login (request, params.userid, params.password)
        log.info "entity after login: " + currentEntity
      } catch (SecurityManagerException sme) {
        flash.message = message(code: sme.code)
        redirect (controller: "public", action: "start")
        return
      }

      log.info "login successful for $params.userid (${currentEntity?.name})"
      def startUrl = "/start" // grailsApplication.config.secmgr.starturl ?: "/start"
      log.info ("redirecting to 'starturl': $startUrl")

      redirect action: "start" //(uri: startUrl, args: [entity: currentEntity])
    }

}
