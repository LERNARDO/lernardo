import at.openfactory.ep.EntityType
import at.openfactory.ep.Entity
import at.openfactory.ep.Link

import lernardo.Helper
import lernardo.Evaluation
import lernardo.Attendance

import posts.ArticlePost

import profiles.ClientProfile
import profiles.FacilityProfile
import profiles.OperatorProfile
import profiles.EducatorProfile

import profiles.UserProfile

import grails.util.GrailsUtil
import at.openfactory.ep.DefaultObjectService
import at.openfactory.ep.EntityHelperService
import at.openfactory.ep.ProfileHelperService
import standard.FunctionService
import standard.MetaDataService
import profiles.ChildProfile
import profiles.ParentProfile
import profiles.PartnerProfile
import lernardo.Method
import lernardo.Element
import at.openfactory.ep.Profile
import lernardo.Comment
import org.springframework.core.io.Resource
import org.codehaus.groovy.grails.commons.ApplicationHolder
import standard.InterfaceMaintenanceService
import at.openfactory.ep.attr.DynAttrSet
import at.openfactory.ep.attr.DynAttr
import at.openfactory.ep.LinkHelperService
import at.openfactory.ep.Tag
import profiles.PateProfile

class BootStrap {
  DefaultObjectService defaultObjectService
  EntityHelperService entityHelperService
  MetaDataService metaDataService
  FunctionService functionService
  ProfileHelperService profileHelperService
  InterfaceMaintenanceService interfaceMaintenanceService
  LinkHelperService linkHelperService
  def GrailsApplication

  def init = {servletContext ->
    defaultObjectService.onEmptyDatabase {
      metaDataService.initialize()
      createDefaultUsers()

      if (GrailsUtil.environment == "development" || GrailsUtil.environment == "test") {
        importChildren()
        createDefaultOperator()
        createDefaultFacilities()
        createDefaultEducators()
        //createDefaultLinks()
        createDefaultTags()
        createDefaultActivityTemplates()
        //createDefaultActivities()
        createDefaultColonias()
        createDefaultParents()
        createDefaultClients()
        createDefaultChildren()
        createDefaultPosts()
        createDefaultPartner()
        createDefaultPates()
        //createDefaultEvents()
        //createDefaultAttendances()
        createDefaultFamilies()
        createDefaultResources()
        createDefaultMethods()
        createDefaultClientGroups()
         createDefaultActivityTemplateGroups()
         createDefaultThemes()
        createDefaultComments()
        createDefaultProjectTemplates()
        //createDefaultHelpers()
      }


      //createDefaultEvaluations()
    }
  }

  def destroy = {
  }

  /*
   * loads children into the database by importing an XML file
   */
  void importChildren() {
    Resource children_xml = ApplicationHolder.application.parentContext.getResource("assets/import/children.xml")
    if (children_xml.exists()) {
      log.info "$children_xml.description found. bootstrapping children"
      interfaceMaintenanceService.importChildren(children_xml.inputStream)
    }
    else {
      log.warn("children input xml at $children_xml.description not found. no children are bootstrapped")
    }
  }

