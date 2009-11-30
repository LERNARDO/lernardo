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
  static namespace = "app"

  def getProfileType = {attrs ->
      out << message(code:"entityType."+Entity.findByName(attrs.remove('entityName')).type.name)
  }

  def getQuoteOfTheDay = {
    Date myDate = new Date()
    SimpleDateFormat df = new SimpleDateFormat( "dd" );
    int day = df.format(myDate).toInteger()
    out << '<span class="quote">"'+grailsApplication.config.quotesMap[day]+'"</span>'
    out << '<p class="quoter">von '+grailsApplication.config.quoterMap[day]+'</p>'
  }

  def showGender = {attrs ->
    if (attrs.remove('gender') == 1)
      out << 'Männlich'
    else
      out << 'Weiblich'
  }

  def getNewInboxMessages = {attrs ->
    int m = filterService.getNewInboxMessages(attrs.remove ("entityName"))
    //println "m = "+ m
    if (m > 0)
      out << "("+m+")"
  }
  def getTemplateCommentsCount = {attrs ->
    out << TemplateComment.countByTemplate(attrs.remove ("template"))
  }

  def getRelationship = {attrs ->
    out << Link.findBySourceAndTarget(Entity.findByName(attrs.remove ("source")),Entity.findByName(attrs.remove ("target"))).type.name
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

  private boolean friend (attrs) {
    Entity current = entityHelperService.loggedIn
    if (!current)
      return false
    Entity e = attrs.remove ("entity") ?: entityHelperService.loggedIn
    if (!e)
      return false

    def result = networkService.isFriendOf(current, e)
    return result
  }

  private boolean bookmark (attrs) {
    Entity current = entityHelperService.loggedIn
    if (!current)
      return false
    Entity e = attrs.remove ("entity") ?: entityHelperService.loggedIn
    if (!e)
      return false

    def result = networkService.isBookmarkOf(current, e)
    return result
  }
}
