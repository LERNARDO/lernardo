dataSource {
	pooled = false
	driverClassName = "org.postgresql.Driver"
    dialect = org.hibernate.dialect.PostgreSQLDialect
	username = "sa_lernardo"
	password = "pw_lernardo"
}
hibernate {
    cache.use_second_level_cache=true
    cache.use_query_cache=true
    cache.provider_class='com.opensymphony.oscache.hibernate.OSCacheProvider'
}
// environment specific settings
environments {
	development {
		dataSource {
			dbCreate = "create-drop" // one of 'create', 'create-drop','update'
            url =      "jdbc:postgresql://localhost:5432/lernardo"
            loggingSql = false
            hibernate.default_schema = 'dev'
		}
	}
	test {
		dataSource {
            dbCreate = "update"
            url = "jdbc:postgresql://lab.uenterprise.de:5432/lernardo"
            loggingSql = false
            hibernate.default_schema = 'test'
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