  void createDefaultUsers() {
    log.info ("==> creating default users")
    EntityType etUser = metaDataService.etUser

    // system admin users
    if (!Entity.findByName('sueninosadmin')) {
      entityHelperService.createEntityWithUserAndProfile("sueninosadmin", etUser, "admin@sueninos.org", "Sueninos Admin") {Entity ent ->
        ent.user.addToAuthorities(metaDataService.systemAdminRole)
        ent.user.addToAuthorities(metaDataService.adminRole)
        ent.user.locale = new Locale ("de", "DE")
        UserProfile prf = (UserProfile)ent.profile
        prf.firstName = "Sueninos"
        prf.lastName = "Admin"
    }
    }

    // admin users
    if (!Entity.findByName('alexanderzeillinger')) {
      entityHelperService.createEntityWithUserAndProfile("alexanderzeillinger", etUser, "aaz@uenterprise.de", "Alexander Zeillinger") {Entity ent ->
        ent.user.addToAuthorities(metaDataService.adminRole)
        ent.user.locale = new Locale ("de", "DE")
        UserProfile prf = (UserProfile)ent.profile
        prf.firstName = "Alexander"
        prf.lastName = "Zeillinger"
      }
    }

    if (!Entity.findByName('patriziarosenkranz')) {
      entityHelperService.createEntityWithUserAndProfile("patriziarosenkranz", etUser, "pcr@lernardo.at", "Patrizia Rosenkranz") {Entity ent ->
        ent.user.addToAuthorities(metaDataService.adminRole)
         ent.user.locale = new Locale ("de", "DE")
        UserProfile prf = (UserProfile)ent.profile
        prf.firstName = "Patrizia"
        prf.lastName = "Rosenkranz"
      }
    }

    if (!Entity.findByName('danielszabo')) {
      entityHelperService.createEntityWithUserAndProfile("danielszabo", etUser, "dsz@lkult.at", "Daniel Szabo") {Entity ent ->
        ent.user.addToAuthorities(metaDataService.adminRole)
        ent.user.locale = new Locale ("de", "DE")
        UserProfile prf = (UserProfile)ent.profile
        prf.firstName = "Daniel"
        prf.lastName = "Szabo"
      }
    }

  }

  void createDefaultEducators() {
    log.info ("==> creating " + grailsApplication.config.dummies + " dummy educators")
    EntityType etEducator = metaDataService.etEducator

    Random generator = new Random()

    // ent.user.addToAuthorities(metaDataService.leadEducatorRole)

    for ( i in 1..grailsApplication.config.dummies ) {
      if (!Entity.findByName("dummyEducator" + i)) {
        entityHelperService.createEntityWithUserAndProfile("dummyEducator" + i, etEducator, "dummyEducator" + i + "@sueninos.org", "dummyEducator" + i) {Entity ent ->
          ent.user.locale = new Locale ("de", "DE")
          EducatorProfile prf = (EducatorProfile)ent.profile
          prf.gender = generator.nextInt(2) + 1
          prf.title = "DummyTitle"
          prf.firstName = "DummyFirstname"
          prf.lastName = "DummyLastName"
          prf.birthDate = new Date(generator.nextInt(20) + 60, generator.nextInt(12) + 1, generator.nextInt(28) + 1)
          prf.currentCountry = "DummyCountry"
          prf.currentZip = "1234"
          prf.currentCity = "DummyCity"
          prf.currentStreet = "DummyStreet"
          prf.originCountry = (generator.nextInt(8) + 1).toString()
          prf.originZip = "1234"
          prf.originCity = "DummyCity"
          prf.originStreet = "DummyStreet"
          prf.contactPhone = "1234"
          prf.contactCountry = "DummyCountry"
          prf.contactCity = "DummyCity"
          prf.contactStreet = "DummyStreet"
          prf.contactZip = "1345"
          prf.contactMail = "dummy@dummy.com"
          prf.education = (generator.nextInt(13) + 1).toString()
          prf.interests = "DummyInterests"
          prf.employment = "DummyEmployment"
          prf.addToLanguages((generator.nextInt(14) + 1).toString())
        }
      }
    }

  }

  void createDefaultParents() {
    log.info ("==> creating " + grailsApplication.config.dummies + " dummy parents")
    EntityType etParent = metaDataService.etParent

    Random generator = new Random()

    for ( i in 1..grailsApplication.config.dummies ) {
      if (!Entity.findByName("dummyParent" + i)) {
        entityHelperService.createEntityWithUserAndProfile("dummyParent" + i, etParent, "dummyParent" + i + "@sueninos.org", "dummyParent" + i) {Entity ent ->
          ent.user.locale = new Locale ("de", "DE")
          ParentProfile prf = (ParentProfile)ent.profile
          prf.firstName = "DummyFirstname"
          prf.lastName = "DummyLastName"
          prf.gender = generator.nextInt(2) + 1
          prf.currentCountry = (generator.nextInt(8) + 1).toString()
          prf.currentZip = "1234"
          prf.currentCity = "DummyCity"
          prf.currentStreet = "DummyStreet"
          prf.addToLanguages((generator.nextInt(14) + 1).toString())
          prf.birthDate = new Date(generator.nextInt(20) + 60, generator.nextInt(12) + 1, generator.nextInt(28) + 1)
          prf.maritalStatus = (generator.nextInt(7) + 1).toString()
          prf.education = (generator.nextInt(13) + 1).toString()
          prf.comment = "DummyComment"
          prf.job = generator.nextBoolean()
          if (prf.job) {
            prf.jobType = (generator.nextInt(14) + 1).toString()
            prf.jobIncome = generator.nextInt(150) + 50
            prf.jobFrequency = "DummyFrequency"
          }
        }
      }
    }

  }

