import at.uenterprise.erp.base.EntityType
import at.uenterprise.erp.base.Entity
import at.uenterprise.erp.base.Link
import at.uenterprise.erp.base.LinkHelperService
import at.uenterprise.erp.base.Tag
import at.uenterprise.erp.base.Profile
import at.uenterprise.erp.base.DefaultObjectService
import at.uenterprise.erp.base.EntityHelperService
import at.uenterprise.erp.base.ProfileHelperService
import at.uenterprise.erp.base.AssetService
import at.uenterprise.erp.lfa.Maingoal
import at.uenterprise.erp.lfa.Subgoal
import at.uenterprise.erp.profiles.ClientProfile
import at.uenterprise.erp.profiles.FacilityProfile
import at.uenterprise.erp.profiles.OperatorProfile
import at.uenterprise.erp.profiles.ChildProfile

import grails.util.GrailsUtil

import at.uenterprise.erp.Method
import at.uenterprise.erp.MetaDataService
import at.uenterprise.erp.WorkdayCategory
import at.uenterprise.erp.News
import at.uenterprise.erp.Comment
import at.uenterprise.erp.Element
import at.uenterprise.erp.Helper
import at.uenterprise.erp.Evaluation
import at.uenterprise.erp.profiles.EducatorProfile
import at.uenterprise.erp.profiles.ParentProfile
import at.uenterprise.erp.profiles.PartnerProfile
import at.uenterprise.erp.profiles.PateProfile
import at.uenterprise.erp.profiles.UserProfile
import at.uenterprise.erp.FunctionService
import at.uenterprise.erp.InterfaceMaintenanceService
import at.uenterprise.erp.Setup
import at.uenterprise.erp.WorkdayUnit

//import org.springframework.core.io.Resource
import org.codehaus.groovy.grails.commons.ApplicationHolder
import at.uenterprise.erp.logbook.Attendance
import at.uenterprise.erp.logbook.Process
import at.uenterprise.erp.EVENT_TYPE
import at.uenterprise.erp.Label
import at.uenterprise.erp.FolderType
import at.uenterprise.erp.Folder
import at.uenterprise.erp.Favorite
import at.uenterprise.erp.base.Asset
import java.text.SimpleDateFormat
import at.uenterprise.erp.Live

class BootStrap {
    DefaultObjectService defaultObjectService
    EntityHelperService entityHelperService
    MetaDataService metaDataService
    FunctionService functionService
    ProfileHelperService profileHelperService
    InterfaceMaintenanceService interfaceMaintenanceService
    LinkHelperService linkHelperService
    AssetService assetService
    def GrailsApplication

    final int dummies = 2 // amount of bootstrapped dummy entities

    def init = {servletContext ->
        defaultObjectService.onEmptyDatabase {
            metaDataService.initialize()

            log.info "====="
            Date begin = new Date()

            createDefaultFolderTypes()
            createDefaultUsers()

            if (GrailsUtil.environment == "development") {
                //importChildren()
                createSetup()
                createLogframes()
                createDefaultOperator()
                createDefaultFacilities()
                createDefaultEducators()
                //createDefaultLinks()
                createDefaultTags()
                createDefaultActivityTemplates()
                createDefaultPartner()
                createDefaultColonies()
                createDefaultParents()
                createDefaultClients()
                createDefaultAttendances()
                createDefaultProcesses()
                createDefaultChildren()
                createDefaultPosts()
                createDefaultPates()
                createDefaultFamilies()
                //createDefaultResources()
                createDefaultMethods()
                createDefaultClientGroups()
                createDefaultActivityTemplateGroups()
                createDefaultThemes()
                createDefaultComments()
                createDefaultProjectTemplates()
                createDefaultProjects()
                //createDefaultHelpers()
                createDefaultWorkdayCategories()
                createDefaultWorkdayUnits()

                createDefaultAppointments()
                //createDefaultGroupActivities()
                createDefaultMessages()
                createDefaultLabels()
                createDefaultFolders()
            }

            //createDefaultEvaluations()
            log.info "====="
            log.info "created bootstrap data in ${(new Date().getTime() - begin.getTime()) / 1000} seconds"
        }

        /*servletContext.etUser                   = metaDataService.etUser
   servletContext.etEducator               = metaDataService.etEducator
   servletContext.etClient                 = metaDataService.etClient
   servletContext.etChild                  = metaDataService.etChild
   servletContext.etOperator               = metaDataService.etOperator
   servletContext.etFacility               = metaDataService.etFacility
   servletContext.etTemplate               = metaDataService.etTemplate
   servletContext.etActivity               = metaDataService.etActivity
   servletContext.etGroupPartner           = metaDataService.etGroupPartner
   servletContext.etGroupFamily            = metaDataService.etGroupFamily
   servletContext.etGroupClient            = metaDataService.etGroupClient
   servletContext.etGroupColony            = metaDataService.etGroupColony
   servletContext.etPate                   = metaDataService.etPate
   servletContext.etPartner                = metaDataService.etPartner
   servletContext.etResource               = metaDataService.etResource
   servletContext.etParent                 = metaDataService.etParent
   servletContext.etTheme                  = metaDataService.etTheme
   servletContext.etProjectTemplate        = metaDataService.etProjectTemplate
   servletContext.etProject                = metaDataService.etProject
   servletContext.etProjectDay             = metaDataService.etProjectDay
   servletContext.etProjectUnit            = metaDataService.etProjectUnit
   servletContext.etProjectUnitTemplate    = metaDataService.etProjectUnitTemplate
   servletContext.etAppointment            = metaDataService.etAppointment

   servletContext.ltFriendship               = metaDataService.ltFriendship
   servletContext.ltSponsorship              = metaDataService.ltSponsorship
   servletContext.ltOperation                = metaDataService.ltOperation
   servletContext.ltClientship               = metaDataService.ltClientship
   servletContext.ltBookmark                 = metaDataService.ltBookmark
   servletContext.ltWorking                  = metaDataService.ltWorking
   servletContext.ltGroupMember              = metaDataService.ltGroupMember
   servletContext.ltGroupMemberParent        = metaDataService.ltGroupMemberParent
   servletContext.ltGroupMemberClient        = metaDataService.ltGroupMemberClient
   servletContext.ltGroupMemberChild         = metaDataService.ltGroupMemberChild
   servletContext.ltGroupMemberEducator      = metaDataService.ltGroupMemberEducator
   servletContext.ltGroupMemberPartner       = metaDataService.ltGroupMemberPartner
   servletContext.ltGroupMemberFacility      = metaDataService.ltGroupMemberFacility
   servletContext.ltGroupMemberClientGroup   = metaDataService.ltGroupMemberClientGroup
   servletContext.ltGroupMemberActivityGroup = metaDataService.ltGroupMemberActivityGroup
   servletContext.ltGroupMemberSubstitute    = metaDataService.ltGroupMemberSubstitute
   servletContext.ltCreator                  = metaDataService.ltCreator
   servletContext.ltEditor                   = metaDataService.ltEditor
   servletContext.ltComment                  = metaDataService.ltComment
   servletContext.ltPate                     = metaDataService.ltPate
   servletContext.ltPartner                  = metaDataService.ltPartner
   servletContext.ltResource                 = metaDataService.ltResource
   servletContext.ltResourcePlanned          = metaDataService.ltResourcePlanned
   servletContext.ltEnlisted                 = metaDataService.ltEnlisted
   servletContext.ltSubTheme                 = metaDataService.ltSubTheme
   servletContext.ltProjectMember            = metaDataService.ltProjectMember
   servletContext.ltProjectUnit              = metaDataService.ltProjectUnit
   servletContext.ltProjectUnitMember        = metaDataService.ltProjectUnitMember
   servletContext.ltProjectUnitParent        = metaDataService.ltProjectUnitParent
   servletContext.ltProjectUnitPartner       = metaDataService.ltProjectUnitPartner
   servletContext.ltProjectDayUnit           = metaDataService.ltProjectDayUnit
   servletContext.ltProjectDayEducator       = metaDataService.ltProjectDayEducator
   servletContext.ltProjectDaySubstitute     = metaDataService.ltProjectDaySubstitute
   servletContext.ltProjectDayResource       = metaDataService.ltProjectDayResource
   servletContext.ltProjectTemplate          = metaDataService.ltProjectTemplate
   servletContext.ltColonia                  = metaDataService.ltColonia
   servletContext.ltFacility                 = metaDataService.ltFacility
   servletContext.ltGroupFamily              = metaDataService.ltGroupFamily
   servletContext.ltLeadEducator             = metaDataService.ltLeadEducator
   servletContext.ltThemeOfFacility          = metaDataService.ltThemeOfFacility
   servletContext.ltTemplate                 = metaDataService.ltTemplate
   servletContext.ltProjectUnitTemplate      = metaDataService.ltProjectUnitTemplate
   servletContext.ltAppointment              = metaDataService.ltAppointment
   servletContext.ltOwner                    = metaDataService.ltOwner
   servletContext.ltResponsible              = metaDataService.ltResponsible

   servletContext.ltActEducator = metaDataService.ltActEducator
   servletContext.ltActClient   = metaDataService.ltActClient
   servletContext.ltActFacility = metaDataService.ltActFacility
   servletContext.ltActTemplate = metaDataService.ltActTemplate
   servletContext.ltActProject  = metaDataService.ltActProject
   servletContext.ltActPartner  = metaDataService.ltActPartner
   servletContext.ltActParent   = metaDataService.ltActParent

   servletContext.ltAbsent = metaDataService.ltAbsent
   servletContext.ltIll    = metaDataService.ltIll*/
    }

