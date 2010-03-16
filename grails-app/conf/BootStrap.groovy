import de.uenterprise.ep.EntityType
import de.uenterprise.ep.Entity
import de.uenterprise.ep.Link

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

class BootStrap {
  def defaultObjectService
  def entityHelperService
  def metaDataService
  def functionService
  def profileHelperService

  def init = {servletContext ->
    defaultObjectService.onEmptyDatabase {
      metaDataService.initialize()
      createDefaultUsers()
      createDefaultEducators()
      createDefaultOperators()
      createDefaultFacilities()
      //createDefaultLinks()
      createDefaultTemplates()
      createDefaultComments()
      createDefaultResources()

      if (GrailsUtil.environment == "development") {
        createDefaultActivities()
        createDefaultClients()
        createDefaultPosts()
        createDefaultEvents()
        createDefaultAttendances()
        //createDefaultGroups()
      }

      createDefaultHelpers()
      createDefaultEvaluations()
    }
  }
  

  def destroy = {
  }

  void createDefaultUsers() {
    log.debug ("==> creating default users")
    EntityType etUser = metaDataService.etUser

    // system admin users
    entityHelperService.createEntityWithUserAndProfile("lernardoadmin", etUser, "admin@lernardo.at", "Lernardo Admin") {Entity ent ->
      ent.user.addToAuthorities(metaDataService.systemAdminRole)
      UserProfile prf = ent.profile
      prf.firstName = "Lernardo"
      prf.lastName = "Admin"
    }

    // admin users
    entityHelperService.createEntityWithUserAndProfile("alexanderzeillinger", etUser, "aaz@uenterprise.de", "Alexander Zeillinger") {Entity ent ->
      ent.user.addToAuthorities(metaDataService.adminRole)
      //ent.user.locale = new Locale ("es", "ES")
      UserProfile prf = ent.profile
      prf.firstName = "Alexander"
      prf.lastName = "Zeillinger"
    }

    entityHelperService.createEntityWithUserAndProfile("patriziarosenkranz", etUser, "pcr@lernardo.at", "Patrizia Rosenkranz") {Entity ent ->
      ent.user.addToAuthorities(metaDataService.adminRole)
      UserProfile prf = ent.profile
      prf.firstName = "Patrizia"
      prf.lastName = "Rosenkranz"
    }

    entityHelperService.createEntityWithUserAndProfile("danielszabo", etUser, "dsz@lernardo.at", "Daniel Szabo") {Entity ent ->
      ent.user.addToAuthorities(metaDataService.adminRole)
      UserProfile prf = ent.profile
      prf.firstName = "Daniel"
      prf.lastName = "Szabo"
    }

    // mod users
    entityHelperService.createEntityWithUserAndProfile("susannestiedl", etUser, "sst@lernardo.at", "Susanne Stiedl") {Entity ent ->
      ent.user.addToAuthorities(metaDataService.modRole)
      UserProfile prf = ent.profile
      prf.firstName = "Susanne"
      prf.lastName = "Stiedl"
    }

    // regular users
    entityHelperService.createEntityWithUserAndProfile("johanneszeitelberger", etUser, "jlz@lernardo.at", "Johannes L. Zeitelberger") {Entity ent ->
      UserProfile prf = ent.profile
      prf.firstName = "Johannes L."
      prf.lastName = "Zeitelberger"
    }

  }

