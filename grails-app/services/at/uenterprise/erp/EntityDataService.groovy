package at.uenterprise.erp

import at.uenterprise.erp.base.Entity

class EntityDataService {
    MetaDataService metaDataService

    /**
     * Returns all colonies
     *
     * @author Alexander Zeillinger
     * @return A list of entities of type colony
     */
    def getAllColonies() {
        def allColonies = Entity.createCriteria().list {
            eq("type", metaDataService.etGroupColony)
            profile {
                order("fullName", "asc")
            }
        }
        return allColonies
    }

    /**
     * Returns all facilities
     *
     * @author Alexander Zeillinger
     * @return A list of entities of type facility
     */
    def getAllFacilities() {
        def allFacilities = Entity.createCriteria().list {
            eq("type", metaDataService.etFacility)
            profile {
                order("fullName", "asc")
            }
        }
        return allFacilities
    }

    /**
     * Returns all educators
     *
     * @author Alexander Zeillinger
     * @return A list of entities of type educator
     */
    def getAllEducators() {
        def allEducators = Entity.createCriteria().listDistinct {
            eq("type", metaDataService.etEducator)
            profile {
                order("fullName", "asc")
            }
            user {
                eq("enabled", true)
            }
        }
        return allEducators
    }
}
