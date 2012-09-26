package at.uenterprise.erp

import spock.lang.*
import grails.plugin.spock.*

class BuildingSpec extends IntegrationSpec {

    def "Saving a building to the database"() {

        given: "A new building"
        def building = new Building(name: 'Stephansdom')

        when: "the building is saved"
        building.save()

        then: "it saved successfully and can be found in the database"
        building.errors.errorCount == 0
        building.id != null
        Building.get(building.id).name == building.name

    }

}
