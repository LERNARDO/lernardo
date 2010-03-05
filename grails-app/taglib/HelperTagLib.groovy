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
  static namespace = "app"

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

  def getPaeds = {attrs, body ->
    def link = Link.findAllByTargetAndType(attrs.entity, metaDataService.ltActPaed)
    if (link)
      link.each {out << body(paeds: it.source)}
    else
      out << '<span class="italic">keine Pädagogen zugewiesen</span>'
  }

  def getFacility = {attrs, body ->
    def link = Link.findByTargetAndType(attrs.entity, metaDataService.ltActFac)
    if (link)
      out << body(facility: link.source)
    else
      out << '<span class="italic">keinem Hort zugewiesen</span>'
  }

  def getCreator = {attrs, body ->
    def link = Link.findByTargetAndType(attrs.entity, metaDataService.ltCreator)
    if (link)
      out << body(creator: link.source)
    else
      out << '<span class="italic">keinem Ersteller zugewiesen</span>'
  }

  def isClient = {attrs, body->
    if (attrs.entity.type.name == metaDataService.etClient.name || secHelperService.isAdmin())
      out << body()
  }

  def isHort = {attrs, body->
    if (attrs.entity.type.name == metaDataService.etHort.name || secHelperService.isAdmin())
      out << body()
  }

  def isPaed = {attrs, body->
    if (attrs.entity.type.name == metaDataService.etPaed.name || secHelperService.isAdmin())
      out << body()
  }

  def isOperator = {attrs, body->
    if (attrs.entity.type.name == metaDataService.etOperator.name || secHelperService.isAdmin())
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

  def getNewInboxMessages = {attrs ->
    int m = filterService.getNewInboxMessages(attrs.entityName)
    if (m > 0)
      out << "("+m+")"
  }
  def getTemplateCommentsCount = {attrs -> 
    out << Link.CountByTargetAndType(attrs.template, metaDataService.ltComment)
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
    if (Entity.findByName(attrs.entityName).user.enabled)
      out << body()
  }

  def notEnabled = {attrs, body->
    if (!Entity.findByName(attrs.entityName).user.enabled)
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
