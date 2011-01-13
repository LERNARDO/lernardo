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
          grails.serverURL = "http://sueninos.lernardo.net" // sueninos
          //grails.serverURL = "http://noe.lernardo.net" // lernardo
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

// Sueninos Config:

/*project = "sueninos"
projectName = "Sueninos" // full project name
currency = "Pesos"*/

// Lernardo Config:

project = "noe"
projectName = "Lernardo"
currency = "Euro"

// ---------------------------------------------------------------------------------------------
// google analytics tracker
// ---------------------------------------------------------------------------------------------

// Sueninos Config:

//google.analytics.webPropertyID = "UA-17725364-2" // http://sueninos.lernardo.net

// Lernardo Config:

google.analytics.webPropertyID = "UA-17725364-3" // http://noe.lernardo.net

// by default, tracking is enabled for the 'production' Env only, but that can be overwritten
// both ways (i.e emergency disable tracking)
// google.analytics.enabled = false

// ---------------------------------------------------------------------------------------------
// attribute visibility
// ---------------------------------------------------------------------------------------------

// controls the visibility of attributes for each project

// Lernardo Config:

// ClientProfile
clientProfile.citizenship = true // true for Lernardo, false for Sueninos
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
educatorProfile.phone = true // true for Lernardo, false for Sueninos

jobs = ['unknown','employed','seekingwork','selfemployed','maternity','house']
languages = ['spanish','german','english','french','italian','turkish','serbocroatian','russian','polish','bulgarian']
educations = ['elementarypedagogue','universitypedagogue','specialpedagogue','nurserypedagogue','socialpedagogue','instrumentalpedagogue','secondarypedagogue','daynanny','childcare','hoardeducator','sociologist','psychologist','other']
employments = ['employed','autonomous','trainee']
schoollevels = ['first','second','third','fourth','fifth','sixth','seventh','eigth','ninth','tenth','eleventh','twelfth']
inchargeof = ['hoardlead','hoardhelper','support','comeducator','externaleducator']

//Sueninos Config:

// ClientProfile
/*clientProfile.citizenship = false // true for Lernardo, false for Sueninos
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

languages = ['spanish','german','english','french','mexican','tsotsil','tseltal','zoque','tojolabal','kanjobal','lacandon','quiche','chol','cakchiquel']
educations = ['pedagogue','psychologist','sociologist','teacher','educator','psychopedagogue','artist','doctor','nurse','housekeeper','accountant']
employments = ['employed','freelancer','volunteer']
jobs = ['shoeblack','bugglegumseller','handcraftseller','builderslabourer','homework','childoverseer','carwasher','dispenser','bearer','garagehelper','handcrafter','garbagecollector','squeegeeman','farecollector']
schoollevels = ['firstnursery','secondnursery','thirdnursery','firstprimary','secondprimary','thirdprimary','fourthprimary','fifthprimary','sixthprimary','firstsecondary','secondsecondary','thirdsecondary','firstpreparatoria','secondpreparatoria','thirdpreparatoria','studies']
inchargeof = ['directorate','programcoordination','program','project','areas','tutor','cook','volunteer']*/

