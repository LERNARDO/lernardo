package at.uenterprise.erp

import at.openfactory.ep.Entity
import at.openfactory.ep.Link
import java.text.SimpleDateFormat
import org.springframework.web.servlet.support.RequestContextUtils
import at.openfactory.ep.EntityHelperService

import at.openfactory.ep.SecHelperService
import org.springframework.beans.SimpleTypeConverter
import org.springframework.context.MessageSourceResolvable
import org.codehaus.groovy.grails.web.util.StreamCharBuffer
import org.codehaus.groovy.grails.commons.DomainClassArtefactHandler

class HelperTagLib {
  EntityHelperService entityHelperService
  MetaDataService metaDataService
  SecHelperService secHelperService
  FunctionService functionService
  def securityManager
  static namespace = "erp"

  /**
   * Checks if a resource is available for planning
   *
   * @author Alexander Zeillinger
   * @attr resource REQUIRED The resource to check
   * @attr entity REQUIRED The group activity or project to check
   */
  def getResourceFree = {attrs, body ->
    Calendar calendar = new GregorianCalendar()
    calendar.setTime(attrs.entity.profile.date)

    if (attrs.entity.type.id == metaDataService.etGroupActivity.id)
      calendar.add(Calendar.MINUTE, attrs.entity.profile.realDuration)
    else {
      // get all project units of a project day and calculate the sum of their durations
      List units = functionService.findAllByLink(null, attrs.entity, metaDataService.ltProjectDayUnit)
      int duration = units*.profile.duration.sum(0)
      calendar.add(Calendar.MINUTE, duration)
    }

    // get begin and end date of the group activity or project
    Date entityBegin = attrs.entity.profile.date
    Date entityEnd = calendar.getTime()

    // find all links the resource is already planned with
    List links = Link.findAllBySourceAndType(attrs.resource, metaDataService.ltResourcePlanned)

    // set the initial amount of how many units are available to the total amount of the resource
    int free = attrs.resource.profile.amount

    // now check for every link if it falls into the duration of the entity and if yes reduce the available amount
    links.each { Link link ->
      Date resourceBegin = new Date()
      resourceBegin.setTime(link.das.beginDate.toLong() * 1000)
      Date resourceEnd = new Date()
      resourceEnd.setTime(link.das.endDate.toLong() * 1000)

     if (!(resourceBegin >= entityEnd || resourceEnd <= entityBegin)) {
       free -= link.das.amount.toInteger()
     }
    }

    out << body(resourceFree: free)
  }

  /**
   * Return the amount of units a resource is planned with
   *
   * @author Alexander Zeillinger
   * @attr resource REQUIRED The resource to check
   * @attr entity REQUIRED The group activity or project to check
   */
  def getPlannedResourceAmount = {attrs ->
    def link = Link.createCriteria().get {
      eq('source', attrs.resource)
      eq('target', attrs.entity)
      eq('type', metaDataService.ltResourcePlanned)
    }
   out << link.das.amount
  }

  /**
   * Returns all entities who have birthday today
   *
   * @author Alexander Zeillinger
   */
  def getBirthdays = {attrs, body ->

    SimpleDateFormat sdf = new SimpleDateFormat("d M")
    Date date = new Date()

    List results = []

    List educators = Entity.findAllByType(metaDataService.etEducator)
    educators.each { Entity educator ->
      if (sdf.format(educator.profile.birthDate) == sdf.format(date))
        results.add(educator)
    }

    List clients = Entity.findAllByType(metaDataService.etClient)
    clients.each { Entity client ->
      if (sdf.format(client.profile.birthDate) == sdf.format(date))
        results.add(client)
    }

    results.each {out << body(entities: it)}
  }

  /**
   * Renders the text of an event
   *
   * @author Alexander Zeillinger
   * @attr event REQUIRED The event to render
   */
  def getEvent = {attrs ->
    Entity who = Entity.get(attrs.event.who)
    def what = Entity.get(attrs.event.what)
    if (!what) {
     what = Helper.get(attrs.event.what)
     if (who && what)
       out << message(code: attrs.event.name, args: ['<a href="' + createLink(controller: who.type.supertype.name +'Profile', action:'show', id: who.id) + '">' + who.profile.fullName + '</a>', '<a href="' + createLink(controller: 'helper', action: 'list') + '">' + what.title + '</a>']).decodeHTML()
    }
    else
      if (who && what)
        out << message(code: attrs.event.name, args: ['<a href="' + createLink(controller: who.type.supertype.name +'Profile', action:'show', id: who.id) + '">' + who.profile.fullName + '</a>', '<a href="' + createLink(controller: what.type.supertype.name +'Profile', action: 'show', id: what.id) + '">' + what.profile.fullName + '</a>']).decodeHTML()
  }

  def profileImage = {attrs ->
    def imgattrs = [:]
    imgattrs['src'] = g.createLink (controller:'app', action:'get', params:[type:'profile', entity:attrs.entity.id])
    attrs.name = attrs.entity.name
    attrs.each {key, val ->
      imgattrs[key] = val
    }
    def mkp = new groovy.xml.MarkupBuilder(out)
    mkp { img (imgattrs) }
  }

  def truncate = {attrs ->
    out << (attrs.string.size() > 20 ? attrs.string.substring(0, 20) + "..." : attrs.string)
  }

  /**
   * Retrieves all online users who where active within the last 5 minutes
   *
   * @author Alexander Zeillinger
   */
  def getOnlineUsers = {attrs, body ->
    List users = Entity.list()

    List onlineUsers = []
    users.each { Entity entity ->
      if (entity?.user?.lastAction)
        if ((new Date().getTime() - entity.user.lastAction.getTime()) / 1000 / 60 <= 5)
          onlineUsers.add(entity)
    }

    onlineUsers.each {out << body(onlineUsers: it)}
  }

  /**
   * Get all workdayunits of an educator
   *
   * @author Alexander Zeillinger
   * @attr educator REQUIRED The educator to find the workdayunits of
   * @attr date1 REQUIRED The begin of the date range to check
   * @attr date2 REQUIRED The end of the date range to check
   */
  def getWorkdayUnits = { attrs, body ->
    Date date1 = Date.parse("dd. MM. yy", attrs.date1)
    Date date2 = Date.parse("dd. MM. yy", attrs.date2) + 1

    Entity educator = attrs.educator

    List units = []
    educator.profile.workdayunits.each { WorkdayUnit workdayUnit ->
      // check if the date of the workdayunit is between date1 and date2
      if (workdayUnit.date1 >= date1 && workdayUnit.date2 <= date2) {
        units.add(workdayUnit)
      }
    }
    out << body(units: units)
  }

