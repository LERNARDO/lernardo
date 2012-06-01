package at.uenterprise.erp.base

class SecHelperService {
    def entityHelperService

    boolean transactional = false

    boolean isMeOrAdmin(String entityName) {
      Entity e = Entity.findByName(entityName)
      if (!e)
        return false

      return (isMeOrAdmin (e))
    }

    boolean isMeOrAdmin(Entity e) {
      if (!e)
        return false

      Entity el = entityHelperService.loggedIn
      if (!el)
        return false

      if (el.name == e.name)
        return true

      return   isAdmin()
    }

    boolean hasAllRoles (Entity e = null, List roles) {
      e = e ?: entityHelperService.loggedIn
      if (!e)
        return false

//      if (e.user?.authorities?.find { roles.contains(it.authority) })
//        return true

      def matching = roles.findAll { e.user?.authorities*.authority.contains(it) }
      return matching.size() == roles.size()
    }

    boolean hasRole (Entity e = null, String name) {
      e = e ?: entityHelperService.loggedIn

      e?.user?.authorities.each {
        if (it.authority == name)
          return true
      }

      return false
    }


    boolean hasNoRoles (Entity e = null, List roles) {
      e = e ?: entityHelperService.loggedIn
      if (!e)
        return true

      def res = !roles.find { e.user?.authorities*.authority.contains (it) }
      return res
    }


    boolean isNotMe (Entity e) {
      if (!e)
        return true

      return entityHelperService.loggedIn.name != e.name
    }

    boolean isAdmin (Entity e = null) {
      e = e ?: entityHelperService.loggedIn
      if (!e)
        return false

      e = Entity.get(e.id)
      Role adminRole = e.user?.authorities.find {it.authority == 'ROLE_ADMIN'} 
      return (adminRole ? true : false)
    }

}
