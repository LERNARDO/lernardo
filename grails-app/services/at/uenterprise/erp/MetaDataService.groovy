package at.uenterprise.erp

import at.uenterprise.erp.base.EntitySuperType
import at.uenterprise.erp.base.EntityType
import at.uenterprise.erp.base.LinkSuperType
import at.uenterprise.erp.base.LinkType
import at.uenterprise.erp.base.Role

class MetaDataService {

  boolean transactional = true

  // EntitySuperTypes
  static final String EST_USER                    = "user"
  static final String EST_EDUCATOR                = "educator"
  static final String EST_CLIENT                  = "client"
  static final String EST_CHILD                   = "child"
  static final String EST_OPERATOR                = "operator"
  static final String EST_FACILITY                = "facility"
  static final String EST_TEMPLATE                = "template"
  static final String EST_ACTIVITY                = "activity"
  static final String EST_GROUP_PARTNER           = "groupPartner"
  static final String EST_GROUP_FAMILY            = "groupFamily"
  static final String EST_GROUP_CLIENT            = "groupClient"
  static final String EST_GROUP_COLONY            = "groupColony"
  static final String EST_GROUP_ACTIVITY_TEMPLATE = "groupActivityTemplate"
  static final String EST_GROUP_ACTIVITY          = "groupActivity"
  static final String EST_PATE                    = "pate"
  static final String EST_PARTNER                 = "partner"
  static final String EST_RESOURCE                = "resource"
  static final String EST_PARENT                  = "parent"
  static final String EST_THEME                   = "theme"
  static final String EST_PROJECT_TEMPLATE        = "projectTemplate"
  static final String EST_PROJECT                 = "project"
  static final String EST_PROJECT_DAY             = "projectDay"
  static final String EST_PROJECT_UNIT            = "projectUnit"
  static final String EST_PROJECT_UNIT_TEMPLATE   = "projectUnitTemplate"
  static final String EST_APPOINTMENT             = "appointment"

  // EntityTypes
  static final String ET_USER                     = "User"
  static final String ET_EDUCATOR                 = "Pädagoge"
  static final String ET_CLIENT                   = "Betreuter"
  static final String ET_CHILD                    = "Kind"
  static final String ET_OPERATOR                 = "Betreiber"
  static final String ET_FACILITY                 = "Einrichtung"
  static final String ET_TEMPLATE                 = "Vorlage"
  static final String ET_ACTIVITY                 = "Aktivität"
  static final String ET_GROUP_PARTNER            = "Sponsorennetzwerk"
  static final String ET_GROUP_FAMILY             = "Familie"
  static final String ET_GROUP_CLIENT             = "Betreutengruppe"
  static final String ET_GROUP_COLONY             = "Siedlung"
  static final String ET_GROUP_ACTIVITY_TEMPLATE  = "Aktivitätsvorlagenblock"
  static final String ET_GROUP_ACTIVITY           = "Aktivitätsblock"
  static final String ET_PATE                     = "Pate"
  static final String ET_PARTNER                  = "Partner"
  static final String ET_RESOURCE                 = "Ressource"
  static final String ET_PARENT                   = "Erziehungsberechtigter"
  static final String ET_THEME                    = "Thema"
  static final String ET_PROJECT_TEMPLATE         = "Projektvorlage"
  static final String ET_PROJECT                  = "Projekt"
  static final String ET_PROJECT_DAY              = "Projekttag"
  static final String ET_PROJECT_UNIT             = "Projekteinheit"
  static final String ET_PROJECT_UNIT_TEMPLATE    = "Projekteinheitvorlage"
  static final String ET_APPOINTMENT              = "Termin"

  // ProfileTypes
  static final String PRT_USER                    = "User"
  static final String PRT_EDUCATOR                = "Educator"
  static final String PRT_CLIENT                  = "Client"
  static final String PRT_CHILD                   = "Child"
  static final String PRT_OPERATOR                = "Operator"
  static final String PRT_FACILITY                = "Facility"
  static final String PRT_TEMPLATE                = "Template"
  static final String PRT_ACTIVITY                = "Activity"
  static final String PRT_GROUP_PARTNER           = "GroupPartner"
  static final String PRT_GROUP_FAMILY            = "GroupFamily"
  static final String PRT_GROUP_CLIENT            = "GroupClient"
  static final String PRT_GROUP_COLONY            = "GroupColony"
  static final String PRT_GROUP_ACTIVITY_TEMPLATE = "GroupActivityTemplate"
  static final String PRT_GROUP_ACTIVITY          = "GroupActivity"
  static final String PRT_PATE                    = "Pate"
  static final String PRT_PARTNER                 = "Partner"
  static final String PRT_RESOURCE                = "Resource"
  static final String PRT_PARENT                  = "Parent"
  static final String PRT_THEME                   = "Theme"
  static final String PRT_PROJECT_TEMPLATE        = "ProjectTemplate"
  static final String PRT_PROJECT                 = "Project"
  static final String PRT_PROJECT_DAY             = "ProjectDay"
  static final String PRT_PROJECT_UNIT            = "ProjectUnit"
  static final String PRT_PROJECT_UNIT_TEMPLATE   = "ProjectUnitTemplate"
  static final String PRT_APPOINTMENT             = "Appointment"

