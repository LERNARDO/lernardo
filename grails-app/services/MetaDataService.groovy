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
  static final String ET_PO = "ForProfitOrganisation"
  static final String ET_NPO = "NonProfitOrganisation"

  static final String PRT_PERSON = "User"                // ProfileType
  static final String PRT_ORG = "Org"
  static final String PRT_FAC = "Fac"

  static final String ROLE_USER = "ROLE_USER"
  static final String ROLE_MOD = "ROLE_MOD"
  static final String ROLE_ADMIN = "ROLE_ADMIN"

  static final String LST_PRS = "PRS"                    // LinkSuperType (personal or organizational)
  static final String LST_OA = "OA"

  static final String LT_FRIEND = "Friend"               // LinkType
  static final String LT_EMPLOYMENT = "Employment"

  def initialize() {
    getEstPerson()
    getEstOrg()
    getEstFac()

    getEtUser()
    getEtPaed()
    getEtClient()
    getEtOperator()
    getEtHort()
    getEtPO()
    getEtNPO()

    getLstPRS()
    getLstOA()

    getLtFriend()
    getLtEmployment()

    getUserRole()
    getModRole()
    getAdminRole()
  }

  def getEstPerson() { defaultObjectService.openEST(EST_PERSON, PRT_PERSON)  }
  def getEstOrg() { defaultObjectService.openEST(EST_ORG, PRT_ORG)  }
  def getEstFac() { defaultObjectService.openEST(EST_FAC, PRT_FAC)  }

  def getEtUser () { defaultObjectService.openET (ET_USER, estPerson) }
  def getEtPaed () { defaultObjectService.openET (ET_PAED, estPerson) }
  def getEtClient () { defaultObjectService.openET (ET_CLIENT, estPerson) }
  def getEtOperator () { defaultObjectService.openET (ET_OPERATOR, estFac) }
  def getEtHort () { defaultObjectService.openET (ET_HORT, estFac) }
  def getEtPO () { defaultObjectService.openET (ET_PO, estOrg) }
  def getEtNPO () { defaultObjectService.openET (ET_NPO, estOrg) }

  def getLstPRS () {defaultObjectService.openLST (LST_PRS, "Personal Relationship") }
  def getLstOA () {defaultObjectService.openLST (LST_OA, "Organisational Association") }

  def getLtFriend () { defaultObjectService.openLT(LT_FRIEND, lstPRS) }
  def getLtEmployment () { defaultObjectService.openLT(LT_EMPLOYMENT, lstOA) }

  def getUserRole () {defaultObjectService.openRole (ROLE_USER, "regular user")}
  def getModRole () {defaultObjectService.openRole (ROLE_MOD, "moderator")}
  def getAdminRole () {defaultObjectService.openRole (ROLE_ADMIN, "system administrator")}

}
