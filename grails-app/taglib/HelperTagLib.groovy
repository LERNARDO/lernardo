import de.uenterprise.ep.Entity
import de.uenterprise.ep.Link
import posts.ArticlePost
import java.text.SimpleDateFormat
import org.springframework.web.servlet.support.RequestContextUtils
import lernardo.Method
import lernardo.Element

class HelperTagLib {
  def entityHelperService
  def metaDataService
  def networkService
  def filterService
  def secHelperService
  def authenticateService
  static namespace = "app"

  // receives a nationality ID and renders either the german or spanish word for it
  def getNationalities = {attrs ->
    Locale locale = RequestContextUtils.getLocale(request)
    int nationality = attrs.nationality.toInteger()
    if (locale.toString() == "de")
      out << grailsApplication.config.nationalities_de[nationality]
    if (locale.toString() == "es")
      out << grailsApplication.config.nationalities_es[nationality]
  }

  // receives a language ID and renders either the german or spanish word for it
  def getLanguages = {attrs ->
    Locale locale = RequestContextUtils.getLocale(request)
    int language = attrs.language.toInteger()   
    if (locale.toString() == "de")
      out << grailsApplication.config.languages_de[language]
    if (locale.toString() == "es")
      out << grailsApplication.config.languages_es[language]
  }

  // receives a partner service ID and renders either the german or spanish word for it
  def getPartnerService = {attrs ->
    Locale locale = RequestContextUtils.getLocale(request)
    int service = attrs.service.toInteger()
    if (locale.toString() == "de")
      out << grailsApplication.config.partner_de[service]
    if (locale.toString() == "es")
      out << grailsApplication.config.partner_es[service]
  }

  // receives a school level ID and renders either the german or spanish word for it
  def getSchoolLevel = {attrs ->
    Locale locale = RequestContextUtils.getLocale(request)
    int level = attrs.level.toInteger()
    if (locale.toString() == "de")
      out << grailsApplication.config.schoolLevels_de[level]
    if (locale.toString() == "es")
      out << grailsApplication.config.schoolLevels_es[level]
  }

  // receives a familyProblem ID and renders either the german or spanish word for it
  def getFamilyProblem = {attrs ->
    Locale locale = RequestContextUtils.getLocale(request)
    int problem = attrs.problem.toInteger()
    if (locale.toString() == "de")
      out << grailsApplication.config.problems_de[problem]
    if (locale.toString() == "es")
      out << grailsApplication.config.problems_es[problem]
  }

  // receives a jobType ID and renders either the german or spanish word for it
  def getJobType = {attrs ->
    //log.info "Job ID: " + attrs.job
    Locale locale = RequestContextUtils.getLocale(request)
    //log.info "Locale: " + locale.toString()
    int job = attrs.job.toInteger()
    if (locale.toString() == "de")
      out << grailsApplication.config.jobs_de[job]
    if (locale.toString() == "es")
      out << grailsApplication.config.jobs_es[job]
  }

  def getClientName = {attrs ->
    Entity entity = Entity.get(attrs.client)
    out << entity.profile.fullName
  }

  def showLocale = {attrs ->
    if (attrs.locale.toString() == 'de')
      out << 'Deutsch'
    else
      out << 'Spanisch'
  }

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

  // returns the filetype of a publication
  def getFileType = {attrs ->
    if (attrs.type == 'application/vnd.ms-excel')
      out << "Excel"
    else if (attrs.type == 'image/jpeg' || attrs.type == 'image/png' || attrs.type == 'image/gif' || attrs.type == 'image/bmp')
      out << "Bild"
    else if (attrs.type == 'application/msword')
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
    else if (attrs.type == 'audio/mpeg3' || attrs.type == 'audio/x-mpeg3')
      out << "MP3"
    else if (attrs.type == 'video/avi')
      out << "Video"
    else
      out << "Unbekannt"
  }

  // finds all units linked to a projectDay
  def getProjectDayUnits = {attrs, body ->
    def link = Link.findAllByTargetAndType(attrs.projectDay, metaDataService.ltProjectDayUnit)
    if (link)
      link.each {out << body(units: it.source)}
    else
      out << '<span class="italic">Keine Projekteinheiten zugewiesen</span> <img src="' + g.resource(dir:'images/icons', file: 'icon_warning.png') + '" alt="toolTip" align="top"/></span>'
  }