  // LinkSuperTypes
  static final String LST_PERSONAL  = "personal"
  static final String LST_OTHER     = "other"

  // LinkType
  static final String LT_FRIENDSHIP                   = "Freundschaft"
  static final String LT_SPONSORSHIP                  = "Sponsoring"
  static final String LT_OPERATION                    = "Betreibung"
  static final String LT_CLIENTSHIP                   = "Betreuung"
  static final String LT_BOOKMARK                     = "Beobachtung"
  static final String LT_WORKING                      = "Arbeitet"
  static final String LT_GROUP_MEMBER                 = "Gruppenmitglied"
  static final String LT_GROUP_MEMBER_PARENT          = "Gruppenmitglied Erziehungsberechtigter"
  static final String LT_GROUP_MEMBER_CLIENT          = "Gruppenmitglied Betreuter"
  static final String LT_GROUP_MEMBER_CHILD           = "Gruppenmitglied Kind"
  static final String LT_GROUP_MEMBER_EDUCATOR        = "Gruppenmitglied Pädagoge"
  static final String LT_GROUP_MEMBER_PARTNER         = "Gruppenmitglied Partner"
  static final String LT_GROUP_MEMBER_FACILITY        = "Gruppenmitglied Einrichtung"
  static final String LT_GROUP_MEMBER_CLIENT_GROUP    = "Gruppenmitglied Betreutengruppe"
  static final String LT_GROUP_MEMBER_ACTIVITY_GROUP  = "Gruppenmitglied Aktivitätsblock"
  static final String LT_GROUP_MEMBER_SUBSTITUTE      = "Gruppenmitglied Supplierung"
  static final String LT_CREATOR                      = "Ersteller"
  static final String LT_EDITOR                       = "Bearbeiter"
  static final String LT_COMMENT                      = "Kommentar"
  static final String LT_PATE                         = "Pate"
  static final String LT_PARTNER                      = "Partner"
  static final String LT_RESOURCE                     = "Ressource"
  static final String LT_RESOURCE_PLANNED             = "Ressource geplant"
  static final String LT_ENLISTED                     = "Angeworben"
  static final String LT_SUBTHEME                     = "Subthema"
  static final String LT_PROJECT_MEMBER               = "Projektmitglied"
  static final String LT_PROJECT_UNIT                 = "Projekteinheit"
  static final String LT_PROJECT_UNIT_MEMBER          = "Projekteinheitmitglied"
  static final String LT_PROJECT_UNIT_PARENT          = "Projekteinheitmitglied Erziehungsberechtigter"
  static final String LT_PROJECT_UNIT_PARTNER         = "Projekteinheitmitglied Partner"
  static final String LT_PROJECT_DAY_UNIT             = "Projekttag Einheit"
  static final String LT_PROJECT_DAY_EDUCATOR         = "Projekttag Pädagoge"
  static final String LT_PROJECT_DAY_SUBSTITUTE       = "Projekttag Ersatzpädagoge"
  static final String LT_PROJECT_DAY_RESOURCE         = "Projekttag Resource"
  static final String LT_PROJECT_TEMPLATE             = "Projektvorlage"
  static final String LT_COLONIA                      = "Kolonie"
  static final String LT_FACILITY                     = "Einrichtung"
  static final String LT_GROUP_FAMILY                 = "Familienmitglied"
  static final String LT_LEAD_EDUCATOR                = "Leitender Pädagoge"
  static final String LT_THEME_OF_FACILITY            = "Thema der Einrichtung"
  static final String LT_TEMPLATE                     = "Vorlage"
  static final String LT_PROJECT_UNIT_TEMPLATE        = "Projekteinheitvorlage"
  static final String LT_APPOINTMENT                  = "Termin"
  static final String LT_OWNER                        = "Besitzer"
  static final String LT_RESPONSIBLE                  = "Verantwortlicher"
  static final String LT_ABSENT                       = "Abwesend"
  static final String LT_ILL                          = "Krank"
  static final String LT_ACT_EDUCATOR                 = "Pädagoge"
  static final String LT_ACT_CLIENT                   = "Betreuter"
  static final String LT_ACT_FACILITY                 = "Einrichtung"
  static final String LT_ACT_TEMPLATE                 = "Vorlage"
  static final String LT_ACT_PROJECT                  = "Projekt"
  static final String LT_ACT_PARTNER                  = "Partner"
  static final String LT_ACT_PARENT                   = "Erziehungsberechtigter"

  // PublicationTypes
  static final String PT_DOC1 = "Typ1"
  static final String PT_DOC2 = "Typ2"
  static final String PT_DOC3 = "Typ3"