  void createDefaultEducators() {
    log.debug ("==> creating default educators")
    EntityType etEducator = metaDataService.etEducator

    // admin users
    entityHelperService.createEntityWithUserAndProfile("christiansczinicz", etEducator, "christian@sueninos.org", "Christian Szinicz") {Entity ent ->
      ent.user.addToAuthorities(metaDataService.adminRole)
      EducatorProfile prf = ent.profile
      prf.gender = 1
      prf.title = "DI"
      prf.birthDate = new Date(1968-1900,02,18)
      prf.PLZ = 29215
      prf.city = "San Cristóbal de Las Casas"
      prf.street = "Av. Norte Oriente 13a"
      prf.contact = ""
      prf.education = ""
      prf.employed = true
      prf.firstName = "Christian"
      prf.lastName = "Szinicz"
      prf.function = ""
      prf.interests = ""
      prf.joinDate = new Date()
      prf.languages = "Deutsch"
      prf.nationality = "Österreich"
    }

    entityHelperService.createEntityWithUserAndProfile("ludwigszinicz", etEducator, "ludwig@sueninos.org", "Ludwig Szinicz") {Entity ent ->
      ent.user.addToAuthorities(metaDataService.adminRole)
      EducatorProfile prf = ent.profile
      prf.gender = 1
      prf.title = "Ing. Dkfm."
      prf.birthDate = new Date(1939-1900,04,17)
      prf.PLZ = 4600
      prf.city = "Schleißheim bei Wels"
      prf.street = ""
      prf.contact = ""
      prf.education = ""
      prf.employed = false
      prf.firstName = "Ludwig"
      prf.lastName = "Szinicz"
      prf.function = ""
      prf.interests = ""
      prf.joinDate = new Date()
      prf.languages = "Deutsch"
      prf.nationality = "Österreich"
    }

    entityHelperService.createEntityWithUserAndProfile("martingolja", etEducator, "martin@lernardo.at", "Martin Golja") {Entity ent ->
      EducatorProfile prf = ent.profile
      prf.title = "Mag."
      prf.firstName = "Martin"
      prf.lastName = "Golja"
      prf.contact = ""
      prf.employed = true
      prf.function = "Hortleiter"
      prf.interests = "Wassersport"
      prf.joinDate = new Date()
      prf.languages = "Deutsch"
      prf.nationality = "Österreich"
      prf.gender = 1
      prf.birthDate = new Date(1969-1900,12,31)
      prf.PLZ = 2563
      prf.city = "Pottenstein"
      prf.street = "Obere Marktfeldstraße 20"
      prf.education = ""
    }

/*    entityHelperService.createEntityWithUserAndProfile("rosa", etEducator, "rosa@lernardo.at", "Rosa Gober") {Entity ent ->
      EducatorProfile prf = ent.profile
      prf.gender = 2
      prf.birthDate = new Date(1961-1900,12,16)
      prf.PLZ = 2565
      prf.city = "Neuhaus"
      prf.street = "Schwarzenseer Straße 19"
      prf.education = """<b>1977 – 1980:</b> Fa. Laurenz-Hofbauer: Lehre Einzelhandelskaufmann, Gesellenprüfung<br>
                          <b>1980 – 1983:</b> ebendort EH-Kaufmann bis Firmenliquidierung<br>
                          <b>1983 – 1998:</b> Filialleiterin der Fa. L .Schumits & Co GmbH. in Leobersdorf<br>
                          <b>1996 – 2004:</b> Karenz und Hausfrau<br>
                          <b>seit 2004:</b> Fa. L. Schumits & Co GmbH in Pfaffstätten (geringfügig)"""
    }

    entityHelperService.createEntityWithUserAndProfile("birgit", etEducator, "bib@lernardo.at", "Birgit Blaesen") {Entity ent ->
      EducatorProfile prf = ent.profile
      prf.gender = 2
      prf.birthDate = new Date(1970-1900,03,19)
      prf.PLZ = 2560
      prf.city = "Hernstein"
      prf.street = "Gartengasse 5"
    }

    entityHelperService.createEntityWithUserAndProfile("hannah", etEducator, "hmb@lernardo.at", "Hannah Mutzbauer") {Entity ent ->
      EducatorProfile prf = ent.profile
      prf.gender = 2
      prf.birthDate = new Date(1982-1900,02,22)
      prf.PLZ = 2564
      prf.city = "Weissenbach an der Triesting"
      prf.street = "Hauptstraße 14"
    }

    entityHelperService.createEntityWithUserAndProfile("regina", etEducator, "regina.toncourt@gmx.at", "Regina Toncourt") {Entity ent ->
      EducatorProfile prf = ent.profile
      prf.gender = 2
      prf.birthDate = new Date(1962-1900,11,04)
      prf.PLZ = 2565
      prf.city = "Neuhaus"
      prf.street = "Hirschbahngasse 3"
      prf.education = """<b>1977 – 1980:</b> Friseur-Perückenmacherlehre, Maskenbildnerkurse, Gesellenprüfung<br>
                          <b>1980 – 1983:</b> während der Ferienzeit Betreuerin beim Wr. Jugendhilfswerk<br>
                          <b>1984 – 1987:</b> Verkäuferin in einem Papierfachgeschäft, halbtags<br>
                          <b>1987 - 1993:</b> Tennisschule „Team Tennis“ (Verkauf, Service, Werbung, Administration, Kinderbetreuung)<br>
                          <b>1993 - 1997:</b> Verein Wr.Jugendzentren – Kinder- und Jugendbetreuung.<br>
                          1jährige Fortbildung: „Soziokulturelle Animation“;<br>
                          laufend Fort- und Weiterbildungen (u.a. sex. Missbrauch, Drogen- und
                          Gewaltprävention, außergerichtlicher Tatausgleich, Konflikt als Chance,
                          Outdoor- und Erlebnispädagogik)<br>
                          <b>1998 - 2001:</b> verlängerte Karenz; Ausbildung bei Dr. Sindelar zur Trainerin bei TLS (Teilleistungsschwächen)<br>
                          <b>2001 – 2004:</b> Karenz, Montessori-Ausbildung bei Claus-Dieter Kaul<br>
                          <b>2005:</b> Montessori-Diplom<br>
                          <b>seit 2005:</b> Tagesmutter und Trainerin bei TLS beim NÖ Hilfswerk"""
    }

    entityHelperService.createEntityWithUserAndProfile("yvonne", etEducator, "ycf@lernardo.at", "Yvonne Frey") {Entity ent ->
      EducatorProfile prf = ent.profile
      prf.gender = 2
      prf.birthDate = new Date(1973-1900,12,01)
      prf.PLZ = 2560
      prf.city = "Grillenberg"
      prf.street = "Florianigasse 32/2"
    }

    entityHelperService.createEntityWithUserAndProfile("anna-maria", etEducator, "amr@lernardo.at", "Anna-Maria Reischer") {Entity ent ->
      EducatorProfile prf = ent.profile
      prf.gender = 2
      prf.birthDate = new Date(2010-1900,01,01)
      prf.PLZ = 2560
      prf.city = "???"
      prf.street = "???????"
    }*/
  
  }

