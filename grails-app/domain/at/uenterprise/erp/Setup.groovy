package at.uenterprise.erp

class Setup {

  List bloodTypes, nationalities, languages, schoolLevels, workDescriptions, educations, employmentStatus, responsibilities, familyStatus, maritalStatus, partnerServices, familyProblems
  static hasMany = [nationalities: String,
                    languages: String,
                    //methods: Method,
                    schoolLevels: String,
                    workDescriptions: String,
                    educations: String,
                    employmentStatus: String,
                    responsibilities: String,
                    bloodTypes: String,
                    familyStatus: String,
                    maritalStatus: String,
                    partnerServices: String,
                    familyProblems: String]

  static constraints = {
  }
}
