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

class BootStrap {
  DefaultObjectService defaultObjectService
  EntityHelperService entityHelperService
  MetaDataService metaDataService
  FunctionService functionService
  ProfileHelperService profileHelperService
  InterfaceMaintenanceService interfaceMaintenanceService

  def init = {servletContext ->
    defaultObjectService.onEmptyDatabase {
      metaDataService.initialize()
      createDefaultUsers()
      createDefaultOperator()
      createDefaultFacilities()
      createDefaultEducators()

      //createDefaultLinks()

      importChildren()

      if (GrailsUtil.environment == "development") {
        createDefaultActivityTemplates()
        //createDefaultActivities()
        createDefaultColonias()
        createDefaultParents()
        createDefaultClients()
        createDefaultChilds()
        createDefaultPosts()
        createDefaultPartner()
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
      }

      createDefaultHelpers()
      //createDefaultEvaluations()
    }
  }

  def destroy = {
  }

  void importChildren() {
    Resource children_xml = ApplicationHolder.application.parentContext.getResource("assets/import/children.xml")
    if (children_xml.exists()) {
      log.debug "$children_xml.description found. bootstrapping children"
      interfaceMaintenanceService.importChildren(children_xml.inputStream)
    }
    else {
      log.warn("children input xml at $children_xml.description not found. no children are bootstrapped")
    }
  }

  void createDefaultUsers() {
    log.debug ("==> creating default users")
    EntityType etUser = metaDataService.etUser

    // system admin users
    entityHelperService.createEntityWithUserAndProfile("sueninosadmin", etUser, "admin@sueninos.org", "Sueninos Admin") {Entity ent ->
      ent.user.addToAuthorities(metaDataService.systemAdminRole)
      ent.user.addToAuthorities(metaDataService.adminRole)
      ent.user.locale = new Locale ("de", "DE")
      UserProfile prf = (UserProfile)ent.profile
      prf.firstName = "Sueninos"
      prf.lastName = "Admin"
    }

    // admin users
    entityHelperService.createEntityWithUserAndProfile("alexanderzeillinger", etUser, "aaz@uenterprise.de", "Alexander Zeillinger") {Entity ent ->
      ent.user.addToAuthorities(metaDataService.adminRole)
      ent.user.locale = new Locale ("de", "DE")
      UserProfile prf = (UserProfile)ent.profile
      prf.firstName = "Alexander"
      prf.lastName = "Zeillinger"
    }

    entityHelperService.createEntityWithUserAndProfile("patriziarosenkranz", etUser, "pcr@lernardo.at", "Patrizia Rosenkranz") {Entity ent ->
      ent.user.addToAuthorities(metaDataService.adminRole)
       ent.user.locale = new Locale ("de", "DE")
      UserProfile prf = (UserProfile)ent.profile
      prf.firstName = "Patrizia"
      prf.lastName = "Rosenkranz"
    }

    entityHelperService.createEntityWithUserAndProfile("danielszabo", etUser, "dsz@lkult.at", "Daniel Szabo") {Entity ent ->
      ent.user.addToAuthorities(metaDataService.adminRole)
      ent.user.locale = new Locale ("de", "DE")
      UserProfile prf = (UserProfile)ent.profile
      prf.firstName = "Daniel"
      prf.lastName = "Szabo"
    }

    entityHelperService.createEntityWithUserAndProfile("kurtludikovsky", etUser, "kll@lkult.at", "Kurt Ludikovsky") {Entity ent ->
      ent.user.addToAuthorities(metaDataService.adminRole)
      ent.user.locale = new Locale ("de", "DE")
      UserProfile prf = (UserProfile)ent.profile
      prf.firstName = "Kurt"
      prf.lastName = "Ludikovsky"
    }
  }

