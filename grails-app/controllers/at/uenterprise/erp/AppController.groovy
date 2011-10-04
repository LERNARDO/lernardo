package at.uenterprise.erp

import at.openfactory.ep.Entity
import at.openfactory.ep.Account
import at.openfactory.ep.SecHelperService
import at.openfactory.ep.EntityHelperService
import at.openfactory.ep.Tag
import at.openfactory.ep.TagLinkType
import at.openfactory.ep.EntityTagLink
import at.openfactory.ep.Asset
import at.openfactory.ep.Link

import org.springframework.web.servlet.support.RequestContextUtils

import javax.servlet.http.Cookie
import at.openfactory.ep.AssetStorage
//import grails.util.GrailsUtil

class AppController {
  SecHelperService secHelperService
  EntityHelperService entityHelperService
  def securityManager
  FunctionService functionService
  MetaDataService metaDataService
  def assetService

  /*
   * renders an image
   */
  def get = {
    Entity ent = Entity.get (params.entity)
    if (!ent) {
      response.sendError(404, "no such entity: '$params.entity")
      return
    }

    AssetStorage store = assetService.findStorage(ent, params.type, params.select ?: 'latest' )
    if (!store) {
        // response.sendError(404, 'no matching asset')
        def res = grailsApplication.mainContext.getResource ("images/default_asset.jpg")
        if (res) {
          response.contentType = "image/jpg"
          response.outputStream << res.inputStream
          response.outputStream.flush ()
        }
      return
    }

    assetService.renderStorage (store, response)
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
    render template: 'livetickersmall', model:[events: events, timeZone: timeZone]
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
    render template: 'liveticker', model:[events: events]
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
        days.each {
          projects << functionService.findByLink(it, null, metaDataService.ltProjectMember)
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
        projectUnits.each {
          def result = functionService.findByLink(it, null, metaDataService.ltProjectDayUnit)
          if (result && !projectDays.contains(result))
            projectDays << result
        }

        // for each project day find all projects they are linked to
        projectDays.each {
          def result = functionService.findByLink(it, null, metaDataService.ltProjectMember)
          if (result)
            projects.add(result)
        }
      }
      else if (entity.type.id == metaDataService.etPartner.id) {
        List projectUnits = functionService.findAllByLink(entity, null, metaDataService.ltProjectUnitParent)

        List projectDays = []
        projectUnits.each {
          def result = functionService.findByLink(it, null, metaDataService.ltProjectDayUnit)
          if (!projectDays.contains(result))
            projectDays << result
        }

        projectDays.each {
          projects << functionService.findByLink(it, null, metaDataService.ltProjectMember)
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
        html    g.render(template:'/errortemplate', model:[request:request, exception: request.exception])
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
    if (currentEntity) {
      Locale locale = currentEntity.user?.locale ?: new Locale("de", "DE");
      RequestContextUtils.getLocaleResolver(request).setLocale(request, response, locale)

      // create a calendar object for user if it doesn't exist already (added on 16.02.2011)
      if (!currentEntity.profile.calendar)
        currentEntity.profile.calendar = new ECalendar().save()

      redirect controller: 'profile', action: 'showNews', id: currentEntity.id
    }
    else
      redirect action: 'home'
  }

  /*
   * this is the public start
   */
  def home = {
    redirect controller: 'articlePost', action: 'index'
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
      redirect controller: 'articlePost', action: 'index'
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

      EntityTagLink etl = new EntityTagLink(tag: tag, entity: entity, type: tlt).save() // IntelliJ fails to recognize the "tag" relationship
      entity.addToTagslinks(etl)
      tag.addToEntityLinks(etl)

    }
    //else {
    //render '<span class="red italic">' + entity.profile.fullName + ' ist bereits als ' + tag.name + ' getaggt!</span>'
    //}

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

    def a = Link.createCriteria()
    def resulta = a.get {
      eq('source', entity)
      eq('target', target)
      eq('type', metaDataService.ltAbsent)
    }
    if (resulta)
      tags.add(true)
    else
      tags.add(false)

    def b = Link.createCriteria()
    def resultb = b.get {
      eq('source', entity)
      eq('target', target)
      eq('type', metaDataService.ltIll)
    }
    if (resultb)
      tags.add(true)
    else
      tags.add(false)

    render template: '/app/localtags', model: [tags: tags, entity: entity, target: target, update: params.update, currentEntity: entityHelperService.loggedIn]
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

    def a = Link.createCriteria()
    def resulta = a.get {
      eq('source', entity)
      eq('target', target)
      eq('type', metaDataService.ltAbsent)
    }
    if (resulta)
      tags.add(true)
    else
      tags.add(false)

    def b = Link.createCriteria()
    def resultb = b.get {
      eq('source', entity)
      eq('target', target)
      eq('type', metaDataService.ltIll)
    }
    if (resultb)
      tags.add(true)
    else
      tags.add(false)

    render template: '/app/localtags', model: [tags: tags, entity: entity, target: target, update: params.update, currentEntity: entityHelperService.loggedIn]
  }

  /*
   * deletes the profile pic of a given entity
   */
  def deleteProfilePic = {
    Entity entity = Entity.get(params.id)

    Asset asset = Asset.findByEntity(entity)
    entity.removeFromAssets(asset)
    asset.delete()

    flash.message = message(code: 'profile.picture.deleted ')
    redirect controller: entity.type.supertype.name + 'Profile', action: 'show', id: entity.id, params: [entity: entity.id]
  }

  //def showImage = {
  //  def name = entityHelperService.loggedIn.name
  //  render '<img src="' + g.createLink (controller:'asset', action:'get', params:[type: 'profile', entity:name]) + '" width="50" />'
  //}

  def changeCreator = {
      Entity target = Entity.get(params.id)
      Link.findByTargetAndType(target, metaDataService.ltCreator)?.delete()

      new Link(source: Entity.get(params.creator), target: target, type: metaDataService.ltCreator).save(flush: true)

      render template: "/templates/creator", model: [entity: target]
  }

  def adminlinks = {
      List entities = Entity.list()
      return [entities: entities]
  }

  def adminlinksresults = {
      if (params.id != 'null') {
          Entity entity = Entity.get(params.id)

          List targets = Link.findAllBySource(entity) //?.collect {it.target}
          List sources = Link.findAllByTarget(entity) //?.collect {it.source}

          render template: 'adminlinksresults', model:[entity: entity, targets: targets, sources: sources]
      }
      else
        render ""
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

  def removeroguecomments = {
    List comments = Comment.list()
    def total = comments.size()
    def deleted = 0
    comments.each { comment ->
      if (!Entity.get(comment.creator)) {
        log.info "no entity found with id: ${comment.creator}"
        comment.delete()
        deleted++
      }
    }
    render "<span class='green'>${deleted} of a total of ${total} comments deleted!</span>"
  }

/*
   * retrieves all educators, users and operators matching the search parameter
   */
  def remoteCreators = {
    if (!params.value) {
      render ""
      return
    }

    def c = Entity.createCriteria()
    def results = c.list {
      or {
        eq("type", metaDataService.etUser)
        eq("type", metaDataService.etEducator)
        eq("type", metaDataService.etOperator)
      }
      or {
        ilike('name', "%" + params.value + "%")
        profile {
          ilike('fullName', "%" + params.value + "%")
        }
      }
      maxResults(15)
    }

    if (results.size() == 0) {
      render '<span class="italic">'+message(code:'noResultsFound')+'</span>'
      return
    }
    else {
      render(template: 'creatorresults', model: [results: results, changed: params.id])
    }
  }

  /*
   * populates tables for sorting links
   */
  def createtables = {
    // group activity templates
    List groups = Entity.findAllByType(metaDataService.etGroupActivityTemplate)
    int number = 0
    groups.each { group ->
      List activityTemplates = functionService.findAllByLink(null, group, metaDataService.ltGroupMember)
      activityTemplates.each { activityTemplate ->
        if (!group.profile.templates.contains(activityTemplate.id.toString())) {
          group.profile.addToTemplates(activityTemplate.id.toString())
          number++
        }
      }
    }
    render "Created ${number} table entries in ${groups.size()} group activity templates<br/>"

    // project templates
    groups = Entity.findAllByType(metaDataService.etProjectTemplate)
    number = 0
    groups.each { group ->
      List projectUnitTemplates = functionService.findAllByLink(null, group, metaDataService.ltProjectUnitTemplate)
      projectUnitTemplates.each { projectUnitTemplate ->
        if (!group.profile.templates.contains(projectUnitTemplate.id.toString())) {
          group.profile.addToTemplates(projectUnitTemplate.id.toString())
          number++
        }
      }
    }
    render "Created ${number} table entries in ${groups.size()} project templates<br/>"

    // project days
    groups = Entity.findAllByType(metaDataService.etProjectDay)
    number = 0
    groups.each { group ->
      List units = functionService.findAllByLink(null, group, metaDataService.ltProjectDayUnit)
      units.each { unit ->
        if (!group.profile.units.contains(unit.id.toString())) {
          group.profile.addToUnits(unit.id.toString())
          number++
        }
      }
    }
    render "Created ${number} table entries in ${groups.size()} project days<br/>"
  }

  def checktables = {
    // group activity templates
    List groups = Entity.findAllByType(metaDataService.etGroupActivityTemplate)
    log.info "group activity templates size: " + groups?.size()
    int number = 0
    groups.each { group ->
      number++
      log.info "group activity templates: Entity-No:"+number+" Entity-Id:"+group.id
      List activityTemplates = functionService.findAllByLink(null, group, metaDataService.ltGroupMember)
      log.info "group activity templates: activityTemplates-Size:"+activityTemplates?.size()
      activityTemplates.each { activityTemplate ->
        log.info "group activity templates: Activity-Template_Id:"+activityTemplate.id
        if (!group.profile.templates.contains(activityTemplate.id.toString())) {
          log.info "group activity templates: activityTemplate: "+activityTemplate.id+" for Entity: "+group.id+ " (profile-id: "+group.profile.id+") not in Sort-Table"
        }
      }
      group.profile.templates.each { templ ->
        def aLink = Link.createCriteria().get {
          eq('source', Entity.get(Integer.parseInt(templ)))
          eq('target', group)
          eq ('type', metaDataService.ltGroupMember)
        }
        if (!aLink) {
          log.info "group activity templates: Entity-Id: "+templ+" for group.profile-ID "+group.profile.id+" not found!!!!!!!!!!!!!!"
        }
      }
    }

    // project templates
    groups = Entity.findAllByType(metaDataService.etProjectTemplate)
    log.info "project templates size: " + groups?.size()
    number = 0
    groups.each { group ->
      number++
      log.info "project templates: Entity-No:"+number+" Entity-Id:"+group.id
      List projectUnitTemplates = functionService.findAllByLink(null, group, metaDataService.ltProjectUnitTemplate)
      log.info "project templates: projectUnits-Size:"+projectUnitTemplates?.size()
      projectUnitTemplates.each { projectUnitTemplate ->
        log.info "project templates: projectUnitTemplate_Id:"+projectUnitTemplate.id
        if (!group.profile.templates.contains(projectUnitTemplate.id.toString())) {
          log.info "project templates: projectUnitTemplate: "+projectUnitTemplate.id+" for Entity "+group.id+" (profile-id: "+group.profile.id+") not in Sort-Table"
        }
      }
      group.profile.templates.each { templ ->
        def aLink = Link.createCriteria().get {
          eq('source', Entity.get(Integer.parseInt(templ)))
          eq('target', group)
          eq ('type', metaDataService.ltProjectUnitTemplate)
        }
        if (!aLink) {
          log.info "project templates: Entity-Id: "+templ+" for group.profile-ID "+group.profile.id+" not found!!!!!!!!!!!!!!"
        }
      }
    }

    // project days
    groups = Entity.findAllByType(metaDataService.etProjectDay)
    log.info "project days size: " + groups?.size()
    number = 0
    groups.each { group ->
      number++
      log.info "project days: Entity-No:"+number+" Entity-Id:"+group.id
      List units = functionService.findAllByLink(null, group, metaDataService.ltProjectDayUnit)
      log.info "project days: Units-Size:"+units?.size()
      units.each { unit ->
        log.info "project days: Unit_Id"+unit.id
        if (!group.profile.units.contains(unit.id.toString())) {
         log.info "project days: unit: "+unit.id+" for Entity: "+group.id+" (profile-id: "+group.profile.id+") not in Sort-Table"
        }
      }
    }
    render "Finished <br/>"

  }

  /*
   * some speed testing of the DB
   */
  def checkDB = {
    log.info "reading all entities of type facility"

    //List facilities = Entity.findAllByType(metaDataService.etFacility)

    params.offset = params.offset ? params.int('offset') : 0
    params.max = Math.min(params.max ? params.int('max') : 15, 100)
    params.sort = params.sort ?: "fullName"
    params.order = params.order ?: "asc"

    List facilities = Entity.createCriteria().list (max: params.max, offset: params.offset) {
      eq("type", metaDataService.etFacility)
      profile {
        order(params.sort, params.order)
      }
    }

    log.info facilities
    log.info "----"

    Date begin = new Date()
      def etFacility = metaDataService.etFacility
    Date end = new Date()
    int time = (end.getTime() - begin.getTime())
    log.info "done reading, time: ${time} milliseconds"

    begin = new Date()
      etFacility = metaDataService.etFacility
    end = new Date()
    time = (end.getTime() - begin.getTime())
    log.info "done reading, time: ${time} milliseconds"

    List facilities2 = Entity.createCriteria().list {
      eq("type", etFacility)
      profile {
        order(params.sort, params.order)
      }
      firstResult (params.offset)
      maxResults (params.max)
    }
    def totalCount = Entity.countByType(etFacility)

    log.info facilities2
    log.info totalCount

  }

  def removeAssets = {

    List entities = Entity.list()

    // delete duplicate profile assets
    entities.each { Entity entity ->
      List assets = Asset.findAllByEntityAndType(entity, "profile", [sort: "dateCreated", order: "desc"])
      //println "assets of entity: " + entity.profile + ": " + assets
      if (assets && assets.size() > 1) {
        for (int i = 1; i < assets.size(); i++) {
          assets[i].delete(flush: true)
        }
      }
    }

    // delete unused asset storages
    List ast = AssetStorage.list()
    ast.each { AssetStorage assetStorage ->
      //println "assets: " + assetStorage.assets
      if (assetStorage.assets.size() == 0)
        assetStorage.delete(flush: true)
    }

    render "done"

  }

}