  void createDefaultClients() {
    log.info ("==> creating " + grailsApplication.config.dummies + " dummy clients")
    EntityType etClient = metaDataService.etClient

    Random generator = new Random()

    for ( i in 1..grailsApplication.config.dummies ) {
      if (!Entity.findByName("dummyClient" + i)) {
        entityHelperService.createEntityWithUserAndProfile("dummyClient" + i, etClient, "dummyClient" + i + "@sueninos.org", "dummyClient" + i) {Entity ent ->
          ent.user.locale = new Locale ("de", "DE")
          ClientProfile prf = (ClientProfile)ent.profile
          prf.firstName = "DummyFirstname"
          prf.lastName = "DummyLastName"
          prf.gender = generator.nextInt(2) + 1
          prf.interests = "DummyInterests"
          prf.currentCountry = "DummyCountry"
          prf.currentZip = "1234"
          prf.currentCity = "DummyCity"
          prf.currentStreet = "DummyStreet"
          prf.originCountry = "DummyCountry"
          prf.originZip = "1234"
          prf.originCity = "DummyCity"
          prf.addToLanguages((generator.nextInt(14) + 1).toString())
          prf.birthDate = new Date(generator.nextInt(20) + 90, generator.nextInt(12) + 1, generator.nextInt(28) + 1)
          prf.schoolLevel = (generator.nextInt(13) + 1).toString()
          prf.size = generator.nextInt(130) + 50
          prf.weight = generator.nextInt(40) + 30
          prf.familyStatus = (generator.nextInt(4) + 1).toString()
          prf.job = generator.nextBoolean()
          if (prf.job) {
            prf.jobType = (generator.nextInt(14) + 1).toString()
            prf.jobIncome = generator.nextInt(150) + 50
            prf.jobFrequency = "DummyFrequency"
          }
          prf.support = generator.nextBoolean()
          if (prf.support)
            prf.supportDescription = "DummyDescription"
        }
      }
    }

  }

  void createDefaultChildren() {
    log.info ("==> creating " + grailsApplication.config.dummies + " dummy children")
    EntityType etChild = metaDataService.etChild

    Random generator = new Random()

    for ( i in 1..grailsApplication.config.dummies ) {
      if (!Entity.findByName("dummyChild" + i)) {
        entityHelperService.createEntityWithUserAndProfile("dummyChild" + i, etChild, "dummyChild" + i + "@sueninos.org", "dummyChild" + i) {Entity ent ->
          ent.user.locale = new Locale ("de", "DE")
          ChildProfile prf = (ChildProfile)ent.profile
          prf.firstName = "DummyFirstname"
          prf.lastName = "DummyLastName"
          prf.gender = generator.nextInt(2) + 1
          prf.birthDate = new Date(generator.nextInt(20) + 90, generator.nextInt(12) + 1, generator.nextInt(28) + 1)
          prf.job = generator.nextBoolean()
          if (prf.job) {
            prf.jobType = (generator.nextInt(14) + 1).toString()
            prf.jobIncome = generator.nextInt(150) + 50
            prf.jobFrequency = "DummyFrequency"
          }
        }
      }
    }

  }

  void createDefaultOperator() {
    log.info ("==> creating default operator")
    EntityType etOperator = metaDataService.etOperator

    if (!Entity.findByName('sueninos')) {
      entityHelperService.createEntityWithUserAndProfile ("sueninos", etOperator, "sueninos@sueninos.org", "Sueninos") {Entity ent->
        ent.user.locale = new Locale ("de", "DE")
        OperatorProfile prf = (OperatorProfile)ent.profile
        prf.zip = ""
        prf.city = ""
        prf.street = ""
        prf.phone = ""
        prf.description = ""
      }
    }

  }

