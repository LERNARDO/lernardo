import de.uenterprise.ep.Entity
import de.uenterprise.ep.Link
import posts.TemplateComment
import posts.ArticlePost

class HelperTagLib {
  def entityHelperService
  def metaDataService
  def networkService
  def filterService
  static namespace = "app"

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