    def destroy = {
    }

    /*
    * loads children into the database by importing an XML file - NOT USED ATM
    */
    /*void importChildren() {
      Resource children_xml = ApplicationHolder.application.parentContext.getResource("assets/import/children.xml")
      if (children_xml.exists()) {
        log.info "$children_xml.description found. bootstrapping children"
        interfaceMaintenanceService.importChildren(children_xml.inputStream)
      }
      else {
        log.warn("children input xml at $children_xml.description not found. no children are bootstrapped")
      }
    }*/

    void createSetup() {
        // get or create the setup instance and populate it with dummy data
        def setup = Setup.list()[0]
        if (!setup) {
            setup = new Setup().save(failOnError: true)
            setup.addToBloodTypes("dummyBloodType")
            setup.addToEducations("dummyEducation")
            setup.addToEmploymentStatus("dummyEmploymentStatus")
            setup.addToFamilyProblems("dummyFamilyProblem")
            setup.addToFamilyStatus("dummyFamilyStatus")
            setup.addToLanguages("dummyLanguage")
            setup.addToMaritalStatus("dummyMaritalStatus")
            setup.addToNationalities("dummyNationality")
            setup.addToPartnerServices("dummyPartnerService")
            setup.addToResponsibilities("dummyResponsibility")
            setup.addToSchoolLevels("dummySchoolLevel")
            setup.addToWorkDescriptions("dummyWorkDescription")
        }
    }

    void createDefaultFolderTypes() {
        if (!FolderType.findByName("favorite"))
            new FolderType(name: "favorite").save()
        if (!FolderType.findByName("publication"))
            new FolderType(name: "publication").save()
    }

    void createLogframes() {
        log.info("creating logframes")

        def mainGoal = new Maingoal(name: "Weltfrieden", description: "Beendigung sämtlicher Konflikte und Kriege").save()

        mainGoal.addToSubGoals(name: "Religionen abschaffen", description: "Ursache vieler Konflikte")
        mainGoal.addToSubGoals(name: "Armut beseitigen")
        mainGoal.addToSubGoals(name: "Bedingungsloses Grundeinkommen")

    }

    void createDefaultUsers() {
        log.info("creating users")
        EntityType etUser = metaDataService.etUser

        // system admin users
        if (!Entity.findByName('admin')) {
            entityHelperService.createEntityWithUserAndProfile("admin", etUser, "admin@lernardo.net", "Admin") {Entity ent ->
                ent.user.addToAuthorities(metaDataService.systemAdminRole)
                ent.user.addToAuthorities(metaDataService.adminRole)
                ent.user.locale = new Locale("de", "DE")
                UserProfile prf = (UserProfile) ent.profile
                prf.firstName = "System"
                prf.lastName = "Admin"
                prf.favoritesFolder = new Folder(name: "root", type: FolderType.findByName("favorite")).save(failOnError: true)
            }
        }

        // admin users
        if (!Entity.findByName('admin2')) {
            entityHelperService.createEntityWithUserAndProfile("admin2", etUser, "admin2@lernardo.net", "Admin2") {Entity ent ->
                ent.user.addToAuthorities(metaDataService.adminRole)
                ent.user.locale = new Locale("de", "DE")
                UserProfile prf = (UserProfile) ent.profile
                prf.firstName = "Admin"
                prf.lastName = "Admin"
                prf.favoritesFolder = new Folder(name: "root", type: FolderType.findByName("favorite")).save(failOnError: true)
            }
        }

    }

