package at.uenterprise.erp

import at.openfactory.ep.Entity
import at.openfactory.ep.Link
import java.text.SimpleDateFormat
import org.springframework.web.servlet.support.RequestContextUtils
import at.openfactory.ep.EntityHelperService

import at.openfactory.ep.SecHelperService

class HelperTagLib {
  EntityHelperService entityHelperService
  MetaDataService metaDataService
  SecHelperService secHelperService
  FunctionService functionService
  def securityManager
  static namespace = "erp"

  def profileImage = {attrs->
    attrs.name = attrs.entity.name
    def imgattrs = [:]
    imgattrs['src'] = g.createLink (controller:'app', action:'get', params:[type:'profile', entity:attrs.entity.id])
    attrs.each {key, val-> imgattrs[key]=val ;}
    def mkp = new groovy.xml.MarkupBuilder(out)
    mkp { img (imgattrs) }
  }

  /*
   * retrieves all online users (activity within the last 5 minutes)
   */
  def getOnlineUsers = {attrs, body ->

    /*def c = Entity.createCriteria()
    def userList = c.list {
      or {
          eq("type", metaDataService.etUser)
          eq("type", metaDataService.etOperator)
          eq("type", metaDataService.etClient)
          eq("type", metaDataService.etEducator)
          eq("type", metaDataService.etParent)
          eq("type", metaDataService.etChild)
          eq("type", metaDataService.etPate)
          eq("type", metaDataService.etPartner)
      }
    }*/

    List userList = Entity.list()

    List onlineUsers = []
    userList.each { Entity entity ->
      if (entity?.user?.lastAction)
        if ((new Date().getTime() - entity.user.lastAction.getTime()) / 1000 / 60 <= 5)
          onlineUsers.add(entity)
    }

    onlineUsers.each {out << body(onlineUsers: it)}
  }

  def getWorkdayUnits = { attrs, body ->
    Date date1 = Date.parse("dd. MM. yy", attrs.date1)
    Date date2 = Date.parse("dd. MM. yy", attrs.date2)

    Entity educator = attrs.educator

    List units = []
    educator.profile.workdayunits.each { WorkdayUnit workdayUnit ->
      // check if the date of the workdayunit is between date1 and date2
      if (workdayUnit.date1.getYear() >= date1.getYear() && workdayUnit.date1.getYear() <= date2.getYear() &&
          workdayUnit.date1.getMonth() >= date1.getMonth() && workdayUnit.date1.getMonth() <= date2.getMonth() &&
          workdayUnit.date1.getDate() >= date1.getDate() && workdayUnit.date1.getDate() <= date2.getDate()) {
            units.add(workdayUnit)
      }
    }
    out << body(units: units)
  }

  def getHoursConfirmed = { attrs, body ->
    Date date1
    Date date2

    if (attrs.date1 != null && attrs.date2 != null) {
      date1 = Date.parse("dd. MM. yy", attrs.date1)
      date2 = Date.parse("dd. MM. yy", attrs.date2)
    }

    Entity educator = attrs.educator

    def notConfirmed = false
    educator.profile.workdayunits.each { WorkdayUnit workdayUnit ->
      // check if the date of the workdayunit is between date1 and date2
      if (attrs.date1 != null & attrs.date2 != null) {
        if (workdayUnit.date1.getYear() >= date1.getYear() && workdayUnit.date1.getYear() <= date2.getYear() &&
            workdayUnit.date1.getMonth() >= date1.getMonth() && workdayUnit.date1.getMonth() <= date2.getMonth() &&
            workdayUnit.date1.getDate() >= date1.getDate() && workdayUnit.date1.getDate() <= date2.getDate()) {
              if (!workdayUnit.confirmed) {
                notConfirmed = true
              }
        }
      }
    }

    if (notConfirmed)
        out << "${message(code: 'yes')}"
    else
        out << "${message(code: 'no')}"
  }

