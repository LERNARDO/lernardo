import grails.util.Environment

// locations to search for config files that get merged into the main config
// config files can either be Java properties files or ConfigSlurper scripts

// grails.config.locations = [ "classpath:${appName}-config.properties",
//                             "classpath:${appName}-config.groovy",
//                             "file:${userHome}/.grails/${appName}-config.properties",
//                             "file:${userHome}/.grails/${appName}-config.groovy"]

def myenv = Environment.current;
def configFile = "file:${System.properties.'catalina.base' ?: System.properties.'base.dir'}/app-config/lernardo-config.groovy"
println "[$myenv] reading configuration from $configFile"
grails.config.locations = [ configFile ]

grails.mime.file.extensions = true // enables the parsing of file extensions from URLs into the request format
grails.mime.use.accept.header = false
grails.mime.types = [ html: ['text/html','application/xhtml+xml'],
                      xml: ['text/xml', 'application/xml'],
                      text: 'text/plain',
                      js: 'text/javascript',
                      rss: 'application/rss+xml',
                      atom: 'application/atom+xml',
                      css: 'text/css',
                      csv: 'text/csv',
                      all: '*/*',
                      json: ['application/json','text/json'],
                      form: 'application/x-www-form-urlencoded',
                      multipartForm: 'multipart/form-data'
                    ]
// The default codec used to encode data with ${}
grails.views.default.codec="none" // none, html, base64
grails.views.gsp.encoding="UTF-8"
grails.converters.encoding="UTF-8"

// enabled native2ascii conversion of i18n properties files
grails.enable.native2ascii = true

grails.views.javascript.library="jquery"

jquery {
    sources = 'jquery' // Holds the value where to store jQuery-js files /web-app/js/
    version = '1.4.2' // The jQuery version in use
}

grails {
  mail {
    host = "smtp.gmail.com"
    port = 465
    username = "lernardomailer@gmail.com"
    password = "theansweris42"
    props = ["mail.smtp.auth":"true",
    "mail.smtp.socketFactory.port":"465",
    "mail.smtp.socketFactory.class":"javax.net.ssl.SSLSocketFactory",
    "mail.smtp.socketFactory.fallback":"false"]
  }
}

secmgr {
  starturl     = "/start"
  publicurl    = "/"
}

// log4j configuration
log4j = {
    // Example of changing the log pattern for the default console
    // appender:
    //
    //appenders {
    //    console name:'stdout', layout:pattern(conversionPattern: '%c{2} %m%n')
    //}
    appenders {
     'null' name: 'stacktrace'  // turn off stacktrace.log

     console(
             name: 'stdout',
             threshold: org.apache.log4j.Level.DEBUG,
             layout: pattern(conversionPattern: "${appName}%d{HH:mm:ss} [%5p] %c %m%n"))
   }

   root {
     error "stdout"
   }


    /*error  'org.codehaus.groovy.grails.web.servlet',  //  controllers
	       'org.codehaus.groovy.grails.web.pages', //  GSP
	       'org.codehaus.groovy.grails.web.sitemesh', //  layouts
	       'org.codehaus.groovy.grails.web.mapping.filter', // URL mapping
	       'org.codehaus.groovy.grails.web.mapping', // URL mapping
	       'org.codehaus.groovy.grails.commons', // core / classloading
	       'org.codehaus.groovy.grails.plugins', // plugins
	       'org.codehaus.groovy.grails.orm.hibernate', // hibernate integration
	       'org.springframework',
	       'org.hibernate'

    warn   'org.mortbay.log'*/

  info   'grails.app'
  info   'grails.app.tagLib'
  info  'grails.app.bootstrap'
  info  'grails.app.dataSource'
  info  'grails.app.controller'
  info  'grails.app.service'

}

// change this value to control the amount of bootstrapped dummy entities
dummies = 20

// the default password used when creating new entity accounts
defaultpass = "pass"

