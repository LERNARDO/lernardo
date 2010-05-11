package standard

import lernardo.PublicationType
import de.uenterprise.ep.DefaultObjectService
import de.uenterprise.ep.EntitySuperType
import de.uenterprise.ep.EntityType
import de.uenterprise.ep.LinkSuperType
import de.uenterprise.ep.LinkType
import de.uenterprise.ep.Role

class MetaDataService {

  boolean transactional = true

  DefaultObjectService defaultObjectService

  // String Constants
  static final String EST_USER = "user"                  // EntitySuperType
  static final String EST_EDUCATOR = "educator"
  static final String EST_CLIENT = "client"
  static final String EST_CHILD = "child"
  static final String EST_OPERATOR = "operator"
  static final String EST_FACILITY = "facility"
  static final String EST_TEMPLATE = "Template"
  static final String EST_ACTIVITY = "Activity"
  static final String EST_GROUP_FAMILY = "GroupFamily"
  static final String EST_GROUP_CLIENT = "GroupClient"
  static final String EST_GROUP_COLONY = "GroupColony"
  static final String EST_GROUP_NETWORK = "GroupNetwork"
  static final String EST_GROUP_LEVEL = "GroupLevel"
  static final String EST_GROUP_ACTIVITY_TEMPLATE = "GroupActivityTemplate"
  static final String EST_COMMENT_TEMPLATE = "CommentTemplate"
  static final String EST_PATE = "pate"
  static final String EST_PARTNER = "partner"
  static final String EST_RESOURCE = "resource"
  static final String EST_PARENT = "parent"

  static final String ET_USER = "User"                   // EntityType
  static final String ET_EDUCATOR = "Pädagoge"
  static final String ET_CLIENT = "Betreuter"
  static final String ET_CHILD = "Kind"
  static final String ET_OPERATOR = "Betreiber"
  static final String ET_FACILITY = "Einrichtung"
  static final String ET_TEMPLATE = "Vorlage"
  static final String ET_ACTIVITY = "Aktivität"
  static final String ET_GROUP_FAMILY = "Gruppe Familie"
  static final String ET_GROUP_CLIENT = "Gruppe Betreute"
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
  static final String PRT_CHILD = "Child"
  static final String PRT_OPERATOR = "Operator"
  static final String PRT_FACILITY = "Facility"
  static final String PRT_TEMPLATE = "Template"
  static final String PRT_ACTIVITY = "Activity"
  static final String PRT_GROUP_FAMILY = "GroupFamily"
  static final String PRT_GROUP_CLIENT = "GroupClient"
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
  static final String LT_GROUP_MEMBER_PARENT = "Gruppenmitglied Erziehungsberechtigter"
  static final String LT_GROUP_MEMBER_CLIENT = "Gruppenmitglied Betreuter"
  static final String LT_GROUP_MEMBER_CHILD = "Gruppenmitglied Kind"
  static final String LT_CREATOR = "Ersteller"
  static final String LT_EDITOR = "Bearbeiter"
  static final String LT_COMMENT = "Kommentar"
  static final String LT_PATE = "Pate"
  static final String LT_PARTNER = "Partner"
  static final String LT_RESOURCE = "Ressource"
  static final String LT_ENLISTED = "Angeworben"

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
    getEstChild()
    getEstOperator()
    getEstFacility()
    getEstTemplate()
    getEstActivity()
    getEstGroupFamily()
    getEstGroupClient()
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
    getEtChild()
    getEtOperator()
    getEtFacility()
    getEtTemplate()
    getEtActivity()
    getEtGroupFamily()
    getEtGroupClient()
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
    getLtGroupMemberParent()
    getLtGroupMemberClient()
    getLtGroupMemberChild()
    getLtCreator()
    getLtEditor()
    getLtComment()
    getLtPate()
    getLtPartner()
    getLtResource()
    getLtEnlisted()

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