  def getSalary = { attrs, body ->
    Date date1
    Date date2

    if (attrs.date1 != null && attrs.date2 != null) {
      date1 = Date.parse("dd. MM. yy", attrs.date1)
      date2 = Date.parse("dd. MM. yy", attrs.date2)
    }

    Entity educator = attrs.educator

    // calculate expected hours
    int expectedHours = 0
    Calendar tcalendarStart = new GregorianCalendar();
    tcalendarStart.setTime(date1);

    Calendar tcalendarEnd = new GregorianCalendar();
    tcalendarEnd.setTime(date2);

    SimpleDateFormat tdf = new SimpleDateFormat("EEEE")

    while (tcalendarStart <= tcalendarEnd) {
       Date currentDate = tcalendarStart.getTime();

       if ((tdf.format(currentDate) == 'Montag' || tdf.format(currentDate) == 'Monday') ||
           (tdf.format(currentDate) == 'Dienstag' || tdf.format(currentDate) == 'Tuesday') ||
           (tdf.format(currentDate) == 'Mittwoch' || tdf.format(currentDate) == 'Wednesday') ||
           (tdf.format(currentDate) == 'Donnerstag' || tdf.format(currentDate) == 'Thursday') ||
           (tdf.format(currentDate) == 'Freitag' || tdf.format(currentDate) == 'Friday')) {
            expectedHours += educator?.profile?.workHours ?: 0
         }
      tcalendarStart.add(Calendar.DATE, 1)
    }

    // calculate real hours
    int hours = 0
    educator.profile.workdayunits.each { WorkdayUnit workdayUnit ->
      // check if the date of the workdayunit is between date1 and date2
      if (attrs.date1 != null & attrs.date2 != null) {
        if (workdayUnit.date1.getYear() >= date1.getYear() && workdayUnit.date1.getYear() <= date2.getYear() &&
            workdayUnit.date1.getMonth() >= date1.getMonth() && workdayUnit.date1.getMonth() <= date2.getMonth() &&
            workdayUnit.date1.getDate() >= date1.getDate() && workdayUnit.date1.getDate() <= date2.getDate()) {
              hours += (workdayUnit.date2.getTime() - workdayUnit.date1.getTime()) / 1000 / 60 / 60
        }
      }
      else
        hours += (workdayUnit.date2.getTime() - workdayUnit.date1.getTime()) / 1000 / 60 / 60
    }

    // calculate salary
    def result = 0
    if (hours <= expectedHours)
        result = hours * (educator?.profile?.hourlyWage ?: 0)
    else
        result = expectedHours * (educator?.profile?.hourlyWage ?: 0) + ((hours - expectedHours) * (educator?.profile?.overtimePay ?: 0))

    out << result

  }

  def getExpectedHours = { attrs, body ->
    Date date1
    Date date2

    if (attrs.date1 != null && attrs.date2 != null) {
      date1 = Date.parse("dd. MM. yy", attrs.date1)
      date2 = Date.parse("dd. MM. yy", attrs.date2)
    }

    Entity educator = attrs.educator

    int expectedHours = 0
    Calendar tcalendarStart = new GregorianCalendar();
    tcalendarStart.setTime(date1);

    Calendar tcalendarEnd = new GregorianCalendar();
    tcalendarEnd.setTime(date2);

    SimpleDateFormat tdf = new SimpleDateFormat("EEEE")

    while (tcalendarStart <= tcalendarEnd) {
       Date currentDate = tcalendarStart.getTime();

       if ((tdf.format(currentDate) == 'Montag' || tdf.format(currentDate) == 'Monday') ||
           (tdf.format(currentDate) == 'Dienstag' || tdf.format(currentDate) == 'Tuesday') ||
           (tdf.format(currentDate) == 'Mittwoch' || tdf.format(currentDate) == 'Wednesday') ||
           (tdf.format(currentDate) == 'Donnerstag' || tdf.format(currentDate) == 'Thursday') ||
           (tdf.format(currentDate) == 'Freitag' || tdf.format(currentDate) == 'Friday')) {
            expectedHours += educator?.profile?.workHours ?: 0
         }
      tcalendarStart.add(Calendar.DATE, 1)
    }

    out << expectedHours
  }