  void createDefaultPartner() {
    log.info ("==> creating " + grailsApplication.config.dummies + " dummy partners")
    EntityType etPartner = metaDataService.etPartner

    Random generator = new Random()

    for ( i in 1..grailsApplication.config.dummies ) {
      if (!Entity.findByName("dummyPartner" + i)) {
        entityHelperService.createEntityWithUserAndProfile ("dummyPartner" + i, etPartner, "dummyPartner" + i + "@sueninos.org", "dummyPartner" + i) {Entity ent->
          ent.user.locale = new Locale ("de", "DE")
          PartnerProfile prf = (PartnerProfile)ent.profile
          prf.zip = "12345"
          prf.city = "DummyCity"
          prf.street = "DummyStreet"
          prf.phone = "DummyPhone"
          prf.description = "dummyDescription"
          prf.country = (generator.nextInt(8) + 1).toString()
          prf.website = "http://www.dummySite.com"
        }
      }
    }
    
  }

  void createDefaultPates() {
    log.info ("==> creating " + grailsApplication.config.dummies + " dummy pates")
    EntityType etPate = metaDataService.etPate

    Random generator = new Random()
    
    for ( i in 1..grailsApplication.config.dummies ) {
      if (!Entity.findByName("dummyPate" + i)) {
        entityHelperService.createEntityWithUserAndProfile ("dummyPate" + i, etPate, "dummyPate" + i + "@sueninos.org", "dummyPate" + i) {Entity ent->
          ent.user.locale = new Locale ("de", "DE")
          PateProfile prf = (PateProfile)ent.profile
          prf.firstName = "dummyFirstname"
          prf.lastName = "dummyLastname"
          prf.zip = "12345"
          prf.city = "DummyCity"
          prf.street = "DummyStreet"
          prf.country = (generator.nextInt(8) + 1).toString()
          prf.motherTongue = (generator.nextInt(14) + 1).toString()
        }
      }
    }

  }

  void createDefaultFacilities () {
    log.info ("==> creating " + grailsApplication.config.dummies + " dummy facilities")
    EntityType etFacility = metaDataService.etFacility

    for ( i in 1..grailsApplication.config.dummies ) {
      if (!Entity.findByName("dummyFacility" + i)) {
        entityHelperService.createEntityWithUserAndProfile ("dummyFacility" + i, etFacility, "dummyFacility" + i + "@sueninos.org", "DummyFacility" + i) {Entity ent->
          ent.user.locale = new Locale ("de", "DE")
          FacilityProfile prf = (FacilityProfile)ent.profile
          prf.country = "Mexiko"
          prf.zip = "12345"
          prf.city = "DummyCity"
          prf.street = "DummyStreet"
          prf.description = "DummyDescription"
        }
      }
    }

  }

  void createDefaultLinks () {
    log.info ("==> creating default links")

    def admin = Entity.findByName ('lernardoadmin')
    def alex = Entity.findByName ('alexanderzeillinger')
    def patrizia = Entity.findByName ('patriziarosenkranz')

    // make admin a friend of everyone
    List users = Entity.list()
    users.each {
      if (it.name != 'lernardoadmin') {
        new Link(source: it as Entity, target: admin, type: metaDataService.ltFriendship).save()
        new Link(source: admin, target: it as Entity, type: metaDataService.ltFriendship).save()
      }
    }

    // friend links - make alex the initiator via dynamic link attribute
    Link liap = linkHelperService.createLink(alex, patrizia, metaDataService.ltFriendship) {link, dad->
      dad.initiator = "true"
    }
    // back link does not (necessarily) has a dynattr
    new Link(source:patrizia, target:alex, type:metaDataService.ltFriendship).save()

    // here's how we would ask for the a dynattr (given the link)
    if (liap.das.initiator) {
      println "$liap.source.name has initiated the relationship"
    }

  }

