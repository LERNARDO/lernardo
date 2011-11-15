package at.uenterprise.erp

import at.openfactory.ep.Entity

class SearchController {
  MetaDataService metaDataService

  def index = {

    def c = Entity.createCriteria()
    def results = c.list {
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
        ilike('name', "%" + params.search + "%")
        profile {
          ilike('fullName', "%" + params.search + "%")
        }
      }
      maxResults(30)
    }
    
    return [results: results]
  }
}
