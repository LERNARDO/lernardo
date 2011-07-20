package at.uenterprise.erp

import at.openfactory.ep.Entity
import at.openfactory.ep.EntityHelperService

class OverviewController {
  EntityHelperService entityHelperService
  MetaDataService metaDataService
  FunctionService functionService

  def index = {}

  def planning = {
    def c = Entity.createCriteria()
    def count = c.list {
      eq("type", servletContext.etActivity)
      profile {
        eq("type", "Themenraum")
      }
    }
    def activities = count.size()

    render template: 'planning', model: [allActivityTemplates: Entity.countByType(servletContext.etTemplate),
                                        allActivities: activities,
                                        allActivityTemplateGroups: Entity.countByType(servletContext.etGroupActivityTemplate),
                                        allActivityGroups: Entity.countByType(servletContext.etGroupActivity),
                                        allProjectTemplates: Entity.countByType(servletContext.etProjectTemplate),
                                        allProjects: Entity.countByType(servletContext.etProject),
                                        allThemes: Entity.countByType(servletContext.etTheme)]
  }

  def groups = {
    render template: 'groups', model: [allColonias: Entity.countByType(servletContext.etGroupColony),
                                       allFamilies: Entity.countByType(servletContext.etGroupFamily),
                                       allPartnerGroups: Entity.countByType(servletContext.etGroupPartner),
                                       allClientGroups: Entity.countByType(servletContext.etGroupClient)]
  }

  def other = {
    List temp = Entity.findAllByType(servletContext.etResource)

    def allResources = 0
    temp.each { resource ->
      def result = functionService.findByLink(resource, null, servletContext.ltResource)
      if (result && result.type.id != servletContext.etTemplate.id)
        allResources++
    }

    render template: 'other', model: [allFacilities: Entity.countByType(servletContext.etFacility),
                                      allResources: allResources,
                                      allMethods: Method.countByType("template")]
  }

  def persons = {
    render template: 'persons', model: [allClients: Entity.countByType(servletContext.etClient),
                                        allEducators: Entity.countByType(servletContext.etEducator),
                                        allParents: Entity.countByType(servletContext.etParent),
                                        allChilds: Entity.countByType(servletContext.etChild),
                                        allPates: Entity.countByType(servletContext.etPate),
                                        allPartners: Entity.countByType(servletContext.etPartner)]
  }

  def admin = {
    render template: 'admin', model: [allOperators: Entity.countByType(servletContext.etOperator),
                                      allUsers: Entity.countByType(servletContext.etUser)]
  }

   /*
   * retrieves users matching the search parameter of the instant search
   */
  def searchMe = {
    if (!params.name) {
      render ""
      return
    }

    def c = Entity.createCriteria()
    def users = c.list {
      or {
          if (params.child)
            eq("type", servletContext.etChild)
          if (params.client)
            eq("type", servletContext.etClient)
          if (params.educator)
            eq("type", servletContext.etEducator)
          if (params.facility)
            eq("type", servletContext.etFacility)
          if (params.operator)
            eq("type", servletContext.etOperator)
          if (params.parent)
            eq("type", servletContext.etParent)
          if (params.partner)
            eq("type", servletContext.etPartner)
          if (params.pate)
            eq("type", servletContext.etPate)
          if (params.family)
            eq("type", servletContext.etGroupFamily)
          if (params.colony)
            eq("type", servletContext.etGroupColony)
          if (params.groupClient)
            eq("type", servletContext.etGroupClient)
          if (params.groupPartner)
            eq("type", servletContext.etGroupPartner)
          if (params.projectTemplate)
            eq("type", servletContext.etProjectTemplate)
          if (params.project)
            eq("type", servletContext.etProject)
          if (params.groupActivity)
            eq("type", servletContext.etGroupActivity)
        }
      or {
        ilike('name', "%" + params.name + "%")
        profile {
          ilike('fullName', "%" + params.name + "%")
        }
      }
      maxResults(15)
    }

    if (users.size() == 0) {
      render '<span class="italic">' + message(code: "searchMe.empty") +  '</span>'
      return
    }
    else {
      render(template: 'searchresults', model: [searchList: users])
    }
  }

  /*
   * used by the glossary
   * either retrieves all users or those matching the given glossary letter
   */
  def showUsers = {
    params.glossary = params.glossary ?: 'Alle'
    params.max = Math.min(params.max ? params.int('max') : 16, 100)
    params.offset = params.offset ? params.int('offset') : 0

    List users
    def numUsers

    if (params.glossary == "Alle") {
      def c = Entity.createCriteria()
      users = c.list {
        or {
          eq("type", servletContext.etChild)
          eq("type", servletContext.etClient)
          eq("type", servletContext.etEducator)
          eq("type", servletContext.etFacility)
          eq("type", servletContext.etOperator)
          eq("type", servletContext.etParent)
          eq("type", servletContext.etPartner)
          eq("type", servletContext.etPate)
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
      def c = Entity.createCriteria()
      users = c.list {
        or {
          eq("type", servletContext.etChild)
          eq("type", servletContext.etClient)
          eq("type", servletContext.etEducator)
          eq("type", servletContext.etFacility)
          eq("type", servletContext.etOperator)
          eq("type", servletContext.etParent)
          eq("type", servletContext.etPartner)
          eq("type", servletContext.etPate)
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

    render(template: 'allusers', model: [entities: users, numEntities: numUsers, glossary: params.glossary])
  }

}