  // Roles
  static final String ROLE_USER           = "ROLE_USER"
  static final String ROLE_MOD            = "ROLE_MOD"
  static final String ROLE_ADMIN          = "ROLE_ADMIN"
  static final String ROLE_SYSTEMADMIN    = "ROLE_SYSTEMADMIN"
  static final String ROLE_LEAD_EDUCATOR  = "ROLE_LEAD_EDUCATOR"

  def initialize() {
    setEstUser()
    setEstEducator()
    setEstClient()
    setEstChild()
    setEstOperator()
    setEstFacility()
    setEstTemplate()
    setEstActivity()
    setEstGroupPartner()
    setEstGroupFamily()
    setEstGroupClient()
    setEstGroupColony()
    setEstGroupActivityTemplate()
    setEstGroupActivity()
    setEstPate()
    setEstPartner()
    setEstResource()
    setEstParent()
    setEstTheme()
    setEstProjectTemplate()
    setEstProject()
    setEstProjectDay()
    setEstProjectUnit()
    setEstProjectUnitTemplate()
    setEstAppointment()

    setEtUser()
    setEtEducator()
    setEtClient()
    setEtChild()
    setEtOperator()
    setEtFacility()
    setEtTemplate()
    setEtActivity()
    setEtGroupPartner()
    setEtGroupFamily()
    setEtGroupClient()
    setEtGroupColony()
    setEtGroupActivityTemplate()
    setEtGroupActivity()
    setEtPate()
    setEtPartner()
    setEtResource()
    setEtParent()
    setEtTheme()
    setEtProjectTemplate()
    setEtProject()
    setEtProjectDay()
    setEtProjectUnit()
    setEtProjectUnitTemplate()
    setEtAppointment()

    setLstPersonal()
    setLstOther()

    setLtFriendship()
    setLtSponsorship()
    setLtOperation()
    setLtClientship()
    setLtBookmark()
    setLtWorking()
    setLtGroupMember()
    setLtGroupMemberParent()
    setLtGroupMemberClient()
    setLtGroupMemberChild()
    setLtGroupMemberEducator()
    setLtGroupMemberPartner()
    setLtGroupMemberFacility()
    setLtGroupMemberClientGroup()
    setLtGroupMemberActivityGroup()
    setLtGroupMemberSubstitute()
    setLtCreator()
    setLtEditor()
    setLtComment()
    setLtPate()
    setLtPartner()
    setLtResource()
    setLtResourcePlanned()
    setLtEnlisted()
    setLtSubTheme()
    setLtProjectMember()
    setLtProjectUnit()
    setLtProjectUnitMember()
    setLtProjectUnitParent()
    setLtProjectUnitPartner()
    setLtProjectDayUnit()
    setLtProjectDayEducator()
    setLtProjectDaySubstitute()
    setLtProjectDayResource()
    setLtProjectTemplate()
    setLtColonia()
    setLtFacility()
    setLtGroupFamily()
    setLtLeadEducator()
    setLtThemeOfFacility()
    setLtTemplate()
    setLtProjectUnitTemplate()
    setLtAppointment()
    setLtOwner()
    setLtResponsible()
    setLtActEducator()
    setLtActClient()
    setLtActFacility()
    setLtActTemplate()
    setLtActProject()
    setLtActPartner()
    setLtActParent()
    setLtAbsent()
    setLtIll()

    setPtDoc1()
    setPtDoc2()
    setPtDoc3()

    setUserRole()
    setModRole()
    setAdminRole()
    setSystemAdminRole()
    setLeadEducatorRole()
  }
  
  // setter

  void setEstUser()                  { openEST (EST_USER, PRT_USER) }
  void setEstEducator()              { openEST (EST_EDUCATOR, PRT_EDUCATOR) }
  void setEstClient()                { openEST (EST_CLIENT, PRT_CLIENT) }
  void setEstChild()                 { openEST (EST_CHILD, PRT_CHILD) }
  void setEstOperator()              { openEST (EST_OPERATOR, PRT_OPERATOR) }
  void setEstFacility()              { openEST (EST_FACILITY, PRT_FACILITY) }
  void setEstTemplate()              { openEST (EST_TEMPLATE, PRT_TEMPLATE) }
  void setEstActivity()              { openEST (EST_ACTIVITY, PRT_ACTIVITY) }
  void setEstGroupPartner()          { openEST (EST_GROUP_PARTNER, PRT_GROUP_PARTNER) }
  void setEstGroupFamily()           { openEST (EST_GROUP_FAMILY, PRT_GROUP_FAMILY) }
  void setEstGroupClient()           { openEST (EST_GROUP_CLIENT, PRT_GROUP_CLIENT) }
  void setEstGroupColony()           { openEST (EST_GROUP_COLONY, PRT_GROUP_COLONY) }
  void setEstGroupActivityTemplate() { openEST (EST_GROUP_ACTIVITY_TEMPLATE, PRT_GROUP_ACTIVITY_TEMPLATE) }
  void setEstGroupActivity  ()       { openEST (EST_GROUP_ACTIVITY, PRT_GROUP_ACTIVITY) }
  void setEstPate()                  { openEST (EST_PATE, PRT_PATE) }
  void setEstPartner()               { openEST (EST_PARTNER, PRT_PARTNER) }
  void setEstResource()              { openEST (EST_RESOURCE, PRT_RESOURCE) }
  void setEstParent()                { openEST (EST_PARENT, PRT_PARENT) }
  void setEstTheme()                 { openEST (EST_THEME, PRT_THEME) }
  void setEstProjectTemplate()       { openEST (EST_PROJECT_TEMPLATE, PRT_PROJECT_TEMPLATE) }
  void setEstProject()               { openEST (EST_PROJECT, PRT_PROJECT) }
  void setEstProjectDay()            { openEST (EST_PROJECT_DAY, PRT_PROJECT_DAY) }
  void setEstProjectUnit()           { openEST (EST_PROJECT_UNIT, PRT_PROJECT_UNIT) }
  void setEstProjectUnitTemplate()   { openEST (EST_PROJECT_UNIT_TEMPLATE, PRT_PROJECT_UNIT_TEMPLATE) }
  void setEstAppointment()           { openEST (EST_APPOINTMENT, PRT_APPOINTMENT) }

