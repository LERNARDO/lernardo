package lernardo

import de.uenterprise.ep.Profile

class CommentTemplateProfile extends Profile {

  String content

  Date dateCreated
  Date lastUpdated

  static constraints = {
    content (blank: false, maxSize:2000)
  }
}