  void createDefaultEducators() {
    log.debug ("==> creating default educators")
    EntityType etEducator = metaDataService.etEducator

    // admin users
    entityHelperService.createEntityWithUserAndProfile("christianszinicz", etEducator, "christian@sueninos.org", "Christian Szinicz") {Entity ent ->
      //ent.user.addToAuthorities(metaDataService.adminRole)
      ent.user.addToAuthorities(metaDataService.leadEducatorRole)
      ent.user.locale = new Locale ("es", "ES")
      EducatorProfile prf = (EducatorProfile)ent.profile
      prf.gender = 1
      prf.title = "DI"
      prf.birthDate = new Date(1968-1900,02,18)
      prf.currentCountry = "Mexiko"
      prf.currentZip = "29215"
      prf.currentCity = "San Cristóbal de Las Casas"
      prf.currentStreet = "Av. Norte Oriente 13a"
      prf.originCountry = "1"
      prf.originZip = ""
      prf.originCity = ""
      prf.originStreet = ""
      prf.contactPhone = ""
      prf.contactCountry = ""
      prf.contactCity = ""
      prf.contactStreet = ""
      prf.contactZip = ""
      prf.contactMail = ""
      prf.education = ""
      prf.firstName = "Christian"
      prf.lastName = "Szinicz"
      prf.interests = ""
      prf.employment = ""
      prf.addToLanguages("1")
    }

    entityHelperService.createEntityWithUserAndProfile("ludwigszinicz", etEducator, "ludwig@sueninos.org", "Ludwig Szinicz") {Entity ent ->
      ent.user.addToAuthorities(metaDataService.adminRole)
      ent.user.locale = new Locale ("es", "ES")
      EducatorProfile prf = (EducatorProfile)ent.profile
      prf.gender = 1
      prf.title = "Ing. Dkfm."
      prf.birthDate = new Date(1939-1900,04,17)
      prf.currentCountry = "Mexiko"
      prf.currentZip = "4600"
      prf.currentCity = "Schleißheim bei Wels"
      prf.currentStreet = ""
      prf.originCountry = "1"
      prf.originZip = ""
      prf.originCity = ""
      prf.originStreet = ""
      prf.contactPhone = ""
      prf.contactCountry = ""
      prf.contactCity = ""
      prf.contactStreet = ""
      prf.contactZip = ""
      prf.contactMail = ""
      prf.education = ""
      prf.firstName = "Ludwig"
      prf.lastName = "Szinicz"
      prf.interests = ""
      prf.employment = ""
      prf.addToLanguages("1")
    }
  }

  void createDefaultParents() {
    log.debug ("==> creating default parents")
    EntityType etParent = metaDataService.etParent

    entityHelperService.createEntityWithUserAndProfile("sabinezeillinger", etParent, "sabine@sueninos.org", "Sabine Zeillinger") {Entity ent ->
      ent.user.locale = new Locale ("de", "DE")
      ParentProfile prf = (ParentProfile)ent.profile
      prf.firstName = "Sabine"
      prf.lastName = "Zeillinger"
      prf.gender = 2
      prf.currentCountry = "Österreich"
      prf.currentZip = "2352"
      prf.currentCity = "Gumpoldskirchen"
      prf.currentStreet = ""
      prf.addToLanguages("1")
      prf.birthDate = new Date()
      prf.job = false
      prf.maritalStatus = ""
      prf.education = "1"
      prf.comment = "Best parent ever!"
    }
  }

