import de.uenterprise.ep.Entity
import de.uenterprise.ep.Link
import posts.TemplateComment
import posts.ArticlePost
import java.text.SimpleDateFormat

class HelperTagLib {
  def entityHelperService
  def metaDataService
  def networkService
  def filterService
  def secHelperService
  static namespace = "app"

  def isHort = {attrs, body->
    if (attrs.entity.type == metaDataService.etHort || secHelperService.isAdmin())
      out << body()
  }

  def isPaed = {attrs, body->
    if (attrs.entity.type == metaDataService.etPaed || secHelperService.isAdmin())
      out << body()
  }

  def isOperator = {attrs, body->
    if (attrs.entity.type == metaDataService.etOperator || secHelperService.isAdmin())
      out << body()
  }

  def active = {attrs ->
    if (attrs.glossary == attrs.letter)
      out << '<span style="background: #567EC6; padding: 1px 3px; color: #fff;">' << attrs.letter << '</span>'
    else
      out << attrs.letter
  }
  
  def getProfileType = {attrs ->
      out << message(code:"entityType."+Entity.findByName(attrs.entityName).type.name)
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
    out << TemplateComment.countByTemplate(attrs.template)
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
