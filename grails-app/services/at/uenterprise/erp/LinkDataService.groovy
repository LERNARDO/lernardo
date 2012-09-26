package at.uenterprise.erp

import at.uenterprise.erp.base.Entity

class LinkDataService {
    FunctionService functionService
    MetaDataService metaDataService

    /**
     * Returns the family a given entity is linked to
     *
     * Depending on the type of the entity the correct link type will be chosen and the family returned
     *
     * @author Alexander Zeillinger
     * @param entity REQUIRED The entity
     * @return An entity of type family
     */
    def getFamily(Entity entity) {
        def type = null

        if (entity.type.supertype.name == "child")
            type = metaDataService.ltGroupMemberChild
        else if (entity.type.supertype.name == "client")
            type = metaDataService.ltGroupFamily
        else if (entity.type.supertype.name == "parent")
            type = metaDataService.ltGroupMemberParent

        Entity family = functionService.findByLink(entity, null, type)

        return family
    }

    /**
     * Returns the colony a given entity is linked to
     *
     * Depending on the type of the entity the correct function parameters will be chosen and the colony returned
     *
     * @author Alexander Zeillinger
     * @param entity REQUIRED The entity
     * @return An entity of type colony
     */
    def getColony(Entity entity) {
        Entity colony = null

        if (entity.type.supertype.name == "client" ||
                entity.type.supertype.name == "educator" ||
                entity.type.supertype.name == "parent" ||
                entity.type.supertype.name == "partner")
            colony = functionService.findByLink(null, entity, metaDataService.ltColonia)
        else if (entity.type.supertype.name == "facility")
            colony = functionService.findByLink(entity, null, metaDataService.ltGroupMemberFacility)

        return colony
    }
}
