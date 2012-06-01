package at.uenterprise.erp.base


/**
 * Helpers to bootstrap the parametrisation and to populate the database with some default data.
 */
class DefaultObjectService {
  // names for default object
  String EST_PERSON = "Person"
  String ET_USER = "User"

  def   sessionFactory
  def   entityHelperService
  def   defaultObjectService

  boolean transactional = false


  /**
  * bootstraps a complete initial database scenario including users, profiles, etc
  */
  def bootstrapData() {
    onEmptyDatabase {
      makeMetaData()
      makeUserEntities()
    }
  }


  def onEmptyDatabase (Closure c) {
    if (!EpSystem.count()) {
      log.warn ("empty database. will install demo data set")
      new EpSystem(sysKey:"SCHEMA_VERSION", sysVal:"0").save()
      if (c) c.call()
      sessionFactory.currentSession.flush()
    }
  }

  def openEST (String name, String profileType) {
    EntitySuperType est = EntitySuperType.findByName (name)
    if (!est) {
      est = new EntitySuperType(name:name, profileType:profileType)
      if (!est.save()) {
        est.errors.each {log.error ("bootstrap validation error: $it")}
        throw new IllegalArgumentException("failed to bootstrap '$name' EntitySuperType")
      }
    }

    return (est)
  }

  def openET (String name, EntitySuperType est) {
    EntityType et = EntityType.findByName (name)
    if (!et) {
      et = new EntityType(name:name)
      est?.addToEntityTypes (et)
      // need to save the owning side of the cascade
      if (!est?.save()) {
        est.errors.each {log.error ("bootstrap validation error: $it")}
        throw new IllegalArgumentException("failed to bootstrap '$name' EntityType")
      }
    }

    return (et)
  }

  def openLST (String name, String desc) {
    LinkSuperType lst = LinkSuperType.findByName (name)
    if (!lst) {
      lst = new LinkSuperType(name:name, description:desc)
      if (!lst.save()) {
        lst.errors.each {log.error ("bootstrap validation error: $it")}
        throw new IllegalArgumentException("failed to bootstrap '$name' ($desc) EntityType")
      }
    }

    return (lst)
  }

  def openLT (String name, LinkSuperType lst) {
    LinkType lt = LinkType.findByName (name)
    if (!lt) {
      lt = new LinkType(name:name)
      lst.addToTypes (lt)
      // need to save the owning side of the cascade
      if (!lst.save()) {
        lst.errors.each {log.error ("bootstrap validation error: $it")}
        throw new IllegalArgumentException("failed to bootstrap 'User' EntityType")
      }
    }

    return (lt)
  }

  def openRole (String auth, String desc) {
    Role role = Role.findByAuthority(auth)
    if (!role) {
      role = new Role(authority:auth, description:desc)
      if (!role.save()) {
        role.errors.each {log.error ("bootstrap validation error: $it")}
        throw new IllegalArgumentException("failed to bootstrap '$name' Security Role")
      }
    }

    return role
  }


  def makeMetaData() {
    // create security roles (needed for user creation)
    new Role(authority:"ROLE_USER", description:"regular user").save()
    new Role(authority:"ROLE_VIP", description:"user with some extra privileges").save()
    new Role(authority:"ROLE_ADMIN", description:"system administrator").save()
    sessionFactory.currentSession.flush()

    log.debug ("start creating '$EST_PERSON' entity supertype")
    EntitySuperType estPerson = new EntitySuperType(name:"$EST_PERSON", profileType:'Person')

    log.debug ("start creating '$ET_USER' entity type")
    estPerson.addToEntityTypes (new EntityType (name:"User"))

    estPerson.save()

    sessionFactory.currentSession.flush()
  }

  def makeUserEntities() {
    // create some entities, types and supertypes
    EntitySuperType estPerson = EntitySuperType.findByName (EST_PERSON)

    log.debug ("start creating entity types")
    EntityType etKrocher = new EntityType (name:"Krocher")
    estPerson.addToEntityTypes (etKrocher)
    EntityType etRocker = new EntityType (name:"Rocker")
    estPerson.addToEntityTypes (etRocker)
    EntityType etEmo = new EntityType (name:"Emo")
    estPerson.addToEntityTypes (etEmo)

    if (!estPerson.save()) {
      estPerson.errors.each {
        log.error ("Bootstrap Error: $it")
      }
      throw new IllegalArgumentException("failed to bootstrap entity structure metadata")
    }
    sessionFactory.currentSession.flush()
    log.debug ("entity structure created successfully")



    // create some actual entities
    entityHelperService.createEntityWithUserAndProfile ("franz", etKrocher, "franz@bbb.com", "Franz Franz and the Melody Boys") {Entity it->
      it.profile.tagline = "to be on top is our job"
      it.profile.gender = 1
    }

    entityHelperService.createEntityWithUserAndProfile("detlef", etEmo, "detleft@aon.at", "Captain Sensible") {Entity ent->
      def admin = Role.findByAuthority("ROLE_ADMIN")
      assert admin
      ent.user.addToAuthorities (admin)
    }


    entityHelperService.createEntityWithUserAndProfile("hugo", etRocker, "karwall@bxlxax.fr", "Hugo Tester")
    entityHelperService.createEntityWithUserAndProfile("otto", etRocker, "ottor@bulag.net", "Otto R. Kaputnik")

  }

}
