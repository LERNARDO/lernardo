import de.uenterprise.ep.EntitySuperType
import de.uenterprise.ep.EntityType
import de.uenterprise.ep.Entity
import de.uenterprise.ep.Role

class BootStrap {
    def profileDataService
    def templateDataService
    def activityDataService
    def articleDataService
    def defaultObjectService
    def entityHelperService
    def sessionFactory


    def init = {servletContext->
        profileDataService.init()
        templateDataService.init()
        activityDataService.init()
        articleDataService.init()

        println "### Starting UeDomains ###"
        initUeDomains()
        println "### Finished UeDomains ###"
    }

    def destroy = {
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