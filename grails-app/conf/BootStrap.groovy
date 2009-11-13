import de.uenterprise.ep.EntitySuperType
import de.uenterprise.ep.EntityType
import de.uenterprise.ep.Entity
import de.uenterprise.ep.Role
import org.joda.time.DateMidnight
import profiles.UserProfile
import de.uenterprise.ep.Link
import profiles.FacProfile
import de.uenterprise.ep.profiles.PersonProfile

class BootStrap {
  //def profileDataService
  def templateDataService
  def activityDataService
  def articleDataService
  def defaultObjectService
  def entityHelperService
  def calendarDataService
  def metaDataService

  def init = {servletContext ->
    defaultObjectService.onEmptyDatabase {
      metaDataService.initialize()
      createDefaultUsers()
      createDefaultFacs()
      createDefaultLinks()
      //profileDataService.init()
      templateDataService.init()
      activityDataService.init()
      articleDataService.init()
      calendarDataService.init()
    }
  }

  def destroy = {
  }

  void createDefaultUsers() {
    log.debug ("==> creating default users")
    EntityType etUser = metaDataService.etUser

    // an admin user
    entityHelperService.createEntityWithUserAndProfile("admin", etUser, "admin@ue.de", "Mr. Admin") {Entity ent ->
      ent.user.addToAuthorities(metaDataService.adminRole)
      UserProfile prf = ent.profile
      prf.tagline = "to be on top is our job"
      prf.gender = 1
    }

    // a mod user
    entityHelperService.createEntityWithUserAndProfile("alex", etUser, "aaz@lernardo.at", "Alexander Zeillinger") {Entity ent ->
      ent.user.addToAuthorities(metaDataService.modRole)
      UserProfile prf = ent.profile
      prf.tagline = "Simplicity is the ultimate sophistication"
      prf.gender = 1
    }

    // some regular users
    entityHelperService.createEntityWithUserAndProfile("patrizia", etUser, "pcr@lernardo.at", "Patrizia Rosenkranz") {Entity ent ->
      UserProfile prf = ent.profile
      prf.birthDate = new DateMidnight(1983, 07, 20).toDate()
      prf.gender = 2
    }

    entityHelperService.createEntityWithUserAndProfile("mike", etUser, "mpk@lernardo.at", "Mike P. Kuhl") {Entity ent ->
      UserProfile prf = ent.profile
      prf.tagline = "Wozu brauch ma des?"
      prf.gender = 1
    }

    entityHelperService.createEntityWithUserAndProfile("johannes", etUser, "jlz@lernardo.at", "Johannes L. Zeitelberger") {Entity ent ->
      UserProfile prf = ent.profile
      prf.tagline = "Ich will die Welt im ERP abbilden!"
      prf.gender = 1
      prf.firstName = "Johannes"
      prf.lastName = "Zeitelberger"
      prf.PLZ = "2560"
      prf.city = "Berndorf"
      prf.street = "Wankengasse 10"
      prf.tel = "0664 / 840 66 20"
    }

    entityHelperService.createEntityWithUserAndProfile("susanne", etUser, "sst@lernardo.at", "Susanne Stiedl") {Entity ent ->
      UserProfile prf = ent.profile
      prf.tagline = "..."
      prf.gender = 2
    }

    entityHelperService.createEntityWithUserAndProfile("birgit", etUser, "bib@lernardo.at", "Birgit Blaesen") {Entity ent ->
      UserProfile prf = ent.profile
      prf.tagline = "..."
      prf.gender = 2
    }

    entityHelperService.createEntityWithUserAndProfile("hannah", etUser, "hmb@lernardo.at", "Hannah Mutzbauer") {Entity ent ->
      UserProfile prf = ent.profile
      prf.tagline = "..."
      prf.gender = 2
    }

    entityHelperService.createEntityWithUserAndProfile("regina", etUser, "rgt@lernardo.at", "Regina Toncourt") {Entity ent ->
      UserProfile prf = ent.profile
      prf.tagline = "..."
      prf.gender = 2
    }
  }

  void createDefaultFacs () {
    log.debug ("==> creating default facilities")
    EntityType etFac = metaDataService.etHort

    entityHelperService.createEntityWithUserAndProfile ("kaumberg", etFac, "kaumberg@lernardo.at", "Hort Kaumberg") {Entity ent->
      FacProfile prf = ent.profile
      prf.PLZ = "2572"
      prf.city = "Kaumberg"
      prf.street = "?"
      prf.tel   = "0660 / 461 1106"
      prf.opened = "?"
      prf.speaker = Entity.findByName('hannah')
      prf.description = "Der zweite unter Lernardo betriebene Hort."
    }
  }

  void createDefaultLinks () {
    log.debug ("==> creating default links")
    def mike = Entity.findByName ('mike')
    def alex = Entity.findByName ('alex')

    // Person Links
    new Link(source:mike, target:alex,  type:metaDataService.ltFriend).save()
  }
  
}