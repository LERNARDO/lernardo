package at.uenterprise.erp

class Setup {

  List bloodTypes, nationalities, languages, schoolLevels, workDescriptions, educations, employmentStatus, responsibilities, familyStatus, maritalStatus, partnerServices, familyProblems
  static hasMany = [nationalities: String,
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
                    partnerServices: String,
                    familyProblems: String]

  static constraints = {
  }
}