    void createDefaultEducators() {
        log.info("creating " + dummies + " educators")
        EntityType etEducator = metaDataService.etEducator

        Random generator = new Random()

        for (i in 1..dummies) {
            if (!Entity.findByName("educator" + i)) {
                Entity entity = entityHelperService.createEntityWithUserAndProfile("educator" + i, etEducator, "educator" + i + "@domain.org", "educatorFirstName educatorLastName " + i) {Entity ent ->
                    ent.user.locale = new Locale("de", "DE")
                    EducatorProfile prf = (EducatorProfile) ent.profile
                    prf.gender = generator.nextInt(2) + 1
                    prf.title = "dummyTitle"
                    prf.firstName = "educatorFirstName" + i
                    prf.lastName = "educatorLastName" + i
                    prf.birthDate = new Date(generator.nextInt(20) + 60, generator.nextInt(12) + 1, generator.nextInt(28) + 1)
                    prf.currentStreet = "dummyStreet"
                    prf.originCountry = "dummyCountry"
                    prf.originZip = "1234"
                    prf.originCity = "dummyCity"
                    prf.originStreet = "dummyStreet"
                    prf.contactPhone = "1234"
                    prf.contactCountry = "dummyCountry"
                    prf.contactCity = "dummyCity"
                    prf.contactStreet = "dummyStreet"
                    prf.contactZip = "1345"
                    prf.contactMail = "dummy@dummy.com"
                    prf.education = "dummyEducation"
                    prf.interests = "dummyInterests"
                    prf.employment = "dummyEmployment"
                    prf.workHoursMonday = 8
                    prf.workHoursTuesday = 8
                    prf.workHoursWednesday = 8
                    prf.workHoursThursday = 8
                    prf.workHoursFriday = 6.5
                    prf.hourlyWage = 10
                    prf.overtimePay = 15
                    prf.favoritesFolder = new Folder(name: "root", type: FolderType.findByName("favorite")).save(failOnError: true)
                }
                new Link(source: entity, target: Entity.findByName("facility" + i), type: metaDataService.ltWorking).save(failOnError: true)
                entity.profile.addToDates(date: new Date(), type: "entry")
            }
        }

    }

    void createDefaultParents() {
        log.info("creating " + dummies + " parents")
        EntityType etParent = metaDataService.etParent

        Random generator = new Random()

        for (i in 1..dummies) {
            if (!Entity.findByName("parent" + i)) {
                Entity entity = entityHelperService.createEntityWithUserAndProfile("parent" + i, etParent, "parent" + i + "@domain.org", "parentFirstName parentLastName " + i) {Entity ent ->
                    ent.user.locale = new Locale("de", "DE")
                    ParentProfile prf = (ParentProfile) ent.profile
                    prf.firstName = "parentFirstName" + i
                    prf.lastName = "parentLastName" + i
                    prf.gender = generator.nextInt(2) + 1
                    prf.currentStreet = "dummyStreet"
                    prf.birthDate = new Date(generator.nextInt(20) + 60, generator.nextInt(12) + 1, generator.nextInt(28) + 1)
                    prf.maritalStatus = "dummyStatus"
                    prf.education = "dummyEducation"
                    prf.comment = "dummyComment"
                    prf.job = generator.nextBoolean()
                    if (prf.job) {
                        prf.addToJobtypes("dummyJob")
                        prf.jobIncome = generator.nextInt(150) + 50
                        prf.jobFrequency = "dummyFrequency"
                    }
                    prf.favoritesFolder = new Folder(name: "root", type: FolderType.findByName("favorite")).save(failOnError: true)
                }
                entity.profile.addToDates(date: new Date(), type: "entry")
            }
        }

    }

    void createDefaultClients() {
        log.info("creating " + dummies + " clients")
        EntityType etClient = metaDataService.etClient

        Random generator = new Random()

        for (i in 1..dummies) {
            if (!Entity.findByName("client" + i)) {
                Entity entity = entityHelperService.createEntityWithUserAndProfile("client" + i, etClient, "client" + i + "@domain.org", "clientFirstName clientLastName " + i) {Entity ent ->
                    ent.user.locale = new Locale("de", "DE")
                    ClientProfile prf = (ClientProfile) ent.profile
                    prf.firstName = "clientFirstName" + i
                    prf.lastName = "clientLastName" + i
                    prf.gender = generator.nextInt(2) + 1
                    prf.interests = "dummyInterests"
                    prf.currentStreet = "dummyStreet"
                    prf.originCountry = "dummyCountry"
                    prf.originZip = "1234"
                    prf.originCity = "dummyCity"
                    prf.birthDate = new Date(generator.nextInt(20) + 90, generator.nextInt(12) + 1, generator.nextInt(28) + 1)
                    prf.schoolLevel = "dummySchoolLevel"
                    prf.familyStatus = "dummyStatus"
                    prf.job = generator.nextBoolean()
                    if (prf.job) {
                        prf.addToJobtypes("dummyJob")
                        prf.jobIncome = generator.nextInt(150) + 50
                        prf.jobFrequency = "dummyFrequency"
                    }
                    prf.support = generator.nextBoolean()
                    if (prf.support)
                        prf.supportDescription = "dummyDescription"
                    prf.favoritesFolder = new Folder(name: "root", type: FolderType.findByName("favorite")).save(failOnError: true)
                }
                new Link(source: entity, target: Entity.findByName("facility1"), type: metaDataService.ltGroupMemberClient).save(failOnError: true)
                entity.profile.addToDates(date: new Date(), type: "entry")
            }
        }

    }

