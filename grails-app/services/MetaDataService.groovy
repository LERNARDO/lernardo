import lernardo.PublicationType

class MetaDataService {

  boolean transactional = true

  def defaultObjectService

  // String Constants
  static final String EST_USER = "user"                  // EntitySuperType
  static final String EST_EDUCATOR = "educator"
  static final String EST_CLIENT = "client"
  static final String EST_OPERATOR = "operator"
  static final String EST_FACILITY = "facility"
  static final String EST_TEMPLATE = "Template"
  static final String EST_ACTIVITY = "Activity"
  static final String EST_GROUP_FAMILY = "GroupFamily"
  static final String EST_GROUP_COLONY = "GroupColony"
  static final String EST_GROUP_NETWORK = "GroupNetwork"
  static final String EST_GROUP_LEVEL = "GroupLevel"
  static final String EST_GROUP_ACTIVITY_TEMPLATE = "GroupActivityTemplate"
  static final String EST_COMMENT_TEMPLATE = "CommentTemplate"
  static final String EST_PATE = "pate"
  static final String EST_PARTNER = "partner"
  static final String EST_RESOURCE = "Resource"
  static final String EST_PARENT = "parent"

  static final String ET_USER = "User"                   // EntityType
  static final String ET_EDUCATOR = "Pädagoge"
  static final String ET_CLIENT = "Betreuter"
  static final String ET_OPERATOR = "Betreiber"
  static final String ET_FACILITY = "Einrichtung"
  static final String ET_TEMPLATE = "Vorlage"
  static final String ET_ACTIVITY = "Aktivität"
  static final String ET_GROUP_FAMILY = "Gruppe Familie"
  static final String ET_GROUP_COLONY = "Gruppe Siedlung"
  static final String ET_GROUP_NETWORK = "Gruppe Netzwerk"
  static final String ET_GROUP_LEVEL = "Gruppe Schulstufe"
  static final String ET_GROUP_ACTIVITY_TEMPLATE = "Gruppe Aktivitätsvorlagen"
  static final String ET_COMMENT_TEMPLATE = "Vorlagenkommentar"
  static final String ET_PATE = "Pate"
  static final String ET_PARTNER = "Partner"
  static final String ET_RESOURCE = "Ressource"
  static final String ET_PARENT = "Erziehungsberechtigter"

  static final String PRT_USER = "User"                // ProfileType
  static final String PRT_EDUCATOR = "Educator"
  static final String PRT_CLIENT = "Client"
  static final String PRT_OPERATOR = "Operator"
  static final String PRT_FACILITY = "Facility"
  static final String PRT_TEMPLATE = "Template"
  static final String PRT_ACTIVITY = "Activity"
  static final String PRT_GROUP_FAMILY = "GroupFamily"
  static final String PRT_GROUP_COLONY = "GroupColony"
  static final String PRT_GROUP_NETWORK = "GroupNetwork"
  static final String PRT_GROUP_LEVEL = "GroupLevel"
  static final String PRT_GROUP_ACTIVITY_TEMPLATE = "GroupActivityTemplate"
  static final String PRT_COMMENT_TEMPLATE = "CommentTemplate"
  static final String PRT_PATE = "Pate"
  static final String PRT_PARTNER = "Partner"
  static final String PRT_RESOURCE = "Resource"
  static final String PRT_PARENT = "Parent"

  static final String ROLE_USER = "ROLE_USER"
  static final String ROLE_MOD = "ROLE_MOD"
  static final String ROLE_ADMIN = "ROLE_ADMIN"
  static final String ROLE_SYSTEMADMIN = "ROLE_SYSTEMADMIN"

  static final String LST_PERSONAL = "personal"          // LinkSuperType
  static final String LST_OTHER = "other"

  static final String LT_FRIENDSHIP = "Freundschaft"     // LinkType
  static final String LT_SPONSORSHIP = "Sponsoring"
  // TODO: remove operation link
  static final String LT_OPERATION = "Betreibung"
  static final String LT_CLIENTSHIP = "Betreuung"
  static final String LT_BOOKMARK = "Beobachtung"
  static final String LT_WORKING = "Arbeitet"
  static final String LT_GROUP_MEMBER = "Gruppenmitglied"
  static final String LT_CREATOR = "Ersteller"
  static final String LT_EDITOR = "Bearbeiter"
  static final String LT_COMMENT = "Kommentar"
  static final String LT_PATE = "Pate"
  static final String LT_PARTNER = "Partner"
  static final String LT_RESOURCE = "Ressource"

