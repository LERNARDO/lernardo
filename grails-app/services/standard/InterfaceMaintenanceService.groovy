package standard

import at.openfactory.ep.EntityType
import grails.util.Environment
import at.openfactory.ep.Entity
import at.openfactory.ep.Account
import profiles.ChildProfile
import java.text.SimpleDateFormat

class InterfaceMaintenanceService {
  MetaDataService metaDataService
  def securityManager
  FunctionService functionService
  def grailsApplication

  boolean transactional = true

  /*
  * this is a simple XML loader that is called on bootstrapping the application
  * currently it only imports children
  */
  def importChildren(def source, boolean fullLoad = false) {

    log.info("==> importing children")

    // Basic stuff each entity will use
    EntityType etChild = metaDataService.etChild

    def children = new XmlSlurper().parse(source)
    log.info("reading ${children.child.size()} children from xml");

    // def isDevEnv = Environment.current == Environment.DEVELOPMENT

    children.child.eachWithIndex {child, n ->

      // load only 300 children for development environment
      //if (fullLoad || Environment.current != Environment.DEVELOPMENT || n < 300) {

      def ent = new Entity(name: functionService.createNick("${child.firstname.text()}", "${child.lastname.text()}"), type: etChild)
      ent.user = new Account(email: "${child.email.text()}", password: securityManager.encodePassword(grailsApplication.config.defaultpass), enabled: child.status.toBoolean())
      ent.user.addToAuthorities(metaDataService.userRole)
      ent.profile = new ChildProfile()
      ent.profile.fullName = "${child.firstname.text()} ${child.lastname.text()}"

      ChildProfile prf = (ChildProfile) ent.profile
      prf.firstName = child.firstname.text()
      prf.lastName = child.lastname.text()
      SimpleDateFormat sdfToDate = new SimpleDateFormat("yyyy-MM-dd");
      prf.birthDate = sdfToDate.parse(child.birthdate.text());
      prf.gender = child.gender.toInteger()
      prf.job = child.job.toBoolean()
      prf.jobType = child.jobtype.toInteger()
      prf.jobIncome = child.jobincome.toInteger()
      prf.jobFrequency = child.jobfrequency.text()
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
