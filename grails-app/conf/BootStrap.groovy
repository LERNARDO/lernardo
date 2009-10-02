import de.uenterprise.ep.EntitySuperType
import de.uenterprise.ep.EntityType
import de.uenterprise.ep.Entity
import de.uenterprise.ep.Role

class BootStrap {
    def profileDataService
    def templateDataService
    def activityDataService
    def articleDataService
    def defaultObjectService ;
    def entityHelperService ;
    def sessionFactory


    def init = {servletContext->
        profileDataService.init()
        templateDataService.init()
        activityDataService.init()
        articleDataService.init()

        initUeDomains()
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

            def mk = entityHelperService.createEntityWithUserAndProfile("mike", etLma, "mk@lkult.at", "Mike Kuhl") {Entity ent->
                def admin = Role.findByAuthority("ROLE_ADMIN")
                assert admin
                ent.user.addToAuthorities (admin)
                ent.profile.tagline = "Wozu brauch ma des?"
                ent.profile.gender = 1
            }
            def jlz = entityHelperService.createEntityWithUserAndProfile("johannes", etLma, "jlz@lkult.at", "Johannes L. Zeitelberger") {Entity ent->
                def admin = Role.findByAuthority("ROLE_ADMIN")
                assert admin
                ent.user.addToAuthorities (admin)
                ent.profile.tagline = "Ich will die Welt im ERP abbilden!"
                ent.profile.gender = 1
            }
            def aaz = entityHelperService.createEntityWithUserAndProfile("alexander", etLma, "aaz@lkult.at", "Alexander Zeillinger") {Entity ent->
                def admin = Role.findByAuthority("ROLE_ADMIN")
                assert admin
                ent.user.addToAuthorities (admin)
                ent.profile.tagline = "Simplicity is the ultimate sophistication"
                ent.profile.gender = 1
            }
            def pcr = entityHelperService.createEntityWithUserAndProfile("patrizia", etLma, "pcr@lkult.at", "Patrizia Rosenkranz") {Entity ent->
                def admin = Role.findByAuthority("ROLE_ADMIN")
                assert admin
                ent.user.addToAuthorities (admin)
                ent.profile.tagline = "Auch Gott hat kein ERP"
                ent.profile.gender = 2
            }
            def martin = entityHelperService.createEntityWithUserAndProfile("martin", etLma, "mg@lernardo.at", "Martin Golja") {Entity ent->
                def admin = Role.findByAuthority("ROLE_ADMIN")
                assert admin
                ent.user.addToAuthorities (admin)
                ent.profile.tagline = "..."
                ent.profile.gender = 1
            }

        }


    }
} 