  void createDefaultClients() {
    log.debug ("==> creating default clients")
    EntityType etClient = metaDataService.etClient

    entityHelperService.createEntityWithUserAndProfile("kirazeillinger", etClient, "kira@sueninos.org", "Kira Zeillinger") {Entity ent ->
      ent.user.locale = new Locale ("de", "DE")
      ClientProfile prf = (ClientProfile)ent.profile
      prf.firstName = "Kira"
      prf.lastName = "Zeillinger"
      prf.gender = 2
      prf.interests = ""
      prf.currentCountry = "Österreich"
      prf.currentZip = "2352"
      prf.currentCity = "Gumpoldskirchen"
      prf.currentStreet = ""
      prf.originCountry = "Österreich"
      prf.originZip = "2352"
      prf.originCity = "Gumpoldskirchen"
      prf.addToLanguages("1")
      prf.birthDate = new Date()
      prf.schoolLevel = 1
      prf.size = 120
      prf.weight = 120
      prf.job = false
      prf.familyStatus = "1"
    }

    entityHelperService.createEntityWithUserAndProfile("keanozeillinger", etClient, "keano@sueninos.org", "Keano Zeillinger") {Entity ent ->
      ent.user.locale = new Locale ("de", "DE")
      ClientProfile prf = (ClientProfile)ent.profile
      prf.firstName = "Keano"
      prf.lastName = "Zeillinger"
      prf.gender = 1
      prf.interests = ""
      prf.currentCountry = "Österreich"
      prf.currentZip = "2352"
      prf.currentCity = "Gumpoldskirchen"
      prf.currentStreet = ""
      prf.originCountry = "Österreich"
      prf.originZip = "2352"
      prf.originCity = "Gumpoldskirchen"
      prf.addToLanguages("1")
      prf.birthDate = new Date()
      prf.schoolLevel = 1
      prf.size = 120
      prf.weight = 120
      prf.job = false
      prf.familyStatus = "1"
    }
  }

  void createDefaultChilds() {
    log.debug ("==> creating default children")
    EntityType etChild = metaDataService.etChild

    entityHelperService.createEntityWithUserAndProfile("karinzeillinger", etChild, "karin@sueninos.org", "Karin Zeillinger") {Entity ent ->
      ent.user.locale = new Locale ("de", "DE")
      ChildProfile prf = (ChildProfile)ent.profile
      prf.firstName = "Karin"
      prf.lastName = "Zeillinger"
      prf.gender = 2
      prf.birthDate = new Date()
      prf.job = false
    }
  }

  void createDefaultOperator() {
    log.debug ("==> creating default operator")
    EntityType etOperator = metaDataService.etOperator

    entityHelperService.createEntityWithUserAndProfile ("sueninos", etOperator, "sueninos@sueninos.org", "Sueninos") {Entity ent->
      ent.user.locale = new Locale ("de", "DE")
      ent.user.addToAuthorities(metaDataService.adminRole)
      OperatorProfile prf = (OperatorProfile)ent.profile
      prf.zip = ""
      prf.city = ""
      prf.street = ""
      prf.phone = ""
      prf.description = ""
    }
  }

  void createDefaultPartner() {
    log.debug ("==> creating default partners")
    EntityType etPartner = metaDataService.etPartner

    entityHelperService.createEntityWithUserAndProfile ("raiffeisenbank", etPartner, "raika@sueninos.org", "Raiffeisen Bank") {Entity ent->
      ent.user.locale = new Locale ("de", "DE")
      PartnerProfile prf = (PartnerProfile)ent.profile
      prf.zip = ""
      prf.city = ""
      prf.street = ""
      prf.phone = ""
      prf.description = ""
      prf.country = "1"
      prf.website = ""
    }
  }

  void createDefaultFacilities () {
    log.debug ("==> creating default facilities")
    EntityType etFacility = metaDataService.etFacility

    entityHelperService.createEntityWithUserAndProfile ("sueninoszentrum", etFacility, "sueninoszentrum@sueninos.org", "Sueninos Zentrum") {Entity ent->
      ent.user.locale = new Locale ("de", "DE")
      FacilityProfile prf = (FacilityProfile)ent.profile
      prf.country = "Mexiko"
      prf.zip = "29247"
      prf.city = "	San Cristóbal de Las Casas"
      prf.street = "	Prolongación Ramón Larrainzar #139"
      prf.description = ""
    }
  }

  void createDefaultLinks () {
    log.debug ("==> creating default links")

    def admin = Entity.findByName ('lernardoadmin')
    def alex = Entity.findByName ('alexanderzeillinger')
    def patrizia = Entity.findByName ('patriziarosenkranz')

    // make admin a friend of everyone
    List users = Entity.list()
    users.each {
      if (it.name != 'lernardoadmin') {
        new Link(source: it, target: admin, type: metaDataService.ltFriendship).save()
        new Link(source: admin, target: it, type: metaDataService.ltFriendship).save()
      }
    }

    // friend links
    new Link(source:alex, target:patrizia, type:metaDataService.ltFriendship).save()
    new Link(source:patrizia, target:alex, type:metaDataService.ltFriendship).save()
  }