  void createDefaultActivityTemplates() {
    log.info ("==> creating " + grailsApplication.config.dummies + " dummy templates")
    EntityType etTemplate = metaDataService.etTemplate

    Random generator = new Random()

    for ( i in 1..grailsApplication.config.dummies ) {
      if (!Entity.findByName("dummyTemplate" + i)) {
        entityHelperService.createEntity("dummyTemplate" + i, etTemplate) {Entity ent ->
          ent.profile = profileHelperService.createProfileFor(ent) as Profile
          ent.profile.fullName = "dummyTemplate" + i
          ent.profile.description = "dummyDescription"
          ent.profile.chosenMaterials = "dummyMaterials"
          ent.profile.socialForm = "DummySocialForm"
          ent.profile.amountEducators = generator.nextInt(3) + 1
          if (generator.nextInt(2) == 0)
            ent.profile.status = "fertig"
          else
            ent.profile.status = "in Bearbeitung"
          ent.profile.duration = generator.nextInt(50) + 10
          if (generator.nextInt(2) == 0)
            ent.profile.type = "normale Aktivitätsvorlage"
          else
            ent.profile.type = "Themenraumaktivitätsvorlage"
        }
      }
    }

  }

  void createDefaultComments() {
    log.info ("==> creating default comments")

    Comment comment = new Comment(content: 'DummyComment', creator: Entity.findByName('alexanderzeillinger').id).save()
    Entity entity = Entity.findByName("dummyTemplate1")
    entity.profile.addToComments(comment)

  }

  void createDefaultResources() {
    log.info ("==> creating " + grailsApplication.config.dummies + " dummy resources")
    EntityType etResource = metaDataService.etResource

    Random generator = new Random()

    for ( i in 1..grailsApplication.config.dummies ) {
      if (!Entity.findByName("dummyResource" + i)) {
        entityHelperService.createEntity("dummyResource" + i, etResource) {Entity ent ->
          ent.profile = profileHelperService.createProfileFor(ent) as Profile
          ent.profile.fullName = "dummyResource" + i
          ent.profile.description = "dummyDescription"
          if (generator.nextInt(2) == 0) {
            ent.profile.type = "planbar"
            ent.profile.classification = "dummyClassification"
          }
          else
            ent.profile.type = "verbrauchbar"
            ent.profile.classification = "dummyClassification"
        }
      }
    }

  }

  void createDefaultActivities() {
    log.info ("==> creating default activities")

    EntityType etActivity = metaDataService.etActivity

    if (!Entity.findByName('klettern')) {
      def entity = entityHelperService.createEntity("klettern", etActivity) {Entity ent ->
        ent.profile = profileHelperService.createProfileFor(ent) as Profile
        ent.profile.fullName = "Klettern"
        ent.profile.date = new Date()
        ent.profile.duration = 60
      }

      new Link(source: Entity.findByName('dummyEducator1'), target: entity, type: metaDataService.ltActEducator).save()
      new Link(source: Entity.findByName('dummyClient1'), target: entity, type: metaDataService.ltActClient).save()
      new Link(source: Entity.findByName('dummyFacility1'), target: entity, type: metaDataService.ltActFacility).save()
      new Link(source: Entity.findByName('dummyTemplate1'), target: entity, type: metaDataService.ltActTemplate).save()
      new Link(source: Entity.findByName('dummyEducator1'), target: entity, type: metaDataService.ltCreator).save()
      //new Link(source: Entity.findByName('martin'), target: entity, type: metaDataService.ltActResource).save()
    }
  }

  void createDefaultPosts() {
    log.info ("==> creating " + grailsApplication.config.dummies + " dummy posts")

    for ( i in 1..grailsApplication.config.dummies ) {
      new ArticlePost(title: 'DummyTitle' + i,
              teaser: 'DummyTeaser' + i,
              content: 'DummyContent' + i,
              author: Entity.findByName('dummyEducator1')).save()
    }

  }

  void createDefaultEvents() {
    log.info ("==> creating default events")

    functionService.createEvent(Entity.findByName('lernardoadmin'), 'Elternsprechtag').save()
  }