  EntitySuperType getEstUser()            {defaultObjectService.openEST (EST_USER, PRT_USER) }
  EntitySuperType getEstEducator()        {defaultObjectService.openEST (EST_EDUCATOR, PRT_EDUCATOR) }
  EntitySuperType getEstClient()          {defaultObjectService.openEST (EST_CLIENT, PRT_CLIENT) }
  EntitySuperType getEstChild()           {defaultObjectService.openEST (EST_CHILD, PRT_CHILD) }
  EntitySuperType getEstOperator()        {defaultObjectService.openEST (EST_OPERATOR, PRT_OPERATOR) }
  EntitySuperType getEstFacility()        {defaultObjectService.openEST (EST_FACILITY, PRT_FACILITY) }
  EntitySuperType getEstTemplate()        {defaultObjectService.openEST (EST_TEMPLATE, PRT_TEMPLATE) }
  EntitySuperType getEstActivity()        {defaultObjectService.openEST (EST_ACTIVITY, PRT_ACTIVITY) }
  EntitySuperType getEstGroupFamily()     {defaultObjectService.openEST (EST_GROUP_FAMILY, PRT_GROUP_FAMILY) }
  EntitySuperType getEstGroupClient()     {defaultObjectService.openEST (EST_GROUP_CLIENT, PRT_GROUP_CLIENT) }
  EntitySuperType getEstGroupColony()     {defaultObjectService.openEST (EST_GROUP_COLONY, PRT_GROUP_COLONY) }
  EntitySuperType getEstGroupNetwork()    {defaultObjectService.openEST (EST_GROUP_NETWORK, PRT_GROUP_NETWORK) }
  EntitySuperType getEstGroupLevel()      {defaultObjectService.openEST (EST_GROUP_LEVEL, PRT_GROUP_LEVEL) }
  EntitySuperType getEstGroupActivityTemplate() {defaultObjectService.openEST (EST_GROUP_ACTIVITY_TEMPLATE, PRT_GROUP_ACTIVITY_TEMPLATE) }
  EntitySuperType getEstCommentTemplate() {defaultObjectService.openEST (EST_COMMENT_TEMPLATE, PRT_COMMENT_TEMPLATE) }
  EntitySuperType getEstPate()            {defaultObjectService.openEST (EST_PATE, PRT_PATE) }
  EntitySuperType getEstPartner()         {defaultObjectService.openEST (EST_PARTNER, PRT_PARTNER) }
  EntitySuperType getEstResource()        {defaultObjectService.openEST (EST_RESOURCE, PRT_RESOURCE) }
  EntitySuperType getEstParent()          {defaultObjectService.openEST (EST_PARENT, PRT_PARENT) }

  EntityType getEtUser()            {defaultObjectService.openET (ET_USER, estUser) }
  EntityType getEtEducator()        {defaultObjectService.openET (ET_EDUCATOR, estEducator) }
  EntityType getEtClient()          {defaultObjectService.openET (ET_CLIENT, estClient) }
  EntityType getEtChild()           {defaultObjectService.openET (ET_CHILD, estChild) }
  EntityType getEtOperator()        {defaultObjectService.openET (ET_OPERATOR, estOperator) }
  EntityType getEtFacility()        {defaultObjectService.openET (ET_FACILITY, estFacility) }
  EntityType getEtTemplate()        {defaultObjectService.openET (ET_TEMPLATE, estTemplate) }
  EntityType getEtActivity()        {defaultObjectService.openET (ET_ACTIVITY, estActivity) }
  EntityType getEtGroupFamily()     {defaultObjectService.openET (ET_GROUP_FAMILY, estGroupFamily) }
  EntityType getEtGroupClient()     {defaultObjectService.openET (ET_GROUP_CLIENT, estGroupClient) }
  EntityType getEtGroupColony()     {defaultObjectService.openET (ET_GROUP_COLONY, estGroupColony) }
  EntityType getEtGroupNetwork()    {defaultObjectService.openET (ET_GROUP_NETWORK, estGroupNetwork) }
  EntityType getEtGroupLevel()      {defaultObjectService.openET (ET_GROUP_LEVEL, estGroupLevel) }
  EntityType getEtGroupActivityTemplate() {defaultObjectService.openET (ET_GROUP_ACTIVITY_TEMPLATE, estGroupActivityTemplate) }
  EntityType getEtCommentTemplate() {defaultObjectService.openET (ET_COMMENT_TEMPLATE, estCommentTemplate) }
  EntityType getEtPate()            {defaultObjectService.openET (ET_PATE, estPate) }
  EntityType getEtPartner()         {defaultObjectService.openET (ET_PARTNER, estPartner) }
  EntityType getEtResource()        {defaultObjectService.openET (ET_RESOURCE, estResource) }
  EntityType getEtParent()          {defaultObjectService.openET (ET_PARENT, estParent) }