  void setEtUser()                  { openET (ET_USER, estUser) }
  void setEtEducator()              { openET (ET_EDUCATOR, estEducator) }
  void setEtClient()                { openET (ET_CLIENT, estClient) }
  void setEtChild()                 { openET (ET_CHILD, estChild) }
  void setEtOperator()              { openET (ET_OPERATOR, estOperator) }
  void setEtFacility()              { openET (ET_FACILITY, estFacility) }
  void setEtTemplate()              { openET (ET_TEMPLATE, estTemplate) }
  void setEtActivity()              { openET (ET_ACTIVITY, estActivity) }
  void setEtGroupPartner()          { openET (ET_GROUP_PARTNER, estGroupPartner) }
  void setEtGroupFamily()           { openET (ET_GROUP_FAMILY, estGroupFamily) }
  void setEtGroupClient()           { openET (ET_GROUP_CLIENT, estGroupClient) }
  void setEtGroupColony()           { openET (ET_GROUP_COLONY, estGroupColony) }
  void setEtGroupActivityTemplate() { openET (ET_GROUP_ACTIVITY_TEMPLATE, estGroupActivityTemplate) }
  void setEtGroupActivity()         { openET (ET_GROUP_ACTIVITY, estGroupActivity) }
  void setEtPate()                  { openET (ET_PATE, estPate) }
  void setEtPartner()               { openET (ET_PARTNER, estPartner) }
  void setEtResource()              { openET (ET_RESOURCE, estResource) }
  void setEtParent()                { openET (ET_PARENT, estParent) }
  void setEtTheme()                 { openET (ET_THEME, estTheme) }
  void setEtProjectTemplate()       { openET (ET_PROJECT_TEMPLATE, estProjectTemplate) }
  void setEtProject()               { openET (ET_PROJECT, estProject) }
  void setEtProjectDay()            { openET (ET_PROJECT_DAY, estProjectDay) }
  void setEtProjectUnit()           { openET (ET_PROJECT_UNIT, estProjectUnit) }
  void setEtProjectUnitTemplate()   { openET (ET_PROJECT_UNIT_TEMPLATE, estProjectUnitTemplate) }
  void setEtAppointment()           { openET (ET_APPOINTMENT, estAppointment) }

  void setLstPersonal() { openLST (LST_PERSONAL, "Personal Relationship") }
  void setLstOther()    { openLST (LST_OTHER, "Other Relationship") }