// custom maps to store data
nationalities_de = ['1':'Deutschland','2':'England','3':'Frankreich','4':'Spanien','5':'Portugal','6':'Österreich','7':'Mexiko','8':'Italien']
nationalities_es = ['1':'Alemania','2':'Inglaterra','3':'Francia','4':'España','5':'Portugal','6':'Austria','7':'México','8':'Italia']
languages_de = ['1':'Spanisch','2':'Deutsch','3':'Englisch','4':'Französisch','5':'Mexikanisch','6':'Tsotsil','7':'Tseltal','8':'Zoque',
                '9':'Tojolabal','10':'Kanjobal','11':'Lacandon','12':'Quiche','13':'Chol','14':'Cakchiquel']
languages_es = ['1':'español','2':'alemán','3':'inglés','4':'francés','5':'mexicana','6':'Tsotsil','7':'Tseltal','8':'Zoque','9':'Tojolabal',
                '10':'Kanjobal','11':'Lacandon','12':'Quiche','13':'Chol','14':'Cakchiquel']

locales = [new Locale ("de", "DE"), new Locale ("es", "ES")]
inchargeof_de = ['1':'Direktion','2':'Programmkoordination','3':'Programm','4':'Projekt','5':'Bereiche','6':'Tutor','7':'Köchin','8':'Freiwilliger']
inchargeof_es = ['1':'Direktion','2':'Programmkoordination','3':'Programm','4':'Projekt','5':'Bereiche','6':'Tutor','7':'Köchin','8':'Freiwilliger']
jobs_de = ['1':'Schuhputzer','2':'Kaugummiverkäufer','3':'Kunsthandwerkverkäufer','4':'Bauhilfsarbeiter','5':'Hausarbeit','6':'Kinderaufpassen',
           '7':'Autowäscher','8':'Austeiler (Werbung)','9':'Träger, Verpacker im Supermarkt','10':'Hilfe in Werkstatt',
           '11':'Kunsthandwerker (Textil, Schmuck)','12':'Müllsammler','13':'Autoscheibenputzer','14':'Fahrgeldeinsammler (öfftl. Kleinbusse)']
jobs_es = ['1':'Boleros','2':'Chicleros','3':'Vendedores de artesanías','4':'Ayudantes de albañil (peón)','5':'Trabajo doméstico','6':'Niñeras-os',
           '7':'Lavadores de coches','8':'Repartidores','9':'Cargadores (bolsas del mercado)','10':'Ayudantes de mecánica',
           '11':'Artesanos (bordadores-pulseras-madera-collares)','12':'Pepenadores (recoger basura)','13':'Limpia parabrisas',
           '14':'Cobradores (colectivos)']
problems_de = ['1':'Alkoholismus','2':'Drogen','3':'Vandalismus','4':'Trennung (Mutter-Vater)','5':'Abwesenheit des Vaters / der Mutter',
               '6':'Gewalt (psychologisch, sexuell, symbolisch, physisch (Eltern gegen die Kinder, Partner untereinander)',
               '7':'Arbeitslosigkeit','8':'Armut (Hunger, Krankheiten, Not)','9':'Behinderung/Krankheit eines Familienangehörigen',
               '10':'Ablehnung der Kinder von Vater/Mutter','11':'Waisen']
problems_es = ['1':'Alcoholismo','2':'Drogadicción','3':'Vandalismo','4':'Separación (mamá-papá)','5':'Ausencia del padre-madre',
               '6':'Violencia: psicológica, sexual, simbólica, física (de madre-padre hacía los hij@s, de pareja a pareja)',
               '7':'Desempleo','8':'Pobreza','9':'Discapacidad de un familiar','10':'Rechazo de padres-madres hacia los hijos','11':'Horfandad']
schoolLevels_de = ['1':'1. Kl. Primarschule','2':'2. Kl. Primarschule','3':'3. Kl. Primarschule','4':'4. Kl. Primarschule','5':'5. Kl. Primarschule',
                   '6':'6. Kl. Primarschule','7':'1. Kl. Sekundarschule','8':'2. Kl. Sekundarschule','9':'3. Kl. Sekundarschule',
                   '10':'1. Kl. Preparatoria','11':'2. Kl. Preparatoria','12':'3. Kl. Preparatoria','13':'Studium']
