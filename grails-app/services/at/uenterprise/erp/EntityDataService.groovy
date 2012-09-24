package at.uenterprise.erp

import at.uenterprise.erp.base.Entity

class EntityDataService {
    MetaDataService metaDataService

    def getAllColonies() {
        def allColonies = Entity.createCriteria().list {
            eq("type", metaDataService.etGroupColony)
            profile {
                order("fullName", "asc")
            }
        }
        return allColonies
    }

    def getAllFacilities() {
        def allFacilities = Entity.createCriteria().list {
            eq("type", metaDataService.etFacility)
            profile {
                order("fullName", "asc")
            }
        }
    }
}
