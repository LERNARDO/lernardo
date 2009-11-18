import de.uenterprise.ep.Entity

class HelperTagLib {
  def entityHelperService
  def metaDataService
  def networkService
  static namespace = "app"

  def getCommentsCount = {attrs ->
    out << Post.countByTemplate(attrs.remove ("template"))
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