  def getTotalHours = { attrs, body ->
    Date date1
    Date date2

    if (attrs.date1 != null && attrs.date2 != null) {
      date1 = Date.parse("dd. MM. yy", attrs.date1)
      date2 = Date.parse("dd. MM. yy", attrs.date2)
    }

    Entity educator = attrs.educator

    int hours = 0
    educator.profile.workdayunits.each { WorkdayUnit workdayUnit ->
      // check if the date of the workdayunit is between date1 and date2
      if (attrs.date1 != null & attrs.date2 != null) {
        if (workdayUnit.date1.getYear() >= date1.getYear() && workdayUnit.date1.getYear() <= date2.getYear() &&
            workdayUnit.date1.getMonth() >= date1.getMonth() && workdayUnit.date1.getMonth() <= date2.getMonth() &&
            workdayUnit.date1.getDate() >= date1.getDate() && workdayUnit.date1.getDate() <= date2.getDate()) {
              hours += (workdayUnit.date2.getTime() - workdayUnit.date1.getTime()) / 1000 / 60 / 60
        }
      }
      else
        hours += (workdayUnit.date2.getTime() - workdayUnit.date1.getTime()) / 1000 / 60 / 60
    }

    out << hours
  }

  /*
   * used for time evaluation, returns the number of hours of an educator and a given category
   */
  def getHoursForCategory = { attrs, body ->
    Date date1
    Date date2
    if (attrs.date1 != "" && attrs.date2 != "") {
      date1 = Date.parse("dd. MM. yy", attrs.date1)
      date2 = Date.parse("dd. MM. yy", attrs.date2)
    }

    Entity educator = attrs.educator
    WorkdayCategory workdayCategory = attrs.category

    int hours = 0
    educator.profile.workdayunits.each { WorkdayUnit workdayUnit ->
      if (workdayUnit.category == workdayCategory.name) {

        // check if the date of the workdayunit is between date1 and date2
        if (attrs.date1 != "" & attrs.date2 != "") {

          if (workdayUnit.date1.getYear() >= date1.getYear() && workdayUnit.date1.getYear() <= date2.getYear() &&
              workdayUnit.date1.getMonth() >= date1.getMonth() && workdayUnit.date1.getMonth() <= date2.getMonth() &&
              workdayUnit.date1.getDate() >= date1.getDate() && workdayUnit.date1.getDate() <= date2.getDate()) {
                hours += (workdayUnit.date2.getTime() - workdayUnit.date1.getTime()) / 1000 / 60 / 60
          }
        }
        else
          hours += (workdayUnit.date2.getTime() - workdayUnit.date1.getTime()) / 1000 / 60 / 60
      }
    }

    out << hours
  }

  /*
   * custom tag for as long as the official implementation is broken, see http://jira.codehaus.org/browse/GRAILS-2512--}%
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

  /*
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

  /*
   * get the tags of a given entity
   */
  def getTags = {attrs, body ->
    Entity entity = attrs.entity
    List tags = entity.tagslinks*.tag
    out << body(tags: tags)
  }

  /*
   * checks whether to render a tag button
   */
  def showTagButton = {attrs, body ->
    List tags = attrs.tags
    List tagnames = tags*.name
    if (!tagnames.contains(attrs.button))
      out << body()
  }