  // activity links
  static final String LT_ACT_EDUCATOR = "Pädagoge"
  static final String LT_ACT_CLIENT = "Betreuter"
  static final String LT_ACT_FACILITY = "Einrichtung"
  static final String LT_ACT_TEMPLATE = "Vorlage"

  static final String PT_DOC1 = "Typ1"
  static final String PT_DOC2 = "Typ2"
  static final String PT_DOC3 = "Typ3"

  def initialize() {
    getEstUser()
    getEstEducator()
    getEstClient()
    getEstOperator()
    getEstFacility()
    getEstTemplate()
    getEstActivity()
    getEstGroupFamily()
    getEstGroupColony()
    getEstGroupNetwork()
    getEstGroupLevel()
    getEstGroupActivityTemplate()
    getEstCommentTemplate()
    getEstPate()
    getEstPartner()
    getEstResource()
    getEstParent()

    getEtUser()
    getEtEducator()
    getEtClient()
    getEtOperator()
    getEtFacility()
    getEtTemplate()
    getEtActivity()
    getEtGroupFamily()
    getEtGroupColony()
    getEtGroupNetwork()
    getEtGroupLevel()
    getEtGroupActivityTemplate()
    getEtCommentTemplate()
    getEtPate()
    getEtPartner()
    getEtResource()
    getEtParent()

    getLstPersonal()
    getLstOther()

    getLtFriendship()
    getLtSponsorship()
    getLtOperation()
    getLtClientship()
    getLtBookmark()
    getLtWorking()
    getLtGroupMember()
    getLtCreator()
    getLtEditor()
    getLtComment()
    getLtPate()
    getLtPartner()
    getLtResource()

    getLtActEducator()
    getLtActClient()
    getLtActFacility()
    getLtActTemplate()

    getUserRole()
    getModRole()
    getAdminRole()
    getSystemAdminRole()

    getPtDoc1()
    getPtDoc2()
    getPtDoc3()
  }

  def getEstUser()            {defaultObjectService.openEST (EST_USER, PRT_USER) }
  def getEstEducator()        {defaultObjectService.openEST (EST_EDUCATOR, PRT_EDUCATOR) }
  def getEstClient()          {defaultObjectService.openEST (EST_CLIENT, PRT_CLIENT) }
  def getEstOperator()        {defaultObjectService.openEST (EST_OPERATOR, PRT_OPERATOR) }
  def getEstFacility()        {defaultObjectService.openEST (EST_FACILITY, PRT_FACILITY) }
  def getEstTemplate()        {defaultObjectService.openEST (EST_TEMPLATE, PRT_TEMPLATE) }
  def getEstActivity()        {defaultObjectService.openEST (EST_ACTIVITY, PRT_ACTIVITY) }
  def getEstGroupFamily()     {defaultObjectService.openEST (EST_GROUP_FAMILY, PRT_GROUP_FAMILY) }
  def getEstGroupColony()     {defaultObjectService.openEST (EST_GROUP_COLONY, PRT_GROUP_COLONY) }
  def getEstGroupNetwork()    {defaultObjectService.openEST (EST_GROUP_NETWORK, PRT_GROUP_NETWORK) }
  def getEstGroupLevel()      {defaultObjectService.openEST (EST_GROUP_LEVEL, PRT_GROUP_LEVEL) }
  def getEstGroupActivityTemplate() {defaultObjectService.openEST (EST_GROUP_ACTIVITY_TEMPLATE, PRT_GROUP_ACTIVITY_TEMPLATE) }
  def getEstCommentTemplate() {defaultObjectService.openEST (EST_COMMENT_TEMPLATE, PRT_COMMENT_TEMPLATE) }
  def getEstPate()            {defaultObjectService.openEST (EST_PATE, PRT_PATE) }
  def getEstPartner()         {defaultObjectService.openEST (EST_PARTNER, PRT_PARTNER) }
  def getEstResource()        {defaultObjectService.openEST (EST_RESOURCE, PRT_RESOURCE) }
  def getEstParent()          {defaultObjectService.openEST (EST_PARENT, PRT_PARENT) }

