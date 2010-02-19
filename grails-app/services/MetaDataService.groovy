class MetaDataService {

  boolean transactional = true

  def defaultObjectService

  // String Constants
  static final String EST_PERSON = "Person"              // EntitySuperType
  static final String EST_ORG = "Organisation"
  static final String EST_FAC = "Facility"

  static final String ET_USER = "User"                   // EntityType
  static final String ET_PAED = "Paed"
  static final String ET_CLIENT = "Client"
  static final String ET_OPERATOR = "Operator"
  static final String ET_HORT = "Hort"
  static final String ET_SCHOOL = "School"
  static final String ET_SPONSOR = "Sponsor"

  static final String PRT_PERSON = "User"                // ProfileType
  static final String PRT_ORG = "Org"
  static final String PRT_FAC = "Fac"

  static final String ROLE_USER = "ROLE_USER"
  static final String ROLE_MOD = "ROLE_MOD"
  static final String ROLE_ADMIN = "ROLE_ADMIN"
  static final String ROLE_SUPERUSER = "ROLE_SUPERUSER"

  static final String LST_PERSONAL = "personal"          // LinkSuperType
  static final String LST_OTHER = "other"

  static final String LT_FRIENDSHIP = "Freundschaft"     // LinkType
  static final String LT_SPONSORSHIP = "Sponsoring"
  static final String LT_OPERATION = "Betreibung"
  static final String LT_CLIENTSHIP = "Betreuung"
  static final String LT_BOOKMARK = "Beobachtung"
  static final String LT_WORKING = "Arbeitet"

  def initialize() {
    getEstPerson()
    getEstOrg()
    getEstFac()

    getEtUser()
    getEtPaed()
    getEtClient()
    getEtOperator()
    getEtHort()
    getEtSchool()
    getEtSponsor()

    getLstPersonal()
    getLstOther()

    getLtFriendship()
    getLtSponsorship()
    getLtOperation()
    getLtClientship()
    getLtBookmark()
    getLtWorking()

    getUserRole()
    getModRole()
    getAdminRole()
    getSuperUserRole()
  }

  def getEstPerson() { defaultObjectService.openEST(EST_PERSON, PRT_PERSON)  }
  def getEstOrg() { defaultObjectService.openEST(EST_ORG, PRT_ORG)  }
  def getEstFac() { defaultObjectService.openEST(EST_FAC, PRT_FAC)  }

  def getEtUser () { defaultObjectService.openET (ET_USER, estPerson) }
  def getEtPaed () { defaultObjectService.openET (ET_PAED, estPerson) }
  def getEtClient () { defaultObjectService.openET (ET_CLIENT, estPerson) }
  def getEtOperator () { defaultObjectService.openET (ET_OPERATOR, estOrg) }
  def getEtHort () { defaultObjectService.openET (ET_HORT, estFac) }
  def getEtSchool () { defaultObjectService.openET (ET_SCHOOL, estFac) }
  def getEtSponsor () { defaultObjectService.openET (ET_SPONSOR, estOrg) }

  def getLstPersonal () {defaultObjectService.openLST (LST_PERSONAL, "Personal Relationship") }
  def getLstOther () {defaultObjectService.openLST (LST_OTHER, "Other Relationship") }

  def getLtFriendship () { defaultObjectService.openLT(LT_FRIENDSHIP, lstPersonal) }
  def getLtSponsorship () { defaultObjectService.openLT(LT_SPONSORSHIP, lstOther) }
  def getLtOperation () { defaultObjectService.openLT(LT_OPERATION, lstOther) }
  def getLtClientship () { defaultObjectService.openLT(LT_CLIENTSHIP, lstOther) }
  def getLtBookmark () { defaultObjectService.openLT(LT_BOOKMARK, lstOther) }
  def getLtWorking () { defaultObjectService.openLT(LT_WORKING, lstOther) }

  def getUserRole () {defaultObjectService.openRole (ROLE_USER, "regular user")}
  def getModRole () {defaultObjectService.openRole (ROLE_MOD, "moderator")}
  def getAdminRole () {defaultObjectService.openRole (ROLE_ADMIN, "administrator")}
  def getSuperUserRole () {defaultObjectService.openRole (ROLE_SUPERUSER, "system administrator")}
}
