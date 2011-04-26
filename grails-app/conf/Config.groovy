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
    version = '1.5.2' // The jQuery version in use
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

    // Example of changing the log pattern for the default console appender:
    //
    //appenders {
    //    console name:'stdout', layout:pattern(conversionPattern: '%c{2} %m%n')
    //}

    appenders {
      'null' name: 'stacktrace'  // turn off stacktrace.log

      console(
             name: 'stdout',
             threshold: org.apache.log4j.Level.DEBUG,
             layout: pattern(conversionPattern: "${appName} - %d{HH:mm:ss} - [%p] - %c -> %m%n"))

      // REFERENCE: http://logging.apache.org/log4j/1.2/apidocs/org/apache/log4j/PatternLayout.html

      // each conversion pattern starts with a percent sign (%)
      // and is followed by optional format modifiers and a conversion character

      // used format modifiers:
      // none

      // used conversion characters:
      // %d - used to output the date of the logging event
      // %p - used to output the priority of the logging event
      // %c - outputs the category of the logging event
      // %m - outputs the application supplied message
      // %n - line separator
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

    info  'com.linkedin.grails'
    info  'grails.app'
    info  'grails.app.tagLib'
    info  'grails.app.bootstrap'
    info  'grails.app.dataSource'
    info  'grails.app.controller'
    info  'grails.app.service'

}

// change this value to control the amount of bootstrapped dummy entities
dummies = 2

// the default password used when creating new entity accounts
defaultpass = "pass"

// custom lists used for selects within the application
nationalities = ['germany','england','france','spain','portugal','austria','mexico','italy','canada']
resourceclasses = ['facility','colony','everywhere']
partners = ['projects','services','funding','personnel']
maritalstatus = ['unknown','single','married','separated','divorced','widowed','partnership']
familyrelations = ['parents','father','mother','other']
problems = ['alcoholism','drugs','vandalism','breakup','absence','violence','unemployment','poverty','disability','denial','orphan']
profiletypes = ['all','operator','facility','educator','client','user','partner','pate','parent','child']
helpertypes = ['operator','educator','client','partner','pate','parent']

// custom maps to store data
colors = [0:'#f44',1:'#4f4',2:'#44f',3:'#ff4',4:'#4ff',5:'#f4f',6:'#c21200',7:'#00660a',8:'#00b8b1',9:'#c24900',10:'#722e00',11:'#ed00e5',12:'#408080',13:'#808000',14:'#461B7E',15:'#307D7E',
          16:'#348017',17:'#AF7817',18:'#7E2217',19:'#C36241',20:'#C11B17',21:'#817339',22:'#218868',23:'#4A7023',24:'#4B0082',25:'#616161',26:'#9D8851',27:'#B13E0F',28:'#C77826',29:'#CD2626']

// used locales
locales = [new Locale ("de", "DE"), new Locale ("es", "ES")]

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
             '31':'Bildung ist nicht das Befüllen von Fässern, sondern das Entzünden von Flammen.',
             '32':'Wenn der Respekt zu unserer zweiten Natur wird, kommt es uns schließlich absurd vor, unsere Kinder einer Bildung auszusetzen, in der ihre eigene Interaktion mit der Umwelt eingeschränkt, viele Stunden lang sogar verboten ist.',
             '33':'Die harmonische Entfaltung von Kindern ist ein natürlicher und darum langsamer Prozess. Unsere Aufgabe ist es die rechten Bedingungen dafür zu schaffen, aber nicht, den Prozess zu beschleunigen. Bringen wir es als Erwachsene fertig, diese inneren Prozesse nicht durch unsere Ungeduld zu stören, sondern ihnen den nötigen Nährstoff zu liefern, so lernt Ihr Kind auf eigenen Füßen zu stehen und nicht sein Leben lang von äußerer Führung abhängig zu sein.']
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
             '31':'Heraklit',
             '32':'Rebeca Wild',
             '33':'Rebeca Wild']