  void createDefaultClients() {
    log.debug ("==> creating default clients")
    EntityType etClient = metaDataService.etClient

    entityHelperService.createEntityWithUserAndProfile("kirazeillinger", etClient, "kira@lernardo.at", "Kira Zeillinger") {Entity ent ->
      ClientProfile prf = ent.profile
      prf.firstName = "Kira"
      prf.lastName = "Zeillinger"
      prf.gender = 2
      prf.PLZ = 2352
      prf.city = "Gumpoldskirchen"
      prf.interests = ""
      prf.street = ""
      prf.personalDetails = ""
      prf.city2 = ""
      prf.joinDate = new Date()
      prf.languages = ""
      prf.income = 0
      prf.birthDate = new Date()
      prf.work = ""
      prf.street2 = ""
      prf.dropoutReason = ""
      prf.doesWork = false
      prf.country2 = ""
      prf.attendance = ""
      prf.dropout = false
      prf.country = ""
      prf.nationality = "Österreich"
      prf.schoolLevel = 1
      prf.notes = ""
    }

    entityHelperService.createEntityWithUserAndProfile("keanozeillinger", etClient, "keano@lernardo.at", "Keano Zeillinger") {Entity ent ->
      ClientProfile prf = ent.profile
      prf.firstName = "Keano"
      prf.lastName = "Zeillinger"
      prf.gender = 1
      prf.PLZ = 2352
      prf.city = "Gumpoldskirchen"
      prf.interests = ""
      prf.street = ""
      prf.personalDetails = ""
      prf.city2 = ""
      prf.joinDate = new Date()
      prf.languages = ""
      prf.income = 0
      prf.birthDate = new Date()
      prf.work = ""
      prf.street2 = ""
      prf.dropoutReason = ""
      prf.doesWork = false
      prf.country2 = ""
      prf.attendance = ""
      prf.dropout = false
      prf.country = ""
      prf.nationality = "Österreich"
      prf.schoolLevel = 1
      prf.notes = ""
    }
  }