schoolLevels_es = ['1':'1er grado primaria','2':'2do grado primaria','3':'3er grado primaria','4':'4to grado primaria','5':'5to grado primaria',
                   '6':'6to grado primaria','7':'1er grado secundaria','8':'2er grado secundaria','9':'3er grado secundaria','10':'1er grado preparatoria',
                   '11':'2er grado preparatoria','12':'3er grado preparatoria','13':'Estudios']
partner_de = ['1':'Projekte, Arbeit','2':'Dienstleistungen','3':'Finanzierung','4':'Personal (Freiwillige)']
partner_es = ['1':'en colaboración','2':'Prestadores de servicios','3':'Monetarios','4':'Personal (voluntarios)']
familyRelation_de = ['1':'Eltern','2':'Vater','3':'Mutter','4':'Andere']
familyRelation_es = ['1':'Padres','2':'Padre','3':'Madre','4':'Otros']
maritalStatus_de = ['1':'ledig','2':'verheiratet','3':'getrennt lebend','4':'geschieden','5':'verwitwet','6':'verpartnert','7':'unbekannt']
maritalStatus_es = ['1':'soltero','2':'casado','3':'separado','4':'ser divorciado','5':'viudo','6':'e_verpartnert','7':'desconocido']

quotesMap = ['00':'Die Aufgabe der Umgebung ist nicht das Kind zu formen, sondern ihm zu erlauben, sich zu offenbaren.',
             '01':'Kinder - die lebenden Botschaften, die wir einer Zeit übermitteln, an der wir selbst nicht mehr teilhaben werden.',
             '02':'Der Erwachsene achtet auf Taten, das Kind auf Liebe.',
             '03':'Die Fragen eines Kindes sind schwerer zu beantworten als die Fragen eines Wissenschaftlers.',
             '04':'Ein Kind ist kein Gefäß, das gefüllt, sondern ein Feuer, das entzündet werden will. ',
             '05':'Es gibt keine großen Entdeckungen und Fortschritte, solange es noch ein unglückliches Kind auf Erden gibt.',
             '06':'Kinderlärm ist Zukunftsmusik.',
             '07':'Nicht Philosophen stellen die radikalsten Fragen, sondern Kinder.',
             '08':'Sollen wir Kinder ziehen, so müssen wir auch Kinder mit ihnen werden.',
             '09':'Es ist nicht nur unsere Aufgabe Kulturgüter von einer Generation zur nächsten zu tragen, sondern den Geist wach zu halten, der diese Güter hervorgebracht hat.',
             '10':'Ein Kind, das im rechten Augenblick und in der rechten Weise unterrichtet wird, kann den gesamten Stoff einer sechsjährigen Grundschule in vier bis sieben Monaten aufnehmen.',
             '11':'Ein Professor der Pädagogik erklärte mir mit Stolz, dass in den Schulen seines Landes 15% der Zeit für Freiarbeit genutzt würden. Ich verkniff mir die Frage, ob 85% Zwangsarbeit eine Errungenschaft sei, auf die man stolz sein könne.',
             '12':'Das Streben nach Wissen ist eine natürliche Veranlagung aller Menschen.',
             '13':'In einer Zeit des Fern-sehens, Fern-hörens, Fern-schreibens, Fern-sprechens brauchen Kinder auch das Greifbare, eine Welt, die man anfassen, fühlen und riechen, in der man sich bewegen kann.',
             '14':'Jedes Kind ist gewissermaßen ein Genie und jedes Genie gewissermaßen ein Kind.',
             '15':'Alle öffentlichen Schulen sind auf die mittelmäßigen Naturen eingerichtet.',
             '16':'Eine Erzieherin ist dann erfolgreich, wenn sie sagen kann: Die Kinder können alles alleine tun, sie brauchen mich nicht mehr.',
             '17':'Die herkömmliche Schule bereitet meist darauf vor, dass die Schüler Befehle befolgen und sehr viel Langeweile aushalten können. Das ist ein Modell, das ab jetzt nicht mehr gebraucht wird. Die Wirtschaft von morgen braucht Schulen in denen man lernt selbst zu denken und selbstbestimmt zu handeln, ohne Disziplinierung und Unterdrückung.',
             '18':'Versucht nicht, Menschen zu beleben mit Lehrmeinungen, werft sie zurück in die Wirklichkeit. Denn das Geheimnis des Lebens findet man im Leben selbst, nicht im Lehren über das Leben.',
             '19':'Es ist ein grundlegender Irrtum zu glauben, dass der Wille des Individuums zerstört werden muss, damit er Gehorsam leisten kann. Das Gegenteil ist der Fall.',
             '20':'Diejenigen, die keine Fehler machen, machen den größten aller Fehler: Sie versuchen nichts Neues.',
             '21':'Die Autorität des Lehrers schadet oft denen, die lernen wollen.',
             '22':'Man soll Denken lehren, nicht Gedachtes.',
             '23':'Wir finden immer wieder bestätigt, dass ein Mensch, der sich gut fühlt, sich auch gut benimmt, und jemand, der sich schlecht fühlt, sich schlecht benimmt.',
             '24':'Begrenze deine Kinder nicht durch dein eigenes Wissen, denn sie sind in einer anderen Zeit geboren.',
             '25':'Wenn ich an eine Zukunft dachte, träumte ich davon, eines Tages eine Schule zu gründen, in der junge Leute ohne Langeweile lernen könnten und wo sie angeregt würden Probleme zu stellen und zu diskutieren, eine Schule, in der keine ungewünschten Antworten auf nie gestellte Fragen angehört werden müssten, in der man nicht nur zum Zwecke lernte, Prüfungen zu bestehen.',
             '26':'Sag es mir, und ich werde es vergessen. Zeig es mir, und ich werde es erinnern. Lass es mich tun, und ich werde es beherrschen.',
             '27':'Wenn du weißt, was du tust, kannst du tun, was du willst.',
             '28':'Stets gab es hohe Ideale und erhabene Gefühle, und stets wurden diese durch den Unterricht weitervermittelt, aber die Kriege hörten nicht auf.',
             '29':'Freiheit heißt Verantwortung. Deshalb wird sie von den meisten Menschen gefürchtet.',
             '30':'Phantasie ist wichtiger als Wissen, denn Wissen ist begrenzt.',
             '31':'Bildung ist nicht das Befüllen von Fässern, sondern das Entzünden von Flammen.']
