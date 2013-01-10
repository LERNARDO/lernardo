//grails.project.source.level = 1.6

grails.project.class.dir = "target/classes"
grails.project.test.class.dir = "target/test-classes"
grails.project.test.reports.dir	= "target/test-reports"

// converts pre 2.0 action closures to methods, see http://grails.org/doc/latest/guide/theWebLayer.html#controllers
grails.compile.artefacts.closures.convert = true

//grails.project.war.file = "target/${appName}-${appVersion}.war"

grails.project.dependency.resolution = {
    // inherit Grails' default dependencies
    inherits( "global" ) {
        // uncomment to disable ehcache
        // excludes 'ehcache'
    }
    log "warn" // log level of Ivy resolver, either 'error', 'warn', 'info', 'debug' or 'verbose'
    repositories {        
        grailsPlugins()
        grailsHome()
        grailsCentral()

        // uncomment the below to enable remote dependency resolution
        // from public Maven repositories
        //mavenLocal()
        //mavenCentral()
        //mavenRepo "http://snapshots.repository.codehaus.org"
        //mavenRepo "http://repository.codehaus.org"
        //mavenRepo "http://download.java.net/maven/2/"
        //mavenRepo "http://repository.jboss.com/maven2/"
    }
    dependencies {
        // specify dependencies here under either 'build', 'compile', 'runtime', 'test' or 'provided' scopes eg.
        // runtime 'mysql:mysql-connector-java:5.1.5'
    }
    plugins {
        compile ":cache-headers:1.1.5"
        compile ":cached-resources:1.0"
        compile ":ckeditor:3.6.3.0"
        compile ":codenarc:0.17"
        compile ":export:1.3"
        compile ":google-analytics:1.0"
        compile ":grails-melody:1.14"
        compile ":hibernate:$grailsVersion"
        compile ":jquery:1.7.1"
        compile ":jquery-ui:1.8.15"
        compile ":lesscss-resources:1.3.0.3"
        compile ":mail:0.9"
        compile ":profiler:0.4"
        compile ":quartz:0.4.2"
        compile ":remote-pagination:0.3"
        compile ":rendering:0.4.2"
        compile ":resources:1.1.6"
        compile ":svn:1.0.0.M1"
        compile ":tomcat:$grailsVersion"
        compile ":zipped-resources:1.0"
    }

}