  void setLtFriendship()                { openLT (LT_FRIENDSHIP, lstPersonal) }
  void setLtSponsorship()               { openLT (LT_SPONSORSHIP, lstOther) }
  void setLtOperation()                 { openLT (LT_OPERATION, lstOther) }
  void setLtClientship()                { openLT (LT_CLIENTSHIP, lstOther) }
  void setLtBookmark()                  { openLT (LT_BOOKMARK, lstOther) }
  void setLtWorking()                   { openLT (LT_WORKING, lstOther) }
  void setLtGroupMember()               { openLT (LT_GROUP_MEMBER, lstOther) }
  void setLtGroupMemberParent()         { openLT (LT_GROUP_MEMBER_PARENT, lstOther) }
  void setLtGroupMemberClient()         { openLT (LT_GROUP_MEMBER_CLIENT, lstOther) }
  void setLtGroupMemberChild()          { openLT (LT_GROUP_MEMBER_CHILD, lstOther) }
  void setLtGroupMemberEducator()       { openLT (LT_GROUP_MEMBER_EDUCATOR, lstOther) }
  void setLtGroupMemberPartner()        { openLT (LT_GROUP_MEMBER_PARTNER, lstOther) }
  void setLtGroupMemberFacility()       { openLT (LT_GROUP_MEMBER_FACILITY, lstOther) }
  void setLtGroupMemberClientGroup()    { openLT (LT_GROUP_MEMBER_CLIENT_GROUP, lstOther) }
  void setLtGroupMemberActivityGroup()  { openLT (LT_GROUP_MEMBER_ACTIVITY_GROUP, lstOther) }
  void setLtGroupMemberSubstitute()     { openLT (LT_GROUP_MEMBER_SUBSTITUTE, lstOther) }
  void setLtCreator()                   { openLT (LT_CREATOR, lstOther) }
  void setLtEditor()                    { openLT (LT_EDITOR, lstOther) }
  void setLtComment()                   { openLT (LT_COMMENT, lstOther) }
  void setLtPate()                      { openLT (LT_PATE, lstOther) }
  void setLtPartner()                   { openLT (LT_PARTNER, lstOther) }
  void setLtResource()                  { openLT (LT_RESOURCE, lstOther) }
  void setLtResourcePlanned()           { openLT (LT_RESOURCE_PLANNED, lstOther) }
  void setLtEnlisted()                  { openLT (LT_ENLISTED, lstOther) }
  void setLtSubTheme()                  { openLT (LT_SUBTHEME, lstOther) }
  void setLtProjectMember()             { openLT (LT_PROJECT_MEMBER, lstOther) }
  void setLtProjectUnit()               { openLT (LT_PROJECT_UNIT, lstOther) }
  void setLtProjectUnitMember()         { openLT (LT_PROJECT_UNIT_MEMBER, lstOther) }
  void setLtProjectUnitParent()         { openLT (LT_PROJECT_UNIT_PARENT, lstOther) }
  void setLtProjectUnitPartner()        { openLT (LT_PROJECT_UNIT_PARTNER, lstOther) }
  void setLtProjectDayUnit()            { openLT (LT_PROJECT_DAY_UNIT, lstOther) }
  void setLtProjectDayEducator()        { openLT (LT_PROJECT_DAY_EDUCATOR, lstOther) }
  void setLtProjectDaySubstitute()      { openLT (LT_PROJECT_DAY_SUBSTITUTE, lstOther) }
  void setLtProjectDayResource()        { openLT (LT_PROJECT_DAY_RESOURCE, lstOther) }
  void setLtProjectTemplate()           { openLT (LT_PROJECT_TEMPLATE, lstOther) }
  void setLtColonia()                   { openLT (LT_COLONIA, lstOther) }
  void setLtFacility()                  { openLT (LT_FACILITY, lstOther) }
  void setLtGroupFamily()               { openLT (LT_GROUP_FAMILY, lstOther) }
  void setLtLeadEducator()              { openLT (LT_LEAD_EDUCATOR, lstOther) }
  void setLtThemeOfFacility()           { openLT (LT_THEME_OF_FACILITY, lstOther) }
  void setLtTemplate()                  { openLT (LT_TEMPLATE, lstOther) }
  void setLtProjectUnitTemplate()       { openLT (LT_PROJECT_UNIT_TEMPLATE, lstOther) }
  void setLtAppointment()               { openLT (LT_APPOINTMENT, lstOther) }
  void setLtOwner()                     { openLT (LT_OWNER, lstOther) }
  void setLtResponsible()               { openLT (LT_RESPONSIBLE, lstOther) }

  // activity links
  void setLtActEducator() { openLT (LT_ACT_EDUCATOR, lstOther) }
  void setLtActClient()   { openLT (LT_ACT_CLIENT, lstOther) }
  void setLtActFacility() { openLT (LT_ACT_FACILITY, lstOther) }
  void setLtActTemplate() { openLT (LT_ACT_TEMPLATE, lstOther) }
  void setLtActProject()  { openLT (LT_ACT_PROJECT, lstOther) }
  void setLtActPartner()  { openLT (LT_ACT_PARTNER, lstOther) }
  void setLtActParent()   { openLT (LT_ACT_PARENT, lstOther) }

  void setLtAbsent() { openLT (LT_ABSENT, lstOther) }
  void setLtIll()    { openLT (LT_ILL, lstOther) }

  void setPtDoc1 () { openPT (PT_DOC1, "Typ 1")}
  void setPtDoc2 () { openPT (PT_DOC2, "Typ 2")}
  void setPtDoc3 () { openPT (PT_DOC3, "Typ 3")}

  void setUserRole()         { openRole (ROLE_USER, "regular user") }
  void setModRole()          { openRole (ROLE_MOD, "moderator") }
  void setAdminRole()        { openRole (ROLE_ADMIN, "administrator") }
  void setSystemAdminRole()  { openRole (ROLE_SYSTEMADMIN, "system administrator") }
  void setLeadEducatorRole() { openRole (ROLE_LEAD_EDUCATOR, "leading educator") }