  void createDefaultActivityTemplates() {
    log.debug ("==> creating default templates")

    EntityType etTemplate = metaDataService.etTemplate

    entityHelperService.createEntity("weidemithindernissen", etTemplate) {Entity ent ->
      ent.profile = profileHelperService.createProfileFor(ent) as Profile
      ent.profile.fullName = "Weide mit Hindernissen"
      ent.profile.description = "Die Bänke werden in Reihen aufgestellt; es können möglichst viele Bewegungsformen ausprobiert werden"
      ent.profile.chosenMaterials = "Holzbänke"
      ent.profile.socialForm = "Großgruppe (bis 15 Kinder)"
      ent.profile.amountEducators = 2
      ent.profile.status = "fertig"
      ent.profile.duration = 30
      ent.profile.type = "normale Aktivitätsvorlage"
    }

    entityHelperService.createEntity("tanzen", etTemplate) {Entity ent ->
      ent.profile = profileHelperService.createProfileFor(ent) as Profile
      ent.profile.fullName = "Tanzen"
      ent.profile.description = "Die Kinder tanzen im Kreis"
      ent.profile.chosenMaterials = "Springschnüre"
      ent.profile.socialForm = "Großgruppe (bis 15 Kinder)"
      ent.profile.amountEducators = 1
      ent.profile.status = "fertig"
      ent.profile.duration = 10
      ent.profile.type = "Themenraumaktivitätsvorlage"
    }
  }

  void createDefaultComments() {
    log.debug ("==> creating default comments")

    Comment comment = new Comment(content: 'Ich bin ein Kommentar', creator: Entity.findByName('alexanderzeillinger').id).save()

    Entity entity = Entity.findByName('tanzen')

    entity.profile.addToComments(comment)

  }

  void createDefaultResources() {
    log.debug ("==> creating default resources")

    EntityType etResource = metaDataService.etResource

    entityHelperService.createEntity("klavier", etResource) {Entity ent ->
      ent.profile = profileHelperService.createProfileFor(ent) as Profile
      ent.profile.fullName = "Klavier"
      ent.profile.description = "Ein echtes Bechstein Klavier!"
      ent.profile.type = "planbar"
      ent.profile.classification = "Diese Ressource ist nur für diese Einrichtung verfügbar."
    }
  }

  void createDefaultActivities() {
    log.debug ("==> creating default activities")

     EntityType etActivity = metaDataService.etActivity

      def entity = entityHelperService.createEntity("klettern", etActivity) {Entity ent ->
        ent.profile = profileHelperService.createProfileFor(ent) as Profile
        ent.profile.fullName = "Klettern"
        ent.profile.date = new Date()
        ent.profile.duration = 60
      }

      new Link(source: Entity.findByName('christianszinicz'), target: entity, type: metaDataService.ltActEducator).save()
      new Link(source: Entity.findByName('keanozeillinger'), target: entity, type: metaDataService.ltActClient).save()
      new Link(source: Entity.findByName('sueninoszentrum'), target: entity, type: metaDataService.ltActFacility).save()
      new Link(source: Entity.findByName('weidemithindernissen'), target: entity, type: metaDataService.ltActTemplate).save()
      new Link(source: Entity.findByName('christianszinicz'), target: entity, type: metaDataService.ltCreator).save()
      //new Link(source: Entity.findByName('martin'), target: entity, type: metaDataService.ltActResource).save()
  }