    void createDefaultChildren() {
        log.info("creating " + dummies + " children")
        EntityType etChild = metaDataService.etChild

        Random generator = new Random()

        for (i in 1..dummies) {
            if (!Entity.findByName("child" + i)) {
                entityHelperService.createEntityWithUserAndProfile("child" + i, etChild, "child" + i + "@domain.org", "childFirstName childLastName " + i) {Entity ent ->
                    ent.user.locale = new Locale("de", "DE")
                    ChildProfile prf = (ChildProfile) ent.profile
                    prf.firstName = "childFirstName" + i
                    prf.lastName = "childLastName" + i
                    prf.gender = generator.nextInt(2) + 1
                    prf.birthDate = new Date(generator.nextInt(20) + 90, generator.nextInt(12) + 1, generator.nextInt(28) + 1)
                    prf.job = generator.nextBoolean()
                    if (prf.job) {
                        prf.addToJobtypes("dummyJob")
                        prf.jobIncome = generator.nextInt(150) + 50
                        prf.jobFrequency = "dummyFrequency"
                    }
                    prf.favoritesFolder = new Folder(name: "root", type: FolderType.findByName("favorite")).save(failOnError: true)
                }
            }
        }

    }

    void createDefaultOperator() {
        log.info("creating operator")
        EntityType etOperator = metaDataService.etOperator

        if (!Entity.findByName('operator')) {
            entityHelperService.createEntityWithUserAndProfile("operator", etOperator, "operator@domain.org", "operator") {Entity ent ->
                ent.user.locale = new Locale("de", "DE")
                OperatorProfile prf = (OperatorProfile) ent.profile
                prf.zip = "12345"
                prf.city = "dummyCity"
                prf.street = "dummyStreet"
                prf.phone = "dummyPhone"
                prf.description = "dummyDescription"
                prf.favoritesFolder = new Folder(name: "root", type: FolderType.findByName("favorite")).save(failOnError: true)
            }
        }

    }

    void createDefaultPartner() {
        log.info("creating " + dummies + " partners")
        EntityType etPartner = metaDataService.etPartner

        for (i in 1..dummies) {
            if (!Entity.findByName("partner" + i)) {
                entityHelperService.createEntityWithUserAndProfile("partner" + i, etPartner, "partner" + i + "@domain.org", "partner " + i) {Entity ent ->
                    ent.user.locale = new Locale("de", "DE")
                    PartnerProfile prf = (PartnerProfile) ent.profile
                    prf.street = "dummyStreet"
                    prf.phone = "dummyPhone"
                    prf.description = "dummyDescription"
                    prf.website = "http://www.dummySite.com"
                    prf.favoritesFolder = new Folder(name: "root", type: FolderType.findByName("favorite")).save(failOnError: true)
                }
            }
        }

    }

    void createDefaultPates() {
        log.info("creating " + dummies + " pates")
        EntityType etPate = metaDataService.etPate

        for (i in 1..dummies) {
            if (!Entity.findByName("pate" + i)) {
                Entity entity = entityHelperService.createEntityWithUserAndProfile("pate" + i, etPate, "pate" + i + "@domain.org", "pateFirstName pateLastName " + i) {Entity ent ->
                    ent.user.locale = new Locale("de", "DE")
                    PateProfile prf = (PateProfile) ent.profile
                    prf.firstName = "pateFirstName" + i
                    prf.lastName = "pateLastName" + i
                    prf.zip = "12345"
                    prf.city = "dummyCity"
                    prf.street = "dummyStreet"
                    prf.country = "dummyCountry"
                    prf.motherTongue = "dummyMotherTongue"
                    prf.favoritesFolder = new Folder(name: "root", type: FolderType.findByName("favorite")).save(failOnError: true)
                }
                entity.profile.addToDates(date: new Date(), type: "entry")
            }
        }

    }

    void createDefaultFacilities() {
        log.info("creating " + dummies + " facilities")
        EntityType etFacility = metaDataService.etFacility

        for (i in 1..dummies) {
            if (!Entity.findByName("facility" + i)) {
                entityHelperService.createEntityWithUserAndProfile("facility" + i, etFacility, "facility" + i + "@domain.org", "facility " + i) {Entity ent ->
                    ent.user.locale = new Locale("de", "DE")
                    FacilityProfile prf = (FacilityProfile) ent.profile
                    prf.zip = "12345"
                    prf.city = "dummyCity"
                    prf.street = "dummyStreet"
                    prf.country = "dummyCountry"
                    prf.description = "dummyDescription"
                }
            }
        }

    }

    void createDefaultLinks() {
        log.info("creating default links")

        def admin = Entity.findByName('admin')

        def educator1 = Entity.findByName('educator1')
        def educator2 = Entity.findByName('educator2')

        // make admin a friend of everyone
        List users = Entity.list()
        users.each {
            if (it.name != 'admin') {
                new Link(source: it, target: admin, type: metaDataService.ltFriendship).save(failOnError: true)
                new Link(source: admin, target: it, type: metaDataService.ltFriendship).save(failOnError: true)
            }
        }

        // friend links - make alex the initiator via dynamic link attribute
        Link liap = linkHelperService.createLink(educator1, educator2, metaDataService.ltFriendship) {link, dad ->
            dad.initiator = "true"
        }
        // back link does not (necessarily) has a dynattr
        new Link(source: educator2, target: educator1, type: metaDataService.ltFriendship).save(failOnError: true)

        // here's how we would ask for the a dynattr (given the link)
        if (liap.das.initiator) {
            println "$liap.source.name has initiated the relationship"
        }

    }

    void createDefaultActivityTemplates() {
        log.info("creating " + dummies + " templates")
        EntityType etTemplate = metaDataService.etTemplate

        Random generator = new Random()

        for (i in 1..dummies) {
            if (!Entity.findByName("template" + i)) {
                def entity = entityHelperService.createEntity("template" + i, etTemplate) {Entity ent ->
                    ent.profile = profileHelperService.createProfileFor(ent) as Profile
                    ent.profile.fullName = "template " + i
                    ent.profile.description = "dummyDescription"
                    ent.profile.chosenMaterials = "dummyMaterials"
                    ent.profile.socialForm = "dummySocialForm"
                    ent.profile.amountEducators = generator.nextInt(3) + 1
                    int random = generator.nextInt(3)
                    if (random == 0)
                        ent.profile.status = "done"
                    else if (random == 1)
                        ent.profile.status = "notDone"
                    else
                        ent.profile.status = "notDoneOpen"
                    ent.profile.duration = generator.nextInt(50) + 10
                    ent.profile.type = "default"
                }
                // add default profile image
                //File file = ApplicationHolder.application.parentContext.getResource("images/default_activitytemplate.png").getFile()
                //assetService.storeAsset(entity, "profile", "image/png", file.getBytes())
                // save creator
                new Link(source: Entity.findByName("educator${i}"), target: entity, type: metaDataService.ltCreator).save(failOnError: true)
                functionService.createEvent(EVENT_TYPE.ACTIVITY_TEMPLATE_CREATED, Entity.findByName('admin').id.toInteger(), entity.id.toInteger())
            }
        }

    }