  /*
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
      out << "return confirm('Es bestehen keine Beziehungen! Löschen bitte bestätigen!')"
    else if (sourceNames.size() > 0 && targetNames.size() == 0)
      out << "return confirm('Es bestehen Beziehungen zu " + sourceNames + "! Löschen bitte bestätigen!')"
    else if (sourceNames.size() == 0 && targetNames.size() > 0)
      out << "return confirm('Es bestehen Beziehungen von " + targetNames + "! Löschen bitte bestätigen!')"
    else
      out << "return confirm('Es bestehen Beziehungen zu " + sourceNames + " und von " + targetNames + "! Löschen bitte bestätigen!')"
  }

  /*
   * new access control methods, separated for modular usage
   */
  def accessCheck = {attrs, body ->
    Entity entity = attrs.entity

    //log.info "----------"

    boolean hasRoles = false
    if (attrs.roles)
      hasRoles = accessHasRoles(entity, attrs.roles)
    //log.info "${entity.profile} has roles: ${hasRoles}"

    boolean hasTypes = false
    if (attrs.types)
      hasTypes = accessHasTypes(entity, attrs.types)
    //log.info "${entity.profile} has types: ${hasTypes}"

    boolean isMe = false
    if (attrs.me && attrs.me == "true")
      isMe = accessIsMe(entity)
    //log.info "${entity.profile} is me: ${isMe}"

    boolean isLeadEducator = false
    if (attrs.facilities)
      isLeadEducator = accessIsLeadEducator(entity, attrs.facilities)
    //log.info "${entity.profile} is lead educator: ${isLeadEducator}"

    boolean isCreatorOf = false
    if (attrs.creatorof)
      isCreatorOf = accessIsCreatorOf(entity, attrs.creatorof)

    if (hasRoles || hasTypes || isMe || isLeadEducator || isCreatorOf)
      out << body()
  }

  // checks if a given entity has at least one of the given roles
  boolean accessHasRoles(Entity entity, List roles) {

    def result = false

    if (entity.user) {
      result = roles.findAll { entity.user?.authorities*.authority.contains(it) }
    }

    return result ? true : false
  }

  // checks if a given entity is of one of the given types
  boolean accessHasTypes(Entity entity, List types) {

    def result = types.findAll { entity.type?.name == it }

    return result ? true : false
  }

  // checks if a given entity is the currently logged in entity
  boolean accessIsMe(Entity entity) {

    def result = entity == entityHelperService.loggedIn

    return result
  }