  void createDefaultOperators() {
    log.debug ("==> creating default operators")
    EntityType etOperator = metaDataService.etOperator

    entityHelperService.createEntityWithUserAndProfile ("vereinlernardo", etOperator, "lernardo@lkult.at", "LERNARDO Lernen - Wachsen") {Entity ent->
      ent.user.addToAuthorities(metaDataService.adminRole)
      OperatorProfile prf = ent.profile
      prf.PLZ = 2560
      prf.city = "Berndorf"
      prf.street = "Leobersdorfer Straße 42"
      prf.tel   = "-"
      prf.description = "-"
    }

    entityHelperService.createEntityWithUserAndProfile ("vereinalpha", etOperator, "verein@alpha.at", "Verein Alpha") {Entity ent->
      ent.user.addToAuthorities(metaDataService.adminRole)
      OperatorProfile prf = ent.profile
      prf.PLZ = 2563
      prf.city = "Pottenstein"
      prf.street = "Hainfelderstrasse 29"
      prf.tel   = "-"
      prf.description = "-"
    }

    entityHelperService.createEntityWithUserAndProfile ("sueninos", etOperator, "sueninos@sueninos.org", "Sueninos") {Entity ent->
      ent.user.addToAuthorities(metaDataService.adminRole)
      OperatorProfile prf = ent.profile
      prf.PLZ = 0
      prf.city = ""
      prf.street = ""
      prf.tel = ""
      prf.description = ""
    }
  }

  void createDefaultFacilities () {
    log.debug ("==> creating default facilities")
    EntityType etFacility = metaDataService.etFacility

    entityHelperService.createEntityWithUserAndProfile ("hortloewenzahn", etFacility, "loewenzahn@lernardo.at", "Hort Löwenzahn") {Entity ent->
      FacilityProfile prf = ent.profile
      prf.PLZ = 2564
      prf.city = "Weissenbach an der Triesting"
      prf.street = "Hauptstraße 12"
      prf.tel   = "0676 / 880 604 001"
      prf.description = """Der Hort befindet sich im Ortszentrum, nur wenige Meter von der Volksschule
                            und dem Kindergarten entfernt. Für den Hortbetrieb steht ein Hortgruppenraum
                            mit ca. 62m² und ein Aufenthaltsraum mit mehr als 24 m² sowie eine Garderobe
                            und Toilettenanlagen getrennt für Mädchen und Buben zur Verfügung. Des Weiteren
                            können in Kooperation mit der Gemeinde Schulräumlichkeiten in der örtlichen
                            Volksschule, sowie Räume der Hauptschule und der Volksschulgarten bzw. Spielplatz
                            genutzt werden.<br>
                            Im Hort selbst stehen ein Essbereich, ein Lernbereich, ein Kreativ- und
                            Spielbereich und ein Ruhebereich zur Verfügung."""
    }

    entityHelperService.createEntityWithUserAndProfile ("hortkaumberg", etFacility, "kaumberg@lernardo.at", "Hort Kaumberg") {Entity ent->
      FacilityProfile prf = ent.profile
      prf.PLZ = 2572
      prf.city = "Kaumberg"
      prf.street = "-"
      prf.tel   = "0660 / 461 1106"
      prf.description = "Der zweite unter Lernardo betriebene Hort."
    }
    
    entityHelperService.createEntityWithUserAndProfile ("sueninoszentrum", etFacility, "sueninoszentrum@sueninos.org", "Sueninos Zentrum") {Entity ent->
      FacilityProfile prf = ent.profile
      prf.PLZ = 29247
      prf.city = "	San Cristóbal de Las Casas"
      prf.street = "	Prolongación Ramón Larrainzar #139"
      prf.tel   = "+52 967 1125100"
      prf.description = ""
    }
  }