  LinkSuperType getLstPersonal()   {defaultObjectService.openLST (LST_PERSONAL, "Personal Relationship") }
  LinkSuperType getLstOther()      {defaultObjectService.openLST (LST_OTHER, "Other Relationship") }

  LinkType getLtFriendship()  {defaultObjectService.openLT (LT_FRIENDSHIP, lstPersonal) }
  LinkType getLtSponsorship() {defaultObjectService.openLT (LT_SPONSORSHIP, lstOther) }
  LinkType getLtOperation()   {defaultObjectService.openLT (LT_OPERATION, lstOther) }
  LinkType getLtClientship()  {defaultObjectService.openLT (LT_CLIENTSHIP, lstOther) }
  LinkType getLtBookmark()    {defaultObjectService.openLT (LT_BOOKMARK, lstOther) }
  LinkType getLtWorking()     {defaultObjectService.openLT (LT_WORKING, lstOther) }
  LinkType getLtGroupMember() {defaultObjectService.openLT (LT_GROUP_MEMBER, lstOther) }
  LinkType getLtGroupMemberParent() {defaultObjectService.openLT (LT_GROUP_MEMBER_PARENT, lstOther) }
  LinkType getLtGroupMemberClient() {defaultObjectService.openLT (LT_GROUP_MEMBER_CLIENT, lstOther) }
  LinkType getLtGroupMemberChild() {defaultObjectService.openLT (LT_GROUP_MEMBER_CHILD, lstOther) }
  LinkType getLtCreator()     {defaultObjectService.openLT (LT_CREATOR, lstOther) }
  LinkType getLtEditor()      {defaultObjectService.openLT (LT_EDITOR, lstOther) }
  LinkType getLtComment()     {defaultObjectService.openLT (LT_COMMENT, lstOther) }
  LinkType getLtPate()        {defaultObjectService.openLT (LT_PATE, lstOther) }
  LinkType getLtPartner()     {defaultObjectService.openLT (LT_PARTNER, lstOther) }
  LinkType getLtResource()    {defaultObjectService.openLT (LT_RESOURCE, lstOther) }
  LinkType getLtEnlisted()    {defaultObjectService.openLT (LT_ENLISTED, lstOther) }

  // activity links
  LinkType getLtActEducator() {defaultObjectService.openLT (LT_ACT_EDUCATOR, lstOther) }
  LinkType getLtActClient()   {defaultObjectService.openLT (LT_ACT_CLIENT, lstOther) }
  LinkType getLtActFacility() {defaultObjectService.openLT (LT_ACT_FACILITY, lstOther) }
  LinkType getLtActTemplate() {defaultObjectService.openLT (LT_ACT_TEMPLATE, lstOther) }

  Role getUserRole()        {defaultObjectService.openRole (ROLE_USER, "regular user") }
  Role getModRole()         {defaultObjectService.openRole (ROLE_MOD, "moderator") }
  Role getAdminRole()       {defaultObjectService.openRole (ROLE_ADMIN, "administrator") }
  Role getSystemAdminRole() {defaultObjectService.openRole (ROLE_SYSTEMADMIN, "system administrator") }

  PublicationType getPtDoc1 () {this.openPT (PT_DOC1, "Typ 1")}
  PublicationType getPtDoc2 () {this.openPT (PT_DOC2, "Typ 2")}
  PublicationType getPtDoc3 () {this.openPT (PT_DOC3, "Typ 3")}

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
