package at.uenterprise.erp

import at.uenterprise.erp.base.Entity

class SearchController {
  MetaDataService metaDataService

  def index = {

    params.search = params.search ? params.search.trim() : null

    def results = []
    if (params.search) {
      results = Entity.createCriteria().list {
        or {
          eq("type", metaDataService.etChild)
          eq("type", metaDataService.etClient)
          eq("type", metaDataService.etEducator)
          eq("type", metaDataService.etFacility)
          eq("type", metaDataService.etOperator)
          eq("type", metaDataService.etParent)
          eq("type", metaDataService.etPartner)
          eq("type", metaDataService.etPate)
          eq("type", metaDataService.etGroupFamily)
          eq("type", metaDataService.etGroupColony)
          eq("type", metaDataService.etGroupClient)
          eq("type", metaDataService.etGroupPartner)
          eq("type", metaDataService.etProjectTemplate)
          eq("type", metaDataService.etProject)
          eq("type", metaDataService.etResource)
          eq("type", metaDataService.etTemplate)
          eq("type", metaDataService.etTheme)
        }
        profile {
          or {
            ilike('fullName', "%" + params.search + "%")
            ilike('interests', "%" + params.search + "%") // client, educator
            ilike('supportDescription', "%" + params.search + "%") // client
            ilike('comment', "%" + params.search + "%") // parents
            ilike('livingConditions', "%" + params.search + "%") // family
            ilike('socioeconomicData', "%" + params.search + "%") // family
            ilike('otherInfo', "%" + params.search + "%") // family
            ilike('description', "%" + params.search + "%") // colony, facility, clientgroup, partnergroup, partner, template, groupactivitytemplate , groupactivity, projecttemplate, project, theme
            ilike('chosenMaterials', "%" + params.search + "%") // template
            ilike('goal', "%" + params.search + "%") // template
            ilike('educationalObjectiveText', "%" + params.search + "%") // groupactivitytemplate, groupactivity, projecttemplate, project
          }
          order('fullName', 'asc')
        }
        //maxResults(100)
      }

        // add all entities that have a label matching the search word
        // FIXME: this should work but doesn't
        /*def results2 = Entity.createCriteria().list {
            or {
                eq("type", metaDataService.etProjectTemplate)
                eq("type", metaDataService.etProject)
                eq("type", metaDataService.etTemplate)
                eq("type", metaDataService.etTheme)
            }
            profile {
                labels {
                    ilike('name', "%" + params.search + "%")
                }
            }
        }

        results.addAll(results2)*/

        // slightly less elegant solution for above code not working
        def entities = Entity.createCriteria().list {
            or {
                eq("type", metaDataService.etProjectTemplate)
                eq("type", metaDataService.etProject)
                eq("type", metaDataService.etTemplate)
                eq("type", metaDataService.etTheme)
            }
        }
        entities.each { Entity entity ->
            if (entity.profile.labels) {
                entity.profile.labels.each { Label label ->
                    if (label.name.contains(params.search))
                        results.add(entity)
                }
            }
        }

        results = results.size() < 100 ? results : results.subList(0, 100)
    }

    return [results: results, search: params.search]
  }
}