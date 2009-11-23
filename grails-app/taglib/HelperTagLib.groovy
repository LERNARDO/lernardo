import de.uenterprise.ep.Entity
import de.uenterprise.ep.Link

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

  def getCommentsCount = {attrs ->
    out << Post.countByTemplate(attrs.remove ("template"))
  }

  def getCommentsCountPost = {attrs ->
    out << Post.countByPost(attrs.remove ("post"))
  }

  def getRelationship = {attrs ->
    out << Link.findBySourceAndTarget(Entity.findByName(attrs.remove ("source")),Entity.findByName(attrs.remove ("target"))).type.name
  }

  def isFriend = {attrs, body->
    if (friend(attrs))
      out << body()
  }

  def notFriend = {attrs, body->
    if (!friend(attrs))
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
}
