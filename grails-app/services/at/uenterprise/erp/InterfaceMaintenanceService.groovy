package at.uenterprise.erp

import at.openfactory.ep.EntityType
import at.openfactory.ep.Entity
import at.openfactory.ep.Account
import at.uenterprise.erp.profiles.ChildProfile
import java.text.SimpleDateFormat

/**
 * This class is used for important XML data
 * Currently only contains an import method
 *
 * @author  Alexander Zeillinger
 */
class InterfaceMaintenanceService {
  MetaDataService metaDataService
  def securityManager
  FunctionService functionService
  def grailsApplication

  boolean transactional = true

  /*
  * This is a simple XML loader that is called on bootstrapping the application.
  * Currently it only imports children
  */
  def importChildren(def source, boolean fullLoad = false) {

    log.info("==> importing children")

    EntityType etChild = metaDataService.etChild

    def childProfiles = new XmlSlurper().parse(source)
    log.info("reading ${childProfiles.childProfile.size()} children from xml");

    // def isDevEnv = Environment.current == Environment.DEVELOPMENT

    childProfiles.childProfile.eachWithIndex {child, n ->

      // load only 300 children for development environment
      //if (fullLoad || Environment.current != Environment.DEVELOPMENT || n < 300) {

      def ent = new Entity(name: functionService.createNick("${child.firstName.text()}", "${child.lastName.text()}"), type: etChild)
      ent.user = new Account(email: "bla${n}@bla.com"/*"${child.email.text()}"*/, password: securityManager.encodePassword(grailsApplication.config.defaultpass), enabled: true)
      ent.user.addToAuthorities(metaDataService.userRole)
      ent.profile = new ChildProfile()
      ent.profile.fullName = "${child.firstname.text()} ${child.lastName.text()}"

      ChildProfile prf = (ChildProfile) ent.profile
      prf.firstName = child.firstName.text()
      prf.lastName = child.lastName.text()
      SimpleDateFormat sdfToDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.S", new Locale("en"));
      prf.birthDate = sdfToDate.parse(child.birthDate.text());
      prf.gender = child.gender.toInteger()
      prf.job = child.job.toBoolean()
      //prf.jobIncome = child?.jobincome?.toInteger()
      //prf.jobFrequency = child?.jobfrequency?.text()
      //prf.sportarten = []
      //athlet.sportarten.sportart.each {sportartid ->
      //  prf.sportarten.add(sportartid.text())
      //}

      ent.save()
      //}
      //if (n % 500 == 0)
      log.debug(n)
    }
  }
}