  /**
   * Check if all workdayunits of an educator are confirmed
   *
   * @author Alexander Zeillinger
   * @attr educator REQUIRED The educator to find the workdayunits of
   * @attr date1 REQUIRED The begin of the date range to check
   * @attr date2 REQUIRED The end of the date range to check
   */
  def getHoursConfirmed = { attrs, body ->
    Date date1
    Date date2

    if (attrs.date1 != null && attrs.date2 != null) {
      date1 = Date.parse("dd. MM. yy", attrs.date1)
      date2 = Date.parse("dd. MM. yy", attrs.date2) + 1
    }

    Entity educator = attrs.educator

    def allConfirmed = true
    educator.profile.workdayunits.each { WorkdayUnit workdayUnit ->
      // check if the date of the workdayunit is between date1 and date2
      if (attrs.date1 != null & attrs.date2 != null) {
        if (workdayUnit.date1 >= date1 && workdayUnit.date2 <= date2) {
          if (!workdayUnit.confirmed) {
            allConfirmed = false
          }
        }
      }
    }

    if (allConfirmed)
        out << "${message(code: 'yes')}"
    else
        out << "${message(code: 'no')}"
  }

  /**
   * Calculates the salary of an educator
   *
   * @author Alexander Zeillinger
   * @attr educator REQUIRED The educator to find the workdayunits of
   * @attr date1 REQUIRED The begin of the date range to check
   * @attr date2 REQUIRED The end of the date range to check
   */
  def getSalary = { attrs, body ->
    Date date1 = null
    Date date2 = null

    if (attrs.date1 != null && attrs.date2 != null) {
      date1 = Date.parse("dd. MM. yy", attrs.date1)
      date2 = Date.parse("dd. MM. yy", attrs.date2) + 1
    }

    Entity educator = attrs.educator

    // calculate expected hours
    BigDecimal expectedHours = 0
    Calendar tcalendarStart = new GregorianCalendar();
    tcalendarStart.setTime(date1);

    Calendar tcalendarEnd = new GregorianCalendar();
    tcalendarEnd.setTime(date2);

    SimpleDateFormat tdf = new SimpleDateFormat("EEEE", new Locale("en"))

    while (tcalendarStart <= tcalendarEnd) {
      Date currentDate = tcalendarStart.getTime();

      if (tdf.format(currentDate) == 'Monday')
        expectedHours += educator.profile.workHoursMonday
      else if (tdf.format(currentDate) == 'Tuesday')
        expectedHours += educator.profile.workHoursTuesday
      else if (tdf.format(currentDate) == 'Wednesday')
        expectedHours += educator.profile.workHoursWednesday
      else if (tdf.format(currentDate) == 'Thursday')
        expectedHours += educator.profile.workHoursThursday
      else if (tdf.format(currentDate) == 'Friday')
        expectedHours += educator.profile.workHoursFriday
      else if (tdf.format(currentDate) == 'Saturday')
        expectedHours += educator.profile.workHoursSaturday
      else if (tdf.format(currentDate) == 'Sunday')
        expectedHours += educator.profile.workHoursSunday

      tcalendarStart.add(Calendar.DATE, 1)
    }

    // calculate real hours
    int hours = 0
    educator.profile.workdayunits.each { WorkdayUnit workdayUnit ->
      // check if the workdayunit should be counted
      WorkdayCategory category = WorkdayCategory.findByName(workdayUnit.category)
      if (category?.count) {
        // check if the date of the workdayunit is between date1 and date2
        if (attrs.date1 != null & attrs.date2 != null) {
          if (workdayUnit.date1 >= date1 && workdayUnit.date2 <= date2) {
            hours += (workdayUnit.date2.getTime() - workdayUnit.date1.getTime()) / 1000 / 60 / 60
          }
        }
        else
          hours += (workdayUnit.date2.getTime() - workdayUnit.date1.getTime()) / 1000 / 60 / 60
      }
    }

    // calculate salary
    def result = 0
    if (hours <= expectedHours)
        result += hours * (educator?.profile?.hourlyWage ?: 0)
    else
        result += expectedHours * (educator?.profile?.hourlyWage ?: 0) + ((hours - expectedHours) * (educator?.profile?.overtimePay ?: 0))

    out << result

  }

  /**
   * Calculates the number of hours an educator should have worked
   *
   * @author Alexander Zeillinger
   * @attr educator REQUIRED The educator to find the workdayunits of
   * @attr date1 REQUIRED The begin of the date range to check
   * @attr date2 REQUIRED The end of the date range to check
   */
  def getExpectedHours = { attrs, body ->
    Date date1 = null
    Date date2 = null

    if (attrs.date1 != null && attrs.date2 != null) {
      date1 = Date.parse("dd. MM. yy", attrs.date1)
      date2 = Date.parse("dd. MM. yy", attrs.date2) + 1
    }

    Entity educator = attrs.educator

    BigDecimal expectedHours = 0
    Calendar tcalendarStart = new GregorianCalendar();
    tcalendarStart.setTime(date1);

    Calendar tcalendarEnd = new GregorianCalendar();
    tcalendarEnd.setTime(date2);

    SimpleDateFormat tdf = new SimpleDateFormat("EEEE", new Locale("en"))

    while (tcalendarStart <= tcalendarEnd) {
      Date currentDate = tcalendarStart.getTime();

      if (tdf.format(currentDate) == 'Monday')
        expectedHours += educator.profile.workHoursMonday
      else if (tdf.format(currentDate) == 'Tuesday')
        expectedHours += educator.profile.workHoursTuesday
      else if (tdf.format(currentDate) == 'Wednesday')
        expectedHours += educator.profile.workHoursWednesday
      else if (tdf.format(currentDate) == 'Thursday')
        expectedHours += educator.profile.workHoursThursday
      else if (tdf.format(currentDate) == 'Friday')
        expectedHours += educator.profile.workHoursFriday
      else if (tdf.format(currentDate) == 'Saturday')
        expectedHours += educator.profile.workHoursSaturday
      else if (tdf.format(currentDate) == 'Sunday')
        expectedHours += educator.profile.workHoursSunday

      tcalendarStart.add(Calendar.DATE, 1)
    }

    out << expectedHours
  }

