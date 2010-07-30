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

// one of the current projects:
// "sueninos"
// "noe"

project = "sueninos"

// ---------------------------------------------------------------------------------------------
// google analytics tracker
// ---------------------------------------------------------------------------------------------

// one of the following IDs:
// "UA-17725364-2" for http://sueninos.lernardo.net
// "UA-17725364-3" for http://noe.lernardo.net

google.analytics.webPropertyID = "UA-17725364-2"

// by default, tracking is enabled for the 'production' Env only, but that can be overwritten
// both ways (i.e emergency disable tracking)
// google.analytics.enabled = false