  void createDefaultPosts() {
    log.debug ("==> creating default posts")

    new ArticlePost(title:'Lernardo im Hort Kaumberg',
            teaser:'''Mit Beginn September 2009 erweitert Lernardo aufgrund der hohen Nachfrage und positiven
            Resonanz seine Einrichtungen mit einem neuen Standort in Kaumberg.''',
            content:'''Dank Kaumberg's Bürgermeister Michael Singraber konnte im Sommer 2009 sehr schnell
            passende Räumlichkeiten gefunden werden. Zur Verfügung gestellt wurde ein Klassenraum der Volksschule
            Kaumberg in dem ca. 10 Kinder zwischen 7 und 10 Jahre betreut werden. Der Beginn erfolgt am 07.
            September, als Hortleiterin wird Hannah Mutzbauer eingesetzt, die sich bereits in Hort Löwenzahn
            bewährt hat. Den Kindern stehen neben dem Klassenraum die Wiese sowie die Freizeitanlage der Schule
            zur vollen Verfügung.''',
            author:Entity.findByName('christianszinicz')).save()
    new ArticlePost(title:'Gesund durch Ernährungsexpertin',
            teaser:'''Hort Löwenzahn freut sich über die Unterstützung durch Birgit Blaesen, einer
            Ernährungsexpertin mit langjähriger Erfahrung, die das Pädagogen Team im Hinblick auf die optimale
            und vielseitige Ernährung der Kinder unterstützen wird.''',
            content:'''Birgit Blaesen absolvierte 1997 bis 1998 die makrobiotische Kochschule in Schweden
            und erweiterte ihr Fachwissen in den darauf folgenden Jahren mit der Ausbildung in traditioneller
            chinesischer Medizin. Von 2002 bis 2003 absolvierte sie die Ausbildung zur Ernährungsberaterin in
            der Wiener Schule für TCM. Zu ihren weiteren Kenntnissen gehört Shiatsu, Zen und Naikan und Ashtanga
            Yoga. Zu ihren bisherigen beruflichen Tätigkeiten zählen u.A. die makrobiotische Küchenleitung im
            Technischen Verlag der Uni Graz, die Unternehmensgründung von "Buntes Brot" im Juni 2001,
            Ernährungprojekt "besser essen - besser leben", diverse Tätigkeiten im Shiatsu Bereich, sowie
            Gründung und Leitung eines Gesundheitszentrums in Pottenstein in 2009.''',
            author:Entity.findByName('christianszinicz')).save()
    new ArticlePost(title:'Hort Löwenzahn erhält Auszeichnung',
            teaser:'''Beim 4. jährlichen Kinderbetreuungspreis organisiert vom Bundesministerium für Wirtschaft,
            Familie und Jugend erhielt der Hort "Löwenzahn Weissenbach" den 4. Preis und eine Prämie von
            €500,-.''',
            content:'''Der Ferienhort Löwenzahn wird für die Sommerferien den Kindern in der Region Triestingtal
            und im Speziellen den Kindern der Marktgemeinde Weissenbach angeboten. Es bietet ein
            abwechslungsreiches Programm für 6-13 Jährige: Themen wie woher kommt das Essen; das Wasser lebt;
            Ferien am Pool; das magische Baumhaus; Natur als Klettergarten; Lernen und Spielen werden behandelt
            bzw. erlebt. Lernen und Spielen versteht sich während der letzten beiden Ferienwochen als
            Vorbereitung für das kommende Schuljahr. Bei diesem Ferienhort gibt es sogar einen sogenannten Tag
            der Ruhe, an dem die Kinder selber entscheiden können, was sie machen möchten. Am 31.8 gibt es einen
            Abschlussausflug in den Märchenpark St. Margarethen.''',
            author:Entity.findByName('christianszinicz')).save()
  }

  void createDefaultEvents() {
    log.debug ("==> creating default events")

    functionService.createEvent(Entity.findByName('lernardoadmin'), 'Elternsprechtag').save()
  }