  /**
   * Calculates the number of total hours an educator has worked
   *
   * @author Alexander Zeillinger
   * @attr educator REQUIRED The educator to find the workdayunits of
   * @attr date1 REQUIRED The begin of the date range to check
   * @attr date2 REQUIRED The end of the date range to check
   */
  def getTotalHours = { attrs, body ->
    Date date1
    Date date2

    if (attrs.date1 != null && attrs.date2 != null) {
      date1 = Date.parse("dd. MM. yy", attrs.date1)
      date2 = Date.parse("dd. MM. yy", attrs.date2) + 1
    }

    Entity educator = attrs.educator

    BigDecimal hours = 0
    educator.profile.workdayunits.each { WorkdayUnit workdayUnit ->
      // check if the workdayunit should be counted
      WorkdayCategory category = WorkdayCategory.findByName(workdayUnit.category)
      if (category?.count) {
        // check if the date of the workdayunit the chosen date range
        if (attrs.date1 != null & attrs.date2 != null) {
          if (workdayUnit.date1 >= date1 && workdayUnit.date2 <= date2) {
            hours += (workdayUnit.date2.getTime() - workdayUnit.date1.getTime()) / 1000 / 60 / 60
          }
        }
        else
          hours += (workdayUnit.date2.getTime() - workdayUnit.date1.getTime()) / 1000 / 60 / 60
      }
    }

    out << hours
  }

  /**
   * Calculates the number of hours an educator has worked in a given category
   *
   * @author Alexander Zeillinger
   * @attr educator REQUIRED The educator to find the workdayunits of
   * @attr date1 REQUIRED The begin of the date range to check
   * @attr date2 REQUIRED The end of the date range to check
   * @attr category REQUIRED The category to check
   */
  def getHoursForCategory = { attrs, body ->
    Date date1
    Date date2
    if (attrs.date1 != "" && attrs.date2 != "") {
      date1 = Date.parse("dd. MM. yy", attrs.date1)
      date2 = Date.parse("dd. MM. yy", attrs.date2) + 1
    }

    Entity educator = attrs.educator
    WorkdayCategory workdayCategory = attrs.category

    BigDecimal hours = 0
    educator.profile.workdayunits.each { WorkdayUnit workdayUnit ->
      if (workdayUnit.category == workdayCategory.name) {

        // check if the date of the workdayunit is between date1 and date2
        if (attrs.date1 != "" & attrs.date2 != "") {
          if (workdayUnit.date1 >= date1 && workdayUnit.date2 <= date2) {
            hours += (workdayUnit.date2.getTime() - workdayUnit.date1.getTime()) / 1000 / 60 / 60
          }
        }
        else
          hours += (workdayUnit.date2.getTime() - workdayUnit.date1.getTime()) / 1000 / 60 / 60
      }
    }

    out << hours
  }

  /**
   * custom tag for as long as the official implementation is broken, see http://jira.codehaus.org/browse/GRAILS-2512--}%
   * TODO: probably outdated, check if it can be replaced by the official tag again
   */
  def remoteField = { attrs, body ->
    def params = attrs['params']?:null
    if(params){
      String pString = "\'"
      params.each { key, value ->
        pString += "${key}=${value}&"
      }
      pString += "\'"
      attrs['params'] = pString;
    }
    out << g.remoteField(attrs, body)
  }

  /**
   * get the local tags of a given entity
   */
  def getLocalTags = {attrs, body ->
    Entity entity = attrs.entity
    Entity target = attrs.target

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

    out << body(tags: tags)
  }

  /**
   * get the tags of a given entity
   */
  def getTags = {attrs, body ->
    Entity entity = attrs.entity
    List tags = entity.tagslinks*.tag
    out << body(tags: tags)
  }

  /**
   * checks whether to render a tag button
   */
  def showTagButton = {attrs, body ->
    List tags = attrs.tags
    List tagnames = tags*.name
    if (!tagnames.contains(attrs.button))
      out << body()
  }

  /**
   * before deleting an entity this method finds any links to and from the entity and returns a confirmation message
   */
  def getLinks = {attrs ->
    Integer id = attrs.id
    Entity entity = Entity.get(id)

    def linksTarget = Link.findAllByTarget(entity)
    List sourceNames = linksTarget*.source.profile.fullName

    def linksSource = Link.findAllBySource(entity)
    List targetNames = linksSource*.target.profile.fullName

    if (sourceNames.size() == 0 && targetNames.size() == 0)
      out << "return confirm('${message(code: 'connectionsNone')}')"
    else if (sourceNames.size() > 0 && targetNames.size() == 0)
      out << "return confirm('${message(code: 'connectionsTo', args: [sourceNames])}')"
    else if (sourceNames.size() == 0 && targetNames.size() > 0)
      out << "return confirm('${message(code: 'connectionsFrom', args: [targetNames])}')"
    else
      out << "return confirm('${message(code: 'connectionsToAndFrom', args: [sourceNames, targetNames])}')"
  }

  /**
   * Modular access check
   *
   * @attr entity REQUIRED The entity which should be checked for access
   * @attr types The types to check against
   * @attr roles The roles to check against
   * @attr checkoperator Check if the entity is an operator
   * @attr creatorof Check if the entity is creator of this
   * @attr me Check if the entity is the currently logged in entity
   * @attr checkstatus Check if the entity is open for editing
   * @attr log Enables logging for current taglib call
   */
  def accessCheck = {attrs, body ->
    Entity entity = attrs.entity

    boolean isOpen = true
    if (attrs.checkstatus) {
      isOpen = accessIsOpen(attrs.checkstatus)
    }

    boolean isMe = false
    if (attrs.me) {
      isMe = accessIsMe(attrs.me)
      if (attrs.log)
        log.info "${attrs.me.profile} is ${entity.profile}: ${isMe}"
    }

    boolean isLeadEducator = false
    if (attrs.facilities)
      isLeadEducator = accessIsLeadEducator(entity, attrs.facilities)
    if (attrs.log)
      log.info "${entity.profile} is lead educator: ${isLeadEducator}"

    boolean isCreatorOf = false
    if (attrs.creatorof)
      isCreatorOf = accessIsCreatorOf(entity, attrs.creatorof)
    if (attrs.log)
      log.info "${entity.profile} is creator: " + isCreatorOf

    boolean isAdmin = entity?.user?.authorities?.find {it.authority == 'ROLE_ADMIN'} ? true : false

    boolean isOperator = false
    if (attrs.checkoperator) {
      isOperator = entity.type == metaDataService.etOperator
      if (attrs.log)
        log.info "${entity.profile} is operator: " + isOperator
    }

    if ((isAdmin || isCreatorOf || isMe || isOperator) ||
        ((accessHasTypes(entity, attrs.types) || accessHasRoles(entity, attrs.roles) || isLeadEducator) && isOpen))
      out << body()
  }

