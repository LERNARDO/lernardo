import de.uenterprise.ep.EntitySuperType
import de.uenterprise.ep.EntityType
import de.uenterprise.ep.Entity
import de.uenterprise.ep.Role
import org.joda.time.DateMidnight
import de.uenterprise.ep.profiles.PersonProfile

class BootStrap {
  def profileDataService
  def templateDataService
  def activityDataService
  def articleDataService
  def defaultObjectService
  def entityHelperService
  def calendarDataService
  def sessionFactory

  def metaDataService

  def init = {servletContext ->
    defaultObjectService.onEmptyDatabase {
      metaDataService.initialize()
      createDefaultUsers()
      //profileDataService.init()
      templateDataService.init()
      activityDataService.init()
      articleDataService.init()
      calendarDataService.init()
    }
    //initUeDomains()

  }

  def destroy = {
  }

  void createDefaultUsers() {
    EntityType etUser = metaDataService.etUser

    // an admin user
    entityHelperService.createEntityWithUserAndProfile("admin", etUser, "admin@ue.de", "Mr. Admin") {Entity ent ->
      ent.user.addToAuthorities(metaDataService.adminRole)
      ent.profile.tagline = "to be on top is our job"
      ent.profile.gender = 1
      ent.profile.location = "hier"
    }

    // a mod user
    entityHelperService.createEntityWithUserAndProfile("alex", etUser, "aaz@lernardo.at", "Alexander Zeillinger") {Entity ent ->
      ent.user.addToAuthorities(metaDataService.modRole)
      ent.profile.tagline = "Simplicity is the ultimate sophistication"
      ent.profile.gender = 1
    }

    // some regular users
    entityHelperService.createEntityWithUserAndProfile("patrizia", etUser, "pcr@lernardo.at", "Patrizia Rosenkranz") {Entity ent ->
      PersonProfile prf = ent.profile

      prf.birthday = new DateMidnight(1983, 07, 20).toDate()
      prf.gender = 2
      prf.profession = "Soziologin"
      prf.location = "Berndorf"
      prf.status = "workaholic"
      prf.hobbies = "musik, tanz"
      prf.webSite = "www.lkult.at"
      prf.description = "Ist eine LKULT Mitarbeiterin."
    }

    entityHelperService.createEntityWithUserAndProfile("mike", etUser, "mpk@lernardo.at", "Mike P. Kuhl") {Entity ent ->
      ent.profile.tagline = "Wozu brauch ma des?"
      ent.profile.gender = 1
    }
    entityHelperService.createEntityWithUserAndProfile("johannes", etUser, "jlz@lernardo.at", "Johannes L. Zeitelberger") {Entity ent ->
      ent.profile.tagline = "Ich will die Welt im ERP abbilden!"
      ent.profile.gender = 1
    }
    entityHelperService.createEntityWithUserAndProfile("susanne", etUser, "sst@lernardo.at", "Susanne Stiedl") {Entity ent ->
      ent.profile.tagline = "..."
      ent.profile.gender = 2
    }
    entityHelperService.createEntityWithUserAndProfile("birgit", etUser, "bib@lernardo.at", "Birgit Blaesen") {Entity ent ->
      ent.profile.tagline = "..."
      ent.profile.gender = 2
    }
    entityHelperService.createEntityWithUserAndProfile("hannah", etUser, "hmb@lernardo.at", "Hannah Mutzbauer") {Entity ent ->
      ent.profile.tagline = "..."
      ent.profile.gender = 2
    }
    entityHelperService.createEntityWithUserAndProfile("regina", etUser, "rgt@lernardo.at", "Regina Toncourt") {Entity ent ->
      ent.profile.tagline = "..."
      ent.profile.gender = 2
    }
  }
}