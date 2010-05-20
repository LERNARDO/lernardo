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
  static final String EST_TEMPLATE = "template"
  static final String EST_ACTIVITY = "activity"
  static final String EST_GROUP_PARTNER = "groupPartner"
  static final String EST_GROUP_FAMILY = "groupFamily"
  static final String EST_GROUP_CLIENT = "groupClient"
  static final String EST_GROUP_COLONY = "groupColony"
  static final String EST_GROUP_NETWORK = "groupNetwork"
  static final String EST_GROUP_LEVEL = "groupLevel"
  static final String EST_GROUP_ACTIVITY_TEMPLATE = "groupActivityTemplate"
  static final String EST_GROUP_ACTIVITY = "groupActivity"
  static final String EST_COMMENT_TEMPLATE = "commentTemplate"
  static final String EST_PATE = "pate"
  static final String EST_PARTNER = "partner"
  static final String EST_RESOURCE = "resource"
  static final String EST_PARENT = "parent"
  static final String EST_THEME = "theme"
  static final String EST_PROJECT_TEMPLATE = "projectTemplate"
  static final String EST_PROJECT = "project"
  static final String EST_PROJECT_DAY = "projectDay"
  static final String EST_PROJECT_UNIT = "projectUnit"

  static final String ET_USER = "User"                   // EntityType
  static final String ET_EDUCATOR = "Paedagoge"
  static final String ET_CLIENT = "Betreuter"
  static final String ET_CHILD = "Kind"
  static final String ET_OPERATOR = "Betreiber"
  static final String ET_FACILITY = "Einrichtung"
  static final String ET_TEMPLATE = "Vorlage"
  static final String ET_ACTIVITY = "Aktivitaet"
  static final String ET_GROUP_PARTNER = "Gruppe Partner"
  static final String ET_GROUP_FAMILY = "Gruppe Familie"
  static final String ET_GROUP_CLIENT = "Gruppe Betreute"
  static final String ET_GROUP_COLONY = "Gruppe Siedlung"
  static final String ET_GROUP_NETWORK = "Gruppe Netzwerk"
  static final String ET_GROUP_LEVEL = "Gruppe Schulstufe"
  static final String ET_GROUP_ACTIVITY_TEMPLATE = "Gruppe Aktivitaetsvorlagen"
  static final String ET_GROUP_ACTIVITY = "Gruppe Aktivitaeten"
  static final String ET_COMMENT_TEMPLATE = "Vorlagenkommentar"
  static final String ET_PATE = "Pate"
  static final String ET_PARTNER = "Partner"
  static final String ET_RESOURCE = "Ressource"
  static final String ET_PARENT = "Erziehungsberechtigter"
  static final String ET_THEME = "Thema"
  static final String ET_PROJECT_TEMPLATE = "Projektvorlage"
  static final String ET_PROJECT = "Projekt"
  static final String ET_PROJECT_DAY = "Projekttag"
  static final String ET_PROJECT_UNIT = "Projekteinheit"

  static final String PRT_USER = "User"                // ProfileType
  static final String PRT_EDUCATOR = "Educator"
  static final String PRT_CLIENT = "Client"
  static final String PRT_CHILD = "Child"
  static final String PRT_OPERATOR = "Operator"
  static final String PRT_FACILITY = "Facility"
  static final String PRT_TEMPLATE = "Template"
  static final String PRT_ACTIVITY = "Activity"
  static final String PRT_GROUP_PARTNER = "GroupPartner"
  static final String PRT_GROUP_FAMILY = "GroupFamily"
  static final String PRT_GROUP_CLIENT = "GroupClient"
  static final String PRT_GROUP_COLONY = "GroupColony"
  static final String PRT_GROUP_NETWORK = "GroupNetwork"
  static final String PRT_GROUP_LEVEL = "GroupLevel"
  static final String PRT_GROUP_ACTIVITY_TEMPLATE = "GroupActivityTemplate"
  static final String PRT_GROUP_ACTIVITY = "GroupActivity"
  static final String PRT_COMMENT_TEMPLATE = "CommentTemplate"
  static final String PRT_PATE = "Pate"
  static final String PRT_PARTNER = "Partner"
  static final String PRT_RESOURCE = "Resource"
  static final String PRT_PARENT = "Parent"
  static final String PRT_THEME = "Theme"
  static final String PRT_PROJECT_TEMPLATE = "ProjectTemplate"
  static final String PRT_PROJECT = "Project"
  static final String PRT_PROJECT_DAY = "ProjectDay"
  static final String PRT_PROJECT_UNIT = "ProjectUnit"

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
  static final String LT_GROUP_MEMBER_EDUCATOR = "Gruppenmitglied Pädagoge"
  static final String LT_GROUP_MEMBER_PARTNER = "Gruppenmitglied Partner"
  static final String LT_GROUP_MEMBER_FACILITY = "Gruppenmitglied Einrichtung"
  static final String LT_GROUP_MEMBER_CLIENT_GROUP = "Gruppenmitglied Betreutengruppe"
  static final String LT_CREATOR = "Ersteller"
  static final String LT_EDITOR = "Bearbeiter"
  static final String LT_COMMENT = "Kommentar"
  static final String LT_PATE = "Pate"
  static final String LT_PARTNER = "Partner"
  static final String LT_RESOURCE = "Ressource"
  static final String LT_ENLISTED = "Angeworben"
  static final String LT_SUBTHEME = "Subthema"
  static final String LT_PROJECT_MEMBER = "Projektmitglied"
  static final String LT_PROJECT_UNIT = "Projekteinheit"
  static final String LT_PROJECT_UNIT_MEMBER = "Projekteinheitmitglied"
  static final String LT_PROJECT_UNIT_PARENT = "Projekteinheitmitglied Erziehungsberechtigter"
  static final String LT_PROJECT_UNIT_PARTNER = "Projekteinheitmitglied Partner"
  static final String LT_PROJECT_DAY_UNIT = "Projekttag Einheit"
  static final String LT_PROJECT_DAY_EDUCATOR = "Projekttag Pädagoge"
  static final String LT_PROJECT_DAY_RESOURCE = "Projekttag Resource"
  static final String LT_PROJECT_TEMPLATE = "Projektvorlage"

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
    getEstGroupPartner()
    getEstGroupFamily()
    getEstGroupClient()
    getEstGroupColony()
    getEstGroupNetwork()
    getEstGroupLevel()
    getEstGroupActivityTemplate()
    getEstGroupActivity()
    getEstCommentTemplate()
    getEstPate()
    getEstPartner()
    getEstResource()
    getEstParent()
    getEstTheme()
    getEstProjectTemplate()
    getEstProject()
    getEstProjectDay()
    getEstProjectUnit()

    getEtUser()
    getEtEducator()
    getEtClient()
    getEtChild()
    getEtOperator()
    getEtFacility()
    getEtTemplate()
    getEtActivity()
    getEtGroupPartner()
    getEtGroupFamily()
    getEtGroupClient()
    getEtGroupColony()
    getEtGroupNetwork()
    getEtGroupLevel()
    getEtGroupActivityTemplate()
    getEtGroupActivity()
    getEtCommentTemplate()
    getEtPate()
    getEtPartner()
    getEtResource()
    getEtParent()
    getEtTheme()
    getEtProjectTemplate()
    getEtProject()
    getEtProjectDay()
    getEtProjectUnit()

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
    getLtGroupMemberEducator()
    getLtGroupMemberPartner()
    getLtGroupMemberFacility()
    getLtGroupMemberClientGroup()
    getLtCreator()
    getLtEditor()
    getLtComment()
    getLtPate()
    getLtPartner()
    getLtResource()
    getLtEnlisted()
    getLtSubTheme()
    getLtProjectMember()
    getLtProjectUnit()
    getLtProjectUnitMember()
    getLtProjectUnitParent()
    getLtProjectUnitPartner()
    getLtProjectDayUnit()
    getLtProjectDayEducator()
    getLtProjectDayResource()
    getLtProjectTemplate()

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

  EntitySuperType getEstUser()                  {defaultObjectService.openEST (EST_USER, PRT_USER) }
  EntitySuperType getEstEducator()              {defaultObjectService.openEST (EST_EDUCATOR, PRT_EDUCATOR) }
  EntitySuperType getEstClient()                {defaultObjectService.openEST (EST_CLIENT, PRT_CLIENT) }
  EntitySuperType getEstChild()                 {defaultObjectService.openEST (EST_CHILD, PRT_CHILD) }
  EntitySuperType getEstOperator()              {defaultObjectService.openEST (EST_OPERATOR, PRT_OPERATOR) }
  EntitySuperType getEstFacility()              {defaultObjectService.openEST (EST_FACILITY, PRT_FACILITY) }
  EntitySuperType getEstTemplate()              {defaultObjectService.openEST (EST_TEMPLATE, PRT_TEMPLATE) }
  EntitySuperType getEstActivity()              {defaultObjectService.openEST (EST_ACTIVITY, PRT_ACTIVITY) }
  EntitySuperType getEstGroupPartner()         {defaultObjectService.openEST (EST_GROUP_PARTNER, PRT_GROUP_PARTNER) }
  EntitySuperType getEstGroupFamily()          {defaultObjectService.openEST (EST_GROUP_FAMILY, PRT_GROUP_FAMILY) }
  EntitySuperType getEstGroupClient()           {defaultObjectService.openEST (EST_GROUP_CLIENT, PRT_GROUP_CLIENT) }
  EntitySuperType getEstGroupColony()           {defaultObjectService.openEST (EST_GROUP_COLONY, PRT_GROUP_COLONY) }
  EntitySuperType getEstGroupNetwork()          {defaultObjectService.openEST (EST_GROUP_NETWORK, PRT_GROUP_NETWORK) }
  EntitySuperType getEstGroupLevel()            {defaultObjectService.openEST (EST_GROUP_LEVEL, PRT_GROUP_LEVEL) }
  EntitySuperType getEstGroupActivityTemplate() {defaultObjectService.openEST (EST_GROUP_ACTIVITY_TEMPLATE, PRT_GROUP_ACTIVITY_TEMPLATE) }
  EntitySuperType getEstGroupActivity  ()       {defaultObjectService.openEST (EST_GROUP_ACTIVITY, PRT_GROUP_ACTIVITY) }
  EntitySuperType getEstCommentTemplate()       {defaultObjectService.openEST (EST_COMMENT_TEMPLATE, PRT_COMMENT_TEMPLATE) }
  EntitySuperType getEstPate()                  {defaultObjectService.openEST (EST_PATE, PRT_PATE) }
  EntitySuperType getEstPartner()               {defaultObjectService.openEST (EST_PARTNER, PRT_PARTNER) }
  EntitySuperType getEstResource()              {defaultObjectService.openEST (EST_RESOURCE, PRT_RESOURCE) }
  EntitySuperType getEstParent()                {defaultObjectService.openEST (EST_PARENT, PRT_PARENT) }
  EntitySuperType getEstTheme()                 {defaultObjectService.openEST (EST_THEME, PRT_THEME) }
  EntitySuperType getEstProjectTemplate()       {defaultObjectService.openEST (EST_PROJECT_TEMPLATE, PRT_PROJECT_TEMPLATE) }
  EntitySuperType getEstProject()               {defaultObjectService.openEST (EST_PROJECT, PRT_PROJECT) }
  EntitySuperType getEstProjectDay()            {defaultObjectService.openEST (EST_PROJECT_DAY, PRT_PROJECT_DAY) }
  EntitySuperType getEstProjectUnit()           {defaultObjectService.openEST (EST_PROJECT_UNIT, PRT_PROJECT_UNIT) }

  EntityType getEtUser()            {defaultObjectService.openET (ET_USER, estUser) }
  EntityType getEtEducator()        {defaultObjectService.openET (ET_EDUCATOR, estEducator) }
  EntityType getEtClient()          {defaultObjectService.openET (ET_CLIENT, estClient) }
  EntityType getEtChild()           {defaultObjectService.openET (ET_CHILD, estChild) }
  EntityType getEtOperator()        {defaultObjectService.openET (ET_OPERATOR, estOperator) }
  EntityType getEtFacility()        {defaultObjectService.openET (ET_FACILITY, estFacility) }
  EntityType getEtTemplate()        {defaultObjectService.openET (ET_TEMPLATE, estTemplate) }
  EntityType getEtActivity()        {defaultObjectService.openET (ET_ACTIVITY, estActivity) }
  EntityType getEtGroupPartner()    {defaultObjectService.openET (ET_GROUP_PARTNER, estGroupPartner) }
  EntityType getEtGroupFamily()     {defaultObjectService.openET (ET_GROUP_FAMILY, estGroupFamily) }
  EntityType getEtGroupClient()     {defaultObjectService.openET (ET_GROUP_CLIENT, estGroupClient) }
  EntityType getEtGroupColony()     {defaultObjectService.openET (ET_GROUP_COLONY, estGroupColony) }
  EntityType getEtGroupNetwork()    {defaultObjectService.openET (ET_GROUP_NETWORK, estGroupNetwork) }
  EntityType getEtGroupLevel()      {defaultObjectService.openET (ET_GROUP_LEVEL, estGroupLevel) }
  EntityType getEtGroupActivityTemplate() {defaultObjectService.openET (ET_GROUP_ACTIVITY_TEMPLATE, estGroupActivityTemplate) }
  EntityType getEtGroupActivity()   {defaultObjectService.openET (ET_GROUP_ACTIVITY, estGroupActivity) }
  EntityType getEtCommentTemplate() {defaultObjectService.openET (ET_COMMENT_TEMPLATE, estCommentTemplate) }
  EntityType getEtPate()            {defaultObjectService.openET (ET_PATE, estPate) }
  EntityType getEtPartner()         {defaultObjectService.openET (ET_PARTNER, estPartner) }
  EntityType getEtResource()        {defaultObjectService.openET (ET_RESOURCE, estResource) }
  EntityType getEtParent()          {defaultObjectService.openET (ET_PARENT, estParent) }
  EntityType getEtTheme()           {defaultObjectService.openET (ET_THEME, estTheme) }
  EntityType getEtProjectTemplate() {defaultObjectService.openET (ET_PROJECT_TEMPLATE, estProjectTemplate) }
  EntityType getEtProject()         {defaultObjectService.openET (ET_PROJECT, estProject) }
  EntityType getEtProjectDay()      {defaultObjectService.openET (ET_PROJECT_DAY, estProjectDay) }
  EntityType getEtProjectUnit()     {defaultObjectService.openET (ET_PROJECT_UNIT, estProjectUnit) }

  LinkSuperType getLstPersonal() {defaultObjectService.openLST (LST_PERSONAL, "Personal Relationship") }
  LinkSuperType getLstOther()    {defaultObjectService.openLST (LST_OTHER, "Other Relationship") }

  LinkType getLtFriendship()             {defaultObjectService.openLT (LT_FRIENDSHIP, lstPersonal) }
  LinkType getLtSponsorship()            {defaultObjectService.openLT (LT_SPONSORSHIP, lstOther) }
  LinkType getLtOperation()              {defaultObjectService.openLT (LT_OPERATION, lstOther) }
  LinkType getLtClientship()             {defaultObjectService.openLT (LT_CLIENTSHIP, lstOther) }
  LinkType getLtBookmark()               {defaultObjectService.openLT (LT_BOOKMARK, lstOther) }
  LinkType getLtWorking()                {defaultObjectService.openLT (LT_WORKING, lstOther) }
  LinkType getLtGroupMember()            {defaultObjectService.openLT (LT_GROUP_MEMBER, lstOther) }
  LinkType getLtGroupMemberParent()      {defaultObjectService.openLT (LT_GROUP_MEMBER_PARENT, lstOther) }
  LinkType getLtGroupMemberClient()      {defaultObjectService.openLT (LT_GROUP_MEMBER_CLIENT, lstOther) }
  LinkType getLtGroupMemberChild()       {defaultObjectService.openLT (LT_GROUP_MEMBER_CHILD, lstOther) }
  LinkType getLtGroupMemberEducator()    {defaultObjectService.openLT (LT_GROUP_MEMBER_EDUCATOR, lstOther) }
  LinkType getLtGroupMemberPartner()     {defaultObjectService.openLT (LT_GROUP_MEMBER_PARTNER, lstOther) }
  LinkType getLtGroupMemberFacility()    {defaultObjectService.openLT (LT_GROUP_MEMBER_FACILITY, lstOther) }
  LinkType getLtGroupMemberClientGroup() {defaultObjectService.openLT (LT_GROUP_MEMBER_CLIENT_GROUP, lstOther) }
  LinkType getLtCreator()                {defaultObjectService.openLT (LT_CREATOR, lstOther) }
  LinkType getLtEditor()                 {defaultObjectService.openLT (LT_EDITOR, lstOther) }
  LinkType getLtComment()                {defaultObjectService.openLT (LT_COMMENT, lstOther) }
  LinkType getLtPate()                   {defaultObjectService.openLT (LT_PATE, lstOther) }
  LinkType getLtPartner()                {defaultObjectService.openLT (LT_PARTNER, lstOther) }
  LinkType getLtResource()               {defaultObjectService.openLT (LT_RESOURCE, lstOther) }
  LinkType getLtEnlisted()               {defaultObjectService.openLT (LT_ENLISTED, lstOther) }
  LinkType getLtSubTheme()               {defaultObjectService.openLT (LT_SUBTHEME, lstOther) }
  LinkType getLtProjectMember()          {defaultObjectService.openLT (LT_PROJECT_MEMBER, lstOther) }
  LinkType getLtProjectUnit()            {defaultObjectService.openLT (LT_PROJECT_UNIT, lstOther) }
  LinkType getLtProjectUnitMember()      {defaultObjectService.openLT (LT_PROJECT_UNIT_MEMBER, lstOther) }
  LinkType getLtProjectUnitParent()      {defaultObjectService.openLT (LT_PROJECT_UNIT_PARENT, lstOther) }
  LinkType getLtProjectUnitPartner()     {defaultObjectService.openLT (LT_PROJECT_UNIT_PARTNER, lstOther) }
  LinkType getLtProjectDayUnit()         {defaultObjectService.openLT (LT_PROJECT_DAY_UNIT, lstOther) }
  LinkType getLtProjectDayEducator()     {defaultObjectService.openLT (LT_PROJECT_DAY_EDUCATOR, lstOther) }
  LinkType getLtProjectDayResource()     {defaultObjectService.openLT (LT_PROJECT_DAY_RESOURCE, lstOther) }
  LinkType getLtProjectTemplate()        {defaultObjectService.openLT (LT_PROJECT_TEMPLATE, lstOther) }

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