  void createDefaultHelpers() {
    log.info ("==> creating default helper")

    new Helper(title: 'Wie kann ich eine Aktivitätsvorlage erstellen?',
               content: '''Um eine Aktivitätsvorlage zu erstellen klicke zuerst auf "Aktivätsvorlagen" in der orangenen
                           Hauptnavigation. Dort findest du dann einen Button "Aktivitätsvorlage erstellen".''',
               type: metaDataService.etEducator.name).save()
    new Helper(title: 'Wie kann ich eine Aktivität planen?',
               content: '''Aktivitäten beruhen immer auf einer Aktivitätsvorlage. Klicke in der orangenen Hauptnavigation
                           auf "Aktivitätsvorlagen" und wähle dort eine Vorlage aus indem du auf dessen Namen klickst.
                           Im nächsten Schritt kannst du dann über den Button "Neue Aktivität planen" eine konkrete
                           Aktivität planen. Für jede Aktivität must du eine Einrichtung, Pädagogen und Betreute auswählen.''',
               type: metaDataService.etEducator.name).save()
    new Helper(title: 'Wie kann ich einen Artikel verfassen?',
               content: '''Artikel können direkt auf der Startseite verfasst werden. Klicke auf "Home" in der blauen
                           Navigationsleiste um dorthin zu gelangen und klicke auf den roten Link "Neuen Artikel verfassen".''',
               type: metaDataService.etEducator.name).save()
    new Helper(title: 'Wie kann ich jemandem eine Nachricht ins Postfach schicken?',
               content: '''Um jemandem eine Nachricht zu schicken musst du zuerst sein/ihr Profil besuchen. Dort findest
                           du dann links in der Seitennavigation den Punkt "Nachricht senden".''',
               type: metaDataService.etEducator.name).save()
    new Helper(title: 'Was ist das Netzwerk?',
               content: '''Im Netzwerk hast du eine Auflistung aller für dich relevanten User im ERP, wie deine Betreuten,
                           oder andere Pädagogen. Diese Liste kannst du selbst verwalten indem du andere Profile besuchst,
                           und dort Freunde oder Bookmarks hinzufügst.''',
               type: metaDataService.etEducator.name).save()
    new Helper(title: 'Wie kann ich eine Beurteilung eines Betreuten anlegen?',
               content: '''Besuche zuerst das Profil des Betreuten und klicke dort in der linken Seitennavigation auf
                           "Leistungsfortschritt anlegen".''',
               type: metaDataService.etEducator.name).save()

    new Helper(title: 'Wie kann ich einen Betreuten anlegen?',
               content: '''Betreute können über den Link "Betreuten anlegen" in der Seitennavigation links angelegt werden.
                           Notwendige Angaben müssen unbedingt ausgefüllt werden, zusätzliche Angaben sind optional und
                           können später noch über "Daten ändern" ergänzt oder geändert werden.''',
               type: metaDataService.etFacility.name).save()

    new Helper(title: 'Wie funktioniert die Anwesenheits-/Essensliste? (AE-Liste)',
           content: '''In der AE-Liste werden alle im Hort betreuten Kinder aufgelistet. Für jedes Kind kann die Anwesenheit,
                       sowie die Teilnahme am Mittagessen eingetragen werden. Daraus lässt sich dann die Summe der Anwesenden
                       und die Gesamtsumme der Essenbeiträge ausrechnen. Es besteht außerdem die Möglichkeit diese Liste als
                       PDF anzuzeigen und bequem ausdrucken zu lassen.''',
           type: metaDataService.etFacility.name).save()

    new Helper(title: 'Wo kann ich sämtliche Profile verwalten',
           content: '''Die Verwaltung für Betreiber befindet sich links in der Seitennavigation unter der Gruppe Administration.
                       Dort können folgende Profile verwaltet werden: Einrichtungen, Pädagogen, Betreute, Partner, Paten und
                       Erziehungsberechtigte.''',
           type: metaDataService.etOperator.name).save()
  }

  void createDefaultEvaluations() {
    log.info ("==> creating default evaluations")

    new Evaluation(owner: Entity.findByName('keanozeillinger'),
                   description: 'Keano zeigt eine leichte Leseschwäche, die besonders beim Lesen quantenphysikalischer Literatur zu bemerken sind.',
                   method: 'Als Maßnahme habe ich ihm mehrere Kinderbücher gegeben, damit tut er sich offensichtlich leichter.',
                   writer: Entity.findByName('christianszinicz')).save()
    new Evaluation(owner: Entity.findByName('kirazeillinger'),
                   description: 'Kira ist ein wahres Genie. Keine Aufgabe macht ihr Probleme und sie hat sehr viel Spaß. Ich glaube aber sie hat Symptome von Hyperaktivität.',
                   method: 'Ich möchte mit ihr verstärkt Interventionen machen, die weniger kopflastig sind.',
                   writer: Entity.findByName('christianszinicz')).save()
  }