  // finds all educators linked to a projectDay
  def getProjectDayEducators = {attrs, body ->
    def link = Link.findAllByTargetAndType(attrs.projectDay, metaDataService.ltProjectDayEducator)
    if (link)
      link.each {out << body(educators: it.source)}
    else
      out << '<span class="italic">Keine Pädagogen zugewiesen</span> <img src="' + g.resource(dir:'images/icons', file: 'icon_warning.png') + '" alt="toolTip" align="top"/></span>'
  }

  // finds all resources linked to a projectDay
  def getProjectDayResources = {attrs, body ->
    def link = Link.findAllByTargetAndType(attrs.projectDay, metaDataService.ltProjectDayResource)
    if (link)
      link.each {out << body(resources: it.source)}
    else
      out << '<span class="italic">Keine Resourcen zugewiesen</span> <img src="' + g.resource(dir:'images/icons', file: 'icon_warning.png') + '" alt="toolTip" align="top"/></span>'
  }

  // finds all activity groups linked to a projectUnit
  def getProjectUnitActivityGroups = {attrs, body ->
    def link = Link.findAllByTargetAndType(attrs.projectUnit, metaDataService.ltProjectUnit)
    if (link)
      link.each {out << body(activityGroups: it.source)}
    else
      out << '<span class="italic">Keine Aktivitätsvorlagengruppen gefunden</span> <img src="' + g.resource(dir:'images/icons', file: 'icon_warning.png') + '" alt="toolTip" align="top"/></span>'
  }

  // finds all parents linked to a projectUnit
  def getProjectUnitParents = {attrs, body ->
    def link = Link.findAllByTargetAndType(attrs.projectUnit, metaDataService.ltProjectUnitParent)
    if (link)
      link.each {out << body(parents: it.source)}
    else
      out << '<span class="italic">Keine Erziehungsberechtigten zugewiesen</span> <img src="' + g.resource(dir:'images/icons', file: 'icon_warning.png') + '" alt="toolTip" align="top"/></span>'
  }

  // finds all partners linked to a projectUnit
  def getProjectUnitPartners = {attrs, body ->
    def link = Link.findAllByTargetAndType(attrs.projectUnit, metaDataService.ltProjectUnitPartner)
    if (link)
      link.each {out << body(partners: it.source)}
    else
      out << '<span class="italic">Keine Partner zugewiesen</span> <img src="' + g.resource(dir:'images/icons', file: 'icon_warning.png') + '" alt="toolTip" align="top"/></span>'
  }

  // finds all groupActivityTemplates linked to a projectUnit
  def getGroupActivityTemplates = {attrs, body ->
    def link = Link.findAllByTargetAndType(attrs.projectUnit, metaDataService.ltProjectUnitMember)
    if (link)
      link.each {out << body(groupActivityTemplates: it.source)}
    else
      out << '<span class="italic">Keine Aktivitätsvorlagengruppen zugewiesen</span> <img src="' + g.resource(dir:'images/icons', file: 'icon_warning.png') + '" alt="toolTip" align="top"/></span>'
  }

  def getResources = {attrs, body ->
    def link = Link.findAllByTargetAndType(attrs.entity, metaDataService.ltResource)
    if (link)
      link.each {out << body(resources: it.source)}
    else
      out << '<span class="italic">Keine Ressourcen zugewiesen</span> <img src="' + g.resource(dir:'images/icons', file: 'icon_warning.png') + '" alt="toolTip" align="top"/></span>'
  }

  def getGroup = {attrs, body ->
    def link = Link.findAllByTargetAndType(attrs.entity, metaDataService.ltGroupMember)
    if (link)
      link.each {out << body(members: it.source)}
    else
      out << '<span class="italic">Diese Gruppe ist leer</span>'
  }

  def getGroupSize = {attrs, body ->
    def result = Link.countByTargetAndType(attrs.entity, metaDataService.ltGroupMember)

    if (result == 0)
      out << '0 <img src="'+ g.resource(dir:'images/icons', file: 'icon_warning.png') + '" alt="toolTip" align="top"/>'
    else
      out << result
  }

