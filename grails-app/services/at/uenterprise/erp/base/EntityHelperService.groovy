package at.uenterprise.erp.base

/**
 * User: mkuhl
 * Date: 25.05.2009
 * Time: 22:18:53
 * Description: entity related business rules and helpers
 */

public class EntityHelperService {
  def securityManager 
  def profileHelperService

  static transactional = true



/**
* creates an entity optionally calls an closure to modify the entity and save it

*/
Entity createEntity (String name, EntityType type, Closure c=null) {
  def ent = new Entity(name:name, type:type)
  if (c)
    c.call (ent)

  if (ent.save())
    return ent

  ent.errors.allErrors.each {
    log.error ("create entity $name: field: '$it.field' code: $it.code, rejectedValue: $it.rejectedValue")
  }
  throw new EntityException(entity:ent, message:"failed to create entity '$name'")
}


/**
* creates an entity with an account
*/
  Entity createEntityWithUser (String name, EntityType type, String emailAddr, Closure c=null) {
    createEntity(name, type) {Entity ent->
      def role = Role.findByAuthority("ROLE_USER")
      if (!role)
        throw new EntityException(message:"cannot create user account. ROLE_USER not found", entity:ent)

      ent.user = new Account (email:emailAddr, password:securityManager.encodePassword("pass"), enabled:true)
      ent.user.addToAuthorities (role)
      if (c) c.call (ent)
    }
  }

  /**
   * creates an entity with account and matching profile according to supertype
   */
  Entity createEntityWithUserAndProfile (String name, EntityType type, String emailAddr, String fullName, Closure c=null) {
    createEntityWithUser (name, type, emailAddr) {Entity ent->
      ent.profile = profileHelperService.createProfileFor(ent)
      ent.profile.fullName = fullName
      ent.profile.tagline  = "describe yourself in 25 words or less!"
      if (c) c.call (ent)
    }
  }

  EntitySuperType getPersonSuperType () {
    return EntitySuperType.findByName ("Person")
  }

  /**
   * get Entity for currently logged in user account (if any)
   */
  Entity getLoggedIn (boolean authZByRoleUser = true) {
    def Entity e = securityManager.getCurrentEntity()
    if (e)
      e = Entity.get(e.id)

    if(authZByRoleUser) {
      if (e?.user) {
          for(Role role:e.user.authorities) {
            if(role.authority == "ROLE_USER")
              return (e)
        }
      }
      return null
    }

    return (e)
  }
}

class EntityException extends RuntimeException {
  String message
  Entity entity
}