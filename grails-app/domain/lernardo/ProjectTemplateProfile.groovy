package lernardo

import at.openfactory.ep.Profile

class ProjectTemplateProfile extends Profile {

    SortedSet comments
    static hasMany = [comments: Comment]

    String description
    String status

    static constraints = {
      fullName (blank: false, maxSize: 50)
      description (blank: true, maxSize: 5000)
    }

    String toString(){
      return "${fullName}"
    }
}
