import de.uenterprise.ep.EntityType
import de.uenterprise.ep.Entity
import de.uenterprise.ep.Link
import profiles.UserProfile
import profiles.FacProfile
import posts.ArticlePost
import posts.TemplateComment
import profiles.OrgProfile
import lernardo.ActivityTemplate
import lernardo.Activity
import lernardo.Event
import grails.util.GrailsUtil
import org.codehaus.groovy.grails.commons.GrailsApplication
import lernardo.Helper
import lernardo.Evaluation
import lernardo.Attendance

class BootStrap {
  def defaultObjectService
  def entityHelperService
  def calendarDataService
  def metaDataService
  def FunctionService

  def init = {servletContext ->
    defaultObjectService.onEmptyDatabase {
      metaDataService.initialize()
      calendarDataService.initialize()
      createDefaultUsers()
      createDefaultPaeds()
      createDefaultOperators()
      createDefaultFacilities()
      createDefaultLinks()
      createDefaultActivityTemplates()

      if (GrailsUtil.environment == GrailsApplication.ENV_DEVELOPMENT) {
        createDefaultActivities()
        createDefaultClients()
        createDefaultPosts()
        createDefaultEvents()
        createDefaultAttendances()
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

    // an admin user
    entityHelperService.createEntityWithUserAndProfile("admin", etUser, "admin@lernardo.at", "Lernardo Admin") {Entity ent ->
      ent.user.addToAuthorities(metaDataService.adminRole)
      UserProfile prf = ent.profile
      prf.tagline = "to be on top is our job"
      prf.gender = 1
      prf.title = "-"
      prf.birthDate = new Date()
      prf.PLZ = 1000
      prf.city = "Wien"
      prf.street = "Riemergasse 14"
      prf.tel = "-"
      prf.biography = "-"
    }

    // mod users
    entityHelperService.createEntityWithUserAndProfile("alex", etUser, "aaz@uenterprise.de", "Alexander Zeillinger") {Entity ent ->
      ent.user.addToAuthorities(metaDataService.modRole)
      UserProfile prf = ent.profile
      prf.tagline = "Simplicity is the ultimate sophistication"
      prf.gender = 1
      prf.city = "Gumpoldskirchen"
      prf.birthDate = new Date(1982-1900,02,22)
      prf.PLZ = 2352
      prf.street = "Rudolf Tamchina Gasse 5/5"
      prf.tel = "0664 / 840 66 32"
    }

    entityHelperService.createEntityWithUserAndProfile("patrizia", etUser, "pcr@lernardo.at", "Patrizia Rosenkranz") {Entity ent ->
      ent.user.addToAuthorities(metaDataService.modRole)
      UserProfile prf = ent.profile
      prf.gender = 2
      prf.title = "B.A."
      prf.city = "Berndorf"
      prf.birthDate = new Date(1983-1900,07,20)
      prf.PLZ = 2560
      prf.street = "-"
      prf.tel = "0664 / 840 66 27"
    }

    entityHelperService.createEntityWithUserAndProfile("susanne", etUser, "sst@lernardo.at", "Susanne Stiedl") {Entity ent ->
      ent.user.addToAuthorities(metaDataService.modRole)
      UserProfile prf = ent.profile
      prf.tagline = "..."
      prf.gender = 2
      prf.birthDate = new Date(1966-1900,11,19)
      prf.PLZ = 2563
      prf.city = "Pottenstein"
      prf.street = "-"
      prf.tel = "0664 / 204 91 68"
      prf.biography = "-"
    }

    // some regular users
    entityHelperService.createEntityWithUserAndProfile("mike", etUser, "mpk@lernardo.at", "Mike P. Kuhl") {Entity ent ->
      UserProfile prf = ent.profile
      prf.tagline = "Wozu brauch ma des?"
      prf.gender = 1
      prf.PLZ = 1000
      prf.city = "Wien"
      prf.street ="sss"
      prf.tel = "1234"
    }

    entityHelperService.createEntityWithUserAndProfile("johannes", etUser, "jlz@lernardo.at", "Johannes L. Zeitelberger") {Entity ent ->
      UserProfile prf = ent.profile
      prf.tagline = "Ich will die Welt im ERP abbilden!"
      prf.gender = 1
      prf.PLZ = 2560
      prf.city = "Berndorf"
      prf.street = "Wankengasse 10"
      prf.tel = "0664 / 840 66 20"
    }

    entityHelperService.createEntityWithUserAndProfile("stephanie", etUser, "sp@lernardo.at", "Stephanie Pirkfellner") {Entity ent ->
      UserProfile prf = ent.profile
      prf.tagline = "..."
      prf.gender = 2
      prf.birthDate = new Date(1940-1900,12,26)
      prf.PLZ = 2563
      prf.city = "Pottenstein"
      prf.street = "Hainfelderstrasse 29"
      prf.tel = "0664 846 98 19"
    }
  }

  void createDefaultPaeds() {
    log.debug ("==> creating default paeds")
    EntityType etPaed = metaDataService.etPaed

    entityHelperService.createEntityWithUserAndProfile("martin", etPaed, "martin@lernardo.at", "Martin Golja") {Entity ent ->
      UserProfile prf = ent.profile
      prf.tagline = "..."
      prf.title = "Mag."
      prf.gender = 1
      prf.birthDate = new Date(1969-1900,12,31)
      prf.PLZ = 2563
      prf.city = "Pottenstein"
      prf.street = "Obere Marktfeldstraße 20"
      prf.tel = "-"
      prf.biography = """<b>1976-1980</b> Volksschule Pottenstein<br>
                          <b>1980-1988</b> Neusprachlicher Zweig des Bundesrealgymnasiums Berndorf<br>
                          <b>1988</b> Matura<br>
                          <b>1988-1989</b> Präsenzdienst in der Martinekkaserne in Baden<br>
                          <b>1989-2006</b> Übungsleitertätigkeit bei der Union Pottenstein für Kinder und Jugendliche; Altersstufen 3-6, 6-10, 10-15<br>
                          <b>1989</b> Inskription Geographie und Wirtschaftskunde, Germanistik<br>
                          <b>1992</b> Inskription Geographie und Wirtschaftskunde, Leibeserziehung<br>
                          <b>1995</b> Beginn Dienstverhältnis auf der Marktgemeinde Pottenstein<br>
                          <b>1998</b> Ablegung der Prüfungen zum Standesbeamten und Staatsbürgerschaftsevidenzführer<br>
                          <b>1998</b> Inskription von Geographie und Wirtschaftskunde, Psychologie, Pädagogik, Philosophie<br>
                          <b>1998-2001</b> Standesbeamter und Staatsbürgerschaftsevidenzführer am Standesamt Pottenstein<br>
                          <b>1990-2002</b> Mitgesellschafter als staatlich geprüfter Diplomskilehrer in der Skischule St.Anton am Arlberg<br>
                          <b>1997-2002</b> Ausbildnertätigkeit Ski am Universitätssportinstitut Wien<br>
                          <b>2001-2003</b> Skilehrerausbildner beim Wiener Ski- und Snowboardlehrerverband, sowie Snowsportsacademy Holland<br>
                          <b>2002-2003</b> Beschäftigung als Disponent in der Neuwagendisposition Citroen Österreich<br>
                          <b>2003</b> Ablegung der Diplomprüfung an der Universität Wien<br>
                          <b>2004-2005</b> Beschäftigung als Erzieher im Landesjugendheim Pottenstein über den Verein „Jugend und Arbeit“ der NÖ Landesregierung (Lehrerbörse)<br>
                          <b>2005-2006</b> Unterrichtspraktikum am BG/BRG Baden und am BG/BRG Berndorf<br>
                          <b>2005-laufend</b> geschäftsführender Gemeinderat der Marktgemeinde Pottenstein<br>
                          <b>2006-laufend</b> Beschäftigung als Springer in der schulischen Nachmittagsbetreuung beim Verein „Hand in Hand“ des NÖ Familienreferates"""
    }

    entityHelperService.createEntityWithUserAndProfile("rosa", etPaed, "rosa@lernardo.at", "Rosa Gober") {Entity ent ->
      UserProfile prf = ent.profile
      prf.tagline = "..."
      prf.gender = 2
      prf.birthDate = new Date(1961-1900,12,16)
      prf.PLZ = 2565
      prf.city = "Neuhaus"
      prf.street = "Schwarzenseer Straße 19"
      prf.tel = "0664 / 3774 559"
      prf.biography = """<b>1977 – 1980:</b> Fa. Laurenz-Hofbauer: Lehre Einzelhandelskaufmann, Gesellenprüfung<br>
                          <b>1980 – 1983:</b> ebendort EH-Kaufmann bis Firmenliquidierung<br>
                          <b>1983 – 1998:</b> Filialleiterin der Fa. L .Schumits & Co GmbH. in Leobersdorf<br>
                          <b>1996 – 2004:</b> Karenz und Hausfrau<br>
                          <b>seit 2004:</b> Fa. L. Schumits & Co GmbH in Pfaffstätten (geringfügig)"""
    }

    entityHelperService.createEntityWithUserAndProfile("birgit", etPaed, "bib@lernardo.at", "Birgit Blaesen") {Entity ent ->
      UserProfile prf = ent.profile
      prf.tagline = "..."
      prf.gender = 2
      prf.birthDate = new Date(1970-1900,03,19)
      prf.PLZ = 2560
      prf.city = "Hernstein"
      prf.street = "Gartengasse 5"
    }

    entityHelperService.createEntityWithUserAndProfile("hannah", etPaed, "hmb@lernardo.at", "Hannah Mutzbauer") {Entity ent ->
      UserProfile prf = ent.profile
      prf.tagline = "..."
      prf.gender = 2
      prf.birthDate = new Date(1982-1900,02,22)
      prf.PLZ = 2564
      prf.city = "Weissenbach an der Triesting"
      prf.street = "Hauptstraße 14"
    }

    entityHelperService.createEntityWithUserAndProfile("regina", etPaed, "regina.toncourt@gmx.at", "Regina Toncourt") {Entity ent ->
      UserProfile prf = ent.profile
      prf.tagline = "..."
      prf.gender = 2
      prf.birthDate = new Date(1962-1900,11,04)
      prf.PLZ = 2565
      prf.city = "Neuhaus"
      prf.street = "Hirschbahngasse 3"
      prf.tel = "0676 / 4303 145"
      prf.biography = """<b>1977 – 1980:</b> Friseur-Perückenmacherlehre, Maskenbildnerkurse, Gesellenprüfung<br>
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

    entityHelperService.createEntityWithUserAndProfile("yvonne", etPaed, "ycf@lernardo.at", "Yvonne Frey") {Entity ent ->
      UserProfile prf = ent.profile
      prf.tagline = "..."
      prf.gender = 2
      prf.birthDate = new Date(1973-1900,12,01)
      prf.PLZ = 2560
      prf.city = "Grillenberg"
      prf.street = "Florianigasse 32/2"
      prf.tel = "0676 / 964 84 12"
    }

    entityHelperService.createEntityWithUserAndProfile("anna-maria", etPaed, "amr@lernardo.at", "Anna-Maria Reischer") {Entity ent ->
      UserProfile prf = ent.profile
      prf.tagline = "..."
      prf.gender = 2
      prf.birthDate = new Date(2010-1900,01,01)
      prf.PLZ = 2560
      prf.city = "???"
      prf.street = "???????"
      prf.tel = "06?? ???"
    }
  
  }

  void createDefaultClients() {
    log.debug ("==> creating default clients")
    EntityType etClient = metaDataService.etClient

    entityHelperService.createEntityWithUserAndProfile("kira", etClient, "kira@lernardo.at", "Kira Zeillinger") {Entity ent ->
      UserProfile prf = ent.profile
      prf.tagline = "..."
      prf.gender = 2
      prf.PLZ = 2352
      prf.city = "Gumpoldskirchen"
      prf.tel = "0699 / 1234"
    }

    entityHelperService.createEntityWithUserAndProfile("keano", etClient, "keano@lernardo.at", "Keano Zeillinger") {Entity ent ->
      UserProfile prf = ent.profile
      prf.tagline = "..."
      prf.gender = 1
      prf.PLZ = 2352
      prf.city = "Gumpoldskirchen"
      prf.tel = "0699 / 5678"
    }
  }

  void createDefaultOperators() {
    log.debug ("==> creating default operators")
    EntityType etOperator = metaDataService.etOperator

    entityHelperService.createEntityWithUserAndProfile ("vlernardo", etOperator, "lernardo@lkult.at", "LERNARDO Lernen - Wachsen") {Entity ent->
      OrgProfile prf = ent.profile
      prf.PLZ = 2560
      prf.city = "Berndorf"
      prf.street = "Leobersdorfer Straße 42"
      prf.tel   = "-"
      prf.speaker = Entity.findByName('johannes')
      prf.description = "-"
    }
    entityHelperService.createEntityWithUserAndProfile ("alpha", etOperator, "verein@alpha.at", "Verein Alpha") {Entity ent->
      OrgProfile prf = ent.profile
      prf.PLZ = 2563
      prf.city = "Pottenstein"
      prf.street = "Hainfelderstrasse 29"
      prf.tel   = "-"
      //prf.speaker = Entity.findByName('johannes')
      prf.description = "-"
    }
  }

  void createDefaultFacilities () {
    log.debug ("==> creating default facilities")
    EntityType etFac = metaDataService.etHort

    entityHelperService.createEntityWithUserAndProfile ("loewenzahn", etFac, "loewenzahn@lernardo.at", "Hort Löwenzahn") {Entity ent->
      FacProfile prf = ent.profile
      prf.PLZ = 2564
      prf.city = "Weissenbach an der Triesting"
      prf.street = "Hauptstraße 12"
      prf.tel   = "0676 / 880 604 001"
      prf.opened = "Mo-Fr, 11 bis 18 Uhr"
      prf.speaker = Entity.findByName('regina')
      prf.description = """Der Hort befindet sich im Ortszentrum, nur wenige Meter von der Volksschule
                            und dem Kindergarten entfernt. Für den Hortbetrieb steht ein Hortgruppenraum
                            mit ca. 62m² und ein Aufenthaltsraum mit mehr als 24 m² sowie eine Garderobe
                            und Toilettenanlagen getrennt für Mädchen und Buben zur Verfügung. Des Weiteren
                            können in Kooperation mit der Gemeinde Schulräumlichkeiten in der örtlichen
                            Volksschule, sowie Räume der Hauptschule und der Volksschulgarten bzw. Spielplatz
                            genutzt werden.<br>
                            Im Hort selbst stehen ein Essbereich, ein Lernbereich, ein Kreativ- und
                            Spielbereich und ein Ruhebereich zur Verfügung."""
      prf.foodCosts = 3
    }

    entityHelperService.createEntityWithUserAndProfile ("kaumberg", etFac, "kaumberg@lernardo.at", "Hort Kaumberg") {Entity ent->
      FacProfile prf = ent.profile
      prf.PLZ = 2572
      prf.city = "Kaumberg"
      prf.street = "-"
      prf.tel   = "0660 / 461 1106"
      prf.opened = "?"
      prf.speaker = Entity.findByName('hannah')
      prf.description = "Der zweite unter Lernardo betriebene Hort."
      prf.foodCosts = 5
    }
  }

  void createDefaultLinks () {
    log.debug ("==> creating default links")
    def mike = Entity.findByName ('mike')
    def alex = Entity.findByName ('alex')
    def patrizia = Entity.findByName ('patrizia')
    def martin = Entity.findByName ('martin')
    def rosa = Entity.findByName ('rosa')
    def birgit = Entity.findByName ('birgit')
    def hannah = Entity.findByName ('hannah')
    def regina = Entity.findByName ('regina')
    def loewenzahn = Entity.findByName ('loewenzahn')
    def kaumberg = Entity.findByName ('kaumberg')
    def kira = Entity.findByName ('kira')
    def keano = Entity.findByName ('keano')
    def vlernardo = Entity.findByName ('vlernardo')
    def alpha = Entity.findByName ('alpha')

    // make admin a friend of everyone
    List users = Entity.list()
    users.each {
      if (it.name != 'admin') {
        new Link(source: it, target: Entity.findByName('admin'), type: metaDataService.ltFriendship).save()
        new Link(source: Entity.findByName('admin'), target: it, type: metaDataService.ltFriendship).save()
      }
    }

    // friend links
    new Link(source:mike, target:alex,  type:metaDataService.ltFriendship).save()
    new Link(source:alex, target:mike,  type:metaDataService.ltFriendship).save()
    new Link(source:alex, target:patrizia, type:metaDataService.ltFriendship).save()
    new Link(source:patrizia, target:alex, type:metaDataService.ltFriendship).save()

    // working links
    new Link(source:martin, target:loewenzahn, type:metaDataService.ltWorking).save()
    new Link(source:rosa, target:loewenzahn, type:metaDataService.ltWorking).save()
    new Link(source:birgit, target:loewenzahn, type:metaDataService.ltWorking).save()
    new Link(source:hannah, target:kaumberg, type:metaDataService.ltWorking).save()
    new Link(source:regina, target:loewenzahn, type:metaDataService.ltWorking).save()

    // client links
    new Link(source:kira, target:kaumberg, type:metaDataService.ltClientship).save()
    new Link(source:keano, target:kaumberg, type:metaDataService.ltClientship).save()

    // operation links
    new Link(source:kaumberg, target:alpha, type:metaDataService.ltOperation).save()
    new Link(source:loewenzahn, target:vlernardo, type:metaDataService.ltOperation).save()
  }

  void createDefaultActivityTemplates() {
    log.debug ("==> creating default activity templates")

    new ActivityTemplate(name:'Weide mit Hindernissen',
                         attribution:'Psychomotorik',
                         description:'''Die Bänke werden in Reihen aufgestellt;
                                        es können möglichst viele Bewegungsformen ausprobiert werden''',
                         duration: 60,
                         socialForm:'Großgruppe (bis 15 Kinder)',
                         materials:'Bänke',
                         ll: 0, be: 3, pk: 1, si: 2, hk: 0, tlt: 1,
                         qualifications:'keine',
                         requiredPaeds: 2).save()
    new ActivityTemplate(name:'Schmetterlinge',
                         attribution:'Psychomotorik',
                         description:'''Jedes Kind erhält ein Band und befestigt dies an einem Arm wie eine Art Flügel.
			                            Die Kinder sind Schmetterlinge und bewegen sich zur Musik (vorwärts/ rückwärts laufen,
			                            beidbeinig/ einbeinig hüpfen etc.)
                                        Kommt es zu einem Musikstopp, setzen sich alle „Schmetterlinge“
			                            jeweils in einen Reifen (=Blume). Dabei zeigt der Arm mit dem Band (Flügel) in die Richtung der
			                            Lehrperson.''',
                         duration: 30,
                         socialForm:'Großgruppe (bis 15 Kinder)',
                         materials:'Musik, 5 Bänder, Reifen',
                         ll: 0, be: 3, pk: 1, si: 2, hk: 1, tlt: 1,
                         qualifications:'keine',
                         requiredPaeds: 2).save()
    new ActivityTemplate(name:'Luftballonmeer',
                         attribution:'Psychomotorik',
                         description:'''Die Kinder blasen Luftballone auf, damit wird ein Bettbezug prall gefüllt.
                                        Ein Luftballonmeer entsteht. Ein Kind legt sich darauf, die anderen Kinder
                                        bewegen das Meer – fühlt sich an, als würde man auf einer Luftmatratze im Meer
                                        schwimmen.''',
                         duration: 45,
                         socialForm:'Kleingruppe (bis 5 Kinder)',
                         materials:'Bettbezug, Luftballone',
                         ll: 0, be: 2, pk: 2, si: 1, hk: 0, tlt: 0,
                         qualifications:'keine',
                         requiredPaeds: 1).save()
    new ActivityTemplate(name:'Musikstopp',
                         attribution:'Psychomotorik',
                         description:'''Zeitungsbögen auf dem Boden verteilen – solange die Musik läuft, werden die Bögen
			                            umlaufen. Wird die Musik gestoppt, so gibt es verschiedene Möglichkeiten: in Bauchlage auf
			                            eine Zeitung legen, mit dem Rücken auf die Zeitung legen, mit einem Bein auf die Zeitung stellen,
			                            auf die Zeitung setzen, Beine bleiben in der Luft''',
                         duration: 30,
                         socialForm:'Kleingruppe (bis 5 Kinder)',
                         materials:'Zeitung, Musik',
                         ll: 0, be: 3, pk: 1, si: 1, hk: 0, tlt: 1,
                         qualifications:'keine',
                         requiredPaeds:1).save()
    new ActivityTemplate(name:'Zeitungshut',
                         attribution:'Psychomotorik',
                         description:'''Jedes Kind faltet sich seinen Zeitungshut und setzt diesen auf. Alle Kinder laufen,
                                        gehen und hüpfen (vorwärts, rückwärts) mit ihren Hüten und versuchen diesen ständig
                                        am eigenen Kopf zu behalten.''',
                         duration: 30,
                         socialForm:'Kleingruppe (bis 8 Kinder)',
                         materials:'Zeitung',
                         ll: 0, be: 3, pk: 1, si: 1, hk: 0, tlt: 0,
                         qualifications:'keine',
                         requiredPaeds: 1).save()
    new ActivityTemplate(name:'Körperschema',
                         attribution:'Psychomotorik',
                         description:'''Zwei Kinder bilden ein Paar. Ein Kind legt sich auf den Boden. Der Partner setzt
			                            sich daneben und legt die Perlenschnur, Bleiband etc. am Rand des Körpers entlang (Variante:
			                            den Körper mit Kreiden nachziehen bzw. auf Papier nachzeichnen). Das liegende Kind steht
			                            langsam auf und sieht seinen umrahmten Körper (Körperschema). Danach wird gewechselt. Der
			                            eigene Körper wird dadurch wahrgenommen, die Körperteile können benannt und somit erkannt werden.''',
                         duration: 30,
                         socialForm:'Partnerarbeit',
                         materials:'Papier, Kreide, Bleiband,Perlenketten, Schnüre,Ketten, Bierdeckel etc.',
                         ll: 0, be: 1, pk: 2, si: 2, hk: 0, tlt: 0,
                         qualifications:'keine',
                         requiredPaeds: 1).save()
    new ActivityTemplate(name:'Pizzamassage',
                         attribution:'Psychomotorik',
                         description:'''Die Kinder tun sich paarweise zusammen und bekommen ein Matte bzw. Decke. Ein Kind legt
                                        sich in Bauchlage auf die Matte und ist von nun an das Blech für den Pizzateig, das andere
                                        Kind ist der Pizzabäcker. Das Blech wird eingefettet (mit den Händen über den Rücken bzw.
                                        Oberschenkel streichen), mit Mehl berieselt (Fingerspitzen machen leichte Trommelbewegungen),
                                        es wird Wasser dazugegeben (mit den Fingern fließendes Wasser imitieren), Mehl und Wasser
                                        werden zusammengeschoben, bevor der Teig geknetet, ausgerollt und mit Tomaten, Eiern, Käse
                                        etc. belegt wird. Dann wird die Pizza in den Ofen geschoben (Partner legt sich auf den Rücken
                                        des anderen und wärmt), anschließend werden kleine Stücke geschnitten (Handkante), die Pizza
                                        wird gegessen und das Blech gereinigt (mit den Händen abreiben).''',
                         duration: 15,
                         socialForm:'Partnerarbeit',
                         materials:'keine',
                         ll: 0, be: 1, pk: 2, si: 1, hk: 0, tlt: 1,
                         qualifications:'keine',
                         requiredPaeds: 1).save()
    new ActivityTemplate(name:'Heizdecke',
                         attribution:'Psychomotorik',
                         description:'''Ein Kind liegt auf einer Matte (Decke) und wird von den anderen Kindern mit Bierdeckeln
			zugedeckt. Diese legen die Bierdeckel vorsichtig auf das liegende Kind. Es hat die Augen geschlossen
			und soll möglichst gar nichts von dem Auflegen der Bierdeckel spüren. Auch Hände und Füße sollen nicht
			mehr zu sehen sein. Abschließend darf das zugedeckte Kind entscheiden, ob es langsam wieder aufgedeckt
			werden will oder ob es durch kräftiges Schütteln alle Bierdeckel von sich wirft.''',
                         duration: 15,
                         socialForm:'Partnerarbeit',
                         materials:'Bierdeckel, Decken',
                         ll: 0, be: 1, pk: 2, si: 1, hk: 0, tlt: 1,
                         qualifications:'keine',
                         requiredPaeds: 1).save()
    new ActivityTemplate(name:'Autowäsche',
                         attribution:'Psychomotorik',
                         description:'''Die Kinder stellen sich in einer Reihe gegenüber auf und bilden eine Autowaschstraße.
			Ein Kind bestimmt, welcher Autotyp es sein will, welche Farbe es hat und welches Waschprogramm
			es wünscht. Dann fährt es mit einem Rollbrett in die Waschstraße ein (oder kniet sich auf allen
			Vieren), wird berieselt (z.B. mit den Fingern Regentropfen machen), eingeschäumt (reiben) und
			getrocknet (Wind erzeugen). Die Kinder bringen weitere Ideen in das Spiel ein.''',
                         duration: 30,
                         socialForm:'Kleingruppe (4-8 Kinder)',
                         materials:'eventuell Rollbrett',
                         ll: 0, be: 2, pk: 1, si: 1, hk: 0, tlt: 0,
                         qualifications:'keine',
                         requiredPaeds: 1).save()
    new ActivityTemplate(name:'Ballschaukel',
                         attribution:'Psychomotorik',
                         description:'''Eine Teilnehmerin bzw. ein Teilnehmer legt sich auf einen großen Ball (z.B. Gymnastikball)
                         und wird vorsichtig hin und her geschaukelt. Dazu wird der Ball von den Gruppenmitgliedern so bewegt, dass
                         der bzw. die Liegende sicher auf dem Ball ruht. Für die Entspannung sind sehr vorsichtige, gleichmäßig
                         schaukelnde oder kreisende Bewegungen geeignet.''',
                         duration: 30,
                         socialForm:'Kleingruppe (4-8 Kinder)',
                         materials:'Gymnastikball',
                         ll: 0, be: 2, pk: 2, si: 1, hk: 0, tlt: 0,
                         qualifications:'keine',
                         requiredPaeds: 1).save()
    new ActivityTemplate(name:'Bewegungslandschaft',
                         attribution:'Psychomotorik',
                         description:'''Zuerst wird die Bewegungslandschaft gemeinsam besprochen, indem einzelne Kinder oder die
			                            Lehrperson die Bewegungsaufgaben an den Geräten vorzeigen. Bei dem akustischen Signal mit dem
			                            Tamburin erfolgt ein Richtungswechsel.<br /><br />
                                        Ablauf: Die Kinder springen beidbeinig/ einbeinig in die Reifen – fahren mit dem Rollbrett
                                        durch den Tunnel - springen auf den Kasten und wieder runter – gehen bzw. laufen vorwärts
                                        oder rückwärts auf den Langbänken – balancieren über das Seil – klettern die Sprossenwand
                                        hinauf und rutschen auf der Langbank hinunter.''',
                         duration: 90,
                         socialForm:'Großgruppe (bis 15 Kinder)',
                         materials:'3 Langbänke, 2 Seile, Kasten,Reifen (2x blau, 2x rot), Rollbrett,Matten, Schaumstofftunnel, Tamburin',
                         ll: 0, be: 3, pk: 1, si: 1, hk: 0, tlt: 0,
                         qualifications:'keine',
                         requiredPaeds: 2).save()
    new ActivityTemplate(name:'Schatten',
                         attribution:'Psychomotorik',
                         description:'''Es werden Paare gebildet. Jedes Paar erhält ein Material (Rollbrett, Skateboard, Sitzsack).
			Ein Kind setzt sich auf das Material bzw. Gerät und das andere Kind schiebt oder zieht das Kind.
			Der bzw. die SpielleiterIn oder ein Kind streckt die Arme waagrecht aus, dabei ändert diese Person
			die Richtung. Die anderen Kinder versuchen immer auf diese Person einen Schatten zu werfen, indem
			sie sich so schnell wie möglich hinter diese Person begeben. Vor diesem Spiel müssen die Kinder
			unbedingt mit den verschiedenen Materialien bzw. Geräten experimentieren können. Auch ist eine
			Einführung bezüglich der Anwendung des Materials bzw. des Geräts notwendig. Die Kinder sollen vor
			dem Spiel in experimenteller Art und Weise eigene Erfahrungen mit Rollbrett, Sitzsack und Skateboard.''',
                         duration: 30,
                         socialForm:'Partnerarbeit',
                         materials:'Rollbrett, Skateboard, Sitzsack, 2 Seile',
                         ll: 0, be: 3, pk: 2, si: 1, hk: 0, tlt: 0,
                         qualifications:'keine',
                         requiredPaeds: 1).save()
    new ActivityTemplate(name:'Blättertanz',
                         attribution:'Psychomotorik',
                         description:'''Jedes Kind sucht sich ein Blatt, von dem es denkt es sei das schönste Blatt der Welt. Alle Kinder
			deponieren ihr Blatt an einer Stelle des Raums, wo sie es wieder finden. Im Weiteren können
			verschiedene Spielvarianten (14-17) gewählt werden.''',
                         duration: 5,
                         socialForm:'Kleingruppe (bis 8 Kinder), Partnerarbeit',
                         materials:'Blätter',
                         ll: 0, be: 2, pk: 1, si: 1, hk: 0, tlt: 0,
                         qualifications:'keine',
                         requiredPaeds: 1).save()
    new ActivityTemplate(name:'Renn- und Schleichrunde',
                         attribution:'Psychomotorik',
                         description:'''Alle rennen so schnell sie können im Kreis. Auf ein Kommando hin müssen alle so langsam wie
                                        möglich gehen. Input: „Nun geht ihr über eine Herbstwiese, die übersät ist mit Schalen von
                                        Esskastanien.“<br />Nun rennen wieder alle ganz schnell. Auf ein Kommando müssen alle so
                                        langsam wie möglich gehen und es folgt ein neuer Input: „Ihr geht über eine Herbstwiese
                                        voller nasser glitschiger Blätter.“<br />Hiervon gibt es mehrere Runden. Die Abschlussrunde
                                        beinhaltet folgende Aufgabe: „Nun geht ihr über	eine Herbstwiese und findet das wunderschönste
                                        Blatt der Welt.''',
                         duration: 10,
                         socialForm:'Kleingruppe (bis 8 Kinder), Partnerarbeit',
                         materials:'Blätter',
                         ll: 0, be: 2, pk: 1, si: 1, hk: 0, tlt: 0,
                         qualifications:'keine',
                         requiredPaeds: 1).save()
    new ActivityTemplate(name:'Sinnliches Blatt',
                         attribution:'Psychomotorik',
                         description:'''Alle setzen sich in einem Sitzkreis zusammen und beschreiben welche Farbe, Geruch, Klang und
			                            Geschmack ihr Blatt hat.''',
                         duration: 10,
                         socialForm:'Kleingruppe (bis 8 Kinder), Partnerarbeit',
                         materials:'Blätter',
                         ll: 0, be: 2, pk: 1, si: 1, hk: 0, tlt: 0,
                         qualifications:'keine',
                         requiredPaeds: 1).save()
    new ActivityTemplate(name:'Blatt fällt solo',
                         attribution:'Psychomotorik',
                         description:'''Alle Kinder verteilen sich im Raum. Sie halten ihr Blatt hoch und lassen es los. Nun beobachtet
                                        jeder wie sein Blatt zu Boden fällt. Anschließend versucht jeder so zu Boden zu	fallen, wie es
                                        sein Blatt getan hat.''',
                         duration: 10,
                         socialForm:'Kleingruppe (bis 8 Kinder), Partnerarbeit',
                         materials:'Blätter',
                         ll: 0, be: 2, pk: 1, si: 1, hk: 0, tlt: 0,
                         qualifications:'keine',
                         requiredPaeds: 1).save()
    new ActivityTemplate(name:'Blatt fällt Gruppe',
                         attribution:'Psychomotorik',
                         description:'''Alle Kinder stehen im Kreis. Ein Kind geht in die Mitte und lässt sein Blatt zu Boden fallen.
                                        Alle beobachten dieses Blatt und versuchen genauso zu Boden zu fallen. Das Kind in der Mitte
                                        beobachtet wie "seine Blätter" zu Boden fallen. Zum Abschluss suchen sich die Kinder einen
                                        Partner und massieren und kitzeln sich gegenseitig mit ihren Blättern die Fußsohlen.''',
                         duration: 10,
                         socialForm:'Kleingruppe (bis 8 Kinder), Partnerarbeit',
                         materials:'Blätter',
                         ll: 0, be: 2, pk: 1, si: 1, hk: 0, tlt: 0,
                         qualifications:'keine',
                         requiredPaeds: 1).save()
    new ActivityTemplate(name:'ZeitungsträgerIn',
                         attribution:'Psychomotorik',
                         description:'''Große einzelne Zeitungsblätter werden jeweils über den Körper gehängt (Kopf, Arme, ggf. Beine).
			Ohne mit den Händen das Zeitungspapier zu halten, muss die Person die Zeitungsblätter ins Ziel
			tragen. Dieses Spiel kann auch als Staffelspiel gespielt werden. Fällt eine Zeitung herunter, werden
			diese an Ort und Stelle wieder aufgenommen. Oder: es zählen die Zeitungsblätter, die heil ins Ziel
			gebracht wurden ohne dass diese zuvor heruntergefallen sind.''',
                         duration: 30,
                         socialForm:'Kleingruppe (bis 6 Kinder)',
                         materials:'Zeitung',
                         ll: 0, be: 2, pk: 1, si: 0, hk: 0, tlt: 0,
                         qualifications:'keine',
                         requiredPaeds: 1).save()
    new ActivityTemplate(name:'Faltzeitung',
                         attribution:'Psychomotorik',
                         description:'Jedes Kind versucht ein Zeitungsblatt so oft wie möglich zu falten.',
                         duration: 15,
                         socialForm:'Einzelarbeit',
                         materials:'Zeitungen',
                         ll: 0, be: 1, pk: 0, si: 0, hk: 1, tlt: 0,
                         qualifications:'keine',
                         requiredPaeds: 1).save()
    new ActivityTemplate(name:'Spiele mit Zeitungspapier',
                         attribution:'Psychomotorik',
                         description:'''Die Zeitungen an die Kinder austeilen und die Kinder probieren lassen, was man alles damit machen
			kann. Bsp.: Zeitungen auf den Boden legen und darauf hüpfen, Zeitungen zusammenknüllen und werfen
			(z.B. in einen Eimer), Zeitungen in Stücke reißen, in einen Sack füllen und diesen Sack über einem
			Kind ausleeren etc.''',
                         duration: 15,
                         socialForm:'Klein- und Großgruppe',
                         materials:'Zeitungen',
                         ll: 0, be: 1, pk: 0, si: 0, hk: 1, tlt: 0,
                         qualifications:'keine',
                         requiredPaeds: 1).save()
    new ActivityTemplate(name:'Spiele mit Zeitungspapier 2',
                         attribution:'Psychomotorik',
                         description:'''Kleine Zeitungsschnipsel werden mit einem Trinkhhalm angesaugt und von Schüssel A nach
                                        Schüssel B gebracht. Alternativ können die Papierschnipsel aber auch mit chinesischen
                                        Stäbchen befördert werden.''',
                         duration: 15,
                         socialForm:'Einzelarbeit',
                         materials:'Zeitung, Trinkhalme, 2 Schüsseln',
                         ll: 0, be: 2, pk: 0, si: 0, hk: 0, tlt: 0,
                         qualifications:'keine',
                         requiredPaeds: 1).save()
    new ActivityTemplate(name:'Zeitungspuzzle',
                         attribution:'Psychomotorik',
                         description:'Eine Zeitungsseite wird zerschnitten und sodann wieder zusammengesetzt.',
                         duration: 15,
                         socialForm:'Einzelarbeit',
                         materials:'Zeitung',
                         ll: 0, be: 1, pk: 0, si: 1, hk: 0, tlt: 0,
                         qualifications:'keine',
                         requiredPaeds: 1).save()
    new ActivityTemplate(name:'Klopapierturm',
                         attribution:'Psychomotorik',
                         description:'''Mehrere aufeinander gestapelte Klopapierrollen werden eine Strecke weit balanciert.
			Wer schafft es am Weitesten ohne dass eine Rolle runter fällt? Wer kann die meisten Rollen auf
			einmal bis zum Ziel tragen?''',
                         duration: 15,
                         socialForm:'Einzelarbeit',
                         materials:'Klopapierrollen',
                         ll: 0, be: 2, pk: 0, si: 0, hk: 0, tlt: 0,
                         qualifications:'keine',
                         requiredPaeds: 1).save()
    new ActivityTemplate(name:'Zeitungsschlange',
                         attribution:'Psychomotorik',
                         description:'''Das Kind versucht aus einer Zeitungsseite die längste Schlange zu reißen. Mit einem
			Maßband wird die Länge der Schlange ermittelt.''',
                         duration: 15,
                         socialForm:'Einzelarbeit',
                         materials:'Zeitung',
                         ll: 0, be: 1, pk: 0, si: 0, hk: 1, tlt: 0,
                         qualifications:'keine',
                         requiredPaeds: 1).save()
    new ActivityTemplate(name:'Zeitungstanz',
                         attribution:'Psychomotorik',
                         description:'''Jeweils zwei Personen tanzen auf einem Zeitungsblatt zur Musik, nach einer gewissen Zeit
			wird jeweils die Zeitung halbiert/gefaltet und es wird weitergetanzt.''',
                         duration: 15,
                         socialForm:'Partnerarbeit',
                         materials:'Zeitung, Musik',
                         ll: 0, be: 2, pk: 1, si: 1, hk: 0, tlt: 0,
                         qualifications:'keine',
                         requiredPaeds: 1).save()
    new ActivityTemplate(name:'Bierdeckelspiele',
                         attribution:'Psychomotorik',
                         description:'''Hier gibt es verschiedene Varianten, die im Weiteren beschrieben werden:<br />
                                        Alle Kinder sitzen und klemmen den Bierdeckel zwischen die Füße. Nun versuchen sie, ihn über
                                        den Kopf abzulegen.<br />
                                        Alle sitzen auf dem Boden und klemmen den Bierdeckel zwischen die Füße. Nun lassen sie den
                                        Deckel Karussell fahren, indem sie sich um die eigene Achse drehen (Sitzkreisel).<br />
                                        Partnerarbeit: Ein  Kind hält den Reifen, das andere Kind versucht, Bierdeckel durch den
                                        Reifen zu werfen. Die Bierdeckel sind die Gleitschuhe, auf die sich die Kinder stellen und
                                        mit denen sie durch den Raum gleiten. Wer schafft es, den Raum zu erobern ohne seine Gleitschuhe
                                        zu verlieren?<br />
                                        Einander zurollen und oder als Frisbee werfen.<br />
                                        Die Kinder stehen mit einem Fuß auf einem Bierdeckel, einen Deckel halten sie in der Hand.
                                        Nun legen sie diesen Bierdeckel vor ihren Füßen ab, treten mit dem anderen Fuß darauf, nehmen
                                        den frei gewordenen Deckel auf und legen ihn wieder vor ihren Füßen ab usw. So legen sich die
                                        Kinder ihren eingenen Weg.<br />
                                        Zimmer putzen: Jeweils die Hälfte der Kinder wirft möglichst schnell die Bierdeckel	(Schmutz)
                                        aus ihrem Teil des Raumes in das gegnerische Feld. Nach Ablauf der Zeit wird die Anzahl der
                                        Bierdeckel in beiden Feldern gezählt.<br />
                                        Rollmarkt: Das Kind rollt den runden Bierdeckel möglichst weit,	durch eine Öffnung im Karton
                                        oder über eine Zielmarkierung hinaus.<br />
                                        Pyramiden bauen: Wer baut die höchste Pyramide?<br />
                                        Straßennetz: Die Kinder bauen ein Straßennetz aus Bierdeckeln auf (Abzweigungen, Kreuzungen
                                        etc.). Auf der Straße wird sodann behutsam balanciert, der Boden soll nicht berührt werden!''',
                         duration: 30,
                         socialForm:'Kleingruppe, Partnerarbeit',
                         materials:'Bierdeckel, Reifen',
                         ll: 0, be: 3, pk: 1, si: 1, hk: 0, tlt: 0,
                         qualifications:'keine',
                         requiredPaeds: 1).save()
    new ActivityTemplate(name:'Bierdeckel-Staffelspiele',
                         attribution:'Psychomotorik',
                         description:'''Es werden zwei Gruppen gebildet, folgende Spiele eignen sich als Staffel:<br />
                                        Bierdeckellauf: Bierdeckel müssen jeweils einzeln von A nach B gebracht werden.<br />
                                        Bierdeckelweg: Mit Hilfe von 3-4 Bierdeckeln darf nur auf diesen Bierdeckeln gelaufen werden.
                                        Die Berührung des Bodens ist nicht erlaubt.<br /><br />
                                        Auf dem Kopf balancieren: Bierdeckel müssen	als Staffel von A nach B gebracht werden. Die
                                        Bierdeckel werden diesmal jedoch auf dem Kopf balanciert. Die Anzahl der gleichzeitig beförderten
                                        Bierdeckel ist unwesentlich, fallen sie jedoch unterwegs vom Kopf, so geht’s zurück zum Start!<br />
                                        Körperkontakt: Zwei Kinder laufen gemeinsam los. Die Bierdeckel werden zwischen Kopf, Füßen, Bauch,
                                        Knie, Handballen, Ferse etc. geklemmt und dürfen nicht mit den Händen gehalten werden.
                                        Festgeklemmt: Bierdeckel zwischen die Knie klemmen und loslaufen. Dabei spielt es keine Rolle
                                        wie viele Bierdeckeln zwischen die Knie geklemmt werden.<br /><br />
                                        Känguru: Bierdeckel werden zwischen die Beine/Knie geklemmt, die Strecke wird nun gehüpft.
                                        Anschließend ist das nächste Kind an der Reihe. Zielwerfen mit Bierdeckeln: Ein Bierdeckel wird
                                        geworfen. Dort, wo der Bierdeckel gelandet ist, wird ein weiterer geworfen. Dies geht so lang,
                                        bis man die Ziellinie erreicht bzw. überschritten hat.
                                        Kellner: Der Bierdeckel dient als Tablett. Darauf müssen Erbsen, Bohnen etc. von A nach B
                                        transportiert werden. Es geht um Schnelligkeit und wie viele Erbsen in einer bestimmten	Zeit
                                        transportiert werden können. Heruntergefallene Erbsen dürfen nicht mehr aufgelesen werden.''',
                         duration: 30,
                         socialForm:'2 Kleingruppen (maximal 8 Kinder)',
                         materials:'Bierdeckel',
                         ll: 0, be: 3, pk: 1, si: 1, hk: 0, tlt: 0,
                         qualifications:'keine',
                         requiredPaeds: 1).save()
    new ActivityTemplate(name:'Fliegender Pilz',
                         attribution:'Psychomotorik',
                         description:'''Das Schwungtuch wird auf und ab bewegt. Wenn das Tuch nach oben schwingt, lassen alle los.
                                        Wohin fällt das Tuch?''',
                         duration: 15,
                         socialForm:'Großgruppe (bis 15 Kinder)',
                         materials:'Schwungtuch',
                         ll: 0, be: 2, pk: 0, si: 0, hk: 0, tlt: 0,
                         qualifications:'keine',
                         requiredPaeds: 2).save()
  }

    void createDefaultActivities() {
      log.debug ("==> creating default activities")

      /*for (int i=1;i<31;i++) {
         new Activity(title:'Ankunft',
                      owner:Entity.findByName('martin'),
                      date: new Date(2009-1900,11,i,11,00),
                      duration: 30,
                      paeds:[],
                      clients:[],
                      facility:Entity.findByName('kaumberg'),
                      template:'',
                      attribution:'Ankunft').save()
         new Activity(title:'Freies Spielen',
                      owner:Entity.findByName('martin'),
                      date: new Date(2009-1900,11,i,11,30),
                      duration: 60,
                      paeds:[],
                      clients:[],
                      facility:Entity.findByName('kaumberg'),
                      template:'',
                      attribution:'Spielen').save()
         new Activity(title:'Mittagessen',
                      owner:Entity.findByName('martin'),
                      date: new Date(2009-1900,11,i,12,30),
                      duration: 60,
                      paeds:[],
                      clients:[],
                      facility:Entity.findByName('kaumberg'),
                      template:'',
                      attribution:'Mittagessen').save()
         new Activity(title:'Betreuung HÜ',
                      owner:Entity.findByName('martin'),
                      date: new Date(2009-1900,11,i,13,30),
                      duration: 90,
                      paeds:[],
                      clients:[],
                      facility:Entity.findByName('kaumberg'),
                      template:'',
                      attribution:'Betreuung').save()

        // 15:00 to 17:30 time for Lernardo activities

         new Activity(title:'Gehen',
                      owner:Entity.findByName('martin'),
                      date: new Date(2009-1900,11,i,17,30),
                      duration: 30,
                      paeds:[],
                      clients:[],
                      facility:Entity.findByName('kaumberg'),
                      template:'',
                      attribution:'Ankunft').save()} */

      new Activity(title:'Weide mit Hindernissen',
            owner:Entity.findByName('hannah'),
            date: new Date(2009-1900,11,01,15,00),
            duration: 60,
            paeds:[Entity.findByName('alex'),Entity.findByName('mike')],
            clients:[Entity.findByName('alex'),Entity.findByName('mike')],
            facility:Entity.findByName('loewenzahn'),
            template:'Weide mit Hindernissen',
            attribution:'Psychomotorik').save()
      new Activity(title:'Schmetterlinge',
            owner:Entity.findByName('hannah'),
            date: new Date(2009-1900,11,01,16,00),
            duration: 30,
            paeds:[Entity.findByName('alex'),Entity.findByName('mike')],
            clients:[Entity.findByName('alex'),Entity.findByName('mike')],
            facility:Entity.findByName('loewenzahn'),
            template:'Schmetterlinge',
            attribution:'Psychomotorik').save()
      new Activity(title:'Luftballonmeer',
            owner:Entity.findByName('regina'),
            date: new Date(2009-1900,11,01,16,30),
            duration: 60,
            paeds:[Entity.findByName('alex'),Entity.findByName('mike')],
            clients:[Entity.findByName('alex'),Entity.findByName('mike')],
            facility:Entity.findByName('loewenzahn'),
            template:'Luftballonmeer',
            attribution:'Psychomotorik').save()
    }

  void createDefaultPosts() {
    log.debug ("==> creating default posts")

    new TemplateComment(content:'Sehr nette Aktivität! Die Beschreibung könnte aber noch etwas genauer ausgeführt werden.',
            author:Entity.findByName('regina'),
            template:ActivityTemplate.findByName('Schatten')).save()

    new ArticlePost(title:'Lernardo im Hort Kaumberg',
            teaser:'''Mit Beginn September 2009 erweitert Lernardo aufgrund der hohen Nachfrage und positiven
            Resonanz seine Einrichtungen mit einem neuen Standort in Kaumberg.''',
            content:'''Dank Kaumberg's Bürgermeister Michael Singraber konnte im Sommer 2009 sehr schnell
            passende Räumlichkeiten gefunden werden. Zur Verfügung gestellt wurde ein Klassenraum der Volksschule
            Kaumberg in dem ca. 10 Kinder zwischen 7 und 10 Jahre betreut werden. Der Beginn erfolgt am 07.
            September, als Hortleiterin wird Hannah Mutzbauer eingesetzt, die sich bereits in Hort Löwenzahn
            bewährt hat. Den Kindern stehen neben dem Klassenraum die Wiese sowie die Freizeitanlage der Schule
            zur vollen Verfügung.''',
            author:Entity.findByName('martin')).save()
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
            author:Entity.findByName('martin')).save()
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
            author:Entity.findByName('regina')).save()
  }

  void createDefaultEvents() {
    log.debug ("==> creating default events")

    FunctionService.createEvent(Entity.findByName('admin'), 'Elternsprechtag').save()
  }

  void createDefaultHelpers() {
    log.debug ("==> creating default helper")

    new Helper(title: 'Wie kann ich eine Aktivitätsvorlage erstellen?',
               content: '''Um eine Aktivitätsvorlage zu erstellen klicke zuerst auf "Aktivätsvorlagen" in der orangenen
                           Hauptnavigation. Dort findest du dann einen Button "Aktivitätsvorlage erstellen".''',
               type: metaDataService.etPaed.name).save()
    new Helper(title: 'Wie kann ich eine Aktivität planen?',
               content: '''Aktivitäten beruhen immer auf einer Aktivitätsvorlage. Klicke in der orangenen Hauptnavigation
                           auf "Aktivitätsvorlagen" und wähle dort eine Vorlage aus indem du auf dessen Namen klickst.
                           Im nächsten Schritt kannst du dann über den Button "Neue Aktivität planen" eine konkrete
                           Aktivität planen. Für jede Aktivität must du eine Einrichtung, Pädagogen und Betreute auswählen.''',
               type: metaDataService.etPaed.name).save()
    new Helper(title: 'Wie kann ich einen Artikel verfassen?',
               content: '''Artikel können direkt auf der Startseite verfasst werden. Klicke auf "Home" in der blauen
                           Navigationsleiste um dorthin zu gelangen und klicke auf den roten Link "Neuen Artikel verfassen".''',
               type: metaDataService.etPaed.name).save()
    new Helper(title: 'Wie kann ich jemandem eine Nachricht ins Postfach schicken?',
               content: '''Um jemandem eine Nachricht zu schicken musst du zuerst sein/ihr Profil besuchen. Dort findest
                           du dann links in der Seitennavigation den Punkt "Nachricht senden".''',
               type: metaDataService.etPaed.name).save()
    new Helper(title: 'Was ist das Netzwerk?',
               content: '''Im Netzwerk hast du eine Auflistung aller für dich relevanten User im ERP, wie deine Betreuten,
                           oder andere Pädagogen. Diese Liste kannst du selbst verwalten indem du andere Profile besuchst,
                           und dort Freunde oder Bookmarks hinzufügst.''',
               type: metaDataService.etPaed.name).save()
    new Helper(title: 'Wie kann ich eine Beurteilung eines Betreuten anlegen?',
               content: '''Besuche zuerst das Profil des Betreuten und klicke dort in der linken Seitennavigation auf
                           "Leistungsfortschritt anlegen".''',
               type: metaDataService.etPaed.name).save()

    new Helper(title: 'Wie kann ich einen Betreuten anlegen?',
               content: '''Betreute können über den Link "Betreuten anlegen" in der Seitennavigation links angelegt werden.
                           Notwendige Angaben müssen unbedingt ausgefüllt werden, zusätzliche Angaben sind optional und
                           können später noch über "Daten ändern" ergänzt oder geändert werden.''',
               type: metaDataService.etHort.name).save()

    new Helper(title: 'Wie funktioniert die Anwesenheits-/Essensliste? (AE-Liste)',
           content: '''In der AE-Liste werden alle im Hort betreuten Kinder aufgelistet. Für jedes Kind kann die Anwesenheit,
                       sowie die Teilnahme am Mittagessen eingetragen werden. Daraus lässt sich dann die Summe der Anwesenden
                       und die Gesamtsumme der Essenbeiträge ausrechnen. Es besteht außerdem die Möglichkeit diese Liste als
                       PDF anzuzeigen und bequem ausdrucken zu lassen.''',
           type: metaDataService.etHort.name).save()
  }

  void createDefaultEvaluations() {
    log.debug ("==> creating default evaluations")

    new Evaluation(owner: Entity.findByName('keano'),
                   description: 'Keano zeigt eine leichte Leseschwäche, die besonders beim Lesen quantenphysikalischer Literatur zu bemerken sind.',
                   method: 'Als Maßnahme habe ich ihm mehrere Kinderbücher gegeben, damit tut er sich offensichtlich leichter.',
                   writer: Entity.findByName('hannah')).save()
    new Evaluation(owner: Entity.findByName('kira'),
                   description: 'Kira ist ein wahres Genie. Keine Aufgabe macht ihr Probleme und sie hat sehr viel Spaß. Ich glaube aber sie hat Symptome von Hyperaktivität.',
                   method: 'Ich möchte mit ihr verstärkt Interventionen machen, die weniger kopflastig sind.',
                   writer: Entity.findByName('hannah')).save()
  }

  void createDefaultAttendances() {
    log.debug ("==> creating default attendances")

    def a = new Attendance(clients: Entity.findByName('kira'),
                   didAttend: [true, true],
                   didEat: [true, false],
                   date: new Date()).save()
    a.clients << Entity.findByName('keano')
  }
}