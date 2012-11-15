// only change the customer name here:

// possible values:
// "sueninos"
// "noe"

customer = "noe"

// nothing needs to be changed below this line

// this is the mail plugin configuration
grails {
    mail {
        host = "smtp.gmail.com"
        port = 465
        username = "lernardomailer@gmail.com"
        password = "theansweris42"
        props = ["mail.smtp.auth": "true",
                "mail.smtp.socketFactory.port": "465",
                "mail.smtp.socketFactory.class": "javax.net.ssl.SSLSocketFactory",
                "mail.smtp.socketFactory.fallback": "false"]
    }
}

// this will be used if no "from" is supplied in a mail
grails.mail.default.from = "lernardomailer@gmail.com"

if (customer == "sueninos") {

    // ---------------------------------------------------------------------------------------------
    // general configuration
    // ---------------------------------------------------------------------------------------------

    customerName = "Sueniños" // full customer name
    currency = "Peso"
    currencySymbol  = '''$'''
    timeZone = "America/Guatemala" // UTC-6

    // ---------------------------------------------------------------------------------------------
    // database configuration
    // ---------------------------------------------------------------------------------------------

    dataSource {
      pooled = true
      driverClassName = "org.postgresql.Driver"
      dialect = org.hibernate.dialect.PostgreSQLDialect
      username = "sa_lernardo"
      password = "pw_lernardo"
      properties {
        maxActive = 15
        maxIdle = 5
        minIdle = 3
        initialSize = 3
        minEvictableIdleTimeMillis = 60000
        timeBetweenEvictionRunsMillis = 60000
        numTestsPerEvictionRun = 3
        maxWait = 10000
      }
    }

    environments {
      development {
        dataSource {
              dbCreate = "create-drop" // one of 'create', 'create-drop','update'
              url = "jdbc:postgresql://localhost:5432/lernardo"
              logSql = false
              hibernate.default_schema = 'dev'
              grails.serverURL = "http://localhost:8080/lernardo"
        }
      }
      test {
        dataSource {
              dbCreate = "update"
              url = "jdbc:postgresql://localhost:5432/lernardo"
              logSql = false
              hibernate.default_schema = 'test'
              grails.serverURL = "http://lernardo.customer.uenterprise.de/test"

            // use these when running tests
            //driverClassName = "org.h2.Driver"
            //dialect = "org.hibernate.dialect.H2Dialect"
            //url = "jdbc:h2:mem:testDb;MVCC=TRUE"
        }
      }
      production {
        dataSource {
              dbCreate = "update"
              url = "jdbc:postgresql://localhost:5432/lernardo"
              logSql = false
              hibernate.default_schema = 'prod'
              grails.serverURL = "http://sueninos.lernardo.net"
        }
      }
    }

    // ---------------------------------------------------------------------------------------------
    // google analytics tracker
    // ---------------------------------------------------------------------------------------------

    google.analytics.webPropertyID = "UA-17725364-2"

    // by default, tracking is enabled for the 'production' Env only, but that can be overwritten
    // both ways (i.e emergency disable tracking)
    // google.analytics.enabled = false

}

if (customer == "noe") {

    // ---------------------------------------------------------------------------------------------
    // general configuration
    // ---------------------------------------------------------------------------------------------

    customerName = "Lernardo"
    currency = "Euro"
    currencySymbol  = '''€'''
    timeZone = "Europe/Vienna" // UTC+1

    // ---------------------------------------------------------------------------------------------
    // database configuration
    // ---------------------------------------------------------------------------------------------

    dataSource {
      pooled = true
      driverClassName = "org.postgresql.Driver"
      dialect = org.hibernate.dialect.PostgreSQLDialect
      username = "sa_lernardo"
      password = "pw_lernardo"
      properties {
        maxActive = 15
        maxIdle = 5
        minIdle = 3
        initialSize = 3
        minEvictableIdleTimeMillis = 60000
        timeBetweenEvictionRunsMillis = 60000
        numTestsPerEvictionRun = 3
        maxWait = 10000
      }
    }

    environments {
      development {
        dataSource {
              dbCreate = "create-drop" // one of 'create', 'create-drop','update'
              url = "jdbc:postgresql://localhost:5432/lernardo"
              loggingSql = false
              hibernate.default_schema = 'dev'
              grails.serverURL = "http://localhost:8080/lernardo"
        }
      }
      test {
        dataSource {
              dbCreate = "update"
              url = "jdbc:postgresql://localhost:5432/lernardo"
              loggingSql = false
              hibernate.default_schema = 'test'
              grails.serverURL = "http://lernardo.customer.uenterprise.de/test"
        }
      }
      production {
        dataSource {
              dbCreate = "update"
              url = "jdbc:postgresql://localhost:5432/lernardo"
              loggingSql = false
              hibernate.default_schema = 'prod'
              grails.serverURL = "http://noe.lernardo.net"
        }
      }
    }

    // ---------------------------------------------------------------------------------------------
    // google analytics tracker
    // ---------------------------------------------------------------------------------------------

    google.analytics.webPropertyID = "UA-17725364-3"

    // by default, tracking is enabled for the 'production' Env only, but that can be overwritten
    // both ways (i.e emergency disable tracking)
    // google.analytics.enabled = false

}