    void createDefaultComments() {
        log.info("creating comments")

        Comment comment = new Comment(content: 'dummyComment', creator: Entity.findByName('admin2').id).save(failOnError: true)
        Entity entity = Entity.findByName("template1")
        entity.profile.addToComments(comment)

    }

    void createDefaultResources() {
        log.info("creating " + dummies + " resources")

        for (i in 1..dummies) {
            if (!Entity.findByName("resource" + i)) {
                def resource = entityHelperService.createEntity("resource" + i, metaDataService.etResource) {Entity ent ->
                    ent.profile = profileHelperService.createProfileFor(ent) as Profile
                    ent.profile.fullName = "resource " + i
                    ent.profile.description = "dummyDescription"
                    ent.profile.classification = "dummyClassification"
                    ent.profile.costsUnit = "perDay"
                }
                new Link(source: resource, target: Entity.findByName("template${i}"), type: metaDataService.ltResource).save(failOnError: true)
            }
        }

    }

    void createDefaultPosts() {
        log.info("creating " + dummies + " news")

        for (i in 1..dummies) {
            new News(title: 'dummyTitle ' + i,
                    teaser: 'dummyTeaser ' + i,
                    content: 'dummyContent ' + i,
                    author: Entity.findByName('educator1')).save(failOnError: true)
        }

    }

    void createDefaultHelpers() {
        log.info("creating helper")

        new Helper(title: 'Wie kann ich eine Aktivitätsvorlage erstellen?',
                content: '''Um eine Aktivitätsvorlage zu erstellen klicke zuerst auf "Aktivätsvorlagen" in der orangenen
                           Hauptnavigation. Dort findest du dann einen Button "Aktivitätsvorlage erstellen".''',
                type: metaDataService.etEducator.name).save(failOnError: true)
        new Helper(title: 'Wie kann ich eine Aktivität planen?',
                content: '''Aktivitäten beruhen immer auf einer Aktivitätsvorlage. Klicke in der orangenen Hauptnavigation
                           auf "Aktivitätsvorlagen" und wähle dort eine Vorlage aus indem du auf dessen Namen klickst.
                           Im nächsten Schritt kannst du dann über den Button "Neue Aktivität planen" eine konkrete
                           Aktivität planen. Für jede Aktivität must du eine Einrichtung, Pädagogen und Betreute auswählen.''',
                type: metaDataService.etEducator.name).save(failOnError: true)
        new Helper(title: 'Wie kann ich einen Artikel verfassen?',
                content: '''Artikel können direkt auf der Startseite verfasst werden. Klicke auf "Home" in der blauen
                           Navigationsleiste um dorthin zu gelangen und klicke auf den roten Link "Neuen Artikel verfassen".''',
                type: metaDataService.etEducator.name).save(failOnError: true)
        new Helper(title: 'Wie kann ich jemandem eine Nachricht ins Postfach schicken?',
                content: '''Um jemandem eine Nachricht zu schicken musst du zuerst sein/ihr Profil besuchen. Dort findest
                           du dann links in der Seitennavigation den Punkt "Nachricht senden".''',
                type: metaDataService.etEducator.name).save(failOnError: true)
        new Helper(title: 'Was ist das Netzwerk?',
                content: '''Im Netzwerk hast du eine Auflistung aller für dich relevanten User im ERP, wie deine Betreuten,
                           oder andere Pädagogen. Diese Liste kannst du selbst verwalten indem du andere Profile besuchst,
                           und dort Freunde oder Bookmarks hinzufügst.''',
                type: metaDataService.etEducator.name).save(failOnError: true)
        new Helper(title: 'Wie kann ich eine Beurteilung eines Betreuten anlegen?',
                content: '''Besuche zuerst das Profil des Betreuten und klicke dort in der linken Seitennavigation auf
                           "Leistungsfortschritt anlegen".''',
                type: metaDataService.etEducator.name).save(failOnError: true)

        new Helper(title: 'Wie kann ich einen Betreuten anlegen?',
                content: '''Betreute können über den Link "Betreuten anlegen" in der Seitennavigation links angelegt werden.
                           Notwendige Angaben müssen unbedingt ausgefüllt werden, zusätzliche Angaben sind optional und
                           können später noch über "Daten ändern" ergänzt oder geändert werden.''',
                type: metaDataService.etFacility.name).save(failOnError: true)

        new Helper(title: 'Wie funktioniert die Anwesenheits-/Essensliste? (AE-Liste)',
                content: '''In der AE-Liste werden alle im Hort betreuten Kinder aufgelistet. Für jedes Kind kann die Anwesenheit,
                       sowie die Teilnahme am Mittagessen eingetragen werden. Daraus lässt sich dann die Summe der Anwesenden
                       und die Gesamtsumme der Essenbeiträge ausrechnen. Es besteht außerdem die Möglichkeit diese Liste als
                       PDF anzuzeigen und bequem ausdrucken zu lassen.''',
                type: metaDataService.etFacility.name).save(failOnError: true)

        new Helper(title: 'Wo kann ich sämtliche Profile verwalten',
                content: '''Die Verwaltung für Betreiber befindet sich links in der Seitennavigation unter der Gruppe Administration.
                       Dort können folgende Profile verwaltet werden: Einrichtungen, Pädagogen, Betreute, Partner, Paten und
                       Erziehungsberechtigte.''',
                type: metaDataService.etOperator.name).save(failOnError: true)
    }

