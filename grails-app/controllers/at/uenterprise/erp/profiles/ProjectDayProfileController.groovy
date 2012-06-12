package at.uenterprise.erp.profiles

import at.uenterprise.erp.base.Entity
import at.uenterprise.erp.FunctionService
import at.uenterprise.erp.MetaDataService

class ProjectDayProfileController {
  FunctionService functionService
  MetaDataService metaDataService

  def show = {
    Entity projectDay = Entity.get(params.id)
    
    // find project
    Entity project = functionService.findByLink(projectDay, null, metaDataService.ltProjectMember)
    
    redirect controller: 'projectProfile', action: 'show', id: project.id, params: [one: projectDay.id]
  }

  def completeDay = {
    Entity day = Entity.get(params.id)

    if (day.profile.complete)
      day.profile.complete = false
    else
      day.profile.complete = true

    day.profile.save(flush: true)

    forward controller: "projectProfile", action: "setprojectday", id: day.id, params: [project: params.project]
  }
}