  def getGroupDuration = {attrs, body ->
    def link = Link.findAllByTargetAndType(attrs.entity, metaDataService.ltGroupMember)
    def duration = 0
    if (link)
      link.each {duration += it.source.profile.duration}
    out << duration
  }

  def getTemplate = {attrs, body ->
    def link = Link.findByTargetAndType(attrs.entity, metaDataService.ltActTemplate)
    if (link)
      out << body(template: link.source)
    else
      out << '<span class="italic">keine Vorlage vorhanden</span>'
  }

  def getClients = {attrs, body ->
    def link = Link.findAllByTargetAndType(attrs.entity, metaDataService.ltActClient)
    if (link)
      link.each {out << body(clients: it.source)}
    else
      out << '<span class="italic">keine Betreuten zugewiesen <img src="' + g.resource(dir:'images/icons', file: 'icon_warning.png') + '" alt="toolTip" align="top"/></span>'
  }

  def getPateClients = {attrs, body ->
    def link = Link.findAllByTargetAndType(attrs.entity, metaDataService.ltPate)
    if (link)
      link.each {out << body(clients: it.source)}
    else
      out << '<span class="italic">keine Betreuten zugewiesen</span> <img src="' + g.resource(dir:'images/icons', file: 'icon_warning.png') + '" alt="toolTip" align="top"/></span>'
  }

  def getEducators = {attrs, body ->
    def link = Link.findAllByTargetAndType(attrs.entity, metaDataService.ltActEducator)
    if (link)
      link.each {out << body(educators: it.source)}
    else
      out << '<span class="italic">keine Pädagogen zugewiesen</span> <img src="' + g.resource(dir:'images/icons', file: 'icon_warning.png') + '" alt="toolTip" align="top"/></span>'
  }

  def getFacility = {attrs, body ->
    def link = Link.findByTargetAndType(attrs.entity, metaDataService.ltActFacility)
    if (link)
      out << body(facility: link.source)
    else
      out << '<span class="italic">keiner Einrichtung zugewiesen</span>'
  }

  def getCreator = {attrs, body ->
    out << body(creator: Entity.get(attrs.id))
  }

  def getEditor = {attrs, body ->
    def link = Link.findByTargetAndType(attrs.entity, metaDataService.ltEditor)
    if (link)
      out << body(editor: link.source)
    else
      out << '<span class="italic">noch nicht bearbeitet</span>'
  }

  def isParent = {attrs, body->
    if (attrs.entity.type.name == metaDataService.etParent.name || secHelperService.isAdmin()|| authenticateService.ifAllGranted('ROLE_SYSTEMADMIN'))
      out << body()
  }

  def isPate = {attrs, body->
    if (attrs.entity.type.name == metaDataService.etPate.name || secHelperService.isAdmin()|| authenticateService.ifAllGranted('ROLE_SYSTEMADMIN'))
      out << body()
  }

  def isPartner = {attrs, body->
    if (attrs.entity.type.name == metaDataService.etPartner.name || secHelperService.isAdmin()|| authenticateService.ifAllGranted('ROLE_SYSTEMADMIN'))
      out << body()
  }

  def isClient = {attrs, body->
    if (attrs.entity.type.name == metaDataService.etClient.name || secHelperService.isAdmin()|| authenticateService.ifAllGranted('ROLE_SYSTEMADMIN'))
      out << body()
  }

  def isFacility = {attrs, body->
    if (attrs.entity.type.name == metaDataService.etFacility.name || secHelperService.isAdmin()|| authenticateService.ifAllGranted('ROLE_SYSTEMADMIN'))
      out << body()
  }

  def isEducator = {attrs, body->
    if (attrs.entity.type.name == metaDataService.etEducator.name || secHelperService.isAdmin()|| authenticateService.ifAllGranted('ROLE_SYSTEMADMIN'))
      out << body()
  }

  def isOperator = {attrs, body->
    if (attrs.entity.type.name == metaDataService.etOperator.name || secHelperService.isAdmin() || authenticateService.ifAllGranted('ROLE_SYSTEMADMIN'))
      out << body()
  }