quoterMap = ['00':'Maria Montessori',
             '01':'Neil Postman',
             '02':'-unbekannt-',
             '03':'Alice Miller',
             '04':'Francois Rabelais',
             '05':'Albert Einstein',
             '06':'-unbekannt-',
             '07':'Hellmut Walters',
             '08':'Martin Luther',
             '09':'Erich Roth',
             '10':'Paul Goodman',
             '11':'Rebecca Wild',
             '12':'Aristoteles',
             '13':'Renate Zimmer',
             '14':'Arthur Schopenhauer',
             '15':'Friedrich Nietzsche',
             '16':'Maria Montessori',
             '17':'Frithjof Bergmann',
             '18':'-unbekannt-',
             '19':'Maria Montessori',
             '20':'-unbekannt-',
             '21':'Cicero',
             '22':'Cornelius Gurlitt',
             '23':'Rebecca Wild',
             '24':'Anthony de Mello',
             '25':'Sir Karl Popper',
             '26':'Konfuzius',
             '27':'Moshe Feldenkrais',
             '28':'Maria Montessori',
             '29':'George Bernard Shaw',
             '30':'Albert Einstein',
             '31':'Heraklit']

profileType_de = ['all':'Alle','Betreiber':'Betreiber','Einrichtung':'Einrichtungen','Pädagoge':'Pädagogen','Betreuter':'Betreute',
          'User':'User','Partner':'Partner','Pate':'Pate','Erziehungsberechtigter':'Erziehungsberechtigte','Kind':'Kinder']
profileType_es = ['all':'Todos','Betreiber':'Operador','Einrichtung':'Instalaciones','Pädagoge':'Pedagogos','Betreuter':'Niños atendidos',
          'User':'Usuario','Partner':'Socio','Pate':'Padrinos','Erziehungsberechtigter':'Tutores','Kind':'Niños']

dateType_de = ['Eintritt':'Eintrittsdatum','Austritt':'Austrittdatum']
dateType_es = ['Eintritt':'Comienzo','Austritt':'Fin']