    void createDefaultEvaluations() {
        log.info("creating evaluations")

        new Evaluation(owner: Entity.findByName('client1'),
                description: 'Er zeigt eine leichte Leseschwäche, die besonders beim Lesen quantenphysikalischer Literatur zu bemerken sind.',
                method: 'Als Maßnahme habe ich ihm mehrere Kinderbücher gegeben, damit tut er sich offensichtlich leichter.',
                writer: Entity.findByName('educator1')).save(failOnError: true)
        new Evaluation(owner: Entity.findByName('client2'),
                description: 'Sie ist ein wahres Genie. Keine Aufgabe macht ihr Probleme und sie hat sehr viel Spaß. Ich glaube aber sie hat Symptome von Hyperaktivität.',
                method: 'Ich möchte mit ihr verstärkt Interventionen machen, die weniger kopflastig sind.',
                writer: Entity.findByName('educator2')).save(failOnError: true)
    }

    void createDefaultFamilies() {
        log.info("creating " + dummies + " families")
        EntityType etGroupFamily = metaDataService.etGroupFamily

        Random generator = new Random()

        for (i in 1..dummies) {
            if (!Entity.findByName("family" + i)) {
                Entity entity = entityHelperService.createEntity("family" + i, etGroupFamily) {Entity ent ->
                    ent.profile = profileHelperService.createProfileFor(ent) as Profile
                    ent.profile.fullName = "family " + i
                    ent.profile.livingConditions = "dummyLivingConditions"
                    ent.profile.socioeconomicData = "dummySocioeconomicData"
                    ent.profile.otherInfo = "dummyOtherInfo"
                    ent.profile.amountHousehold = generator.nextInt(4) + 1
                    ent.profile.familyIncome = generator.nextInt(1500) + 500
                }

                // create some links to that group
                new Link(source: Entity.findByName("parent${i}"), target: entity, type: metaDataService.ltGroupMemberParent).save(failOnError: true)
                new Link(source: Entity.findByName("client${i}"), target: entity, type: metaDataService.ltGroupFamily).save(failOnError: true)
                new Link(source: Entity.findByName("child${i}"), target: entity, type: metaDataService.ltGroupMemberChild).save(failOnError: true)
            }
        }

    }

    void createDefaultColonies() {
        log.info("creating " + dummies + " colonies")
        EntityType etGroupColony = metaDataService.etGroupColony

        for (i in 1..dummies) {
            if (!Entity.findByName("colony" + i)) {
                Entity entity = entityHelperService.createEntity("colony" + i, etGroupColony) {Entity ent ->
                    ent.profile = profileHelperService.createProfileFor(ent) as Profile
                    ent.profile.fullName = "colony " + i
                    ent.profile.description = "dummyDescription"
                }

                // create some links to that group
                new Link(source: Entity.findByName("facility${i}"), target: entity, type: metaDataService.ltGroupMemberFacility).save(failOnError: true)
                new Link(source: Entity.findByName("partner${i}"), target: entity, type: metaDataService.ltGroupMemberPartner).save(failOnError: true)
            }
        }

    }

    void createDefaultMethods() {
        log.info("creating methods")

        for (i in 1..2) {
            if (!Method.findByName("method" + i)) {
                Method method = new Method(name: "method" + i, description: "dummyDescription", type: "template").save(failOnError: true)

                method.addToElements(new Element(name: "element1"))
                method.addToElements(new Element(name: "element2"))
                method.addToElements(new Element(name: "element3"))
                method.addToElements(new Element(name: "element4"))
                method.addToElements(new Element(name: "element5"))
            }
        }

    }

    void createDefaultClientGroups() {
        log.info("creating " + dummies + " client groups")
        EntityType etGroupClient = metaDataService.etGroupClient

        for (i in 1..dummies) {
            if (!Entity.findByName("clientGroup" + i)) {
                Entity entity = entityHelperService.createEntity("clientGroup" + i, etGroupClient) {Entity ent ->
                    ent.profile = profileHelperService.createProfileFor(ent) as Profile
                    ent.profile.fullName = "clientGroup " + i
                    ent.profile.description = "dummyDescription"
                }

                // create some links to that group
                for (j in 1..2) {
                    new Link(source: Entity.findByName("client" + j), target: entity, type: metaDataService.ltGroupMemberClient).save(failOnError: true)
                }
            }
        }

    }

    void createDefaultActivityTemplateGroups() {
        log.info("creating " + dummies + " group activity templates")
        EntityType etGroupActivityTemplate = metaDataService.etGroupActivityTemplate

        Random generator = new Random()

        for (i in 1..1) {
            if (!Entity.findByName("groupActivityTemplate" + i)) {
                Entity entity = entityHelperService.createEntity("groupActivityTemplate" + i, etGroupActivityTemplate) {Entity ent ->
                    ent.profile = profileHelperService.createProfileFor(ent) as Profile
                    ent.profile.fullName = "groupActivityTemplate " + i
                    ent.profile.description = "dummyDescription"
                    ent.profile.educationalObjectiveText = "dummyEducationalObjective"
                    ent.profile.realDuration = generator.nextInt(60) + 30
                    int random = generator.nextInt(3)
                    if (random == 0)
                        ent.profile.status = "done"
                    else if (random == 1)
                        ent.profile.status = "notDone"
                    else
                        ent.profile.status = "notDoneOpen"
                }

                // create some links to that group
                for (j in 1..2) {
                    new Link(source: Entity.findByName("template" + j), target: entity, type: metaDataService.ltGroupMember).save(failOnError: true)
                    entity.profile.addToTemplates(Entity.findByName("template" + j).id.toString())
                }

                // add default profile image
                //File file = ApplicationHolder.application.parentContext.getResource("images/default_groupactivitytemplate.png").getFile()
                //assetService.storeAsset(entity, "profile", "image/png", file.getBytes())

                // save creator
                new Link(source: Entity.findByName("educator${generator.nextInt(dummies) + 1}"), target: entity, type: metaDataService.ltCreator).save(failOnError: true)

                functionService.createEvent(EVENT_TYPE.GROUP_ACTIVITY_TEMPLATE_CREATED, Entity.findByName('admin').id.toInteger(), entity.id.toInteger())
            }
        }

    }