  def getEtUser()            {defaultObjectService.openET (ET_USER, estUser) }
  def getEtEducator()        {defaultObjectService.openET (ET_EDUCATOR, estEducator) }
  def getEtClient()          {defaultObjectService.openET (ET_CLIENT, estClient) }
  def getEtOperator()        {defaultObjectService.openET (ET_OPERATOR, estOperator) }
  def getEtFacility()        {defaultObjectService.openET (ET_FACILITY, estFacility) }
  def getEtTemplate()        {defaultObjectService.openET (ET_TEMPLATE, estTemplate) }
  def getEtActivity()        {defaultObjectService.openET (ET_ACTIVITY, estActivity) }
  def getEtGroupFamily()     {defaultObjectService.openET (ET_GROUP_FAMILY, estGroupFamily) }
  def getEtGroupColony()     {defaultObjectService.openET (ET_GROUP_COLONY, estGroupColony) }
  def getEtGroupNetwork()    {defaultObjectService.openET (ET_GROUP_NETWORK, estGroupNetwork) }
  def getEtGroupLevel()      {defaultObjectService.openET (ET_GROUP_LEVEL, estGroupLevel) }
  def getEtGroupActivityTemplate() {defaultObjectService.openET (ET_GROUP_ACTIVITY_TEMPLATE, estGroupActivityTemplate) }
  def getEtCommentTemplate() {defaultObjectService.openET (ET_COMMENT_TEMPLATE, estCommentTemplate) }
  def getEtPate()            {defaultObjectService.openET (ET_PATE, estPate) }
  def getEtPartner()         {defaultObjectService.openET (ET_PARTNER, estPartner) }
  def getEtResource()        {defaultObjectService.openET (ET_RESOURCE, estResource) }
  def getEtParent()          {defaultObjectService.openET (ET_PARENT, estParent) }

  def getLstPersonal()   {defaultObjectService.openLST (LST_PERSONAL, "Personal Relationship") }
  def getLstOther()      {defaultObjectService.openLST (LST_OTHER, "Other Relationship") }

  def getLtFriendship()  {defaultObjectService.openLT (LT_FRIENDSHIP, lstPersonal) }
  def getLtSponsorship() {defaultObjectService.openLT (LT_SPONSORSHIP, lstOther) }
  def getLtOperation()   {defaultObjectService.openLT (LT_OPERATION, lstOther) }
  def getLtClientship()  {defaultObjectService.openLT (LT_CLIENTSHIP, lstOther) }
  def getLtBookmark()    {defaultObjectService.openLT (LT_BOOKMARK, lstOther) }
  def getLtWorking()     {defaultObjectService.openLT (LT_WORKING, lstOther) }
  def getLtGroupMember() {defaultObjectService.openLT (LT_GROUP_MEMBER, lstOther) }
  def getLtCreator()     {defaultObjectService.openLT (LT_CREATOR, lstOther) }
  def getLtEditor()      {defaultObjectService.openLT (LT_EDITOR, lstOther) }
  def getLtComment()     {defaultObjectService.openLT (LT_COMMENT, lstOther) }
  def getLtPate()        {defaultObjectService.openLT (LT_PATE, lstOther) }
  def getLtPartner()     {defaultObjectService.openLT (LT_PARTNER, lstOther) }
  def getLtResource()    {defaultObjectService.openLT (LT_RESOURCE, lstOther) }

  // activity links
  def getLtActEducator() {defaultObjectService.openLT (LT_ACT_EDUCATOR, lstOther) }
  def getLtActClient()   {defaultObjectService.openLT (LT_ACT_CLIENT, lstOther) }
  def getLtActFacility() {defaultObjectService.openLT (LT_ACT_FACILITY, lstOther) }
  def getLtActTemplate() {defaultObjectService.openLT (LT_ACT_TEMPLATE, lstOther) }

  def getUserRole()        {defaultObjectService.openRole (ROLE_USER, "regular user") }
  def getModRole()         {defaultObjectService.openRole (ROLE_MOD, "moderator") }
  def getAdminRole()       {defaultObjectService.openRole (ROLE_ADMIN, "administrator") }
  def getSystemAdminRole() {defaultObjectService.openRole (ROLE_SYSTEMADMIN, "system administrator") }

  def getPtDoc1 () {this.openPT (PT_DOC1, "Typ 1")}
  def getPtDoc2 () {this.openPT (PT_DOC2, "Typ 2")}
  def getPtDoc3 () {this.openPT (PT_DOC3, "Typ 3")}

  def openPT (String name, String desc) {
    PublicationType pt = PublicationType.findByName (name)
    if (!pt) {
      pt = new PublicationType(name:name, description:desc)
      if (!pt.save()) {
        pr.errors.each {log.error ("bootstrap validation error: $it")}
        throw new IllegalArgumentException("failed to bootstrap '$name' Publication Type")
      }
    }

    return (pt)
  }
}