  void createDefaultHelpers() {
    log.debug ("==> creating default helper")

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
    log.debug ("==> creating default evaluations")

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
    log.debug ("==> creating default attendances")

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
    log.debug ("==> creating default families")

    EntityType etGroupFamily = metaDataService.etGroupFamily

    Entity entity = entityHelperService.createEntity("group", etGroupFamily) {Entity ent ->
      ent.profile = profileHelperService.createProfileFor(ent) as Profile
      ent.profile.fullName = "Zeillinger"
      ent.profile.livingConditions = """Leben in einem soliden österreichischen Mehrfamilienwohnhaus. Alexander Zeillinger erhält ein
                                     ausreichendes Einkommen und Sabine Zeillinger kümmert sich um den Haushalt."""
      ent.profile.socioeconomicData = "Alles in Ordnung"
      ent.profile.otherInfo = """Familie Zeillinger besitzt 2 Katzen und 2 Autos"""
      ent.profile.amountHousehold = 2
      ent.profile.familyIncome = 1540
    }

    // create some links to that group
    new Link(source: Entity.findByName('alexanderzeillinger'), target: entity, type: metaDataService.ltGroupMember).save()
    new Link(source: Entity.findByName('keanozeillinger'), target: entity, type: metaDataService.ltGroupMember).save()
    new Link(source: Entity.findByName('kirazeillinger'), target: entity, type: metaDataService.ltGroupMember).save()
  }

  void createDefaultColonias() {
    log.debug ("==> creating default colonias")

    EntityType etGroupColony = metaDataService.etGroupColony

    Entity entity = entityHelperService.createEntity("group", etGroupColony) {Entity ent ->
      ent.profile = profileHelperService.createProfileFor(ent) as Profile
      ent.profile.fullName = "Gumpoldskirchen"
      ent.profile.description = """Eine kleine Colonia im Süden von Wien"""
    }

    // create some links to that group
    new Link(source: Entity.findByName('sueninoszentrum'), target: entity, type: metaDataService.ltGroupMember).save()
  }

  void createDefaultMethods() {
    log.debug ("==> creating default methods")

    Method method = new Method(name: "5 Säulen", description: "", type: "template").save()

    method.addToElements(new Element(name: "Bewegung & Ernährung"))
    method.addToElements(new Element(name: "Handwerk & Kunst"))
    method.addToElements(new Element(name: "Persönliche Kompetenz"))
    method.addToElements(new Element(name: "Soziale und emotionale Intelligenz"))
    method.addToElements(new Element(name: "Lernen lernen"))
    method.addToElements(new Element(name: "Teilleistungstraining"))   
  }

  void createDefaultClientGroups() {
    log.debug ("==> creating default clientgroups")

    EntityType etGroupClient = metaDataService.etGroupClient

    Entity entity = entityHelperService.createEntity("group", etGroupClient) {Entity ent ->
      ent.profile = profileHelperService.createProfileFor(ent) as Profile
      ent.profile.fullName = "Betreutengruppe Rot"
      ent.profile.description = ""
    }

    // create some links to that group
    new Link(source: Entity.findByName('keanozeillinger'), target: entity, type: metaDataService.ltGroupMemberClient).save()
    new Link(source: Entity.findByName('kirazeillinger'), target: entity, type: metaDataService.ltGroupMemberClient).save()
  }

  void createDefaultActivityTemplateGroups() {
    log.debug ("==> creating default activitytemplategroups")

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
    log.debug ("==> creating default themes")

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
    new Link(source: theme, target: Entity.findByName('sueninoszentrum'), type: metaDataService.ltThemeOfFacility).save()

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
    new Link(source: subtheme, target: Entity.findByName('sueninoszentrum'), type: metaDataService.ltThemeOfFacility).save()
  }

  void createDefaultProjectTemplates() {
    log.debug ("==> creating default projectTemplate")

    EntityType etProjectTemplate = metaDataService.etProjectTemplate

    entityHelperService.createEntity("projectTemplate", etProjectTemplate) {Entity ent ->
      ent.profile = profileHelperService.createProfileFor(ent) as Profile
      ent.profile.fullName = "Projektvorlage 1"
      ent.profile.description = "keine Beschreibung"
      ent.profile.status = "fertig"
    }
  }

}