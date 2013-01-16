grails.servlet.version = "2.5" // Change depending on target container compliance (2.5 or 3.0)
grails.project.class.dir = "target/classes"
grails.project.test.class.dir = "target/test-classes"
grails.project.test.reports.dir	= "target/test-reports"
//grails.project.target.level = 1.6
//grails.project.source.level = 1.6
//grails.project.war.file = "target/${appName}-${appVersion}.war"

// uncomment (and adjust settings) to fork the JVM to isolate classpaths
//grails.project.fork = [
//   run: [maxMemory:1024, minMemory:64, debug:false, maxPerm:256]
//]

// convert pre 2.0 action closures to methods, see http://grails.org/doc/latest/guide/theWebLayer.html#controllers
grails.compile.artefacts.closures.convert = true

grails.project.dependency.resolution = {
    // inherit Grails' default dependencies
    inherits( "global" ) {
        // specify dependency exclusions here; for example, uncomment this to disable ehcache:
        // excludes 'ehcache'
    }
    log "error" // log level of Ivy resolver, either 'error', 'warn', 'info', 'debug' or 'verbose'
    checksums true // Whether to verify checksums on resolve

    repositories {
        inherits true // Whether to inherit repository definitions from plugins

        grailsPlugins()
        grailsHome()
        grailsCentral()

        mavenLocal()
        mavenCentral()

        // uncomment the below to enable remote dependency resolution
        // from public Maven repositories
        //mavenRepo "http://snapshots.repository.codehaus.org"
        //mavenRepo "http://repository.codehaus.org"
        //mavenRepo "http://download.java.net/maven/2/"
        //mavenRepo "http://repository.jboss.com/maven2/"
    }
    dependencies {
        // specify dependencies here under either 'build', 'compile', 'runtime', 'test' or 'provided' scopes eg.

        // runtime 'mysql:mysql-connector-java:5.1.20'
    }
    plugins {
        build ":tomcat:$grailsVersion"

        runtime ":jquery:1.8.3"
        runtime ":jquery-ui:1.8.24"
        runtime ":resources:1.1.6"
        runtime ":zipped-resources:1.0"
        runtime ":cached-resources:1.0"

        compile ":lesscss-resources:1.3.0.3"
        compile ":cache-headers:1.1.5"
        compile ":ckeditor:3.6.3.0"
        compile ":codenarc:0.18"
        compile ":export:1.5"
        compile ":google-analytics:2.0"
        compile ":grails-melody:1.14"
        compile ":hibernate:$grailsVersion"
        compile ":mail:0.9"
        compile ":quartz:0.4.2"
        compile ":remote-pagination:0.4.1"
        compile ":rendering:0.4.3"
    }
}
