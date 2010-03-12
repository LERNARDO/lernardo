import de.uenterprise.ep.Entity
import de.uenterprise.ep.Link
import posts.ArticlePost
import java.text.SimpleDateFormat

class HelperTagLib {
  def entityHelperService
  def metaDataService
  def networkService
  def filterService
  def secHelperService
  def authenticateService
  static namespace = "app"

  def getResources = {attrs, body ->
    def link = Link.findAllByTargetAndType(attrs.entity, metaDataService.ltResource)
    if (link)
      link.each {out << body(resources: it.source)}
    else
      out << '<span class="italic">Keine Ressourcen zugewiesen</span>'
  }

  def getGroup = {attrs, body ->
    def link = Link.findAllByTargetAndType(attrs.entity, metaDataService.ltGroup)
    if (link)
      link.each {out << body(members: it.source)}
    else
      out << '<span class="italic">Diese Gruppe ist leer</span>'
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
      out << '<span class="italic">keine Betreuten zugewiesen</span>'
  }

  def getEducators = {attrs, body ->
    def link = Link.findAllByTargetAndType(attrs.entity, metaDataService.ltActEducator)
    if (link)
      link.each {out << body(educators: it.source)}
    else
      out << '<span class="italic">keine Pädagogen zugewiesen</span>'
  }

  def getFacility = {attrs, body ->
    def link = Link.findByTargetAndType(attrs.entity, metaDataService.ltActFacility)
    if (link)
      out << body(facility: link.source)
    else
      out << '<span class="italic">keiner Einrichtung zugewiesen</span>'
  }

  def getCreator = {attrs, body ->
    def link = Link.findByTargetAndType(attrs.entity, metaDataService.ltCreator)
    if (link)
      out << body(creator: link.source)
    else
      out << '<span class="italic">keinem Ersteller zugewiesen</span>'
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
      out << 'Männlich'
    else
      out << 'Weiblich'
  }

  def showBoolean = {attrs ->
    if (attrs.bool == false)
      out << 'Nein'
    else
      out << 'Ja'
  }

  def getNewInboxMessages = {attrs ->
    int m = filterService.getNewInboxMessages(attrs.entity.id.toString())
    if (m > 0)
      out << "("+m+")"
  }
  def getTemplateCommentsCount = {attrs ->
    out << Link.countByTargetAndType(attrs.template, metaDataService.ltComment)
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
  
}