    void createDefaultThemes() {
        log.info("creating themes")

        EntityType etTheme = metaDataService.etTheme

        Entity theme = entityHelperService.createEntity("theme", etTheme) {Entity ent ->
            ent.profile = profileHelperService.createProfileFor(ent) as Profile
            ent.profile.fullName = "Theme 1"
            ent.profile.description = "dummyDescription"
            ent.profile.startDate = new Date(2011 - 1900, 04, 01)
            ent.profile.endDate = new Date(2011 - 1900, 07, 01)
        }

        // link theme to facility
        new Link(source: theme, target: Entity.findByName('facility1'), type: metaDataService.ltThemeOfFacility).save(failOnError: true)

        Entity subtheme = entityHelperService.createEntity("theme", etTheme) {Entity ent ->
            ent.profile = profileHelperService.createProfileFor(ent) as Profile
            ent.profile.fullName = "Subtheme 1"
            ent.profile.description = "dummyDescription"
            ent.profile.startDate = new Date(2011 - 1900, 05, 01)
            ent.profile.endDate = new Date(2011 - 1900, 06, 01)
        }

        // link subtheme to theme
        new Link(source: subtheme, target: theme, type: metaDataService.ltSubTheme).save(failOnError: true)
        // link subtheme to facility
        new Link(source: subtheme, target: Entity.findByName('facility1'), type: metaDataService.ltThemeOfFacility).save(failOnError: true)
    }

    void createDefaultProjectTemplates() {
        log.info("creating " + dummies + " project templates")
        EntityType etProjectTemplate = metaDataService.etProjectTemplate

        Random generator = new Random()

        for (i in 1..1) {
            if (!Entity.findByName("projectTemplate" + i)) {
                def entity = entityHelperService.createEntity("projectTemplate" + i, etProjectTemplate) {Entity ent ->
                    ent.profile = profileHelperService.createProfileFor(ent) as Profile
                    ent.profile.fullName = "projectTemplate " + i
                    ent.profile.description = "dummyDescription"
                    if (generator.nextInt(2) == 0)
                        ent.profile.status = "done"
                    else
                        ent.profile.status = "notDone"
                }
                // add default profile image
                //File file = ApplicationHolder.application.parentContext.getResource("images/default_projecttemplate.png").getFile()
                //assetService.storeAsset(entity, "profile", "image/png", file.getBytes())
                // save creator
                new Link(source: Entity.findByName("educator${i}"), target: entity, type: metaDataService.ltCreator).save(failOnError: true)
            }
        }

    }

    void createDefaultProjects() {
        log.info("creating " + dummies + " projects")
        EntityType etProject = metaDataService.etProject

        Entity projectTemplate = Entity.findByName("projectTemplate1")

        Entity entity = entityHelperService.createEntity("project", etProject) {Entity ent ->
            ent.profile = profileHelperService.createProfileFor(ent) as Profile
            ent.profile.fullName = "project"
            ent.profile.startDate = new Date()
            ent.profile.endDate = new Date() + 10
            ent.profile.description = "dummyDescription"
        }
        // inherit profile picture: go through each asset of the template, find the asset of type "profile" and assign it to the new entity
        projectTemplate.assets.each { Asset asset ->
            if (asset.type == "profile") {
                new Asset(entity: entity, storage: asset.storage, type: "profile").save()
            }
        }

        // copy labels from template
        projectTemplate.profile.labels.each { Label templateLabel ->
            Label label = new Label()

            label.name = templateLabel.name
            label.description = templateLabel.description
            label.type = "instance"

            entity.profile.addToLabels(label)
        }

        // save creator
        new Link(source: entityHelperService.loggedIn, target: entity, type: metaDataService.ltCreator).save()

        // create link to template
        new Link(source: projectTemplate, target: entity, type: metaDataService.ltProjectTemplate).save()

        // create project days
        Date periodStart = entity.profile.startDate
        Date periodEnd = entity.profile.endDate

        periodEnd.setHours(23)
        periodEnd.setMinutes(59)

        Calendar calendarStart = new GregorianCalendar()
        calendarStart.setTime(periodStart)

        Calendar calendarEnd = new GregorianCalendar()
        calendarEnd.setTime(periodEnd)

        SimpleDateFormat df = new SimpleDateFormat("EEEE", new Locale("en"))

        // loop through the date range and compare the dates day with the params
        while (calendarStart <= calendarEnd) {
            Date currentDate = calendarStart.getTime()

            if (df.format(currentDate) == 'Monday') {
                calendarStart.set(Calendar.HOUR_OF_DAY, 10)
                calendarStart.set(Calendar.MINUTE, 0)
            }

            // create project day
            EntityType etProjectDay = metaDataService.etProjectDay
            Entity projectDay = entityHelperService.createEntity("projectDay", etProjectDay) {Entity ent ->
                ent.profile = profileHelperService.createProfileFor(ent) as Profile
                ent.profile.fullName = entity.profile.fullName
                ent.profile.date = functionService.convertToUTC(calendarStart.getTime())

                Calendar tempCal = Calendar.getInstance()
                tempCal.setTime(ent.profile.date)
                tempCal.add(Calendar.HOUR_OF_DAY, 5)

                ent.profile.endDate = tempCal.getTime()
            }

            // link project day to project
            new Link(source: projectDay, target: entity, type: metaDataService.ltProjectMember).save()

            // increment calendar
            calendarStart.add(Calendar.DATE, 1)
        }

    }

    void createDefaultTags() {
        log.info("creating tags")

        if (!Tag.findByName('abwesend'))
            new Tag(name: 'abwesend').save(failOnError: true)
        if (!Tag.findByName('krank'))
            new Tag(name: 'krank').save(failOnError: true)
    }

    void createDefaultWorkdayCategories() {
        log.info("creating workday categories")

        for (i in 1..3) {
            if (!WorkdayCategory.findByName('workdayCategory' + i)) {
                new WorkdayCategory(name: 'workdayCategory' + i, beginDate: new Date(112, 0, 1, 0, 0), endDate: new Date(113, 0, 1, 0, 0)).save(failOnError: true, flush: true)
            }
        }

    }

