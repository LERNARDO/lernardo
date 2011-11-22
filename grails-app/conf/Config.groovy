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
                      pdf: 'application/pdf',
                      excel: 'application/vnd.ms-excel',
                      all: '*/*',
                      json: ['application/json','text/json'],
                      form: 'application/x-www-form-urlencoded',
                      multipartForm: 'multipart/form-data'
                    ]

// The default codec used to encode data with ${}
grails.views.default.codec = "none" // none, html, base64
grails.views.gsp.encoding = "UTF-8"
grails.converters.encoding = "UTF-8"

// enabled native2ascii conversion of i18n properties files
grails.enable.native2ascii = true

// this has to be updated every time a new plugin version of jquery is installed
grails.views.javascript.library = "jquery"
jquery {
    sources = 'jquery' // Holds the value where to store jQuery-js files /web-app/js/
    version = '1.7' // The jQuery version in use
}

// this is the mail plugin configuration
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

// this will be used if no "from" is supplied in a mail
grails.mail.default.from = "lernardomailer@gmail.com"

secmgr {
  starturl     = "/start"
  publicurl    = "/"
}

// this controls the usage of the profiler plugin
//grails.profiler.disable = true

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
         //layout: pattern(conversionPattern: "${appName} - %d{HH:mm:ss} - [%p] - %c -> %m%n")
         layout: pattern(conversionPattern: "%d{HH:mm:ss} - %p - %c -> %m%n")
      )

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

// this value controld the amount of bootstrapped dummy entities
dummies = 5

// this is the default password used when creating new entity accounts
defaultpass = "pass"

// these are some custom lists used for selects within the application
resourceclasses = ['facility','colony','everywhere']
profiletypes = ['all','operator','facility','educator','client','user','partner','pate','parent','child']
helpertypes = ['operator','educator','client','partner','pate','parent']
costsUnit = ['perDay','perHour']

// these are the currently used locales in the application
locales = [new Locale ("de", "DE"), new Locale ("es", "ES"), new Locale ("en", "GB")]

// UTC is the default time zone
TimeZone.setDefault(TimeZone.getTimeZone("UTC"))

// application name
application.name  = "ERPEL"