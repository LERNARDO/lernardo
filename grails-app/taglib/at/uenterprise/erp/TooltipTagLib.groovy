package at.uenterprise.erp

import at.uenterprise.erp.base.Entity
import at.uenterprise.erp.base.Link

class TooltipTagLib {
    FunctionService functionService
    MetaDataService metaDataService
    static namespace = "erp"

    def getColonyOfEntity = {attrs, body ->
        Entity colony = functionService.findByLink(null, attrs.entity, metaDataService.ltColonia)
        if (colony)
            out << body(colony: colony)
        else
            out << '<span class="italic">' + message(code: 'non') + '</span>'
    }

    def getClientsCountOfEntity = {attrs ->
        def count = Link.countByTargetAndType(attrs.entity, metaDataService.ltGroupMemberClient)
        out << count
    }

    def getFamilyOfEntity = {attrs, body ->
        Entity family = functionService.findByLink(attrs.entity, null, metaDataService.ltGroupMemberChild) // child
        if (!family)
            family = functionService.findByLink(attrs.entity, null, metaDataService.ltGroupFamily) // client
        if (!family)
            family = functionService.findByLink(attrs.entity, null, metaDataService.ltGroupMemberParent) // parent
        if (family)
            out << body(family: family)
        else
            out << '<span class="italic">' + message(code: 'non') + '</span>'
    }

    def getFacilitiesOfClient = {attrs, body ->
        List facilities = functionService.findAllByLink(attrs.entity, null, metaDataService.ltGroupMemberClient).findAll {it.type == metaDataService.etFacility}
        if (facilities)
            out << body(facilities: facilities)
        else
            out << '<span class="italic">' + message(code: 'non') + '</span>'
    }

    def getFacilitiesOfColony = {attrs, body ->
        List facilities = functionService.findAllByLink(null, attrs.entity, metaDataService.ltGroupMemberFacility)
        if (facilities)
            out << body(facilities: facilities)
        else
            out << '<span class="italic">' + message(code: 'non') + '</span>'
    }

    def getResourcesOfColony = {attrs, body ->
        List resources = []
        attrs.entity.profile.resources.each {
            resources.add(Entity.get(it.toInteger()))
        }
        if (resources)
            out << body(resources: resources)
        else
            out << '<span class="italic">' + message(code: 'non') + '</span>'
    }

    def getGodchildrenOfPate = {attrs, body ->
        List godchildren = functionService.findAllByLink(null, attrs.entity, metaDataService.ltPate)
        if (godchildren)
            out << body(godchildren: godchildren)
        else
            out << '<span class="italic">' + message(code: 'non') + '</span>'
    }

    def getPartnersOfPartnerGroup = {attrs, body ->
        List partners = functionService.findAllByLink(null, attrs.entity, metaDataService.ltGroupMember)
        if (partners)
            out << body(partners: partners)
        else
            out << '<span class="italic">' + message(code: 'non') + '</span>'
    }

    def getLeadEducatorsOfFacility = {attrs, body ->
        List leadEducators = functionService.findAllByLink(null, attrs.entity, metaDataService.ltLeadEducator)
        if (leadEducators)
            out << body(leadEducators: leadEducators)
        else
            out << '<span class="italic">' + message(code: 'non') + '</span>'
    }

    def getEducatorsOfFacility = {attrs, body ->
        List educators = functionService.findAllByLink(null, attrs.entity, metaDataService.ltWorking)
        if (educators)
            out << body(educators: educators)
        else
            out << '<span class="italic">' + message(code: 'non') + '</span>'
    }

    def getTemplateOfGroupActivity = {attrs, body ->
        Entity template = functionService.findByLink(null, attrs.entity, metaDataService.ltTemplate)
        if (template)
            out << body(template: template)
        else
            out << '<span class="italic">' + message(code: 'non') + '</span>'
    }

    def getFacilityOfGroupActivity = {attrs, body ->
        Entity facility = functionService.findByLink(attrs.entity, null, metaDataService.ltGroupMemberFacility)
        if (facility)
            out << body(facility: facility)
        else
            out << '<span class="italic">' + message(code: 'non') + '</span>'
    }

    def getEducatorsOfGroupActivity = {attrs, body ->
        List educators = functionService.findAllByLink(null, attrs.entity, metaDataService.ltGroupMemberEducator)
        if (educators)
            out << body(educators: educators)
        else
            out << '<span class="italic">' + message(code: 'non') + '</span>'
    }

    def getProjectsOfTheme = {attrs, body ->
        List projects = functionService.findAllByLink(null, attrs.entity, metaDataService.ltGroupMember)
        if (projects)
            out << body(projects: projects)
        else
            out << '<span class="italic">' + message(code: 'non') + '</span>'
    }

    def getActivityGroupsOfTheme = {attrs, body ->
        List activitygroups = functionService.findAllByLink(null, attrs.entity, metaDataService.ltGroupMemberActivityGroup)
        if (activitygroups)
            out << body(activitygroups: activitygroups)
        else
            out << '<span class="italic">' + message(code: 'non') + '</span>'
    }

    def getFacilitiesOfProject = {attrs, body ->
        List facilities = functionService.findAllByLink(attrs.entity, null, metaDataService.ltGroupMemberFacility)
        if (facilities)
            out << body(facilities: facilities)
        else
            out << '<span class="italic">' + message(code: 'non') + '</span>'
    }

    def getProjectDayCountOfProject = {attrs ->
        def count = Link.countByTargetAndType(attrs.entity, metaDataService.ltProjectMember)
        out << count
    }

}