  /**
   * Creates a new EntitySuperType
   *
   * @author Alexander Zeillinger
   * @param name the name of the entity super type
   * @param profileType the profile type of the entity super type
   */
  def openEST (String name, String profileType) {
    EntitySuperType est = new EntitySuperType(name: name, profileType: profileType)
    if (!est.save()) {
      est.errors.each {log.error ("bootstrap validation error: $it")}
      throw new IllegalArgumentException("failed to bootstrap '$name' EntitySuperType")
    }
  }
  
  /**
   * Creates a new EntityType
   *
   * @author Alexander Zeillinger
   * @param name the name of the entity type
   * @param est the entity super type it belongs to
   */
  def openET (String name, EntitySuperType est) {
    EntityType et = new EntityType(name: name)
    est?.addToEntityTypes (et)
    // need to save the owning side of the cascade
    if (!est?.save()) {
      est.errors.each {log.error ("bootstrap validation error: $it")}
      throw new IllegalArgumentException("failed to bootstrap '$name' EntityType")
    }
  }
  
  /**
   * Creates a new LinkSuperType
   *
   * @author Alexander Zeillinger
   * @param name the name of the link super type
   * @param description the description of the link super type
   */
  def openLST (String name, String description) {
    LinkSuperType lst = new LinkSuperType(name: name, description: description)
    if (!lst.save()) {
      lst.errors.each {log.error ("bootstrap validation error: $it")}
      throw new IllegalArgumentException("failed to bootstrap '$name' LinkSuperType")
    }
  }
  
  /**
   * Creates a new LinkType
   *
   * @author Alexander Zeillinger
   * @param name the name of the link type
   * @param lst the link super type it belongs to
   */
  def openLT (String name, LinkSuperType lst) {
    LinkType lt = new LinkType(name: name)
    lst?.addToTypes (lt)
    // need to save the owning side of the cascade
    if (!lst.save()) {
      lst.errors.each {log.error ("bootstrap validation error: $it")}
      throw new IllegalArgumentException("failed to bootstrap '$name' LinkType")
    }
  }
  
  /**
   * Creates a new PublicationType
   *
   * @author Alexander Zeillinger
   * @param name the name of the publication type
   * @param description the description of the publication type
   */
  def openPT (String name, String description) {
    PublicationType pt = new PublicationType(name: name, description:description)
    if (!pt.save()) {
      pt.errors.each {log.error ("bootstrap validation error: $it")}
      throw new IllegalArgumentException("failed to bootstrap '$name' PublicationType")
    }
  }

  /**
   * Creates a new Role
   *
   * @author Alexander Zeillinger
   * @param auth the name of the role
   * @param description the description of the role
   */
  def openRole (String auth, String description) {
    Role role = new Role(authority: auth, description: description)
    if (!role.save()) {
      role.errors.each {log.error ("bootstrap validation error: $it")}
      throw new IllegalArgumentException("failed to bootstrap '$name' Security Role")
    }
  }
  
  // getter

  EntitySuperType getEstUser()                  { EntitySuperType.findByName (EST_USER) }
  EntitySuperType getEstEducator()              { EntitySuperType.findByName (EST_EDUCATOR) }
  EntitySuperType getEstClient()                { EntitySuperType.findByName (EST_CLIENT) }
  EntitySuperType getEstChild()                 { EntitySuperType.findByName (EST_CHILD) }
  EntitySuperType getEstOperator()              { EntitySuperType.findByName (EST_OPERATOR) }
  EntitySuperType getEstFacility()              { EntitySuperType.findByName (EST_FACILITY) }
  EntitySuperType getEstTemplate()              { EntitySuperType.findByName (EST_TEMPLATE) }
  EntitySuperType getEstActivity()              { EntitySuperType.findByName (EST_ACTIVITY) }
  EntitySuperType getEstGroupPartner()          { EntitySuperType.findByName (EST_GROUP_PARTNER) }
  EntitySuperType getEstGroupFamily()           { EntitySuperType.findByName (EST_GROUP_FAMILY) }
  EntitySuperType getEstGroupClient()           { EntitySuperType.findByName (EST_GROUP_CLIENT) }
  EntitySuperType getEstGroupColony()           { EntitySuperType.findByName (EST_GROUP_COLONY) }
  EntitySuperType getEstGroupActivityTemplate() { EntitySuperType.findByName (EST_GROUP_ACTIVITY_TEMPLATE) }
  EntitySuperType getEstGroupActivity  ()       { EntitySuperType.findByName (EST_GROUP_ACTIVITY) }
  EntitySuperType getEstPate()                  { EntitySuperType.findByName (EST_PATE) }
  EntitySuperType getEstPartner()               { EntitySuperType.findByName (EST_PARTNER) }
  EntitySuperType getEstResource()              { EntitySuperType.findByName (EST_RESOURCE) }
  EntitySuperType getEstParent()                { EntitySuperType.findByName (EST_PARENT) }
  EntitySuperType getEstTheme()                 { EntitySuperType.findByName (EST_THEME) }
  EntitySuperType getEstProjectTemplate()       { EntitySuperType.findByName (EST_PROJECT_TEMPLATE) }
  EntitySuperType getEstProject()               { EntitySuperType.findByName (EST_PROJECT) }
  EntitySuperType getEstProjectDay()            { EntitySuperType.findByName (EST_PROJECT_DAY) }
  EntitySuperType getEstProjectUnit()           { EntitySuperType.findByName (EST_PROJECT_UNIT) }
  EntitySuperType getEstProjectUnitTemplate()   { EntitySuperType.findByName (EST_PROJECT_UNIT_TEMPLATE) }
  EntitySuperType getEstAppointment()           { EntitySuperType.findByName (EST_APPOINTMENT) }
  
