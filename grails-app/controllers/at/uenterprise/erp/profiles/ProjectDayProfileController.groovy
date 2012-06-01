package at.uenterprise.erp.profiles

import at.uenterprise.erp.base.Entity
import at.uenterprise.erp.FunctionService
import at.uenterprise.erp.MetaDataService

class ProjectDayProfileController {
  FunctionService functionService
  MetaDataService metaDataService

  def show = {
    println params
    Entity projectDay = Entity.get(params.id)
    
    // find project
    Entity project = functionService.findByLink(projectDay, null, metaDataService.ltProjectMember)
    
    redirect controller: 'projectProfile', action: 'show', id: project.id, params: [one: projectDay.id]
  }
}
