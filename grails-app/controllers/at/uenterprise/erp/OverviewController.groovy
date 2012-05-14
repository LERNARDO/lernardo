package at.uenterprise.erp

import at.openfactory.ep.Entity
import at.openfactory.ep.EntityHelperService

class OverviewController {
  EntityHelperService entityHelperService
  MetaDataService metaDataService
  FunctionService functionService

  def index = {}

  def planning = {
    def count = Entity.createCriteria().list {
      eq("type", metaDataService.etActivity)
      profile {
        eq("type", "Themenraum")
      }
    }
    def activities = count.size()

    render template: 'planning', model: [allActivityTemplates: Entity.countByType(metaDataService.etTemplate),
                                        allActivities: activities,
                                        allActivityTemplateGroups: Entity.countByType(metaDataService.etGroupActivityTemplate),
                                        allActivityGroups: Entity.countByType(metaDataService.etGroupActivity),
                                        allProjectTemplates: Entity.countByType(metaDataService.etProjectTemplate),
                                        allProjects: Entity.countByType(metaDataService.etProject),
                                        allThemes: Entity.countByType(metaDataService.etTheme)]
  }

  def groups = {
    render template: 'groups', model: [allColonies: Entity.countByType(metaDataService.etGroupColony),
                                       allFamilies: Entity.countByType(metaDataService.etGroupFamily),
                                       allPartnerGroups: Entity.countByType(metaDataService.etGroupPartner),
                                       allClientGroups: Entity.countByType(metaDataService.etGroupClient)]
  }

  def other = {
    List temp = Entity.findAllByType(metaDataService.etResource)

    def allResources = 0
    temp.each { resource ->
      def result = functionService.findByLink(resource, null, metaDataService.ltResource)
      if (result && result.type.id != metaDataService.etTemplate.id)
        allResources++
    }

    render template: 'other', model: [allFacilities: Entity.countByType(metaDataService.etFacility),
                                      allResources: allResources,
                                      allMethods: Method.countByType("template")]
  }

  def persons = {
    render template: 'persons', model: [allClients: Entity.countByType(metaDataService.etClient),
                                        allEducators: Entity.countByType(metaDataService.etEducator),
                                        allParents: Entity.countByType(metaDataService.etParent),
                                        allChilds: Entity.countByType(metaDataService.etChild),
                                        allPates: Entity.countByType(metaDataService.etPate),
                                        allPartners: Entity.countByType(metaDataService.etPartner)]
  }

  def admin = {
    render template: 'admin', model: [allOperators: Entity.countByType(metaDataService.etOperator),
                                      allUsers: Entity.countByType(metaDataService.etUser)]
  }

  /*
   * used by the glossary
   * either retrieves all users or those matching the given glossary letter
   */
  def showUsers = {
    params.glossary = params.glossary ?: 'Alle'
    params.max = Math.min(params.int('max') ?: 16, 100)
    params.offset = params.int('offset') ?: 0

    List users
    def numUsers

    if (params.glossary == "Alle") {
      users = Entity.createCriteria().list {
        user {
          eq("enabled", true)
        }
        or {
          eq("type", metaDataService.etChild)
          eq("type", metaDataService.etClient)
          eq("type", metaDataService.etEducator)
          eq("type", metaDataService.etFacility)
          eq("type", metaDataService.etOperator)
          eq("type", metaDataService.etParent)
          eq("type", metaDataService.etPartner)
          eq("type", metaDataService.etPate)
        }
        profile {
          order("lastName", "asc")
        }
      }
      numUsers = users.size()
      def upperBound = params.offset + 16 < users.size() ? params.offset + 16 : users.size()
      users = users.subList(params.offset, upperBound)
    }
    else {
      //log.debug("start glossary for " + params.glossary)
      users = Entity.createCriteria().list {
        user {
          eq("enabled", true)
        }
        or {
          eq("type", metaDataService.etChild)
          eq("type", metaDataService.etClient)
          eq("type", metaDataService.etEducator)
          eq("type", metaDataService.etFacility)
          eq("type", metaDataService.etOperator)
          eq("type", metaDataService.etParent)
          eq("type", metaDataService.etPartner)
          eq("type", metaDataService.etPate)
        }
        profile {
          ilike("fullName", params.glossary + "%")
          order("fullName", "asc")
        }
        cacheable(true)
      }
      numUsers = users.size()
      def upperBound = params.offset + 16 < users.size() ? params.offset + 16 : users.size()
      users = users.subList(params.offset, upperBound)
    }

    render template: 'allusers', model: [entities: users, numEntities: numUsers, glossary: params.glossary]
  }
  
  def searchMe = {

    if (params.name == "") {
      render ""
      return
    }
    else if (params.name.size() < 2) {
      render '<span class="gray">Bitte mindestens 2 Zeichen eingeben!</span>'
      return
    }

    List searchStrings = params.name.toString().split(" ")

    def results = Entity.createCriteria().list {
      if (params.enabled) {
        user {
          eq("enabled", params.enabled == "true")
        }
      }
      or {
        if (params.child)
          eq("type", metaDataService.etChild)
        if (params.client)
          eq("type", metaDataService.etClient)
        if (params.educator)
          eq("type", metaDataService.etEducator)
        if (params.facility)
          eq("type", metaDataService.etFacility)
        if (params.operator)
          eq("type", metaDataService.etOperator)
        if (params.parent)
          eq("type", metaDataService.etParent)
        if (params.partner)
          eq("type", metaDataService.etPartner)
        if (params.pate)
          eq("type", metaDataService.etPate)
        if (params.family)
          eq("type", metaDataService.etGroupFamily)
        if (params.colony)
          eq("type", metaDataService.etGroupColony)
        if (params.groupClient)
          eq("type", metaDataService.etGroupClient)
        if (params.groupPartner)
          eq("type", metaDataService.etGroupPartner)
        if (params.projectTemplate)
          eq("type", metaDataService.etProjectTemplate)
        if (params.project)
          eq("type", metaDataService.etProject)
        if (params.groupActivity)
          eq("type", metaDataService.etGroupActivity)
        }
      or {
        ilike('name', "%" + params.name + "%")
        profile {
          //ilike('fullName', "%" + params.name + "%")
          and {
            searchStrings.each {String s ->
              ilike('fullName', "%" + s + "%")
            }
          }
          order('fullName','asc')
        }
      }
      maxResults(30)
    }

    render template: 'searchresults', model: [results: results]
  }

}