  // checks if a given entity has at least one of the given roles
  boolean accessHasRoles(Entity entity, List roles = []) {

    def result = false

    if (entity.user) {
      result = roles.findAll { entity.user?.authorities*.authority.contains(it) }
    }

    return result ? true : false
  }

  // checks if a given entity is of one of the given types
  boolean accessHasTypes(Entity entity, List types = []) {

    def result = types.findAll { entity.type?.name == it }

    return result ? true : false
  }

  // checks if a given entity is the currently logged in entity
  boolean accessIsMe(Entity entity) {
    return entity == entityHelperService.loggedIn
  }

  // checks if a given entity has an open status
  boolean accessIsOpen(def checkstatus) {

    def result = false;
    if (checkstatus instanceof Entity) {
      if (checkstatus.profile.status == 'notDoneOpen')
        result = true
    }

    return result
  }

  // checks if a given entity is creator of another given entity
  boolean accessIsCreatorOf(Entity entity, def creatorof) {

    def result = null;
    if (creatorof instanceof Entity) {
      def c = Link.createCriteria()
      result = c.get {
        eq('source', entity)
        eq('target', creatorof)
        eq('type', metaDataService.ltCreator)
      }
    }
    else if (creatorof instanceof Publication) {
      return (creatorof.entity.id == entity.id)
    }

    if (result)
      return true
    else
      return false
  }

  // checks if a given entity is lead educator of a given facility
  boolean accessIsLeadEducator(Entity entity, List facilities) {

    List allFacilities = functionService.findAllByLink(entity, null, metaDataService.ltLeadEducator)

    def hits = false

    allFacilities.each {
      if (facilities.contains(it))
        hits = true
    }

    return hits
  }

  /**
   * outputs selectbox items for each language
   */
  def localeSelect = {attrs ->
    attrs['from'] = grailsApplication.config.locales
    attrs['value'] = (attrs['value'] ?: RequestContextUtils.getLocale(request))?.toString()
    // set the key as a closure that formats the locale
    attrs['optionKey'] = {"${it.language}_${it.country}"}
    // set the option value as a closure that formats the locale for display
    attrs['optionValue'] = {"${it.displayLanguage}"}

    // use generic select
    out << eselect(attrs)
  }

