import at.openfactory.ep.Entity
import at.openfactory.ep.Link
import java.text.SimpleDateFormat
import org.springframework.web.servlet.support.RequestContextUtils
import lernardo.Element
import at.openfactory.ep.EntityHelperService
import standard.MetaDataService
import standard.NetworkService
import standard.FilterService
import at.openfactory.ep.SecHelperService

class HelperTagLib {
  EntityHelperService entityHelperService
  MetaDataService metaDataService
  NetworkService networkService
  FilterService filterService
  SecHelperService secHelperService
  def securityManager
  static namespace = "app"

  /*
   * get the tags of a given entity
   */
  def getTags = {attrs, body ->
    Entity entity = attrs.entity
    List tags = entity.tagslinks.collect {it.tag}
    out << body(tags: tags)
  }

  /*
   * checks whether to render a tag button
   */
  def showTagButton = {attrs, body ->
    List tags = attrs.tags
    List tagnames = tags.collect {it.name}
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
    List sourceNames = linksTarget.collect {it.source.profile.fullName}

    def linksSource = Link.findAllBySource(entity)
    List targetNames = linksSource.collect {it.target.profile.fullName}

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
   * checks if an entity has given roles or a given type or is itself
   */
  def hasRoleOrType = {attrs, body ->
    Entity entity = attrs.entity

    def hasRoles = false

    if (entity.user) {
      List roles = attrs.roles
      hasRoles = roles.findAll { entity.user?.authorities*.authority.contains(it) }
    }

    List types = attrs.types
    def hasType = types.findAll { entity.type?.name == it }

    def myself = attrs.me == 'true' ? entity == entityHelperService.loggedIn : false

    if (hasRoles || hasType || myself)
      out << body()
  }

  /*
   * receives a family status ID and renders either the german or spanish word for it
   */
  def getFamilyStatus = {attrs ->
    Locale locale = RequestContextUtils.getLocale(request) ?: new Locale("de", "DE")
    if (locale.toString() == "de" || locale.toString() == "de_DE")
      out << grailsApplication.config.familyRelation_de[attrs.status]
    if (locale.toString() == "es" || locale.toString() == "es_ES")
      out << grailsApplication.config.familyRelation_es[attrs.status]
  }

  /*
   *  receives a nationality ID and renders either the german or spanish word for it
   */
  def getNationalities = {attrs ->
    Locale locale = RequestContextUtils.getLocale(request) ?: new Locale("de", "DE")
    if (locale.toString() == "de" || locale.toString() == "de_DE")
      out << grailsApplication.config.nationalities_de[attrs.nationality]
    if (locale.toString() == "es" || locale.toString() == "es_ES")
      out << grailsApplication.config.nationalities_es[attrs.nationality]
  }

  /*
   * receives a language ID and renders either the german or spanish word for it
   */
  def getLanguages = {attrs ->
    Locale locale = RequestContextUtils.getLocale(request) ?: new Locale("de", "DE")
    if (locale.toString() == "de" || locale.toString() == "de_DE")
      out << grailsApplication.config.languages_de[attrs.language]
    if (locale.toString() == "es" || locale.toString() == "es_ES")
      out << grailsApplication.config.languages_es[attrs.language]
  }

  /*
   * receives a inChargeOf ID and renders either the german or spanish word for it
   */
  def getInChargeOf = {attrs ->
    Locale locale = RequestContextUtils.getLocale(request) ?: new Locale("de", "DE")
    if (locale.toString() == "de" || locale.toString() == "de_DE")
      out << grailsApplication.config.inchargeof_de[attrs.inchargeof]
    if (locale.toString() == "es" || locale.toString() == "es_ES")
      out << grailsApplication.config.inchargeof_es[attrs.inchargeof]
  }

  /*
   * receives a partner service ID and renders either the german or spanish word for it
   */
  def getPartnerService = {attrs ->
    Locale locale = RequestContextUtils.getLocale(request) ?: new Locale("de", "DE")
    if (locale.toString() == "de" || locale.toString() == "de_DE")
      out << grailsApplication.config.partner_de[attrs.service]
    if (locale.toString() == "es" || locale.toString() == "es_ES")
      out << grailsApplication.config.partner_es[attrs.service]
  }

  /*
   * receives a school level ID and renders either the german or spanish word for it
   */
  def getSchoolLevel = {attrs ->
    Locale locale = RequestContextUtils.getLocale(request) ?: new Locale("de", "DE")
    if (locale.toString() == "de" || locale.toString() == "de_DE")
      out << grailsApplication.config.schoolLevels_de[attrs.level]
    if (locale.toString() == "es" || locale.toString() == "es_ES")
      out << grailsApplication.config.schoolLevels_es[attrs.level]
  }

  /*
   * receives a maritalStatus ID and renders either the german or spanish word for it
   */
  def getMaritalStatus = {attrs ->
    Locale locale = RequestContextUtils.getLocale(request) ?: new Locale("de", "DE")
    if (locale.toString() == "de" || locale.toString() == "de_DE")
      out << grailsApplication.config.maritalStatus_de[attrs.level]
    if (locale.toString() == "es" || locale.toString() == "es_ES")
      out << grailsApplication.config.maritalStatus_es[attrs.level]
  }

  /*
   * receives a familyProblem ID and renders either the german or spanish word for it
   */
  def getFamilyProblem = {attrs ->
    Locale locale = RequestContextUtils.getLocale(request) ?: new Locale("de", "DE")
    if (locale.toString() == "de" || locale.toString() == "de_DE")
      out << grailsApplication.config.problems_de[attrs.problem]
    if (locale.toString() == "es" || locale.toString() == "es_ES")
      out << grailsApplication.config.problems_es[attrs.problem]
  }

  /*
   * receives a jobType ID and renders either the german or spanish word for it
   */
  def getJobType = {attrs ->
    Locale locale = RequestContextUtils.getLocale(request) ?: new Locale("de", "DE")
    if (locale.toString() == "de" || locale.toString() == "de_DE")
      out << grailsApplication.config.jobs_de[attrs.job]
    if (locale.toString() == "es" || locale.toString() == "es_ES")
      out << grailsApplication.config.jobs_es[attrs.job]
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
    def units = Link.countByTargetAndType(attrs.template, metaDataService.ltProjectUnit)
    out << units
  }

  /*
   * finds all project units linked to a project day
   */
  def getProjectDayUnits = {attrs, body ->
    def link = Link.findAllByTargetAndType(attrs.projectDay, metaDataService.ltProjectDayUnit)
    if (link)
      link.each {out << body(units: it.source)}
    else
      out << '<span class="italic">Keine Projekteinheiten zugewiesen</span> <img src="' + g.resource(dir: 'images/icons', file: 'icon_warning.png') + '" alt="toolTip" align="top"/></span>'
  }

  /*
   * finds all educators linked to a project day
   */
  def getProjectDayEducators = {attrs, body ->
    def link = Link.findAllByTargetAndType(attrs.projectDay, metaDataService.ltProjectDayEducator)
    if (link)
      link.each {out << body(educators: it.source)}
    else
      out << '<span class="italic">Keine Pädagogen zugewiesen</span> <img src="' + g.resource(dir: 'images/icons', file: 'icon_warning.png') + '" alt="toolTip" align="top"/></span>'
  }

  /*
   * finds all resources linked to a project day
   */
  def getProjectDayResources = {attrs, body ->
    def link = Link.findAllByTargetAndType(attrs.projectDay, metaDataService.ltProjectDayResource)
    if (link)
      link.each {out << body(resources: it.source)}
    else
      out << '<span class="italic">Keine Resourcen zugewiesen</span> <img src="' + g.resource(dir: 'images/icons', file: 'icon_warning.png') + '" alt="toolTip" align="top"/></span>'
  }

  /*
   * finds all activity groups linked to a project unit
   */
  def getProjectUnitActivityGroups = {attrs, body ->
    def link = Link.findAllByTargetAndType(attrs.projectUnit, metaDataService.ltProjectUnit)
    if (link)
      link.each {out << body(activityGroups: it.source)}
    else
      out << '<span class="italic">Keine Aktivitätsblockvorlagen gefunden</span> <img src="' + g.resource(dir: 'images/icons', file: 'icon_warning.png') + '" alt="toolTip" align="top"/></span>'
  }

  /*
   * finds all parents linked to a project unit
   */
  def getProjectUnitParents = {attrs, body ->
    def link = Link.findAllByTargetAndType(attrs.projectUnit, metaDataService.ltProjectUnitParent)
    if (link)
      link.each {out << body(parents: it.source)}
    else
      out << '<span class="italic">Keine Erziehungsberechtigten zugewiesen</span> <img src="' + g.resource(dir: 'images/icons', file: 'icon_warning.png') + '" alt="toolTip" align="top"/></span>'
  }

  /*
   * finds all partners linked to a project unit
   */
  def getProjectUnitPartners = {attrs, body ->
    def link = Link.findAllByTargetAndType(attrs.projectUnit, metaDataService.ltProjectUnitPartner)
    if (link)
      link.each {out << body(partners: it.source)}
    else
      out << '<span class="italic">Keine Partner zugewiesen</span> <img src="' + g.resource(dir: 'images/icons', file: 'icon_warning.png') + '" alt="toolTip" align="top"/></span>'
  }

  /*
   * finds all group activity templates linked to a project unit
   */
  def getGroupActivityTemplates = {attrs, body ->
    def link = Link.findAllByTargetAndType(attrs.projectUnit, metaDataService.ltProjectUnitMember)
    if (link)
      link.each {out << body(groupActivityTemplates: it.source)}
    else
      out << '<span class="italic">Keine Aktivitätsblockvorlagen zugewiesen</span> <img src="' + g.resource(dir: 'images/icons', file: 'icon_warning.png') + '" alt="toolTip" align="top"/></span>'
  }

  /*
   * finds all resources linked to an entity
   */
  def getResources = {attrs, body ->
    def link = Link.findAllByTargetAndType(attrs.entity, metaDataService.ltResource)
    if (link)
      link.each {out << body(resources: it.source)}
    else
      out << '<span class="italic">Keine Ressourcen zugewiesen</span> <img src="' + g.resource(dir: 'images/icons', file: 'icon_warning.png') + '" alt="toolTip" align="top"/></span>'
  }

  /*
   * finds all group members of a given group
   */
  def getGroup = {attrs, body ->
    def link = Link.findAllByTargetAndType(attrs.entity, metaDataService.ltGroupMember)
    if (link)
      link.each {out << body(members: it.source)}
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
    def link = Link.findAllByTargetAndType(attrs.entity, metaDataService.ltGroupMember)
    def duration = 0
    if (link)
      link.each {duration += it.source.profile.duration}
    out << duration
  }

  /*
   * returns the template to a given activity
   */
  def getTemplate = {attrs, body ->
    def link = Link.findByTargetAndType(attrs.entity, metaDataService.ltActTemplate)
    if (link)
      out << body(template: link.source)
    else
      out << '<span class="italic">keine Vorlage vorhanden</span>'
  }

  /*
   * returns all clients to a given activity
   */
  def getClients = {attrs, body ->
    def link = Link.findAllByTargetAndType(attrs.entity, metaDataService.ltActClient)
    if (link)
      link.each {out << body(clients: it.source)}
    else
      out << '<span class="italic">keine Betreuten zugewiesen <img src="' + g.resource(dir: 'images/icons', file: 'icon_warning.png') + '" alt="toolTip" align="top"/></span>'
  }

  /*
   * returns all clients linked to a given pate
   */
  def getPateClients = {attrs, body ->
    def link = Link.findAllByTargetAndType(attrs.entity, metaDataService.ltPate)
    if (link)
      link.each {out << body(clients: it.source)}
    else
      out << '<span class="italic">keine Betreuten zugewiesen</span> <img src="' + g.resource(dir: 'images/icons', file: 'icon_warning.png') + '" alt="toolTip" align="top"/></span>'
  }

  /*
   * returns all educators linked to a given activity
   */
  def getEducators = {attrs, body ->
    def link = Link.findAllByTargetAndType(attrs.entity, metaDataService.ltActEducator)
    if (link)
      link.each {out << body(educators: it.source)}
    else
      out << '<span class="italic">keine Pädagogen zugewiesen</span> <img src="' + g.resource(dir: 'images/icons', file: 'icon_warning.png') + '" alt="toolTip" align="top"/></span>'
  }

  /*
   * returns the facility linked to a given activity
   */
  def getFacility = {attrs, body ->
    def link = Link.findByTargetAndType(attrs.entity, metaDataService.ltActFacility)
    if (link)
      out << body(facility: link.source)
    else
      out << '<span class="italic">keiner Einrichtung zugewiesen</span>'
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
    if (attrs.entity.type.name == metaDataService.etParent.name || secHelperService.isAdmin())
      out << body()
  }

  /*
   * checks whether the given entity is a pate (or has the admin role)
   */
  def isPate = {attrs, body ->
    if (attrs.entity.type.name == metaDataService.etPate.name || secHelperService.isAdmin())
      out << body()
  }

  /*
   * checks whether the given entity is a partner (or has the admin role)
   */
  def isPartner = {attrs, body ->
    if (attrs.entity.type.name == metaDataService.etPartner.name || secHelperService.isAdmin())
      out << body()
  }

  /*
   * checks whether the given entity is a client (or has the admin role)
   */
  def isClient = {attrs, body ->
    if (attrs.entity.type.name == metaDataService.etClient.name || secHelperService.isAdmin())
      out << body()
  }

  /*
   * checks whether the given entity is a facility (or has the admin role)
   */
  def isFacility = {attrs, body ->
    if (attrs.entity.type.name == metaDataService.etFacility.name || secHelperService.isAdmin())
      out << body()
  }

  /*
   * checks whether the given entity is an educator (or has the admin role)
   */
  def isEducator = {attrs, body ->
    if (attrs.entity.type.name == metaDataService.etEducator.name || secHelperService.isAdmin())
      out << body()
  }

  /*
   * checks whether the given entity is an operator (or has the admin role)
   */
  def isOperator = {attrs, body ->
    if (attrs.entity.type.name == metaDataService.etOperator.name || secHelperService.isAdmin())
      out << body()
  }

  /*
   * checks whether the given entity was created by the current user
   */
  def isCreator = {attrs, body ->
    def c = Link.createCriteria()
    def link = c.get {
      eq('source', entityHelperService.loggedIn)
      eq('target', attrs.entity)
      eq('type', metaDataService.ltCreator)
    }
    // show also when the current user is an operator, admin or sysadmin
    if (link || entityHelperService.loggedIn.type.name == metaDataService.etOperator.name || secHelperService.isAdmin() || secHelperService.hasRole('ROLE_SYSTEMADMIN'))
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
    out << '<p class="quoter">von ' + grailsApplication.config.quoterMap[day] + '</p>'
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
    int m = filterService.getNewInboxMessages(attrs.entity.id.toString())
    if (m > 0)
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
    if (Entity.get(attrs.entity.id).user.enabled)
      out << body()
  }

  def notEnabled = {attrs, body ->
    if (!Entity.get(attrs.entity.id).user.enabled)
      out << body()
  }

  def isAdmin = {attrs, body ->
    if (secHelperService.isAdmin())
      out << body()
  }

  def notAdmin = {attrs, body ->
    if (!secHelperService.isAdmin())
      out << body()
  }

  def isMeOrAdmin = {attrs, body ->
    if (secHelperService.isMeOrAdmin(attrs.entity))
      out << body()
  }

  def isMeOrAdminOrOperator = {attrs, body ->
    if (secHelperService.isMeOrAdmin(attrs.entity) || entityHelperService.loggedIn.type.id == metaDataService.etOperator.id)
      out << body()
  }

  def isSysAdmin = {attrs, body ->
    // "secHelperService.hasRole" is broken so let's use this
    def entity = attrs.entity ?: entityHelperService.loggedIn

    entity.user.authorities.each {
      if (it.authority == "ROLE_SYSTEMADMIN")
        out << body()
        return
    }
  }

  def isMe = {attrs, body ->
    if (entityHelperService.loggedIn?.id == attrs.entity.id)
      out << body()
  }

  def notMe = {attrs, body ->
    if (secHelperService.isNotMe(attrs.entity))
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
    Entity current = entityHelperService.loggedIn
    if (!current)
      return false
    Entity e = attrs.entity ?: entityHelperService.loggedIn
    if (!e)
      return false

    def result = networkService.isFriendOf(current, e)
    return result
  }

  private boolean bookmark(attrs) {
    Entity current = entityHelperService.loggedIn
    if (!current)
      return false
    Entity e = attrs.entity ?: entityHelperService.loggedIn
    if (!e)
      return false

    def result = networkService.isBookmarkOf(current, e)
    return result
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

}