  void createDefaultLinks () {
    log.debug ("==> creating default links")
    
    def alex = Entity.findByName ('alexanderzeillinger')
    def patrizia = Entity.findByName ('patriziarosenkranz')
    def martin = Entity.findByName ('martingolja')
    def rosa = Entity.findByName ('rosagober')
    def birgit = Entity.findByName ('birgitblaesen')
    def hannah = Entity.findByName ('hannahmutzbauer')
    def regina = Entity.findByName ('reginatoncourt')
    def loewenzahn = Entity.findByName ('hortloewenzahn')
    def kaumberg = Entity.findByName ('hortkaumberg')
    def kira = Entity.findByName ('kirazeillinger')
    def keano = Entity.findByName ('keanozeillinger')
    def vlernardo = Entity.findByName ('vereinlernardo')
    def alpha = Entity.findByName ('vereinalpha')

    // make admin a friend of everyone
    List users = Entity.list()
    users.each {
      if (it.name != 'admin') {
        new Link(source: it, target: Entity.findByName('lernardoadmin'), type: metaDataService.ltFriendship).save()
        new Link(source: Entity.findByName('lernardoadmin'), target: it, type: metaDataService.ltFriendship).save()
      }
    }

    // friend links
    new Link(source:alex, target:patrizia, type:metaDataService.ltFriendship).save()
    new Link(source:patrizia, target:alex, type:metaDataService.ltFriendship).save()

    // working links
    new Link(source:martin, target:loewenzahn, type:metaDataService.ltWorking).save()
    new Link(source:rosa, target:loewenzahn, type:metaDataService.ltWorking).save()
    new Link(source:birgit, target:loewenzahn, type:metaDataService.ltWorking).save()
    new Link(source:hannah, target:kaumberg, type:metaDataService.ltWorking).save()
    new Link(source:regina, target:loewenzahn, type:metaDataService.ltWorking).save()

    // client links
    // TODO: find out why creating those 2 links isn't working in bootstrap
    new Link(source:kira, target:kaumberg, type:metaDataService.ltClientship).save()
    new Link(source:keano, target:kaumberg, type:metaDataService.ltClientship).save()

    // operation links
    new Link(source:kaumberg, target:alpha, type:metaDataService.ltOperation).save()
    new Link(source:loewenzahn, target:vlernardo, type:metaDataService.ltOperation).save()
  }

  void createDefaultTemplates() {
    log.debug ("==> creating default templates")

    EntityType etTemplate = metaDataService.etTemplate

    def entity = entityHelperService.createEntity("weidemithindernissen", etTemplate) {Entity ent ->
      ent.profile = profileHelperService.createProfileFor(ent)
      ent.profile.fullName = "Weide mit Hindernissen"
      ent.profile.attribution = "Psychomotorik"
      ent.profile.description = "Die Bänke werden in Reihen aufgestellt; es können möglichst viele Bewegungsformen ausprobiert werden"
      ent.profile.duration = 60
      ent.profile.socialForm = "Großgruppe (bis 15 Kinder)"
      ent.profile.qualifications = "keine"
      ent.profile.requiredEducators = 2
      ent.profile.ll = 0
      ent.profile.be = 3
      ent.profile.pk = 1
      ent.profile.si = 2
      ent.profile.hk = 0
      ent.profile.tlt = 1

    }

  }

  void createDefaultComments() {
    log.debug ("==> creating default comments")

    EntityType etCommentTemplate = metaDataService.etCommentTemplate

    def entity = entityHelperService.createEntity("comment", etCommentTemplate) {Entity ent ->
      ent.profile = profileHelperService.createProfileFor(ent)
      ent.profile.fullName = "comment"
      ent.profile.content = "Tolle Sache!"
    }

    new Link(source: entity, target: Entity.findByName('weidemithindernissen'), type: metaDataService.ltComment).save()
    def c = Entity.createCriteria()
    def source = c.get {
      profile {
        eq('fullName', "Martin Golja")
      }
    }

    new Link(source: source, target: entity, type: metaDataService.ltCreator).save()
  }

  void createDefaultResources() {
    log.debug ("==> creating default resources")

    EntityType etResource = metaDataService.etResource

    def entity = entityHelperService.createEntity("klavier", etResource) {Entity ent ->
      ent.profile = profileHelperService.createProfileFor(ent)
      ent.profile.fullName = "Klavier"
      ent.profile.description = "Ein echtes Bechstein Klavier!"
      ent.profile.type = "planbar"
    }

  }