  /**
   * returns the filetype of a publication
   * Reference: http://en.wikipedia.org/wiki/Internet_media_type
   */
  def getFileType = {attrs ->
    if (attrs.type == 'application/vnd.ms-excel' || attrs.type == 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet')
      out << "Excel"
    else if (attrs.type == 'image/jpeg' || attrs.type == 'image/png' || attrs.type == 'image/gif' || attrs.type == 'image/bmp')
      out << "Bild"
    else if (attrs.type == 'application/msword' || attrs.type == 'application/vnd.openxmlformats-officedocument.wordprocessingml.document')
      out << "Word"
    else if (attrs.type == 'application/force-download' || attrs.type == 'application/pdf')
      out << "PDF"
    else if (attrs.type == 'text/plain')
      out << "Text"
    else if (attrs.type == 'application/vnd.ms-powerpoint' || attrs.type == 'application/mspowerpoint')
      out << "PowerPoint"
    else if (attrs.type == 'application/x-shockwave-flash')
      out << "Flash"
    else if (attrs.type == 'application/zip')
      out << "Archiv"
    else if (attrs.type == 'audio/mpeg3' || attrs.type == 'audio/x-mpeg3' || attrs.type == 'audio/mpeg')
      out << "MP3"
    else if (attrs.type == 'video/avi')
      out << "Video"
    else
      out << "Unbekannt"
  }

  /**
   * finds the number of units linked to a project template
   */
  def getProjectTemplateUnitsCount = {attrs, body ->
    def units = Link.countByTargetAndType(attrs.template, metaDataService.ltProjectUnitTemplate)
    out << units
  }

  /**
   * finds the number of clients linked to a client group
   */
  def getGroupClientsCount = {attrs, body ->
    def clients = Link.countByTargetAndType(attrs.entity, metaDataService.ltGroupMemberClient)
    out << clients
  }

  /**
   * finds the project a project unit belongs to
   */
  def getProjectOfUnit = {attrs ->
    // find project day the project unit is linked to
    Entity projectDay = functionService.findByLink(attrs.unit, null, metaDataService.ltProjectDayUnit)

    // find project the project day is linked to
    if (projectDay) {
      Entity project = functionService.findByLink(projectDay, null, metaDataService.ltProjectMember)
      out << message(code: 'project') + ": " + project?.profile?.fullName ?: 'not found'
    }
  }

  /**
   * finds all project units linked to a project day
   */
  def getProjectDayUnits = {attrs, body ->
    //List projectDayUnits = functionService.findAllByLink(null, attrs.projectDay, metaDataService.ltProjectDayUnit)

    List projectDayUnits = []
    attrs.projectDay.profile.units.each {
      projectDayUnits.add(Entity.get(it))
    }

    if (projectDayUnits)
      projectDayUnits.each {out << body(units: it)}
    else
      out << body(units: null)
      //out << '<span class="italic red">' + message(code: 'projectUnits.choose') + '</span>'
  }

  /**
   * finds all educators linked to a project day
   */
  def getProjectDayEducators = {attrs, body ->
    List projectDayEducators = functionService.findAllByLink(null, attrs.projectDay, metaDataService.ltProjectDayEducator)
    if (projectDayEducators)
      projectDayEducators.each {out << body(educators: it)}
    else
      out << '<span class="italic red">' + message(code: 'educators.choose') + '</span>'
  }

  /**
   * finds all supplemental educators linked to a project day
   */
  def getProjectDaySubstitutes = {attrs, body ->
    List projectDaySubstitutes = functionService.findAllByLink(null, attrs.projectDay, metaDataService.ltProjectDaySubstitute)
    if (projectDaySubstitutes)
      projectDaySubstitutes.each {out << body(educators: it)}
    else
      out << '<span class="italic red">' + message(code: 'substitutes.choose') + '</span>'
  }

  /**
   * finds all resources linked to a project day
   */
  def getProjectDayResources = {attrs, body ->
    List projectDayResources = functionService.findAllByLink(null, attrs.projectDay, metaDataService.ltProjectDayResource)
    if (projectDayResources)
      projectDayResources.each {out << body(resources: it)}
    else
      out << '<span class="italic">' + message(code: 'resources.notAssigned') + '</span> <img src="' + g.resource(dir: 'images/icons', file: 'icon_warning.png') + '" alt="toolTip" align="top"/></span>'
  }

  /**
   * finds all activity groups linked to a project unit
   */
  def getProjectUnitActivityGroups = {attrs, body ->
    List projectUnitActivityGroups = functionService.findAllByLink(null, attrs.projectUnit, metaDataService.ltProjectUnit)
    if (projectUnitActivityGroups)
      projectUnitActivityGroups.each {out << body(activityGroups: it)}
    else
      out << '<span class="italic">Keine Aktivitätsblockvorlagen gefunden</span> <img src="' + g.resource(dir: 'images/icons', file: 'icon_warning.png') + '" alt="toolTip" align="top"/></span>'
  }

  /**
   * finds all parents linked to a project unit
   */
  def getProjectUnitParents = {attrs, body ->
    List projectUnitParents = functionService.findAllByLink(null, attrs.projectUnit, metaDataService.ltProjectUnitParent)
    if (projectUnitParents)
      projectUnitParents.each {out << body(parents: it)}
    else
      out << '<span class="italic red">' + message(code: 'parents.choose') + '</span>'
  }

  /**
   * finds the number of parents linked to a project unit
   */
  def getProjectUnitParentsCount = {attrs, body ->
    List projectUnitParents = functionService.findAllByLink(null, attrs.projectUnit, metaDataService.ltProjectUnitParent)
    out << "(" + projectUnitParents.size() + ")"
  }

  /**
   * finds all partners linked to a project unit
   */
  def getProjectUnitPartners = {attrs, body ->
    List projectUnitPartners = functionService.findAllByLink(null, attrs.projectUnit, metaDataService.ltProjectUnitPartner)
    if (projectUnitPartners)
      projectUnitPartners.each {out << body(partners: it)}
    else
      out << '<span class="italic red">' + message(code: 'partners.choose') + '</span>'
  }

  /**
   * finds all group activity templates linked to a project unit
   */
  def getGroupActivityTemplates = {attrs, body ->
    List groupActivityTemplates = functionService.findAllByLink(null, attrs.projectUnit, metaDataService.ltProjectUnitMember)
    if (groupActivityTemplates)
      groupActivityTemplates.each {out << body(groupActivityTemplates: it)}
    else
      out << '<span class="italic red" style="margin-left: 15px">' + message(code: 'groupActivityTemplates.notAssigned') + '</span>'
  }

  /**
   * finds all resources linked to an entity
   */
  def getResources = {attrs, body ->
    List resources = functionService.findAllByLink(null, attrs.entity, metaDataService.ltResource)
    if (resources)
      resources.each {out << body(resources: it)}
    else
      out << '<span class="italic">' + message(code: 'resources.notAssigned') + '</span> <img src="' + g.resource(dir: 'images/icons', file: 'icon_warning.png') + '" alt="toolTip" align="top"/></span>'
  }

  /**
   * finds all group members of a given group
   */
  def getGroup = {attrs, body ->
    List groups = functionService.findAllByLink(null, attrs.entity, metaDataService.ltGroupMember)
    if (groups)
      groups.each {out << body(members: it)}
    else
      out << '<span class="italic">Diese Gruppe ist leer</span>'
  }

  /**
   * returns the size of a group
   */
  def getGroupSize = {attrs, body ->
    def result = Link.countByTargetAndType(attrs.entity, metaDataService.ltGroupMember)
    if (result == 0)
      out << '0 <img src="' + g.resource(dir: 'images/icons', file: 'icon_warning.png') + '" alt="toolTip" align="top"/>'
    else
      out << result
  }

  /**
   * returns all facilities linked to a group
   */
  def getGroupFacilities = {attrs, body ->
    def result = Link.countByTargetAndType(attrs.entity, metaDataService.ltGroupMemberFacility)
    if (result == 0)
      out << '0 <img src="' + g.resource(dir: 'images/icons', file: 'icon_warning.png') + '" alt="toolTip" align="top"/>'
    else
      out << result
  }

  /**
   * returns all resources linked to a group
   */
  def getGroupResources = {attrs, body ->
    def result = Link.countByTargetAndType(attrs.entity, metaDataService.ltResource)
    if (result == 0)
      out << '0 <img src="' + g.resource(dir: 'images/icons', file: 'icon_warning.png') + '" alt="toolTip" align="top"/>'
    else
      out << result
  }

  /**
   * returns the total duration of the activities within a group
   */
  def getGroupDuration = {attrs, body ->
    List groups = functionService.findAllByLink(null, attrs.entity, metaDataService.ltGroupMember)
    def duration = 0
    if (groups)
      groups.each {duration += it.profile.duration}
    out << duration
  }

  /**
   * returns the entity a resource is linked to - which is either a facility or colony
   */
  def resourceCreatedIn = {attrs, body ->
    def result = functionService.findByLink(attrs.resource, null, metaDataService.ltResource)
    if (result)
      out << body(source: result)
  }

  /**
   * returns the template to a given activity
   */
  def getTemplate = {attrs, body ->
    Entity template = functionService.findByLink(null, attrs.entity, metaDataService.ltActTemplate)
    if (template)
      out << body(template: template)
    else
      out << '<span class="italic">keine Vorlage vorhanden</span>'
  }

  /**
   * returns all clients to a given activity
   */
  def getClients = {attrs, body ->
    List clients = functionService.findAllByLink(null, attrs.entity, metaDataService.ltActClient)
    if (clients)
      clients.each {out << body(clients: it)}
    else
      out << '<span class="italic">' + message(code: 'clients.empty') + '</span> <img src="' + g.resource(dir: 'images/icons', file: 'icon_warning.png') + '" alt="toolTip" align="top"/>'
  }

  /**
   * returns all clients linked to a given pate
   */
  def getPateClients = {attrs, body ->
    List pateClients = functionService.findAllByLink(null, attrs.entity, metaDataService.ltPate)
    if (pateClients)
      pateClients.each {out << body(clients: it)}
    else
      out << '<span class="italic">' + message(code: 'clients.empty') + '</span> <img src="' + g.resource(dir: 'images/icons', file: 'icon_warning.png') + '" alt="toolTip" align="top"/>'
  }

  /**
   * returns all educators linked to a given activity
   */
  def getEducators = {attrs, body ->
    List educators = functionService.findAllByLink(null, attrs.entity, metaDataService.ltActEducator)
    if (educators)
      educators.each {out << body(educators: it)}
    else
      out << '<span class="italic">' + message(code: 'educators.empty') + '</span> <img src="' + g.resource(dir: 'images/icons', file: 'icon_warning.png') + '" alt="toolTip" align="top"/>'
  }

  /**
   * returns the facility linked to a given activity
   */
  def getFacility = {attrs, body ->
    Entity facility = functionService.findByLink(null, attrs.entity, metaDataService.ltActFacility)
    if (facility)
      out << body(facility: facility)
    else
      out << '<span class="italic">' + message(code:'notAssignedToFacility') + '</span>'
  }

  /**
   * returns the facility linked to a given activity
   */
  def getFacilityOfProject = {attrs, body ->
    Entity facilityOfProject = functionService.findByLink(null, attrs.entity, metaDataService.ltGroupMemberFacility)
    if (facilityOfProject)
      out << body(facility: facilityOfProject)
    else
      out << '<span class="italic">' + message(code:'notAssignedToFacility') + '</span>'
  }

  /**
   * returns all subthemes of a given activity
   */
  def getSubThemes = {attrs, body ->
    List subThemes = functionService.findAllByLink(null, attrs.theme, metaDataService.ltSubTheme)
    if (subThemes)
      subThemes.each {out << body(subthemes: it)}
  }

  /**
   * returns the creator of an entity
   */
  def createdBy = {attrs, body ->
    def result = functionService.findByLink(null, attrs.entity, metaDataService.ltCreator)
    if (result)
      out << body(creator: result)
  }

  /**
   * returns the creator (entity) to a given ID
   */
  def getCreator = {attrs, body ->
    out << body(creator: Entity.get(attrs.id))
  }

  /**
   * sets the active state of each letter of the glossary
   */
  def active = {attrs ->
    if (attrs.glossary == attrs.letter)
      out << '<span style="background: #050; padding: 1px 3px; color: #fff;">' << attrs.letter << '</span>'
    else
      out << attrs.letter
  }

  /**
   * finds the colony linked to a given entity
   */
  def getColony = {attrs, body ->
    out << body(colony: functionService.findByLink(null, attrs.entity, metaDataService.ltColonia))
  }

  /**
   * returns the quote of the day
   */
  def getQuoteOfTheDay = {
    Date myDate = new Date()
    SimpleDateFormat df = new SimpleDateFormat("dd", new Locale("en"))
    String day = df.format(myDate)
    out << '<span class="quote">"' + grailsApplication.config.quotesMap[day] + '"</span>'
    out << '<p class="quoter">' + message(code:"from") + " " + grailsApplication.config.quoterMap[day] + '</p>'
  }

  /**
   * returns the pic of the day
   */
  def getPicOfTheDay = { attrs, body ->
    Date myDate = new Date()
    SimpleDateFormat df = new SimpleDateFormat("dd", new Locale("en"))
    String day = df.format(myDate)
    out << body(day)
  }

  /**
   * returns the gender
   */
  def showGender = {attrs ->
    if (attrs.gender == 1)
      out << message(code: 'male')
    else
      out << message(code: 'female')
  }

  /**
   * returns the number of new private messages through a service
   */
  def getNewInboxMessages = {attrs ->
    def c = Msg.createCriteria()
    def results = c.list {
      eq('entity', attrs.entity)
      ne('sender', attrs.entity)
      eq('read', false)
    }

    if (results.size() > 0)
      out << "(" + results.size() + ")"
  }

  /**
   * returns the number of publications of an entity
   */
  def getPublicationCount = {attrs ->
    int m = Publication.countByEntity(attrs.entity)

    // group activity template
    if (attrs.entity.type.name == "Aktivitätsvorlagenblock") {
      List activitytemplates = functionService.findAllByLink(null, attrs.entity, metaDataService.ltGroupMember)

      activitytemplates.each {
        m += Publication.countByEntity(it as Entity)
      }
    }

    // group activity
    else if (attrs.entity.type.name == "Aktivitätsblock") {
      Entity groupactivitytemplate = functionService.findByLink(null, attrs.entity, metaDataService.ltTemplate)

      if (groupactivitytemplate) {
          m += Publication.countByEntity(groupactivitytemplate)

          List activitytemplates = functionService.findAllByLink(null, groupactivitytemplate, metaDataService.ltGroupMember)

          activitytemplates.each {
            m += Publication.countByEntity(it as Entity)
          }
      }
    }

    // project template
    else if (attrs.entity.type.name == "Projektvorlage") {
      List projectUnits = functionService.findAllByLink(null, attrs.entity, metaDataService.ltProjectUnit)

      List groupactivitytemplates = []
      projectUnits.each {
        def bla = functionService.findAllByLink(null, it as Entity, metaDataService.ltProjectUnitMember)
        bla.each {
          if (!groupactivitytemplates.contains(it)) // filter duplicate group activity templates
            groupactivitytemplates << it
        }
      }

      groupactivitytemplates.each {
        m += Publication.countByEntity(it)
      }

      List activitytemplates = []
      groupactivitytemplates.each {
        def bla = functionService.findAllByLink(null, it as Entity, metaDataService.ltGroupMember)
        bla.each {
          if (!activitytemplates.contains(it)) // filter duplicate activity templates
            activitytemplates << it
        }
      }

      activitytemplates.each {
        m += Publication.countByEntity(it) 
      }
    }

    // project
    else if (attrs.entity.type.name == "Projekt") {
      Entity projectTemplate = functionService.findByLink(null, attrs.entity, metaDataService.ltProjectTemplate)

      if (projectTemplate) {
          m += Publication.countByEntity(projectTemplate)

          List projectUnits = functionService.findAllByLink(null, projectTemplate, metaDataService.ltProjectUnit)

          List groupactivitytemplates = []
          projectUnits.each {
            def bla = functionService.findAllByLink(null, it as Entity, metaDataService.ltProjectUnitMember)
            bla.each {
              if (!groupactivitytemplates.contains(it)) // filter duplicate group activity templates
                groupactivitytemplates << it
            }
          }

          groupactivitytemplates.each {
            m += Publication.countByEntity(it)
          }

          List activitytemplates = []
          groupactivitytemplates.each {
            def bla = functionService.findAllByLink(null, it as Entity, metaDataService.ltGroupMember)
            bla.each {
              if (!activitytemplates.contains(it)) // filter duplicate activity templates
                activitytemplates << it
            }
          }

          activitytemplates.each {
            m += Publication.countByEntity(it)
          }
      }
    }
    
    out << "(" + m + ")"
  }

  /**
   * returns the link (relationship) type between two given entities
   */
  def getRelationship = {attrs ->
    out << Link.findBySourceAndTarget(Entity.findByName(attrs.source), Entity.findByName(attrs.target)).type.name
  }

  /**
   * self explanatory methods below
   */

  def isLoggedIn = {attrs, body ->
    if (entityHelperService.loggedIn)
      out << body()
  }

  def isNotLoggedIn = {attrs, body ->
    if (!entityHelperService.loggedIn)
      out << body()
  }

  def isFriend = {attrs, body ->
    if (friend(attrs))
      out << body()
  }

  def notFriend = {attrs, body ->
    if (!friend(attrs))
      out << body()
  }

  def isBookmark = {attrs, body ->
    if (bookmark(attrs))
      out << body()
  }

  def notBookmark = {attrs, body ->
    if (!bookmark(attrs))
      out << body()
  }

  def isEnabled = {attrs, body ->
    if (attrs?.entity?.user?.enabled)
      out << body()
  }

  def notEnabled = {attrs, body ->
    if (!attrs?.entity?.user?.enabled)
      out << body()
  }

  def notAdmin = {attrs, body ->
    if (!attrs.entity.user.authorities.find {it.authority == 'ROLE_ADMIN'})
      out << body()
  }

  def isSystemAdmin = {attrs, body ->
    if (attrs.entity.user.authorities.find {it.authority == 'ROLE_SYSTEMADMIN'} )
      out << body()
  }

  def isMeOrAdmin = {attrs, body ->
    if (attrs.entity.name == entityHelperService.loggedIn.name || attrs.current.user.authorities.find {it.authority == 'ROLE_ADMIN'} )
      out << body()
  }

  def isMeOrAdminOrOperator = {attrs, body ->
    if (attrs.entity.name == attrs.current.name || attrs.current.user.authorities.find {it.authority == 'ROLE_ADMIN'} || attrs.current.type.id == metaDataService.etOperator.id)
      out << body()
  }

  def notMe = {attrs, body ->
    if (entityHelperService.loggedIn.id != attrs.entity.id)
      out << body()
  }

  def hasNotRoles = {attrs, body ->
    def entity = attrs.entity ?: entityHelperService.loggedIn

    def res = !attrs.roles.find { entity.user.authorities*.authority.contains(it) }
    if (res)
      out << body()
  }

  private boolean friend(attrs) {
    Entity currentEntity = entityHelperService.loggedIn
    if (!currentEntity)
      return false
    Entity e = attrs.entity ?: currentEntity
    if (!e)
      return false

    def c = Link.createCriteria
    def result = c.get {
      eq("source", currentEntity)
      eq("target", e)
      eq("type", metaDataService.ltFriendship)
    }
    return result ? true : false
  }

  private boolean bookmark(attrs) {
    Entity currentEntity = entityHelperService.loggedIn
    if (!currentEntity)
      return false
    Entity e = attrs.entity ?: currentEntity
    if (!e)
      return false

    def c = Link.createCriteria
    def result = c.get {
      eq("source", currentEntity)
      eq("target", e)
      eq("type", metaDataService.ltBookmark)
    }
    return result ? true : false
  }

  /**
   * starbox rating used for rating elements of methods
   */
  def starBox = {attrs ->

    Entity currentEntity = entityHelperService.loggedIn

    Element element = Element.get(attrs.element)

    def star = "<img src='${grailsAttributes.getApplicationUri(request)}/images/icons/icon_star.png'/>"
    def star_empty = "<img src='${grailsAttributes.getApplicationUri(request)}/images/icons/icon_star_empty.png'/>"

    def updateDiv = "starBox${element.id}"
    def vote = element.voting


    out << '<div>'
    // if the current entity is admin, operator or the creator display this
    if (currentEntity.user.authorities.find {it.authority == 'ROLE_ADMIN'} || currentEntity.type.id == metaDataService.etOperator.id || accessIsCreatorOf(currentEntity,attrs.template)) {
      out << remoteLink(update: updateDiv, controller: 'templateProfile', action: 'vote', params: [element: element.id, val: 1]) { vote > 0 ? star : star_empty }
      out << remoteLink(update: updateDiv, controller: 'templateProfile', action: 'vote', params: [element: element.id, val: 2]) { vote > 1 ? star : star_empty }
      out << remoteLink(update: updateDiv, controller: 'templateProfile', action: 'vote', params: [element: element.id, val: 3]) { vote > 2 ? star : star_empty }
      out << remoteLink(update: updateDiv, controller: 'templateProfile', action: 'vote', params: [element: element.id, val: 4]) { vote > 3 ? star : star_empty }
      out << remoteLink(update: updateDiv, controller: 'templateProfile', action: 'vote', params: [element: element.id, val: 5]) { vote > 4 ? star : star_empty }
    }
    // else just display the images
    else {
      out << (vote > 0 ? star : star_empty)
      out << (vote > 1 ? star : star_empty)
      out << (vote > 2 ? star : star_empty)
      out << (vote > 3 ? star : star_empty)
      out << (vote > 4 ? star : star_empty)
    }
    out << '</div>'



  }

  def getActiveEducator = {attrs, body ->

    // For some weird reason all but the last element in the list are of type String and the last element is not of type String so both types
    // need to be checked... WTF Groovy?!?

      Entity currentEntity = entityHelperService.loggedIn

    def result = currentEntity.profile.calendar.calendareds.contains(attrs.id.toString())

    //def result = attrs.educators.contains(attrs.id.toString()) || attrs.educators.contains(attrs.id)

    out << body(active: result)
  }

  def getCurrentEntity = {attrs, body ->
    out << body(currentEntity: entityHelperService.loggedIn)
  }


  // modified select used by localeSelect as a temporary workaround until it's fixed
  def eselect = { attrs ->
        def messageSource = grailsAttributes.getApplicationContext().getBean("messageSource")
        def locale = RequestContextUtils.getLocale(request)
        def writer = out
        attrs.id = attrs.id ?: attrs.name
        def from = attrs.remove('from')
        def keys = attrs.remove('keys')
        def optionKey = attrs.remove('optionKey')
        def optionValue = attrs.remove('optionValue')
        def value = attrs.remove('value')
        if (value instanceof Collection && attrs.multiple == null) {
            attrs.multiple = 'multiple'
        }
        if (value instanceof StreamCharBuffer) {
            value = value.toString()
        }
        def valueMessagePrefix = attrs.remove('valueMessagePrefix')
        def noSelection = attrs.remove('noSelection')
        if (noSelection != null) {
            noSelection = noSelection.entrySet().iterator().next()
        }
        def disabled = attrs.remove('disabled')
        if (disabled && Boolean.valueOf(disabled)) {
            attrs.disabled = 'disabled'
        }

        writer << "<select name=\"${attrs.remove('name')?.encodeAsHTML()}\" "
        // process remaining attributes
        outputAttributes(attrs)

        writer << '>'
        writer.println()

        if (noSelection) {
            renderNoSelectionOptionImpl(writer, noSelection.key, noSelection.value, value)
            writer.println()
        }

        // create options from list
        if (from) {
            from.eachWithIndex {el, i ->
                def keyValue = null
                writer << '<option '
                if (keys) {
                    keyValue = keys[i]
                    ewriteValueAndCheckIfSelected(keyValue, value, writer)
                }
                else if (optionKey) {
                    def keyValueObject = null
                    if (optionKey instanceof Closure) {
                        keyValue = optionKey(el)
                        //log.info "optionKey: " + optionKey(el) + ", is locale? " + (optionKey(el) instanceof Locale)
                        //log.info "from element: " + el + ", is locale? " + (el instanceof Locale)
                    }
                    else if (el != null && optionKey == 'id' && grailsApplication.getArtefact(DomainClassArtefactHandler.TYPE, el.getClass().name)) {
                        keyValue = el.ident()
                        keyValueObject = el
                    }
                    else {
                        keyValue = el[optionKey]
                        keyValueObject = el
                    }
                    ewriteValueAndCheckIfSelected(keyValue, value, writer, keyValueObject)
                }
                else {
                    keyValue = el
                    ewriteValueAndCheckIfSelected(keyValue, value, writer)
                }
                writer << '>'
                if (optionValue) {
                    if (optionValue instanceof Closure) {
                        writer << optionValue(el).toString().encodeAsHTML()
                    }
                    else {
                        writer << el[optionValue].toString().encodeAsHTML()
                    }
                }
                else if (el instanceof MessageSourceResolvable) {
                    writer << messageSource.getMessage(el, locale)
                }
                else if (valueMessagePrefix) {
                    def message = messageSource.getMessage("${valueMessagePrefix}.${keyValue}", null, null, locale)
                    if (message != null) {
                        writer << message.encodeAsHTML()
                    }
                    else if (keyValue && keys) {
                        def s = el.toString()
                        if (s) writer << s.encodeAsHTML()
                    }
                    else if (keyValue) {
                        writer << keyValue.encodeAsHTML()
                    }
                    else {
                        def s = el.toString()
                        if (s) writer << s.encodeAsHTML()
                    }
                }
                else {
                    def s = el.toString()
                    if (s) writer << s.encodeAsHTML()
                }
                writer << '</option>'
                writer.println()
            }
        }
        // close tag
        writer << '</select>'
    }

    def typeConverter = new SimpleTypeConverter()
    private ewriteValueAndCheckIfSelected(keyValue, value, writer) {
        ewriteValueAndCheckIfSelected(keyValue, value, writer, null)
    }

    private ewriteValueAndCheckIfSelected(keyValue, value, writer, el) {

        boolean selected = false
        def keyClass = keyValue?.getClass()
        //log.info keyValue
        //log.info keyClass
        if (keyClass.isInstance(value)) {
            selected = (keyValue == value)
        }
        else if (value instanceof Collection) {
            // first try keyValue
            selected = value.contains(keyValue)
            if (! selected && el != null) {
                selected = value.contains(el)
            }
        }
        else if (keyClass && value) {
            try {
                //value = typeConverter.convertIfNecessary(value, keyClass)
                selected = (keyValue == value)
            }
            catch (e) {
                // ignore
            }
        }
        writer << "value=\"${keyValue}\" "
        if (selected) {
            writer << 'selected="selected" '
        }
    }

    void outputAttributes(attrs) {
        attrs.remove('tagName') // Just in case one is left
        def writer = getOut()
        attrs.each { k, v ->
            writer << "$k=\"${v.encodeAsHTML()}\" "
        }
    }

    def renderNoSelectionOptionImpl(out, noSelectionKey, noSelectionValue, value) {
        // If a label for the '--Please choose--' first item is supplied, write it out
        out << "<option value=\"${(noSelectionKey == null ? '' : noSelectionKey)}\"${noSelectionKey == value ? ' selected="selected"' : ''}>${noSelectionValue.encodeAsHTML()}</option>"
    }

}