  void createDefaultAttendances() {
    log.info ("==> creating default attendances")

    new Attendance(client: Entity.findByName('kirazeillinger'),
                   didAttend: true,
                   didEat: true,
                   date: new Date(2010-1900,01,07)).save()
    new Attendance(client: Entity.findByName('keanozeillinger'),
                   didAttend: true,
                   didEat: false,
                   date: new Date(2010-1900,01,07)).save()
  }

  void createDefaultFamilies() {
    log.info ("==> creating " + grailsApplication.config.dummies + " dummy families")
    EntityType etGroupFamily = metaDataService.etGroupFamily

    Random generator = new Random()

    for ( i in 1..grailsApplication.config.dummies ) {
      if (!Entity.findByName("dummyFamily" + i)) {
        Entity entity = entityHelperService.createEntity("dummyFamily" + i, etGroupFamily) {Entity ent ->
          ent.profile = profileHelperService.createProfileFor(ent) as Profile
          ent.profile.fullName = "dummyFamily" + i
          ent.profile.livingConditions = "dummyLivingConditions"
          ent.profile.socioeconomicData = "dummySocioeconomicData"
          ent.profile.otherInfo = "dummyOtherInfo"
          ent.profile.amountHousehold = generator.nextInt(4) + 1
          ent.profile.familyIncome = generator.nextInt(1500) + 500
        }

        // create some links to that group
        new Link(source: Entity.findByName("dummyParent" + i), target: entity, type: metaDataService.ltGroupMemberParent).save()
        new Link(source: Entity.findByName("dummyClient" + i), target: entity, type: metaDataService.ltGroupFamily).save()
        new Link(source: Entity.findByName("dummyChild" + i), target: entity, type: metaDataService.ltGroupMemberChild).save()
      }
    }
    
  }

  void createDefaultColonias() {
    log.info ("==> creating " + grailsApplication.config.dummies + " dummy colonias")
    EntityType etGroupColony = metaDataService.etGroupColony

    for ( i in 1..grailsApplication.config.dummies ) {
      if (!Entity.findByName("dummyColonia" + i)) {
        Entity entity = entityHelperService.createEntity("dummyColonia" + i, etGroupColony) {Entity ent ->
          ent.profile = profileHelperService.createProfileFor(ent) as Profile
          ent.profile.fullName = "dummyColonia" + i
          ent.profile.description = "dummyDescription"
        }

        // create some links to that group
        new Link(source: Entity.findByName("dummyFacility"+i), target: entity, type: metaDataService.ltGroupMemberFacility).save()
        new Link(source: Entity.findByName("dummyEducator"+i), target: entity, type: metaDataService.ltGroupMemberEducator).save()
        new Link(source: Entity.findByName("dummyPartner"+i), target: entity, type: metaDataService.ltGroupMemberPartner).save()
      }
    }

  }

  void createDefaultMethods() {
    log.info ("==> creating 2 dummy methods")

    for ( i in 1..2 ) {
      if (!Method.findByName("dummyMethod" + i)) {
        Method method = new Method(name: "dummyMethod" + i, description: "dummyDescription", type: "template").save()

        method.addToElements(new Element(name: "dummyElement1"))
        method.addToElements(new Element(name: "dummyElement2"))
        method.addToElements(new Element(name: "dummyElement3"))
        method.addToElements(new Element(name: "dummyElement4"))
        method.addToElements(new Element(name: "dummyElement5"))
      }
    }

  }

