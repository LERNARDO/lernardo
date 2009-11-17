import de.uenterprise.ep.EntityType
import de.uenterprise.ep.Entity

import profiles.UserProfile
import de.uenterprise.ep.Link
import profiles.FacProfile

class BootStrap {
  //def profileDataService
  //def activityDataService
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
      createDefaultActivityTemplates()
      createDefaultActivities()
      createDefaultPosts()
      //profileDataService.init()
      //activityDataService.init()
      calendarDataService.init()
    }
  }

  def destroy = {
  }

  void createDefaultUsers() {
    log.debug ("==> creating default users")
    EntityType etPerson = metaDataService.etUser

    // an admin user
    entityHelperService.createEntityWithUserAndProfile("admin", etPerson, "admin@lernardo.at", "Lernardo Admin") {Entity ent ->
      ent.user.addToAuthorities(metaDataService.adminRole)
      UserProfile prf = ent.profile
      ent.profile.tagline = "to be on top is our job"
      prf.gender = 1
      prf.title = "-"
      prf.birthDate = new Date()
      prf.PLZ = 1000
      prf.city = "Wien"
      prf.street = "Riemergasse 14"
      prf.tel = "-"
      prf.gender = 1
      prf.biography = "-"
    }

    // a mod user
    entityHelperService.createEntityWithUserAndProfile("alex", etPerson, "aaz@lernardo.at", "Alexander Zeillinger") {Entity ent ->
      ent.user.addToAuthorities(metaDataService.modRole)
      UserProfile prf = ent.profile
      prf.tagline = "Simplicity is the ultimate sophistication"
      prf.gender = 1
      prf.city = "Gumpoldskirchen"
      prf.birthDate = new Date(1982-1900,02,22)
      prf.PLZ = 2352
      prf.street = "Rudolf Tamchina Gasse 5/5"
    }

    // some regular users
    entityHelperService.createEntityWithUserAndProfile("patrizia", etPerson, "pcr@lernardo.at", "Patrizia Rosenkranz") {Entity ent ->
      UserProfile prf = ent.profile
      prf.birthDate = new Date(1983-1900, 07, 20)
      prf.gender = 2
      prf.city = "Berndorf"
    }

    entityHelperService.createEntityWithUserAndProfile("mike", etPerson, "mpk@lernardo.at", "Mike P. Kuhl") {Entity ent ->
      UserProfile prf = ent.profile
      prf.tagline = "Wozu brauch ma des?"
      prf.gender = 1
      prf.city = "Wien"
    }

    entityHelperService.createEntityWithUserAndProfile("johannes", etPerson, "jlz@lernardo.at", "Johannes L. Zeitelberger") {Entity ent ->
      UserProfile prf = ent.profile
      prf.tagline = "Ich will die Welt im ERP abbilden!"
      prf.gender = 1
      prf.PLZ = 2560
      prf.city = "Berndorf"
      prf.street = "Wankengasse 10"
      prf.tel = "0664 / 840 66 20"
    }

    entityHelperService.createEntityWithUserAndProfile("susanne", etPerson, "sst@lernardo.at", "Susanne Stiedl") {Entity ent ->
      UserProfile prf = ent.profile
      prf.tagline = "..."
      prf.gender = 2
      prf.city = "Berndorf"
    }

    entityHelperService.createEntityWithUserAndProfile("birgit", etPerson, "bib@lernardo.at", "Birgit Blaesen") {Entity ent ->
      UserProfile prf = ent.profile
      prf.tagline = "..."
      prf.gender = 2
      prf.city = "Berndorf"
    }

    entityHelperService.createEntityWithUserAndProfile("hannah", etPerson, "hmb@lernardo.at", "Hannah Mutzbauer") {Entity ent ->
      UserProfile prf = ent.profile
      prf.tagline = "..."
      prf.gender = 2
      prf.city = "Kaumberg"
    }

    entityHelperService.createEntityWithUserAndProfile("regina", etPerson, "rgt@lernardo.at", "Regina Toncourt") {Entity ent ->
      UserProfile prf = ent.profile
      prf.tagline = "..."
      prf.gender = 2
      prf.city = "Weissenbach"
    }

  }

  void createDefaultFacs () {
    log.debug ("==> creating default facilities")
    EntityType etFac = metaDataService.etHort

    entityHelperService.createEntityWithUserAndProfile ("loewenzahn", etFac, "loewenzahn@lernardo.at", "Hort Löwenzahn") {Entity ent->
      FacProfile prf = ent.profile
      prf.PLZ = 2564
      prf.city = "Weissenbach an der Triesting"
      prf.street = "Hauptstraße 12"
      prf.tel   = "0676 / 880 604 001"
      prf.opened = "Mo-Fr, 11 bis 18 Uhr"
      //prf.speaker = Entity.findByName('regina')
      prf.description = "Der erste unter Lernardo betriebene Hort."
    }

    entityHelperService.createEntityWithUserAndProfile ("kaumberg", etFac, "kaumberg@lernardo.at", "Hort Kaumberg") {Entity ent->
      FacProfile prf = ent.profile
      prf.PLZ = 2572
      prf.city = "Kaumberg"
      prf.street = "?"
      prf.tel   = "0660 / 461 1106"
      prf.opened = "?"
      //prf.speaker = Entity.findByName('hannah')
      prf.description = "Der zweite unter Lernardo betriebene Hort."
    }
  }

  void createDefaultLinks () {
    log.debug ("==> creating default links")
    def mike = Entity.findByName ('mike')
    def alex = Entity.findByName ('alex')
    def patrizia = Entity.findByName ('patrizia')

    // Person Links
    new Link(source:mike, target:alex,  type:metaDataService.ltFriend).save()
    new Link(source:alex, target:mike,  type:metaDataService.ltFriend).save()
    new Link(source:alex, target:patrizia, type:metaDataService.ltFriend).save()
    new Link(source:patrizia, target:alex, type:metaDataService.ltFriend).save()
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

     /*

	templates.id_14 = [name:'Renn- und Schleichrunde',
            id:'14',
            zuordnung:'Psychomotorik',
            beschreibung:'''Alle rennen so schnell sie können im Kreis. Auf ein Kommando hin müssen alle so langsam wie
			möglich gehen.
Input: „Nun geht ihr über eine Herbstwiese, die übersät ist mit Schalen von Esskastanien.“

<br />Nun rennen wieder alle ganz schnell. Auf ein Kommando müssen alle so langsam wie möglich gehen
			und es folgt ein neuer Input: „Ihr geht über eine Herbstwiese voller nasser glitschiger Blätter.“ <br />

Hiervon gibt es mehrere Runden. Die Abschlussrunde beinhaltet folgende Aufgabe: „Nun geht ihr über
			eine Herbstwiese und findet das wunderschönste Blatt der Welt.''',
            dauer:'10 Minuten',
            sozialform:'Kleingruppe (bis 8 Kinder),Partnerarbeit',
            materialien:'Blätter',
            ll: '0',
            be: '2',
            pk: '1',
            si: '1',
            hk: '0',
            tlt: '0',
            qualifikationen:'keine',
            anzahlPaedagogen:'1']

	templates.id_15 = [name:'Sinnliches Blatt',
            id:'15',
            zuordnung:'Psychomotorik',
            beschreibung:'''Alle setzen sich in einem Sitzkreis zusammen und beschreiben welche Farbe, Geruch, Klang und
			Geschmack ihr Blatt hat.''',
            dauer:'10 Minuten',
            sozialform:'Kleingruppe (bis 8 Kinder),Partnerarbeit',
            materialien:'Blätter',
            ll: '0',
            be: '2',
            pk: '1',
            si: '1',
            hk: '0',
            tlt: '0',
            qualifikationen:'keine',
            anzahlPaedagogen:'1']

	templates.id_16 = [name:'Blatt fällt solo',
            id:'16',
            zuordnung:'Psychomotorik',
            beschreibung:'''Alle Kinder verteilen sich im Raum. Sie halten ihr Blatt hoch und lassen es los.
			Nun beobachtet jeder wie sein Blatt zu Boden fällt. Anschließend versucht jeder so zu Boden zu
			fallen, wie es sein Blatt getan hat.''',
            dauer:'10 Minuten',
            sozialform:'Kleingruppe (bis 8 Kinder),Partnerarbeit',
            materialien:'Blätter',
            ll: '0',
            be: '2',
            pk: '1',
            si: '1',
            hk: '0',
            tlt: '0',
            qualifikationen:'keine',
            anzahlPaedagogen:'1']


	templates.id_17 = [name:'Blatt fällt Gruppe',
            id:'17',
            zuordnung:'Psychomotorik',
            beschreibung:'''Alle Kinder stehen im Kreis. Ein Kind geht in die Mitte und lässt sein Blatt zu Boden
			fallen. Alle beobachten dieses Blatt und versuchen genauso zu Boden zu fallen. Das Kind in der
			Mitte beobachtet wie ""seine Blätter"" zu Boden fallen.

Zum Abschluss suchen sich die Kinder
			einen Partner und massieren und kitzeln sich gegenseitig mit ihren Blättern die Fußsohlen.''',
            dauer:'10 Minuten',
            sozialform:'Kleingruppe (bis 8 Kinder),Partnerarbeit',
            materialien:'Blätter',
            ll: '0',
            be: '2',
            pk: '1',
            si: '1',
            hk: '0',
            tlt: '0',
            qualifikationen:'keine',
            anzahlPaedagogen:'1']

	templates.id_18 = [name:'ZeitungsträgerIn',
            id:'18',
            zuordnung:'Psychomotorik',
            beschreibung:'''Große einzelne Zeitungsblätter werden jeweils über den Körper gehängt (Kopf, Arme, ggf. Beine).
			Ohne mit den Händen das Zeitungspapier zu halten, muss die Person die Zeitungsblätter ins Ziel
			tragen. Dieses Spiel kann auch als Staffelspiel gespielt werden. Fällt eine Zeitung herunter, werden
			diese an Ort und Stelle wieder aufgenommen. Oder: es zählen die Zeitungsblätter, die heil ins Ziel
			gebracht wurden ohne dass diese zuvor heruntergefallen sind.''',
            dauer:'30 Minuten',
            sozialform:'Kleingruppe (bis 6 Kinder)',
            materialien:'Zeitung',
            ll: '0',
            be: '2',
            pk: '1',
            si: '0',
            hk: '0',
            tlt: '0',
            qualifikationen:'keine',
            anzahlPaedagogen:'1']

	templates.id_19 = [name:'Faltzeitung',
            id:'19',
            zuordnung:'Psychomotorik',
            beschreibung:'''Jedes Kind versucht ein Zeitungsblatt so oft wie möglich zu falten.''',
            dauer:'15 Minuten',
            sozialform:'Einzelarbeit',
            materialien:'Zeitungen',
            ll: '0',
            be: '1',
            pk: '0',
            si: '0',
            hk: '1',
            tlt: '0',
            qualifikationen:'keine',
            anzahlPaedagogen:'1']

	templates.id_20 = [name:'Spiele mit Zeitungspapier',
            id:'20',
            zuordnung:'Psychomotorik',
            beschreibung:'''Die Zeitungen an die Kinder austeilen und die Kinder probieren lassen, was man alles damit machen
			kann. Bsp.: Zeitungen auf den Boden legen und darauf hüpfen, Zeitungen zusammenknüllen und werfen
			(z.B. in einen Eimer), Zeitungen in Stücke reißen, in einen Sack füllen und diesen Sack über einem
			Kind ausleeren etc.''',
            dauer:'15 Minuten',
            sozialform:'Klein- und Großgruppe',
            materialien:'Zeitungen',
            ll: '0',
            be: '1',
            pk: '0',
            si: '0',
            hk: '1',
            tlt: '0',
            qualifikationen:'keine',
            anzahlPaedagogen:'1']

	templates.id_21 = [name:'Spiele mit Zeitungspapier',
            id:'21',
            zuordnung:'Psychomotorik',
            beschreibung:'''Kleine Zeitungsschnipsel werden mit einem Trinkhhalm
angesaugt und von Schüssel A
			nach Schüssel B gebracht.
Alternativ können die Papierschnipsel aber auch mit
chinesischen
			Stäbchen befördert werden.''',
            dauer:'15 Minuten',
            sozialform:'Einzelarbeit',
            materialien:'Zeitung, Trinkhalme, 2 Schüsseln',
            ll: '0',
            be: '2',
            pk: '0',
            si: '0',
            hk: '0',
            tlt: '0',
            qualifikationen:'keine',
            anzahlPaedagogen:'1']

	templates.id_22 = [name:'Zeitungspuzzle',
            id:'22',
            zuordnung:'Psychomotorik',
            beschreibung:'''Eine Zeitungsseite wird zerschnitten und sodann wieder zusammengesetzt.''',
            dauer:'15 Minuten',
            sozialform:'Einzelarbeit',
            materialien:'Zeitung',
            ll: '0',
            be: '1',
            pk: '0',
            si: '1',
            hk: '0',
            tlt: '0',
            qualifikationen:'keine',
            anzahlPaedagogen:'1']

	templates.id_23 = [name:'Klopapierturm',
            id:'23',
            zuordnung:'Psychomotorik',
            beschreibung:'''Mehrere aufeinander gestapelte Klopapierrollen werden eine Strecke weit balanciert.
			Wer schafft es am Weitesten ohne dass eine Rolle runter fällt? Wer kann die meisten Rollen auf
			einmal bis zum Ziel tragen?''',
            dauer:'15 Minuten',
            sozialform:'Einzelarbeit',
            materialien:'Klopapierrollen',
            ll: '0',
            be: '2',
            pk: '0',
            si: '0',
            hk: '0',
            tlt: '0',
            qualifikationen:'keine',
            anzahlPaedagogen:'1']

	templates.id_24 = [name:'Zeitungsschlange',
            id:'24',
            zuordnung:'Psychomotorik',
            beschreibung:'''Das Kind versucht aus einer Zeitungsseite die längste Schlange zu reißen. Mit einem
			Maßband wird die Länge der Schlange ermittelt.''',
            dauer:'15 Minuten',
            sozialform:'Einzelarbeit',
            materialien:'Zeitung',
            ll: '0',
            be: '1',
            pk: '0',
            si: '0',
            hk: '1',
            tlt: '0',
            qualifikationen:'keine',
            anzahlPaedagogen:'1']

	templates.id_25 = [name:'Zeitungstanz',
            id:'25',
            zuordnung:'Psychomotorik',
            beschreibung:'''Jeweils zwei Personen tanzen auf einem Zeitungsblatt zur Musik, nach einer gewissen Zeit
			wird jeweils die Zeitung halbiert/gefaltet und es wird weitergetanzt.''',
            dauer:'15 Minuten',
            sozialform:'Partnerarbeit',
            materialien:'Zeitung, Musik',
            ll: '0',
            be: '2',
            pk: '1',
            si: '1',
            hk: '0',
            tlt: '0',
            qualifikationen:'keine',
            anzahlPaedagogen:'1']

	templates.id_26 = [name:'Bierdeckelspiele',
            id:'26',
            zuordnung:'Psychomotorik',
            beschreibung:'''Hier gibt es verschiedene Varianten, die im Weiteren beschrieben werden:
 <br />
Alle Kinder sitzen
			und klemmen den Bierdeckel zwischen die Füße.
Nun versuchen sie, ihn über den Kopf abzulegen. <br />

Alle
			sitzen auf dem Boden und klemmen den Bierdeckel zwischen die
Füße. Nun lassen sie den Deckel Karussell
			fahren, indem sie sich um
die eigene Achse drehen (Sitzkreisel). <br />

Partnerarbeit: Ein  Kind hält
			den Reifen, das andere Kind versucht,
Bierdeckel durch den Reifen zu werfen.

Die Bierdeckel sind die
			Gleitschuhe, auf die sich die Kinder stellen und
mit denen sie durch den Raum gleiten. Wer schafft es,
			den Raum zu
erobern ohne seine Gleitschuhe zu verlieren? <br />

Einander zurollen und oder als Frisbee
			werfen.

<br />Die Kinder stehen mit einem Fuß auf einem Bierdeckel, einen Deckel
halten sie in der Hand.
			Nun legen sie diesen Bierdeckel vor ihren Füßen
ab, treten mit dem anderen Fuß darauf, nehmen den
			frei gewordenen
Deckel auf und legen ihn wieder vor ihren Füßen ab usw. So legen sich
die Kinder
			ihren eingenen Weg.

<br />Zimmer putzen: Jeweils die Hälfte der Kinder wirft möglichst schnell die
Bierdeckel
			(Schmutz) aus ihrem Teil des Raumes in das gegnerische Feld.
Nach Ablauf der Zeit wird die Anzahl der
			Bierdeckel in beiden Feldern gezählt. <br />

Rollmarkt: Das Kind rollt den runden Bierdeckel möglichst weit,
			durch eine
Öffnung im Karton oder über eine Zielmarkierung hinaus <br />

Pyramiden bauen: Wer baut die höchste
			Pyramide? <br />

Straßennetz: Die Kinder bauen ein Straßennetz aus Bierdeckeln auf
(Abzweigungen, Kreuzungen
			etc.). Auf der Straße wird sodann behutsam
balanciert, der Boden soll nicht berührt werden!''',
            dauer:'30 Minuten',
            sozialform:'Kleingruppe, Partnerarbeit',
            materialien:'Bierdeckel, Reifen',
            ll: '0',
            be: '3',
            pk: '1',
            si: '1',
            hk: '0',
            tlt: '0',
            qualifikationen:'keine',
            anzahlPaedagogen:'1']

	templates.id_27 = [name:'Bierdeckel-Staffelspiele',
            id:'27',
            zuordnung:'Psychomotorik',
            beschreibung:'''Es werden zwei Gruppen gebildet, folgende Spiele eignen sich als Staffel:<br />


Bierdeckellauf: Bierdeckel müssen jeweils einzeln von A nach B gebracht
werden.<br />


Bierdeckelweg: Mit Hilfe von 3-4 Bierdeckeln darf nur auf diesen
Bierdeckeln gelaufen werden.
			Die Berührung des Bodens ist nicht erlaubt.

 <br /><br />Auf dem Kopf balancieren: Bierdeckel müssen
			als Staffel von A nach B gebracht
werden. Die Bierdeckel werden diesmal jedoch auf dem Kopf balanciert.

Die Anzahl der gleichzeitig beförderten Bierdeckel ist unwesentlich, fallen sie
jedoch unterwegs
			vom Kopf, so geht’s zurück zum Start! <br />

Körperkontakt: Zwei Kinder laufen gemeinsam los. Die
			Bierdeckel werden
zwischen Kopf, Füßen, Bauch, Knie, Handballen, Ferse etc. geklemmt und
dürfen
			nicht mit den Händen gehalten werden.

Festgeklemmt: Bierdeckel zwischen die Knie klemmen und loslaufen.

Dabei spielt es keine Rolle wie viele Bierdeckeln zwischen die Knie geklemmt werden.

 <br /><br />
			Känguru: Bierdeckel werden zwischen die Beine/Knie geklemmt, die Strecke wird
nun gehüpft. Anschließend
			ist das nächste Kind an der Reihe.

Zielwerfen mit Bierdeckeln: Ein Bierdeckel wird geworfen. Dort, wo der
			Bierdeckel
gelandet ist, wird ein weiterer geworfen. Dies geht so lang, bis man die Ziellinie
erreicht
			bzw. überschritten hat.

Kellner: Der Bierdeckel dient als Tablett. Darauf müssen Erbsen, Bohnen etc.

			von A nach B transportiert werden. Es geht um Schnelligkeit und wie viele Erbsen
in einer bestimmten
			Zeit transportiert werden können. Heruntergefallene Erbsen
dürfen nicht mehr aufgelesen werden.
''',
            dauer:'30 Minuten',
            sozialform:'2 Kleingruppen (maximal 8 Kinder)',
            materialien:'Bierdeckel',
            ll: '0',
            be: '3',
            pk: '1',
            si: '1',
            hk: '0',
            tlt: '0',
            qualifikationen:'keine',
            anzahlPaedagogen:'1']

	templates.id_28 = [name:'Fliegender Pilz',
            id:'28',
            zuordnung:'Psychomotorik',
            beschreibung:'''Das Schwungtuch wird auf und ab bewegt. Wenn das Tuch nach oben schwingt, lassen alle los.
			Wohin fällt das Tuch?''',
            dauer:'15 Minuten',
            sozialform:'Großgruppe (bis 15 Kinder)',
            materialien:'Schwungtuch',
            ll: '0',
            be: '2',
            pk: '0',
            si: '0',
            hk: '0',
            tlt: '0',
            qualifikationen:'keine',
            anzahlPaedagogen:'2']*/
  }

    void createDefaultActivities() {
      log.debug ("==> creating default activities")

      new Activity(title:'Weide mit Hindernissen',
            owner:Entity.findByName('alex'),
            date: new Date(2009-1900,10,01,15,30),
            duration: 60,
            paeds:[Entity.findByName('alex'),Entity.findByName('mike')],
            clients:[Entity.findByName('alex'),Entity.findByName('mike')],
            facility:Entity.findByName('loewenzahn')).save()
      new Activity(title:'Schmetterlinge',
            owner:Entity.findByName('alex'),
            date: new Date(2009-1900,10,01,16,30),
            duration: 30,
            paeds:[Entity.findByName('alex'),Entity.findByName('mike')],
            clients:[Entity.findByName('alex'),Entity.findByName('mike')],
            facility:Entity.findByName('loewenzahn')).save()
      new Activity(title:'Luftballonmeer',
            owner:Entity.findByName('alex'),
            date: new Date(2009-1900,10,02,15,30),
            duration: 45,
            paeds:[Entity.findByName('alex'),Entity.findByName('mike')],
            clients:[Entity.findByName('alex'),Entity.findByName('mike')],
            facility:Entity.findByName('loewenzahn')).save()
    }

  void createDefaultPosts() {
    log.debug ("==> creating default activity templates")

    new PostType(name:'article').save()
    new PostType(name:'comment').save()

    PostType pt = PostType.findByName('article')

    new Post(type:pt,
            title:'Lernardo im Hort Kaumberg',
            teaser:'''Mit Beginn September 2009 erweitert Lernardo aufgrund der hohen Nachfrage und positiven
            Resonanz seine Einrichtungen mit einem neuen Standort in Kaumberg.''',
            content:'''Dank Kaumberg's Bürgermeister Michael Singraber konnte im Sommer 2009 sehr schnell
            passende Räumlichkeiten gefunden werden. Zur Verfügung gestellt wurde ein Klassenraum der Volksschule
            Kaumberg in dem ca. 10 Kinder zwischen 7 und 10 Jahre betreut werden. Der Beginn erfolgt am 07.
            September, als Hortleiterin wird Hannah Mutzbauer eingesetzt, die sich bereits in Hort Löwenzahn
            bewährt hat. Den Kindern stehen neben dem Klassenraum die Wiese sowie die Freizeitanlage der Schule
            zur vollen Verfügung.''',
            author:Entity.findByName('alex')).save()
    new Post(type:pt,
            title:'Gesund durch Ernährungsexpertin',
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
            author:Entity.findByName('alex')).save()
    new Post(type:pt,
            title:'Hort Löwenzahn erhält Auszeichnung',
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
            author:Entity.findByName('alex')).save()
  }
  
}