  EntityType getEtUser()                  { EntityType.findByName (ET_USER) }
  EntityType getEtEducator()              { EntityType.findByName (ET_EDUCATOR) }
  EntityType getEtClient()                { EntityType.findByName (ET_CLIENT) }
  EntityType getEtChild()                 { EntityType.findByName (ET_CHILD) }
  EntityType getEtOperator()              { EntityType.findByName (ET_OPERATOR) }
  EntityType getEtFacility()              { EntityType.findByName (ET_FACILITY) }
  EntityType getEtTemplate()              { EntityType.findByName (ET_TEMPLATE) }
  EntityType getEtActivity()              { EntityType.findByName (ET_ACTIVITY) }
  EntityType getEtGroupPartner()          { EntityType.findByName (ET_GROUP_PARTNER) }
  EntityType getEtGroupFamily()           { EntityType.findByName (ET_GROUP_FAMILY) }
  EntityType getEtGroupClient()           { EntityType.findByName (ET_GROUP_CLIENT) }
  EntityType getEtGroupColony()           { EntityType.findByName (ET_GROUP_COLONY) }
  EntityType getEtGroupActivityTemplate() { EntityType.findByName (ET_GROUP_ACTIVITY_TEMPLATE) }
  EntityType getEtGroupActivity()         { EntityType.findByName (ET_GROUP_ACTIVITY) }
  EntityType getEtPate()                  { EntityType.findByName (ET_PATE) }
  EntityType getEtPartner()               { EntityType.findByName (ET_PARTNER) }
  EntityType getEtResource()              { EntityType.findByName (ET_RESOURCE) }
  EntityType getEtParent()                { EntityType.findByName (ET_PARENT) }
  EntityType getEtTheme()                 { EntityType.findByName (ET_THEME) }
  EntityType getEtProjectTemplate()       { EntityType.findByName (ET_PROJECT_TEMPLATE) }
  EntityType getEtProject()               { EntityType.findByName (ET_PROJECT) }
  EntityType getEtProjectDay()            { EntityType.findByName (ET_PROJECT_DAY) }
  EntityType getEtProjectUnit()           { EntityType.findByName (ET_PROJECT_UNIT) }
  EntityType getEtProjectUnitTemplate()   { EntityType.findByName (ET_PROJECT_UNIT_TEMPLATE) }
  EntityType getEtAppointment()           { EntityType.findByName (ET_APPOINTMENT) }

  LinkSuperType getLstPersonal() { LinkSuperType.findByName (LST_PERSONAL) }
  LinkSuperType getLstOther()    { LinkSuperType.findByName (LST_OTHER) }
  