  void createDefaultClientGroups() {
    log.info ("==> creating " + grailsApplication.config.dummies + " dummy client groups")
    EntityType etGroupClient = metaDataService.etGroupClient

    Random generator = new Random()

    for ( i in 1..grailsApplication.config.dummies ) {
      if (!Entity.findByName("dummyClientGroup" + i)) {
        Entity entity = entityHelperService.createEntity("dummyClientGroup" + i, etGroupClient) {Entity ent ->
          ent.profile = profileHelperService.createProfileFor(ent) as Profile
          ent.profile.fullName = "dummyClientGroup" + i
          ent.profile.description = "dummyDescription"
        }

        // create some links to that group
        def links = generator.nextInt(8) + 2 // amount of clients to add
        List clients = []
        for ( j in 1..links ) {
          def done = false
          while (!done) {
            def client = generator.nextInt(20) + 1
            if (!clients.contains(client)) {
              clients << client
              done = true
            }
          }
        }
        clients.each {
          new Link(source: Entity.findByName("dummyClient" + it), target: entity, type: metaDataService.ltGroupMemberClient).save()
        }
      }
    }

  }

  void createDefaultActivityTemplateGroups() {
    log.info ("==> creating default activitytemplategroups")

    EntityType etGroupActivityTemplate = metaDataService.etGroupActivityTemplate

    Entity entity = entityHelperService.createEntity("group", etGroupActivityTemplate) {Entity ent ->
      ent.profile = profileHelperService.createProfileFor(ent) as Profile
      ent.profile.fullName = "Vorlagengruppe 1"
      ent.profile.description = ""
      ent.profile.status = "fertig"
      ent.profile.realDuration = 60
    }

    // create some links to that group
    new Link(source: Entity.findByName('weidemithindernissen'), target: entity, type: metaDataService.ltGroupMember).save()
    new Link(source: Entity.findByName('tanzen'), target: entity, type: metaDataService.ltGroupMember).save()
  }

  void createDefaultThemes() {
    log.info ("==> creating default themes")

    EntityType etTheme = metaDataService.etTheme

    Entity theme = entityHelperService.createEntity("theme", etTheme) {Entity ent ->
      ent.profile = profileHelperService.createProfileFor(ent) as Profile
      ent.profile.fullName = "Thema 1"
      ent.profile.description = ""
      ent.profile.type = "Thema"
      ent.profile.startDate = new Date(2010-1900,01,01)
      ent.profile.endDate = new Date(2010-1900,11,01)
    }

    // link theme to facility
    new Link(source: theme, target: Entity.findByName('dummyFacility0'), type: metaDataService.ltThemeOfFacility).save()

    Entity subtheme = entityHelperService.createEntity("theme", etTheme) {Entity ent ->
      ent.profile = profileHelperService.createProfileFor(ent) as Profile
      ent.profile.fullName = "Subthema 1"
      ent.profile.description = ""
      ent.profile.type = "Subthema"
      ent.profile.startDate = new Date(2010-1900,05,01)
      ent.profile.endDate = new Date(2010-1900,07,01)
    }

    // link subtheme to theme
    new Link(source: subtheme, target: theme, type: metaDataService.ltSubTheme).save()
    // link subtheme to facility
    new Link(source: subtheme, target: Entity.findByName('dummyFacility0'), type: metaDataService.ltThemeOfFacility).save()
  }

  void createDefaultProjectTemplates() {
    log.info ("==> creating " + grailsApplication.config.dummies + " dummy project templates")
    EntityType etProjectTemplate = metaDataService.etProjectTemplate

    Random generator = new Random()
    
    for ( i in 1..grailsApplication.config.dummies ) {
      if (!Entity.findByName("dummyProjectTemplate" + i)) {
        entityHelperService.createEntity("dummyProjectTemplate" + i, etProjectTemplate) {Entity ent ->
          ent.profile = profileHelperService.createProfileFor(ent) as Profile
          ent.profile.fullName = "dummyProjectTemplate" + i
          ent.profile.description = "dummyDescription"
          if (generator.nextInt(2) == 0)
            ent.profile.status = "fertig"
          else
            ent.profile.status = "in Bearbeitung"
        }
      }
    }
        
  }

  void createDefaultTags () {
    log.info ("==> creating default tags")

    if (!Tag.findByName('abwesend'))
      new Tag(name: 'abwesend').save()
    if (!Tag.findByName('krank'))
      new Tag(name: 'krank').save()
  }

}