  void createDefaultActivities() {
    log.debug ("==> creating default activities")

     EntityType etActivity = metaDataService.etActivity

      def entity = entityHelperService.createEntity("Klettern", etActivity) {Entity ent ->
        ent.profile = profileHelperService.createProfileFor(ent)
        ent.profile.fullName = "Klettern"
        ent.profile.date = new Date()
        ent.profile.duration = 60
      }

      new Link(source: Entity.findByName('martingolja'), target: entity, type: metaDataService.ltActEducator).save()
      new Link(source: Entity.findByName('keanozeillinger'), target: entity, type: metaDataService.ltActClient).save()
      new Link(source: Entity.findByName('hortloewenzahn'), target: entity, type: metaDataService.ltActFacility).save()
      new Link(source: Entity.findByName('weidemithindernissen'), target: entity, type: metaDataService.ltActTemplate).save()
      new Link(source: Entity.findByName('martingolja'), target: entity, type: metaDataService.ltCreator).save()
      //new Link(source: Entity.findByName('martin'), target: entity, type: metaDataService.ltActResource).save()

  }

  void createDefaultPosts() {
    log.debug ("==> creating default posts")

/*    new TemplateComment(content:'Sehr nette Aktivität! Die Beschreibung könnte aber noch etwas genauer ausgeführt werden.',
            author:Entity.findByName('regina'),
            template:ActivityTemplate.findByName('Schatten')).save()*/

    new ArticlePost(title:'Lernardo im Hort Kaumberg',
            teaser:'''Mit Beginn September 2009 erweitert Lernardo aufgrund der hohen Nachfrage und positiven
            Resonanz seine Einrichtungen mit einem neuen Standort in Kaumberg.''',
            content:'''Dank Kaumberg's Bürgermeister Michael Singraber konnte im Sommer 2009 sehr schnell
            passende Räumlichkeiten gefunden werden. Zur Verfügung gestellt wurde ein Klassenraum der Volksschule
            Kaumberg in dem ca. 10 Kinder zwischen 7 und 10 Jahre betreut werden. Der Beginn erfolgt am 07.
            September, als Hortleiterin wird Hannah Mutzbauer eingesetzt, die sich bereits in Hort Löwenzahn
            bewährt hat. Den Kindern stehen neben dem Klassenraum die Wiese sowie die Freizeitanlage der Schule
            zur vollen Verfügung.''',
            author:Entity.findByName('martingolja')).save()
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
            author:Entity.findByName('martingolja')).save()
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
            author:Entity.findByName('martingolja')).save()
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
                   writer: Entity.findByName('hannah')).save()
    new Evaluation(owner: Entity.findByName('kirazeillinger'),
                   description: 'Kira ist ein wahres Genie. Keine Aufgabe macht ihr Probleme und sie hat sehr viel Spaß. Ich glaube aber sie hat Symptome von Hyperaktivität.',
                   method: 'Ich möchte mit ihr verstärkt Interventionen machen, die weniger kopflastig sind.',
                   writer: Entity.findByName('hannah')).save()
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

  void createDefaultGroups() {
    log.debug ("==> creating default groups")

    EntityType etGroupFamily = metaDataService.etGroupFamily

    def entity = entityHelperService.createEntity("Zeillinger", etGroupFamily) {Entity ent ->
      ent.profile = profileHelperService.createProfileFor(ent)
      ent.profile.fullName = "Zeillinger"
      ent.profile.livingConditions = """Leben in einem soliden österreichischen Mehrfamilienwohnhaus. Alexander Zeillinger erhält ein
                                     ausreichendes Einkommen und Sabine Zeillinger kümmert sich um den Haushalt."""
      ent.profile.personCount = 2
      //ent.profile.totalIncome = 1550
      ent.profile.otherData = """Familie Zeillinger besitzt 2 Katzen und 2 Autos"""
    }

    new Link(source: Entity.findByName('alex'), target: entity, type: metaDataService.ltGroup).save()
    //new Link(source: Entity.findByName('sabine'), target: entity, type: metaDataService.ltGroup).save()

  }

}