  LinkType getLtFriendship()                { LinkType.findByName (LT_FRIENDSHIP) }
  LinkType getLtSponsorship()               { LinkType.findByName (LT_SPONSORSHIP) }
  LinkType getLtOperation()                 { LinkType.findByName (LT_OPERATION) }
  LinkType getLtClientship()                { LinkType.findByName (LT_CLIENTSHIP) }
  LinkType getLtBookmark()                  { LinkType.findByName (LT_BOOKMARK) }
  LinkType getLtWorking()                   { LinkType.findByName (LT_WORKING) }
  LinkType getLtGroupMember()               { LinkType.findByName (LT_GROUP_MEMBER) }
  LinkType getLtGroupMemberParent()         { LinkType.findByName (LT_GROUP_MEMBER_PARENT) }
  LinkType getLtGroupMemberClient()         { LinkType.findByName (LT_GROUP_MEMBER_CLIENT) }
  LinkType getLtGroupMemberChild()          { LinkType.findByName (LT_GROUP_MEMBER_CHILD) }
  LinkType getLtGroupMemberEducator()       { LinkType.findByName (LT_GROUP_MEMBER_EDUCATOR) }
  LinkType getLtGroupMemberPartner()        { LinkType.findByName (LT_GROUP_MEMBER_PARTNER) }
  LinkType getLtGroupMemberFacility()       { LinkType.findByName (LT_GROUP_MEMBER_FACILITY) }
  LinkType getLtGroupMemberClientGroup()    { LinkType.findByName (LT_GROUP_MEMBER_CLIENT_GROUP) }
  LinkType getLtGroupMemberActivityGroup()  { LinkType.findByName (LT_GROUP_MEMBER_ACTIVITY_GROUP) }
  LinkType getLtGroupMemberSubstitute()     { LinkType.findByName (LT_GROUP_MEMBER_SUBSTITUTE) }
  LinkType getLtCreator()                   { LinkType.findByName (LT_CREATOR) }
  LinkType getLtEditor()                    { LinkType.findByName (LT_EDITOR) }
  LinkType getLtComment()                   { LinkType.findByName (LT_COMMENT) }
  LinkType getLtPate()                      { LinkType.findByName (LT_PATE) }
  LinkType getLtPartner()                   { LinkType.findByName (LT_PARTNER) }
  LinkType getLtResource()                  { LinkType.findByName (LT_RESOURCE) }
  LinkType getLtResourcePlanned()           { LinkType.findByName (LT_RESOURCE_PLANNED) }
  LinkType getLtEnlisted()                  { LinkType.findByName (LT_ENLISTED) }
  LinkType getLtSubTheme()                  { LinkType.findByName (LT_SUBTHEME) }
  LinkType getLtProjectMember()             { LinkType.findByName (LT_PROJECT_MEMBER) }
  LinkType getLtProjectUnit()               { LinkType.findByName (LT_PROJECT_UNIT) }
  LinkType getLtProjectUnitMember()         { LinkType.findByName (LT_PROJECT_UNIT_MEMBER) }
  LinkType getLtProjectUnitParent()         { LinkType.findByName (LT_PROJECT_UNIT_PARENT) }
  LinkType getLtProjectUnitPartner()        { LinkType.findByName (LT_PROJECT_UNIT_PARTNER) }
  LinkType getLtProjectDayUnit()            { LinkType.findByName (LT_PROJECT_DAY_UNIT) }
  LinkType getLtProjectDayEducator()        { LinkType.findByName (LT_PROJECT_DAY_EDUCATOR) }
  LinkType getLtProjectDaySubstitute()      { LinkType.findByName (LT_PROJECT_DAY_SUBSTITUTE) }
  LinkType getLtProjectDayResource()        { LinkType.findByName (LT_PROJECT_DAY_RESOURCE) }
  LinkType getLtProjectTemplate()           { LinkType.findByName (LT_PROJECT_TEMPLATE) }
  LinkType getLtColonia()                   { LinkType.findByName (LT_COLONIA) }
  LinkType getLtFacility()                  { LinkType.findByName (LT_FACILITY) }
  LinkType getLtGroupFamily()               { LinkType.findByName (LT_GROUP_FAMILY) }
  LinkType getLtLeadEducator()              { LinkType.findByName (LT_LEAD_EDUCATOR) }
  LinkType getLtThemeOfFacility()           { LinkType.findByName (LT_THEME_OF_FACILITY) }
  LinkType getLtTemplate()                  { LinkType.findByName (LT_TEMPLATE) }
  LinkType getLtProjectUnitTemplate()       { LinkType.findByName (LT_PROJECT_UNIT_TEMPLATE) }
  LinkType getLtAppointment()               { LinkType.findByName (LT_APPOINTMENT) }
  LinkType getLtOwner()                     { LinkType.findByName (LT_OWNER) }
  LinkType getLtResponsible()               { LinkType.findByName (LT_RESPONSIBLE) }
  
  LinkType getLtActEducator() { LinkType.findByName (LT_ACT_EDUCATOR) }
  LinkType getLtActClient()   { LinkType.findByName (LT_ACT_CLIENT) }
  LinkType getLtActFacility() { LinkType.findByName (LT_ACT_FACILITY) }
  LinkType getLtActTemplate() { LinkType.findByName (LT_ACT_TEMPLATE) }
  LinkType getLtActProject()  { LinkType.findByName (LT_ACT_PROJECT) }
  LinkType getLtActPartner()  { LinkType.findByName (LT_ACT_PARTNER) }
  LinkType getLtActParent()   { LinkType.findByName (LT_ACT_PARENT) }
  
  LinkType getLtAbsent() { LinkType.findByName (LT_ABSENT) }
  LinkType getLtIll()    { LinkType.findByName (LT_ILL) }

  PublicationType getPtDoc1 () { PublicationType.findByName (PT_DOC1)}
  PublicationType getPtDoc2 () { PublicationType.findByName (PT_DOC2)}
  PublicationType getPtDoc3 () { PublicationType.findByName (PT_DOC3)}

  Role getUserRole()         { Role.findByAuthority (ROLE_USER) }
  Role getModRole()          { Role.findByAuthority (ROLE_MOD) }
  Role getAdminRole()        { Role.findByAuthority (ROLE_ADMIN) }
  Role getSystemAdminRole()  { Role.findByAuthority (ROLE_SYSTEMADMIN) }
  Role getLeadEducatorRole() { Role.findByAuthority (ROLE_LEAD_EDUCATOR) }
  
}