    void createDefaultWorkdayUnits() {
        log.info("creating workday units")

        WorkdayUnit wdu1 = new WorkdayUnit(category: WorkdayCategory.findByName('workdayCategory1').name, description: "bla", date1: new Date(110, 11, 1, 10, 0), date2: new Date(110, 11, 1, 11, 0)).save(failOnError: true)
        WorkdayUnit wdu2 = new WorkdayUnit(category: WorkdayCategory.findByName('workdayCategory2').name, description: "bla", date1: new Date(110, 11, 1, 12, 0), date2: new Date(110, 11, 1, 14, 0)).save(failOnError: true)
        WorkdayUnit wdu3 = new WorkdayUnit(category: WorkdayCategory.findByName('workdayCategory3').name, description: "bla", date1: new Date(110, 11, 1, 15, 0), date2: new Date(110, 11, 1, 18, 0)).save(failOnError: true)

        Entity educator = Entity.findByName("educator1")

        educator.profile.addToWorkdayunits(wdu1)
        educator.profile.addToWorkdayunits(wdu2)
        educator.profile.addToWorkdayunits(wdu3)
    }

    void createDefaultAppointments() {
        log.info("creating " + dummies + " appointments")
        EntityType etAppointment = metaDataService.etAppointment

        Random generator = new Random()

        for (i in 1..dummies) {
            Entity entity = entityHelperService.createEntity("appointment" + i, etAppointment) {Entity ent ->
                ent.profile = profileHelperService.createProfileFor(ent) as Profile
                ent.profile.fullName = "appointment " + i
                use([groovy.time.TimeCategory]) {
                    ent.profile.beginDate = new Date(new Date().getYear(), new Date().getMonth(), generator.nextInt(28) + 1, generator.nextInt(15) + 5, generator.nextInt(59))
                    ent.profile.endDate = ent.profile.beginDate.plus((generator.nextInt(5) + 1).hours).plus(generator.nextInt(59).minutes)
                }
                ent.profile.beginDate = functionService.convertToUTC(ent.profile.beginDate)
                ent.profile.endDate = functionService.convertToUTC(ent.profile.endDate)
                ent.profile.description = "dummyDescription"
                ent.profile.allDay = false
                ent.profile.isPrivate = false
            }

            // create link to owner
            new Link(source: entity, target: Entity.findByName("educator${generator.nextInt(dummies) + 1}"), type: metaDataService.ltAppointment).save(failOnError: true)
        }

    }

    void createDefaultGroupActivities() {
        log.info("creating " + dummies + " group activities")
        EntityType etGroupActivity = metaDataService.etGroupActivity

        Random generator = new Random()

        for (i in 1..dummies) {
            Entity groupActivityTemplate = Entity.findByName("groupActivityTemplate${generator.nextInt(dummies) + 1}")
            Entity entity = entityHelperService.createEntity("groupActivity", etGroupActivity) {Entity ent ->
                ent.profile = profileHelperService.createProfileFor(ent) as Profile
                ent.profile.fullName = "groupActivity " + i
                ent.profile.realDuration = 60
                ent.profile.date = new Date(new Date().getYear(), new Date().getMonth(), generator.nextInt(28) + 1, generator.nextInt(15) + 5, generator.nextInt(59))
                ent.profile.educationalObjective = ""
                ent.profile.educationalObjectiveText = "dummyObjectiveText"
                ent.profile.date = functionService.convertToUTC(ent.profile.date)
                ent.profile.description = "dummyDescription"
            }

            // save creator
            new Link(source: Entity.findByName("educator${generator.nextInt(dummies) + 1}"), target: entity, type: metaDataService.ltCreator).save(failOnError: true)

            // find all templates linked to the groupActivityTemplate
            List templates = functionService.findAllByLink(null, groupActivityTemplate, metaDataService.ltGroupMember)

            // and link them to the new groupActivity
            templates.each { Entity template ->
                new Link(source: template, target: entity, type: metaDataService.ltGroupMember).save(failOnError: true)
            }

            // link template to instance
            new Link(source: groupActivityTemplate, target: entity, type: metaDataService.ltTemplate).save(failOnError: true)

            // link to facility
            new Link(source: entity, target: Entity.findByName("facility${generator.nextInt(dummies) + 1}"), type: metaDataService.ltGroupMemberFacility).save(failOnError: true)

            // link to educator
            new Link(source: Entity.findByName("educator${generator.nextInt(dummies) + 1}"), target: entity, type: metaDataService.ltGroupMemberEducator).save(failOnError: true)
        }

    }

    void createDefaultMessages() {
        log.info("creating " + dummies + " messages")

        Entity first = Entity.findByName("admin")
        Entity second = Entity.findByName("educator1")

        for (i in 1..dummies) {
            functionService.createMessage(first, [second.id.toString()], first, "subject${i}", "content", true).save()
            functionService.createMessage(first, [second.id.toString()], second, "subject${i}", "content").save()
        }
    }

    void createDefaultAttendances() {
        log.info("creating " + dummies + " attendances")

        for (i in 1..dummies) {
            Entity client = Entity.findByName("client" + i)
            Entity facility = Entity.findByName("facility" + i)

            new Attendance(client: client, facility: facility).save(failOnError: true)
        }
    }

    void createDefaultProcesses() {
        log.info("creating " + dummies + " processes")

        Random generator = new Random()

        for (i in 1..dummies) {
            int random = generator.nextInt(2)

            String unit = "perDay"
            if (random == 0)
                unit = "perMonth"

            new Process(name: "process" + i, costs: 0, unit: unit).save(failOnError: true)
        }
    }

    void createDefaultLabels() {
        log.info("creating " + dummies + " labels")

        for (i in 1..dummies) {
            Label label = new Label(name: "label" + i, description: "description" + i, type: "template").save(failOnError: true)
            Setup.list()[0].addToLabels(label.id.toString())
        }
    }

    void createDefaultFolders() {
        log.info("creating folders")

        Entity admin = Entity.findByName('admin')
        FolderType favFolderType = new FolderType(name: "favorite").save(failOnError: true)
        admin.profile.favoritesFolder = new Folder(name: "root", description: "root of all favorites", type: favFolderType).save(failOnError: true)
        admin.profile.save()

        Folder someFolder = new Folder(name: "some", description: "some folder", type: favFolderType, folder: admin.profile.favoritesFolder).save(failOnError: true)
        admin.profile.favoritesFolder.addToFolders(someFolder)

        Favorite admin2 = new Favorite(entity: Entity.findByName('admin2'), description: "Another admin", folder: admin.profile.favoritesFolder).save(failOnError: true)
        admin.profile.favoritesFolder.addToFavorites(admin2)

    }

}