  def active = {attrs ->
    if (attrs.glossary == attrs.letter)
      out << '<span style="background: #567EC6; padding: 1px 3px; color: #fff;">' << attrs.letter << '</span>'
    else
      out << attrs.letter
  }
  
  def getQuoteOfTheDay = {
    Date myDate = new Date()
    SimpleDateFormat df = new SimpleDateFormat( "dd" )
    int day = df.format(myDate).toInteger()
    out << '<span class="quote">"'+grailsApplication.config.quotesMap[day]+'"</span>'
    out << '<p class="quoter">von '+grailsApplication.config.quoterMap[day]+'</p>'
  }

  def getPicOfTheDay = { attrs, body ->
    Date myDate = new Date()
    SimpleDateFormat df = new SimpleDateFormat( "dd" )
    String day = df.format(myDate)//.toInteger()
    out << body(day)
  }

  def showGender = {attrs ->
    if (attrs.gender == 1)
      out << message(code:'male')
    else
      out << message(code:'female')
  }

  def getNewInboxMessages = {attrs ->
    int m = filterService.getNewInboxMessages(attrs.entity.id.toString())
    if (m > 0)
      out << "("+m+")"
  }

  def getRelationship = {attrs ->
    out << Link.findBySourceAndTarget(Entity.findByName(attrs.source),Entity.findByName(attrs.target)).type.name
  }

  def isLoggedIn = {attrs, body->
    if (entityHelperService.loggedIn)
      out << body()
  }

  def isNotLoggedIn = {attrs, body->
    if (!entityHelperService.loggedIn)
      out << body()
  }

  def isFriend = {attrs, body->
    if (friend(attrs))
      out << body()
  }

  def notFriend = {attrs, body->
    if (!friend(attrs))
      out << body()
  }

  def isBookmark = {attrs, body->
    if (bookmark(attrs))
      out << body()
  }

  def notBookmark = {attrs, body->
    if (!bookmark(attrs))
      out << body()
  }

  def isEnabled = {attrs, body->
    if (Entity.get(attrs.entity.id).user.enabled)
      out << body()
  }

  def notEnabled = {attrs, body->
    if (!Entity.get(attrs.entity.id).user.enabled)
      out << body()
  }

  def isAdmin = {attrs, body->
    if (authenticateService.ifAllGranted('ROLE_ADMIN') || authenticateService.ifAllGranted('ROLE_SYSTEMADMIN'))
      out << body()
  }

  def isMeOrAdmin = {attrs, body->
    if (attrs.entity == entityHelperService.loggedIn || authenticateService.ifAllGranted('ROLE_ADMIN') || authenticateService.ifAllGranted('ROLE_SYSTEMADMIN'))
      out << body()
  }

  def isSysAdmin = {attrs, body->
    if (authenticateService.ifAllGranted('ROLE_SYSTEMADMIN'))
      out << body()
  }

  def notMe = {attrs, body->
    if (entityHelperService.loggedIn?.id != attrs.entity.id)
      out << body()
  }

  private boolean friend (attrs) {
    Entity current = entityHelperService.loggedIn
    if (!current)
      return false
    Entity e = attrs.entity ?: entityHelperService.loggedIn
    if (!e)
      return false

    def result = networkService.isFriendOf(current, e)
    return result
  }

  private boolean bookmark (attrs) {
    Entity current = entityHelperService.loggedIn
    if (!current)
      return false
    Entity e = attrs.entity ?: entityHelperService.loggedIn
    if (!e)
      return false

    def result = networkService.isBookmarkOf(current, e)
    return result
  }

  // starbox zur Bewertung einer Entitiy anzeigen
  def starBox = {attrs ->

    Element element = Element.get(attrs.element)

    def star = "<img src='${grailsAttributes.getApplicationUri(request)}/images/icons/icon_star.png'/>"
    def star_empty = "<img src='${grailsAttributes.getApplicationUri(request)}/images/icons/icon_star_empty.png'/>"

    //def (vote, myVote) = ideaService.getVoting(attrs.idea)
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