  // checks if a given entity is creator of another given entity
  boolean accessIsCreatorOf(Entity entity, Entity creatorof) {

    def c = Link.createCriteria()
    def result = c.get {
      eq('source', entity)
      eq('target', creatorof)
      eq('type', metaDataService.ltCreator)
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

  /*
   * outputs selectbox items for each language
   */
  def localeSelect = {attrs ->
    attrs['from'] = grailsApplication.config.locales
    attrs['value'] = (attrs['value'] ? attrs['value'] : RequestContextUtils.getLocale(request))
    // set the key as a closure that formats the locale
    attrs['optionKey'] = {"${it.language}_${it.country}"}
    // set the option value as a closure that formats the locale for display
    attrs['optionValue'] = {"${it.displayLanguage}"}

    // use generic select
    out << select(attrs)
  }

  /*
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

  /*
   * finds the number of units linked to a project template
   */
  def getProjectTemplateUnitsCount = {attrs, body ->
    def units = Link.countByTargetAndType(attrs.template, metaDataService.ltProjectUnitTemplate)
    out << units
  }

  /*
   * finds the number of clients linked to a client group
   */
  def getGroupClientsCount = {attrs, body ->
    def clients = Link.countByTargetAndType(attrs.entity, metaDataService.ltGroupMemberClient)
    out << clients
  }

  /*
   * finds all project units linked to a project day
   */
  def getProjectDayUnits = {attrs, body ->
    List projectDayUnits = functionService.findAllByLink(null, attrs.projectDay, metaDataService.ltProjectDayUnit)
    if (projectDayUnits)
      projectDayUnits.each {out << body(units: it)}
    else
      out << '<span class="italic red">Bitte die Projekteinheiten auswählen, die an diesem Projekttag stattfinden sollen!</span></span>'
  }

  /*
   * finds all educators linked to a project day
   */
  def getProjectDayEducators = {attrs, body ->
    List projectDayEducators = functionService.findAllByLink(null, attrs.projectDay, metaDataService.ltProjectDayEducator)
    if (projectDayEducators)
      projectDayEducators.each {out << body(educators: it)}
    else
      out << '<span class="italic red">Bitte die Pädagogen auswählen, die an diesem Projekttag teilnehmen!</span></span>'
  }

  /*
   * finds all supplemental educators linked to a project day
   */
  def getProjectDaySubstitutes = {attrs, body ->
    List projectDaySubstitutes = functionService.findAllByLink(null, attrs.projectDay, metaDataService.ltProjectDaySubstitute)
    if (projectDaySubstitutes)
      projectDaySubstitutes.each {out << body(educators: it)}
    else
      out << '<span class="italic red">Bitte die Ersatzpädagogen auswählen, die an diesem Projekttag teilnehmen!</span></span>'
  }

  /*
   * finds all resources linked to a project day
   */
  def getProjectDayResources = {attrs, body ->
    List projectDayResources = functionService.findAllByLink(null, attrs.projectDay, metaDataService.ltProjectDayResource)
    if (projectDayResources)
      projectDayResources.each {out << body(resources: it)}
    else
      out << '<span class="italic">Keine Resourcen zugewiesen</span> <img src="' + g.resource(dir: 'images/icons', file: 'icon_warning.png') + '" alt="toolTip" align="top"/></span>'
  }

  /*
   * finds all activity groups linked to a project unit
   */
  def getProjectUnitActivityGroups = {attrs, body ->
    List projectUnitActivityGroups = functionService.findAllByLink(null, attrs.projectUnit, metaDataService.ltProjectUnit)
    if (projectUnitActivityGroups)
      projectUnitActivityGroups.each {out << body(activityGroups: it)}
    else
      out << '<span class="italic">Keine Aktivitätsblockvorlagen gefunden</span> <img src="' + g.resource(dir: 'images/icons', file: 'icon_warning.png') + '" alt="toolTip" align="top"/></span>'
  }

  /*
   * finds all parents linked to a project unit
   */
  def getProjectUnitParents = {attrs, body ->
    List projectUnitParents = functionService.findAllByLink(null, attrs.projectUnit, metaDataService.ltProjectUnitParent)
    if (projectUnitParents)
      projectUnitParents.each {out << body(parents: it)}
    else
      out << '<span class="italic red">Bitte die Erziehungsberechtigten auswählen, die an dieser Projekteinheit teilnehmen!</span></span>'
  }

  /*
   * finds all partners linked to a project unit
   */
  def getProjectUnitPartners = {attrs, body ->
    List projectUnitPartners = functionService.findAllByLink(null, attrs.projectUnit, metaDataService.ltProjectUnitPartner)
    if (projectUnitPartners)
      projectUnitPartners.each {out << body(partners: it)}
    else
      out << '<span class="italic red">Bitte die Partner auswählen, die an dieser Projekteinheit teilnehmen!</span></span>'
  }

  /*
   * finds all group activity templates linked to a project unit
   */
  def getGroupActivityTemplates = {attrs, body ->
    List groupActivityTemplates = functionService.findAllByLink(null, attrs.projectUnit, metaDataService.ltProjectUnitMember)
    if (groupActivityTemplates)
      groupActivityTemplates.each {out << body(groupActivityTemplates: it)}
    else
      out << '<span class="italic red" style="margin-left: 15px">Keine Aktivitätsblockvorlagen zugewiesen!</span></span>'
  }

  /*
   * finds all resources linked to an entity
   */
  def getResources = {attrs, body ->
    List resources = functionService.findAllByLink(null, attrs.entity, metaDataService.ltResource)
    if (resources)
      resources.each {out << body(resources: it)}
    else
      out << '<span class="italic">Keine Ressourcen zugewiesen</span> <img src="' + g.resource(dir: 'images/icons', file: 'icon_warning.png') + '" alt="toolTip" align="top"/></span>'
  }

  /*
   * finds all group members of a given group
   */
  def getGroup = {attrs, body ->
    List groups = functionService.findAllByLink(null, attrs.entity, metaDataService.ltGroupMember)
    if (groups)
      groups.each {out << body(members: it)}
    else
      out << '<span class="italic">Diese Gruppe ist leer</span>'
  }

  /*
   * returns the size of a group
   */
  def getGroupSize = {attrs, body ->
    def result = Link.countByTargetAndType(attrs.entity, metaDataService.ltGroupMember)
    if (result == 0)
      out << '0 <img src="' + g.resource(dir: 'images/icons', file: 'icon_warning.png') + '" alt="toolTip" align="top"/>'
    else
      out << result
  }

  /*
   * returns all facilities linked to a group
   */
  def getGroupFacilities = {attrs, body ->
    def result = Link.countByTargetAndType(attrs.entity, metaDataService.ltGroupMemberFacility)
    if (result == 0)
      out << '0 <img src="' + g.resource(dir: 'images/icons', file: 'icon_warning.png') + '" alt="toolTip" align="top"/>'
    else
      out << result
  }

  /*
   * returns all resources linked to a group
   */
  def getGroupResources = {attrs, body ->
    def result = Link.countByTargetAndType(attrs.entity, metaDataService.ltResource)
    if (result == 0)
      out << '0 <img src="' + g.resource(dir: 'images/icons', file: 'icon_warning.png') + '" alt="toolTip" align="top"/>'
    else
      out << result
  }

  /*
   * returns the total duration of the activities within a group
   */
  def getGroupDuration = {attrs, body ->
    List groups = functionService.findAllByLink(null, attrs.entity, metaDataService.ltGroupMember)
    def duration = 0
    if (groups)
      groups.each {duration += it.profile.duration}
    out << duration
  }

  /*
   * returns the entity a resource is linked to - which is either a facility or colony
   */
  def resourceCreatedIn = {attrs, body ->
    def result = functionService.findByLink(attrs.resource, null, metaDataService.ltResource)
    if (result)
      out << body(source: result)
  }

  /*
   * returns the template to a given activity
   */
  def getTemplate = {attrs, body ->
    Entity template = functionService.findByLink(null, attrs.entity, metaDataService.ltActTemplate)
    if (template)
      out << body(template: template)
    else
      out << '<span class="italic">keine Vorlage vorhanden</span>'
  }

  /*
   * returns all clients to a given activity
   */
  def getClients = {attrs, body ->
    List clients = functionService.findAllByLink(null, attrs.entity, metaDataService.ltActClient)
    if (clients)
      clients.each {out << body(clients: it)}
    else
      out << '<span class="italic">keine Betreuten zugewiesen <img src="' + g.resource(dir: 'images/icons', file: 'icon_warning.png') + '" alt="toolTip" align="top"/></span>'
  }

  /*
   * returns all clients linked to a given pate
   */
  def getPateClients = {attrs, body ->
    List pateClients = functionService.findAllByLink(null, attrs.entity, metaDataService.ltPate)
    if (pateClients)
      pateClients.each {out << body(clients: it)}
    else
      out << '<span class="italic">keine Betreuten zugewiesen</span> <img src="' + g.resource(dir: 'images/icons', file: 'icon_warning.png') + '" alt="toolTip" align="top"/></span>'
  }

  /*
   * returns all educators linked to a given activity
   */
  def getEducators = {attrs, body ->
    List educators = functionService.findAllByLink(null, attrs.entity, metaDataService.ltActEducator)
    if (educators)
      educators.each {out << body(educators: it)}
    else
      out << '<span class="italic">keine Pädagogen zugewiesen</span> <img src="' + g.resource(dir: 'images/icons', file: 'icon_warning.png') + '" alt="toolTip" align="top"/></span>'
  }

  /*
   * returns the facility linked to a given activity
   */
  def getFacility = {attrs, body ->
    Entity facility = functionService.findByLink(null, attrs.entity, metaDataService.ltActFacility)
    if (facility)
      out << body(facility: facility)
    else
      out << '<span class="italic">' + message(code:'notAssignedToFacility') + '</span>'
  }

  /*
   * returns the facility linked to a given activity
   */
  def getFacilityOfProject = {attrs, body ->
    Entity facilityOfProject = functionService.findByLink(null, attrs.entity, metaDataService.ltGroupMemberFacility)
    if (facilityOfProject)
      out << body(facility: facilityOfProject)
    else
      out << '<span class="italic">' + message(code:'notAssignedToFacility') + '</span>'
  }

  /*
   * returns all subthemes of a given activity
   */
  def getSubThemes = {attrs, body ->
    List subThemes = functionService.findAllByLink(null, attrs.theme, metaDataService.ltSubTheme)
    if (subThemes)
      subThemes.each {out << body(subthemes: it)}
  }

  /*
   * returns the creator of an entity
   */
  def createdBy = {attrs, body ->
    def result = functionService.findByLink(null, attrs.entity, metaDataService.ltCreator)
    if (result)
      out << body(creator: result)
  }

  /*
   * returns the creator (entity) to a given ID
   */
  def getCreator = {attrs, body ->
    out << body(creator: Entity.get(attrs.id))
  }

  /*
   * checks whether the given entity is a parent (or has the admin role)
   */
  def isParent = {attrs, body ->
    if (attrs.entity.type.name == metaDataService.etParent.name || attrs.entity.user.authorities.find {it.authority == 'ROLE_ADMIN'})
      out << body()
  }

  /*
   * checks whether the given entity is a pate (or has the admin role)
   */
  def isPate = {attrs, body ->
    if (attrs.entity.type.name == metaDataService.etPate.name || attrs.entity.user.authorities.find {it.authority == 'ROLE_ADMIN'})
      out << body()
  }

  /*
   * checks whether the given entity is a partner (or has the admin role)
   */
  def isPartner = {attrs, body ->
    if (attrs.entity.type.name == metaDataService.etPartner.name || attrs.entity.user.authorities.find {it.authority == 'ROLE_ADMIN'})
      out << body()
  }

  /*
   * checks whether the given entity is a client (or has the admin role)
   */
  def isClient = {attrs, body ->
    if (attrs.entity.type.name == metaDataService.etClient.name || attrs.entity.user.authorities.find {it.authority == 'ROLE_ADMIN'})
      out << body()
  }

  /*
   * checks whether the given entity is a facility (or has the admin role)
   */
  def isFacility = {attrs, body ->
    if (attrs.entity.type.name == metaDataService.etFacility.name || attrs.entity.user.authorities.find {it.authority == 'ROLE_ADMIN'})
      out << body()
  }

  /*
   * checks whether the given entity is an educator (or has the admin role)
   */
  def isEducator = {attrs, body ->
    if (attrs.entity.type.name == metaDataService.etEducator.name ||attrs.entity.user.authorities.find {it.authority == 'ROLE_ADMIN'})
      out << body()
  }

  /*
   * checks whether the given entity is an operator (or has the admin role)
   */
  def isOperator = {attrs, body ->
    if (attrs.entity.type.name == metaDataService.etOperator.name || attrs.entity.user.authorities.find {it.authority == 'ROLE_ADMIN'})
      out << body()
  }

  /*
   * checks whether the given entity was created by the current user
   */
  def isCreator = {attrs, body ->
    Entity currentEntity = entityHelperService.loggedIn
    def c = Link.createCriteria()
    def link = c.get {
      eq('source', currentEntity)
      eq('target', attrs.entity)
      eq('type', metaDataService.ltCreator)
    }
    // show also when the current user is an operator, admin or sysadmin
    if (link || currentEntity.type.name == metaDataService.etOperator.name || currentEntity.user.authorities.find {it.authority == 'ROLE_ADMIN'})
      out << body()
  }

  /*
   * sets the active state of each letter of the glossary
   */
  def active = {attrs ->
    if (attrs.glossary == attrs.letter)
      out << '<span style="background: #050; padding: 1px 3px; color: #fff;">' << attrs.letter << '</span>'
    else
      out << attrs.letter
  }

  /*
   * returns the quote of the day
   */
  def getQuoteOfTheDay = {
    Date myDate = new Date()
    SimpleDateFormat df = new SimpleDateFormat("dd")
    String day = df.format(myDate)
    out << '<span class="quote">"' + grailsApplication.config.quotesMap[day] + '"</span>'
    out << '<p class="quoter">' + message(code:"from") + " " + grailsApplication.config.quoterMap[day] + '</p>'
  }

  /*
   * returns the pic of the day
   */
  def getPicOfTheDay = { attrs, body ->
    Date myDate = new Date()
    SimpleDateFormat df = new SimpleDateFormat("dd")
    String day = df.format(myDate)
    out << body(day)
  }

  /*
   * returns the gender
   */
  def showGender = {attrs ->
    if (attrs.gender == 1)
      out << message(code: 'male')
    else
      out << message(code: 'female')
  }

  /*
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

  /*
   * returns the number of publications of an entity
   */
  def getPublicationCount = {attrs ->
    int m = Publication.countByEntity(attrs.entity)

    // group activity template
    if (attrs.entity.type.id == metaDataService.etGroupActivityTemplate.id) {
      List activitytemplates = functionService.findAllByLink(null, attrs.entity, metaDataService.ltGroupMember)

      activitytemplates.each {
        m += Publication.countByEntity(it as Entity)
      }
    }

    // group activity
    else if (attrs.entity.type.id == metaDataService.etGroupActivity.id) {
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
    else if (attrs.entity.type.id == metaDataService.etProjectTemplate.id) {
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
    else if (attrs.entity.type.id == metaDataService.etProject.id) {
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

  /*
   * returns the link (relationship) type between two given entities
   */
  def getRelationship = {attrs ->
    out << Link.findBySourceAndTarget(Entity.findByName(attrs.source), Entity.findByName(attrs.target)).type.name
  }

  /*
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
    if (attrs.entity.user.enabled)
      out << body()
  }

  def notEnabled = {attrs, body ->
    if (!attrs.entity.user.enabled)
      out << body()
  }

  def isAdmin = {attrs, body ->
    if (attrs.entity.user.authorities.find {it.authority == 'ROLE_ADMIN'})
      out << body()
  }

  def notAdmin = {attrs, body ->
    if (!attrs.entity.user.authorities.find {it.authority == 'ROLE_ADMIN'})
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

  def isSysAdmin = {attrs, body ->
    def entity = attrs.entity ?: entityHelperService.loggedIn

    entity.user.authorities.each {
      if (it.authority == "ROLE_SYSTEMADMIN")
        out << body()
        return
    }
  }

  def isMe = {attrs, body ->
    if (entityHelperService.loggedIn.id == attrs.entity.id)
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

  def hasRoles = {attrs, body ->
    def entity = attrs.entity ?: entityHelperService.loggedIn

    def res = attrs.roles.findAll { entity.user.authorities*.authority.contains(it) }
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

  /*
   * starbox rating used for rating elements of methods
   */
  def starBox = {attrs ->

    Element element = Element.get(attrs.element)

    def star = "<img src='${grailsAttributes.getApplicationUri(request)}/images/icons/icon_star.png'/>"
    def star_empty = "<img src='${grailsAttributes.getApplicationUri(request)}/images/icons/icon_star_empty.png'/>"

    def updateDiv = "starBox${element.id}"
    def vote = element.voting

    out << '<div>'
    out << remoteLink(update: updateDiv, controller: 'templateProfile', action: 'vote', params: [element: element.id, val: 1]) { vote > 0 ? star : star_empty }
    out << remoteLink(update: updateDiv, controller: 'templateProfile', action: 'vote', params: [element: element.id, val: 2]) { vote > 1 ? star : star_empty }
    out << remoteLink(update: updateDiv, controller: 'templateProfile', action: 'vote', params: [element: element.id, val: 3]) { vote > 2 ? star : star_empty }
    out << remoteLink(update: updateDiv, controller: 'templateProfile', action: 'vote', params: [element: element.id, val: 4]) { vote > 3 ? star : star_empty }
    out << remoteLink(update: updateDiv, controller: 'templateProfile', action: 'vote', params: [element: element.id, val: 5]) { vote > 4 ? star : star_empty }
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

}
