class MetaDataService {

  boolean transactional = true

  def defaultObjectService

  // String Constants
  static final String EST_PERSON = "Person"              // EntitySuperType
  static final String EST_ORG = "Organisation"
  static final String EST_FAC = "Facility"
  static final String EST_ACTIVITY = "Activity"

  static final String ET_USER = "User"                   // EntityType
  static final String ET_PAED = "Pädagoge"
  static final String ET_CLIENT = "Betreuter"
  static final String ET_OPERATOR = "Betreiber"
  static final String ET_HORT = "Einrichtung"
  static final String ET_SCHOOL = "Schule"
  static final String ET_SPONSOR = "Sponsor"
  static final String ET_ACTIVITY = "Aktivität"

  static final String PRT_PERSON = "User"                // ProfileType
  static final String PRT_ORG = "Org"
  static final String PRT_FAC = "Fac"
  static final String PRT_PAED = "Paed"
  static final String PRT_CLIENT = "Client"
  static final String PRT_ACTIVITY = "Activity"

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

  // activity links
  static final String LT_ACT_PAED = "Pädagoge"
  static final String LT_ACT_CLIENT = "Betreuter"
  static final String LT_ACT_FAC = "Einrichtung"
  static final String LT_ACT_TEMPLATE = "Vorlage"
  static final String LT_ACT_CREATOR = "Ersteller"
  static final String LT_ACT_RESOURCE = "Ressource"

  def initialize() {
    getEstPerson()
    getEstOrg()
    getEstFac()
    getEstActivity()

    getEtUser()
    getEtPaed()
    getEtClient()
    getEtOperator()
    getEtHort()
    getEtSchool()
    getEtSponsor()
    getEtActivity()

    getLstPersonal()
    getLstOther()

    getLtFriendship()
    getLtSponsorship()
    getLtOperation()
    getLtClientship()
    getLtBookmark()
    getLtWorking()

    getLtActPaed()
    getLtActClient()
    getLtActFac()
    getLtActTemplate()
    getLtActCreator()
    getLtActResource()

    getUserRole()
    getModRole()
    getAdminRole()
    getSuperUserRole()
  }

  def getEstPerson()   {defaultObjectService.openEST (EST_PERSON, PRT_PERSON) }
  def getEstOrg()      {defaultObjectService.openEST (EST_ORG, PRT_ORG) }
  def getEstFac()      {defaultObjectService.openEST (EST_FAC, PRT_FAC) }
  def getEstActivity() {defaultObjectService.openEST (EST_ACTIVITY, PRT_ACTIVITY) }

  def getEtUser()     {defaultObjectService.openET (ET_USER, estPerson) }
  def getEtPaed()     {defaultObjectService.openET (ET_PAED, estPerson) }
  def getEtClient()   {defaultObjectService.openET (ET_CLIENT, estPerson) }
  def getEtOperator() {defaultObjectService.openET (ET_OPERATOR, estOrg) }
  def getEtHort()     {defaultObjectService.openET (ET_HORT, estFac) }
  def getEtSchool()   {defaultObjectService.openET (ET_SCHOOL, estFac) }
  def getEtSponsor()  {defaultObjectService.openET (ET_SPONSOR, estOrg) }
  def getEtActivity() {defaultObjectService.openET (ET_ACTIVITY, estActivity) }

  def getLstPersonal()   {defaultObjectService.openLST (LST_PERSONAL, "Personal Relationship") }
  def getLstOther()      {defaultObjectService.openLST (LST_OTHER, "Other Relationship") }

  def getLtFriendship()  {defaultObjectService.openLT (LT_FRIENDSHIP, lstPersonal) }
  def getLtSponsorship() {defaultObjectService.openLT (LT_SPONSORSHIP, lstOther) }
  def getLtOperation()   {defaultObjectService.openLT (LT_OPERATION, lstOther) }
  def getLtClientship()  {defaultObjectService.openLT (LT_CLIENTSHIP, lstOther) }
  def getLtBookmark()    {defaultObjectService.openLT (LT_BOOKMARK, lstOther) }
  def getLtWorking()     {defaultObjectService.openLT (LT_WORKING, lstOther) }

  // activity links
  def getLtActPaed()     {defaultObjectService.openLT (LT_ACT_PAED, lstOther) }
  def getLtActClient()   {defaultObjectService.openLT (LT_ACT_CLIENT, lstOther) }
  def getLtActFac()      {defaultObjectService.openLT (LT_ACT_FAC, lstOther) }
  def getLtActTemplate() {defaultObjectService.openLT (LT_ACT_TEMPLATE, lstOther) }
  def getLtActCreator()  {defaultObjectService.openLT (LT_ACT_CREATOR, lstOther) }
  def getLtActResource() {defaultObjectService.openLT (LT_ACT_RESOURCE, lstOther) }

  def getUserRole()      {defaultObjectService.openRole (ROLE_USER, "regular user") }
  def getModRole()       {defaultObjectService.openRole (ROLE_MOD, "moderator") }
  def getAdminRole()     {defaultObjectService.openRole (ROLE_ADMIN, "administrator") }
  def getSuperUserRole() {defaultObjectService.openRole (ROLE_SUPERUSER, "system administrator") }
}
