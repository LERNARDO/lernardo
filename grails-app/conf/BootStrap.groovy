import de.uenterprise.ep.EntitySuperType
import de.uenterprise.ep.EntityType
import de.uenterprise.ep.Entity
import de.uenterprise.ep.Role
import org.grails.plugins.jquery.calendar.domain.CalendarEventType
import org.grails.plugins.jquery.calendar.domain.CalendarEvent

class BootStrap {
    def profileDataService
    def templateDataService
    def activityDataService
    def articleDataService
    def defaultObjectService
    def entityHelperService
    def sessionFactory
    def calendarService

    def init = {servletContext->
        profileDataService.init()
        templateDataService.init()
        activityDataService.init()
        articleDataService.init()

        println "### Starting UeDomains ###"
        initUeDomains()
        println "### Finished UeDomains ###"
        
        def eventTypes = ['conference', 'contest', 'exam', 'meeting']
        addEventTypes(eventTypes)
        addEvents(eventTypes)

        calendarService.securityDelegate = [
           getCurrentUser: {-> [id: 1]},
           isUserAllowedToCreateEvents: {-> true},
           isUserAllowedToEditEvent: {e -> true},
           isUserAllowedToCreateReminder: {e -> true}
       ]

        calendarService.mailDelegate = [
            sendReminder: {reminder ->  println 'reminder sent' },
        ]
    }

    def destroy = {
    }

    def addEventTypes(eventTypes) {
        if (!CalendarEventType.count()) {
            eventTypes.each {
                new CalendarEventType(name: it).save(failOnError: true)
            }
        }
    }

    def addEvents(eventTypes) {
        def DAYS = 20
        Calendar day = GregorianCalendar.instance
        day.set Calendar.MILLISECOND, 0
        day.set Calendar.SECOND, 0
        day.set Calendar.MINUTE, 0
        day.roll Calendar.DAY_OF_YEAR, -DAYS/2 as int

        // Events get added here
        DAYS.times {
            day.set Calendar.HOUR_OF_DAY, 14
            def startDate = day.time
            day.set Calendar.HOUR_OF_DAY, 16
            def endDate = day.time
            new CalendarEvent(
                    userID: 1,
                    name: "name #$it",
                    description: "description #$it",
                    location: "location #$it",
                    eventType: CalendarEventType.findByName(eventTypes[it % 4]),
                    startDate: startDate,
                    endDate: endDate
            ).save(failOnError: true)

            day.roll Calendar.DAY_OF_YEAR, 1
        }
    }

    void initUeDomains () {
        // init metadata if DB is empty
        defaultObjectService.onEmptyDatabase {
            log.info "initializing empty database"
            defaultObjectService.makeMetaData()

            //create lernardo specific parametrisation
            EntitySuperType estPerson = EntitySuperType.findByName (defaultObjectService.EST_PERSON)
            EntityType etLma = new EntityType (name:"mitarbeiter")
            estPerson.addToEntityTypes (etLma)
            if (!estPerson.save()) {
                estPerson.errors.each { log.error ("Person supertype: Bootstrap Error: $it") }
                throw new IllegalArgumentException("failed to bootstrap entity structure metadata")
            }

            def mpk = entityHelperService.createEntityWithUserAndProfile("mike", etLma, "mpk@lernardo.at", "Mike P. Kuhl") {Entity ent->
                def admin = Role.findByAuthority("ROLE_ADMIN")
                assert admin
                ent.user.addToAuthorities (admin)
                ent.profile.tagline = "Wozu brauch ma des?"
                ent.profile.gender = 1
            }
            def jlz = entityHelperService.createEntityWithUserAndProfile("johannes", etLma, "jlz@lernardo.at", "Johannes L. Zeitelberger") {Entity ent->
                def admin = Role.findByAuthority("ROLE_ADMIN")
                assert admin
                ent.user.addToAuthorities (admin)
                ent.profile.tagline = "Ich will die Welt im ERP abbilden!"
                ent.profile.gender = 1
            }
            def aaz = entityHelperService.createEntityWithUserAndProfile("alexander", etLma, "aaz@lernardo.at", "Alexander Zeillinger") {Entity ent->
                def admin = Role.findByAuthority("ROLE_ADMIN")
                assert admin
                ent.user.addToAuthorities (admin)
                ent.profile.tagline = "Simplicity is the ultimate sophistication"
                ent.profile.gender = 1
            }
            def pcr = entityHelperService.createEntityWithUserAndProfile("patrizia", etLma, "pcr@lernardo.at", "Patrizia Rosenkranz") {Entity ent->
                def admin = Role.findByAuthority("ROLE_ADMIN")
                assert admin
                ent.user.addToAuthorities (admin)
                ent.profile.tagline = "Auch Gott hat kein ERP"
                ent.profile.gender = 2
            }
            def sst = entityHelperService.createEntityWithUserAndProfile("susanne", etLma, "sst@lernardo.at", "Susanne Stiedl") {Entity ent->
                def admin = Role.findByAuthority("ROLE_ADMIN")
                assert admin
                ent.user.addToAuthorities (admin)
                ent.profile.tagline = "..."
                ent.profile.gender = 2
            }
            def bib = entityHelperService.createEntityWithUserAndProfile("birgit", etLma, "bib@lernardo.at", "Birgit Blaesen") {Entity ent->
                def admin = Role.findByAuthority("ROLE_ADMIN")
                assert admin
                ent.user.addToAuthorities (admin)
                ent.profile.tagline = "..."
                ent.profile.gender = 2
            }
            def hmb = entityHelperService.createEntityWithUserAndProfile("hannah", etLma, "hmb@lernardo.at", "Hannah Mutzbauer") {Entity ent->
                def admin = Role.findByAuthority("ROLE_ADMIN")
                assert admin
                ent.user.addToAuthorities (admin)
                ent.profile.tagline = "..."
                ent.profile.gender = 2
            }
            def rgt = entityHelperService.createEntityWithUserAndProfile("regina", etLma, "rgt@lernardo.at", "Regina Toncourt") {Entity ent->
                def admin = Role.findByAuthority("ROLE_ADMIN")
                assert admin
                ent.user.addToAuthorities (admin)
                ent.profile.tagline = "..."
                ent.profile.gender = 2
            }
        }
    } // initUeDomains
} 