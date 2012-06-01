package at.uenterprise.erp.base

import org.codehaus.groovy.grails.commons.GrailsClass

class ProfileHelperService {
    def grailsApplication

    boolean transactional = true

    def createProfileFor (Entity entity) {
      if (entity.profile)
        throw new EntityException("profile for entity $entity.name has already been created.",entity)

      def profileClass = findProfileClass(entity.type.supertype.profileType)
      if (!profileClass)
        throw new EntityException ("failed to create profile for entity $entity.name. no profile domain class of type $entity.type.supertype.profileType''.",entity)

      return profileClass.newInstance()
    }

    GrailsClass findProfileClass (String profileType) {
      def result = grailsApplication.domainClasses.find {it.shortName == "${profileType}Profile"}
      log.debug  "found domain class for profile type: $profileType. ($result)"
      return result
    }

    List getAvailableProfiles () {
      def result = grailsApplication.domainClasses.findAll {it.shortName.endsWith("Profile")}.collect {it.shortName}
      log.debug ("list of available profiles: $result")
    }
}

class ProfileException extends RuntimeException {
  String message
  Profile profile
}
