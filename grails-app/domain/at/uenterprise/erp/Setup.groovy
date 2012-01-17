package at.uenterprise.erp

/**
 * This class represents the application setup
 * TODO: ideally this should be a singleton like a service class, maybe this can be changed at a later point
 *
 * @author  Alexander Zeillinger
 */
class Setup {

  List bloodTypes, nationalities, languages, schoolLevels, workDescriptions, educations, employmentStatus, responsibilities, familyStatus, maritalStatus, partnerServices, familyProblems, labels
  static hasMany = [nationalities: String,
                    languages: String,
                    schoolLevels: String,
                    workDescriptions: String,
                    educations: String,
                    employmentStatus: String,
                    responsibilities: String,
                    bloodTypes: String,
                    familyStatus: String,
                    maritalStatus: String,
                    partnerServices: String,
                    familyProblems: String,
                    labels: String]

  static constraints = {

  }

}
