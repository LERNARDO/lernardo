import grails.util.Environment

// locations to search for config files that get merged into the main config;
// config files can be ConfigSlurper scripts, Java properties files, or classes
// in the classpath in ConfigSlurper format

// grails.config.locations = [ "classpath:${appName}-config.properties",
//                             "classpath:${appName}-config.groovy",
//                             "file:${userHome}/.grails/${appName}-config.properties",
//                             "file:${userHome}/.grails/${appName}-config.groovy"]

def configFile = "file:${System.properties.'catalina.base' ?: System.properties.'base.dir'}/app-config/lernardo-config.groovy"
grails.config.locations = [configFile]

grails.project.groupId = "at.uenterprise.erp" // change this to alter the default package name and Maven publishing destination
grails.mime.file.extensions = true // enables the parsing of file extensions from URLs into the request format
grails.mime.use.accept.header = false
grails.mime.types = [
        all:           '*/*',
        atom:          'application/atom+xml',
        css:           'text/css',
        csv:           'text/csv',
        form:          'application/x-www-form-urlencoded',
        html:          ['text/html','application/xhtml+xml'],
        js:            'text/javascript',
        json:          ['application/json', 'text/json'],
        multipartForm: 'multipart/form-data',
        rss:           'application/rss+xml',
        text:          'text/plain',
        xml:           ['text/xml', 'application/xml'],
        pdf:           'application/pdf',
        excel:         'application/vnd.ms-excel'
]

// URL Mapping Cache Max Size, defaults to 5000
//grails.urlmapping.cache.maxsize = 1000

// What URL patterns should be processed by the resources plugin
grails.resources.adhoc.patterns = ['/images/*', '/css/*', '/js/*', '/plugins/*']

// The default codec used to encode data with ${}
grails.views.default.codec = "none" // none, html, base64
grails.views.gsp.encoding = "UTF-8"
grails.converters.encoding = "UTF-8"
// enable Sitemesh preprocessing of GSP pages
grails.views.gsp.sitemesh.preprocess = true
// scaffolding templates configuration
grails.scaffolding.templates.domainSuffix = 'Instance'

// Set to false to use the new Grails 1.2 JSONBuilder in the render method
grails.json.legacy.builder = false
// enabled native2ascii conversion of i18n properties files
grails.enable.native2ascii = true
// packages to include in Spring bean scanning
grails.spring.bean.packages = []
// whether to disable processing of multi part requests
grails.web.disable.multipart=false

// request parameters to mask when logging exceptions
grails.exceptionresolver.params.exclude = ['password']

// configure auto-caching of queries by default (if false you can cache individual queries with 'cache: true')
grails.hibernate.cache.queries = false

// this could be defined in "AppResources.groovy" but we need to reference "customer"
grails.resources.modules = {
    common {
        dependsOn 'jquery'
        resource url: 'css/cssreset-min.css'
        resource url: 'css/cssfonts-min.css'
        resource url: 'less/public.less', attrs: [rel: 'stylesheet/less', type: 'css']
    }

    start {
        dependsOn 'jquery, jquery-ui'
        resource url: 'css/cssreset-min.css'
        resource url: 'css/cssfonts-min.css'
        resource url: 'css/grids-min.css'
        resource url: 'css/jquery.qtip.min.css'
        resource url: 'css/kolorpicker.css'
        resource url: 'css/basic.css' // modal
        resource url: 'css/jquery-ui-timepicker-addon.css'
        resource url: 'less/common.less', attrs: [rel: 'stylesheet/less', type: 'css']
        //resource url: "less/${customer}.less", attrs: [rel: 'stylesheet/less', type: 'css']

        resource url: "js/jquery/jquery.qtip.min.js"
        resource url: "js/app.js"
    }

    other {
        dependsOn 'jquery, jquery-ui'
        resource url: 'css/cssreset-min.css'
        resource url: 'css/cssfonts-min.css'
        resource url: 'css/grids-min.css'
        resource url: 'css/jquery.qtip.min.css'
        resource url: 'css/kolorpicker.css'
        resource url: 'css/basic.css' // modal
        resource url: 'css/jquery-ui-timepicker-addon.css'
        resource url: 'less/common.less', attrs: [rel: 'stylesheet/less', type: 'css']
        //resource url: "less/${customer}.less", attrs: [rel: 'stylesheet/less', type: 'css']

        resource url: "js/jquery/jquery.qtip.min.js"
        // TODO: below scripts are broken when implemented this way, find out why
        //resource url: "js/jquery/spin.min.js"
        //resource url: "js/jquery/jquery.jqEasyCharCounter.min.js"
        //resource url: "js/jquery/jquery-ui-timepicker-addon.js"
        //resource url: "js/jquery/jquery.kolorpicker.js"
        resource url: "js/app.js"
    }
}

// log4j configuration
log4j = {

    appenders {
        'null' name: 'stacktrace'  // turn off stacktrace.log

        console(
                name: 'stdout',
                threshold: org.apache.log4j.Level.DEBUG, // ALL | TRACE | DEBUG | INFO | WARN | ERROR | FATAL | OFF
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

    info 'com.linkedin.grails'
    info 'grails.app'
    info 'grails.app.tagLib'
    info 'grails.app.bootstrap'
    info 'grails.app.dataSource'
    info 'grails.app.controller'
    info 'grails.app.service'
    //debug 'org.hibernate.SQL'

}

// this is the default password used when creating new entity accounts
defaultpass = "pass"

// these are some custom lists used for selects within the application
resourceclasses = ['facility', 'colony', 'everywhere']
profiletypes = ['all', 'operator', 'educator', 'client', 'user', 'partner', 'pate', 'parent', 'child']
helpertypes = ['operator', 'educator', 'client', 'partner', 'pate', 'parent']
costsUnit = ['perDay', 'perHour']
socialForms = ['single', 'partner', 'smallgroup1', 'smallgroup2', 'smallgroup3', 'largegroup1', 'largegroup2', 'open']

// these are the currently used locales in the application
locales = [new Locale("de", "DE"), new Locale("es", "ES"), new Locale("en", "GB")]

// UTC is the default time zone
TimeZone.setDefault(TimeZone.getTimeZone("UTC"))

// application name
application.name = "Lernardo.net"

ckeditor {
    config = "/js/ckconfig.gsp"
}

// PDFs
// Betreutengruppe List View
// Zeitaufzeichnung Bericht
// Logbuch Auswertung
// Aktivitätsblock Show View