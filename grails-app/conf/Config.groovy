// locations to search for config files that get merged into the main config
// config files can either be Java properties files or ConfigSlurper scripts

// grails.config.locations = [ "classpath:${appName}-config.properties",
//                             "classpath:${appName}-config.groovy",
//                             "file:${userHome}/.grails/${appName}-config.properties",
//                             "file:${userHome}/.grails/${appName}-config.groovy"]

// if(System.properties["${appName}.config.location"]) {
//    grails.config.locations << "file:" + System.properties["${appName}.config.location"]
// }
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

// mail plugin configuration…
grails.mail.default.from="lernardomailer@gmail.com"

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

// set per-environment serverURL stem for creating absolute links
environments {
    production {
        grails.serverURL = "http://www.changeme.com"
    }
    development {
        grails.serverURL = "http://localhost:8080/${appName}"
    }
    test {
        grails.serverURL = "http://localhost:8080/${appName}"
    }

}

// log4j configuration
log4j = {
    // Example of changing the log pattern for the default console
    // appender:
    //
    //appenders {
    //    console name:'stdout', layout:pattern(conversionPattern: '%c{2} %m%n')
    //}

    error  'org.codehaus.groovy.grails.web.servlet',  //  controllers
	       'org.codehaus.groovy.grails.web.pages', //  GSP
	       'org.codehaus.groovy.grails.web.sitemesh', //  layouts
	       'org.codehaus.groovy.grails.web.mapping.filter', // URL mapping
	       'org.codehaus.groovy.grails.web.mapping', // URL mapping
	       'org.codehaus.groovy.grails.commons', // core / classloading
	       'org.codehaus.groovy.grails.plugins', // plugins
	       'org.codehaus.groovy.grails.orm.hibernate', // hibernate integration
	       'org.springframework',
	       'org.hibernate'

    warn   'org.mortbay.log'

  info   'grails.app'
  info   'grails.app.tagLib'
  debug  'grails.app.bootstrap'
  debug  'grails.app.dataSource'
  debug  'grails.app.controller'
  debug  'grails.app.service'

}

quotesMap = [0:'Die Aufgabe der Umgebung ist nicht das Kind zu formen, sondern ihm zu erlauben, sich zu offenbaren.',
             1:'Kinder - die lebenden Botschaften, die wir einer Zeit übermitteln, an der wir selbst nicht mehr teilhaben werden.',
             2:'Der Erwachsene achtet auf Taten, das Kind auf Liebe.',
             3:'Die Fragen eines Kindes sind schwerer zu beantworten als die Fragen eines Wissenschaftlers.',
             4:'Ein Kind ist kein Gefäß, das gefüllt, sondern ein Feuer, das entzündet werden will. ',
             5:'Es gibt keine großen Entdeckungen und Fortschritte, solange es noch ein unglückliches Kind auf Erden gibt.',
             6:'Kinderlärm ist Zukunftsmusik.',
             7:'Nicht Philosophen stellen die radikalsten Fragen, sondern Kinder.',
             8:'Sollen wir Kinder ziehen, so müssen wir auch Kinder mit ihnen werden.',
             9:'-',
             10:'-',
             11:'-',
             12:'-',
             13:'-',
             14:'-',
             15:'-',
             16:'-',
             17:'-',
             18:'-',
             19:'-',
             20:'-',
             21:'-',
             22:'-',
             23:'-',
             24:'-',
             25:'-',
             26:'-',
             27:'-',
             28:'-',
             29:'-',
             30:'-',
             31:'-']
quoterMap = [0:'Maria Montessori',
             1:'Neil Postman',
             2:'-unbekannt-',
             3:'Alice Miller',
             4:'Francois Rabelais',
             5:'Albert Einstein',
             6:'-unbekannt',
             7:'Hellmut Walters',
             8:'Martin Luther',
             9:'-',
             10:'-',
             11:'-',
             12:'-',
             13:'-',
             14:'-',
             15:'-',
             16:'-',
             17:'-',
             18:'-',
             19:'-',
             20:'-',
             21:'-',
             22:'-',
             23:'-',
             24:'-',
             25:'-',
             26:'-',
             27:'-',
             28:'-',
             29:'-',
             30:'-',
             31:'-']