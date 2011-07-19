// only change the project name here:

// possible values:
// "sueninos"
// "noe"

project = "sueninos"

// nothing needs to be changed below this line

if (project == "sueninos") {

    // ---------------------------------------------------------------------------------------------
    // database configuration
    // ---------------------------------------------------------------------------------------------

    dataSource {
      pooled = false
      driverClassName = "org.postgresql.Driver"
      dialect = org.hibernate.dialect.PostgreSQLDialect
      username = "sa_lernardo"
      password = "pw_lernardo"
    }

    environments {
      development {
        dataSource {
              dbCreate = "create-drop" // one of 'create', 'create-drop','update'
              url = "jdbc:postgresql://localhost:5432/lernardo"
              loggingSql = true
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
              grails.serverURL = "https://lernardo.customer.uenterprise.de/test"
        }
      }
      production {
        dataSource {
              dbCreate = "update"
              url = "jdbc:postgresql://localhost:5432/lernardo"
              loggingSql = false
              hibernate.default_schema = 'prod'
              grails.serverURL = "http://sueninos.lernardo.net"
        }
      }
    }

    // ---------------------------------------------------------------------------------------------
    // email configuration
    // ---------------------------------------------------------------------------------------------

    // this will be used if no "from" is supplied in a mail
    grails.mail.default.from="lernardomailer@gmail.com"

    // ---------------------------------------------------------------------------------------------
    // layout configuration
    // ---------------------------------------------------------------------------------------------

    projectName = "Sueninos" // full project name
    currency = "Pesos"
    timeZone = "America/Guatemala" // UTC-6

    // ---------------------------------------------------------------------------------------------
    // google analytics tracker
    // ---------------------------------------------------------------------------------------------

    google.analytics.webPropertyID = "UA-17725364-2" // http://sueninos.lernardo.net

    // by default, tracking is enabled for the 'production' Env only, but that can be overwritten
    // both ways (i.e emergency disable tracking)
    // google.analytics.enabled = false

    // ---------------------------------------------------------------------------------------------
    // attribute visibility
    // ---------------------------------------------------------------------------------------------

    // controls the visibility of attributes

    // ClientProfile
    clientProfile.citizenship = false
    clientProfile.socialSecurityNumber = false
    clientProfile.contact = false
    clientProfile.job = true
    clientProfile.originZip = true
    clientProfile.originCity = true
    clientProfile.familyStatus = true

    // GroupFamilyProfile
    groupFamilyProfile.familyIncome = true
    groupFamilyProfile.familyProblems = true
    groupFamilyProfile.amountHousehold = true
    groupFamilyProfile.city = false

    // ParentProfile
    parentProfile.socialSecurityNumber = false
    parentProfile.phone = false
    parentProfile.jobIncome = true
    parentProfile.jobFrequency = true
    parentProfile.education = true
    parentProfile.currentCountry = true
    parentProfile.citizenship = false

    // EducatorProfile
    educatorProfile.enlisted = true
    educatorProfile.origin = true
    educatorProfile.contact = true
    educatorProfile.phone = false

}

if (project == "noe") {

    // ---------------------------------------------------------------------------------------------
    // database configuration
    // ---------------------------------------------------------------------------------------------

    dataSource {
      pooled = false
      driverClassName = "org.postgresql.Driver"
        dialect = org.hibernate.dialect.PostgreSQLDialect
      username = "sa_lernardo"
      password = "pw_lernardo"
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
              grails.serverURL = "https://lernardo.customer.uenterprise.de/test"
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
    // email configuration
    // ---------------------------------------------------------------------------------------------

    // this will be used if no "from" is supplied in a mail
    grails.mail.default.from="lernardomailer@gmail.com"

    // ---------------------------------------------------------------------------------------------
    // layout configuration
    // ---------------------------------------------------------------------------------------------

    projectName = "Lernardo"
    currency = "Euro"
    timeZone = "Europe/Vienna" // UTC+1

    // ---------------------------------------------------------------------------------------------
    // google analytics tracker
    // ---------------------------------------------------------------------------------------------

    google.analytics.webPropertyID = "UA-17725364-3" // http://noe.lernardo.net

    // by default, tracking is enabled for the 'production' Env only, but that can be overwritten
    // both ways (i.e emergency disable tracking)
    // google.analytics.enabled = false

    // ---------------------------------------------------------------------------------------------
    // attribute visibility
    // ---------------------------------------------------------------------------------------------

    // controls the visibility of attributes

    // ClientProfile
    clientProfile.citizenship = true
    clientProfile.socialSecurityNumber = true
    clientProfile.contact = true
    clientProfile.job = false
    clientProfile.originZip = false
    clientProfile.originCity = false
    clientProfile.familyStatus = false

    // GroupFamilyProfile
    groupFamilyProfile.familyIncome = false
    groupFamilyProfile.familyProblems = false
    groupFamilyProfile.amountHousehold = false
    groupFamilyProfile.city = true

    // ParentProfile
    parentProfile.socialSecurityNumber = true
    parentProfile.phone = true
    parentProfile.jobIncome = false
    parentProfile.jobFrequency = false
    parentProfile.education = false
    parentProfile.currentCountry = false
    parentProfile.citizenship = true

    // EducatorProfile
    educatorProfile.enlisted = false
    educatorProfile.origin = false
    educatorProfile.contact = false
    educatorProfile.phone = true

}



