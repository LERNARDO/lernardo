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
          //grails.serverURL = "http://sueninos.lernardo.net" // sueninos
          grails.serverURL = "http://noe.lernardo.net" // lernardo
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

// full project names:
// "Sueninos"
// "Lernardo"

// currency:
// "Pesos"
// "Euro"

project = "sueninos"
projectName = "Sueninos" // full project name
currency = "Pesos"

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

// ---------------------------------------------------------------------------------------------
// attribute visibility
// ---------------------------------------------------------------------------------------------

// controls the visibility of attributes for each project

// Lernardo Config:

// ClientProfile
/*clientProfile.citizenship = true // true for Lernardo, false for Sueninos
clientProfile.socialSecurityNumber = true // true for Lernardo, false for Sueninos
clientProfile.contact = true // true for Lernardo, false for Sueninos
clientProfile.size = false // false for Lernardo, true for Sueninos
clientProfile.weight = false // false for Lernardo, true for Sueninos
clientProfile.job = false // false for Lernardo, true for Sueninos
clientProfile.originZip = false // false for Lernardo, true for Sueninos
clientProfile.originCity = false // false for Lernardo, true for Sueninos
clientProfile.familyStatus = false // false for Lernardo, true for Sueninos

// GroupFamilyProfile
groupFamilyProfile.familyIncome = false // false for Lernardo, true for Sueninos
groupFamilyProfile.familyProblems = false // false for Lernardo, true for Sueninos
groupFamilyProfile.amountHousehold = false // false for Lernardo, true for Sueninos
groupFamilyProfile.city = true // true for Lernardo, false for Sueninos

// ParentProfile
parentProfile.socialSecurityNumber = true // true for Lernardo, false for Sueninos
parentProfile.phone = true // true for Lernardo, false for Sueninos
parentProfile.jobIncome = false // false for Lernardo, true for Sueninos
parentProfile.jobFrequency = false // false for Lernardo, true for Sueninos
parentProfile.education = false // false for Lernardo, true for Sueninos
parentProfile.currentCountry = false // false for Lernardo, true for Sueninos
parentProfile.citizenship = true // true for Lernardo, false for Sueninos

// EducatorProfile
educatorProfile.enlisted = false // false for Lernardo, true for Sueninos
educatorProfile.origin = false // false for Lernardo, true for Sueninos
educatorProfile.contact = false // false for Lernardo, true for Sueninos
educatorProfile.phone = true // true for Lernardo, false for Sueninos*/

//Sueninos Config:

// ClientProfile
clientProfile.citizenship = false // true for Lernardo, false for Sueninos
clientProfile.socialSecurityNumber = false // true for Lernardo, false for Sueninos
clientProfile.contact = false // true for Lernardo, false for Sueninos
clientProfile.size = true // false for Lernardo, true for Sueninos
clientProfile.weight = true // false for Lernardo, true for Sueninos
clientProfile.job = true // false for Lernardo, true for Sueninos
clientProfile.originZip = true // false for Lernardo, true for Sueninos
clientProfile.originCity = true // false for Lernardo, true for Sueninos
clientProfile.familyStatus = true // false for Lernardo, true for Sueninos

// GroupFamilyProfile
groupFamilyProfile.familyIncome = true // false for Lernardo, true for Sueninos
groupFamilyProfile.familyProblems = true // false for Lernardo, true for Sueninos
groupFamilyProfile.amountHousehold = true // false for Lernardo, true for Sueninos
groupFamilyProfile.city = false // true for Lernardo, false for Sueninos

// ParentProfile
parentProfile.socialSecurityNumber = false // true for Lernardo, false for Sueninos
parentProfile.phone = false // true for Lernardo, false for Sueninos
parentProfile.jobIncome = true // false for Lernardo, true for Sueninos
parentProfile.jobFrequency = true // false for Lernardo, true for Sueninos
parentProfile.education = true // false for Lernardo, true for Sueninos
parentProfile.currentCountry = true // false for Lernardo, true for Sueninos
parentProfile.citizenship = false // true for Lernardo, false for Sueninos

// EducatorProfile
educatorProfile.enlisted = true // false for Lernardo, true for Sueninos
educatorProfile.origin = true // false for Lernardo, true for Sueninos
educatorProfile.contact = true // false for Lernardo, true for Sueninos
educatorProfile.phone = false // true for Lernardo, false for Sueninos

// jobs for Lernardo
jobs = ['1':'unbekannt','2':'angestellt','3':'arbeitssuchend','4':'selbstständig','5':'karenziert','6':'Hausfrau/Hausmann']

// languages for Lernardo
languages = ['1':'Deutsch','2':'Englisch','3':'Französisch','4':'Spanisch','5':'Italienisch']

// education for Lernardo (TODO: temp list, final list to come from PCR)
education = ['1':'Pädagoge','2':'Psychologe','3':'Soziologe','4':'Lehrer (staatl. Ausbildung)','5':'Erzieher','6':'Psychopädagoge','7':'Bildender Künstler',
             '8':'Arzt','9':'Krankenschwester','10':'Wirtschafter','11':'Buchhalter/Steuerberater']

// employment for Lernardo (TODO: temp list, final list to come from PCR)
employment = ['1':'Angestellt','2':'Freier Mitarbeiter','3':'Freiwilliger']

// school levels for Lernardo
schoolLevels = ['1':'1. Schulstufe','2':'2. Schulstufe','3':'3. Schulstufe','4':'4. Schulstufe','5':'5. Schulstufe','6':'6. Schulstufe',
                '7':'7. Schulstufe','8':'8. Schulstufe','9':'9. Schulstufe','10':'10. Schulstufe','11':'11. Schulstufe','12':'12. Schulstufe']