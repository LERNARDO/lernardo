package at.uenterprise.erp

class Setup {

  List bloodTypes
  static hasMany = [countries: String,
                    languages: String,
                    //methods: Method,
                    schoolLevels: String,
                    workDescriptions: String, // jobs
                    educations: String,
                    employmentStatus: String, // employments
                    responsibilities: String, // in charge of
                    bloodTypes: String,
                    familyStatus: String,
                    maritalStatus: String,
                    services: String,
                    familyProblems: String]

  static constraints = {
  }
}
