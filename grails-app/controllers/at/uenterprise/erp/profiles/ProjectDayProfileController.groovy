package at.uenterprise.erp.profiles

import at.uenterprise.erp.base.Entity
import at.uenterprise.erp.FunctionService
import at.uenterprise.erp.MetaDataService
import at.uenterprise.erp.base.EntityHelperService
import at.uenterprise.erp.base.EntityType
import at.uenterprise.erp.base.Link
import at.uenterprise.erp.base.Profile
import at.uenterprise.erp.base.ProfileHelperService
import grails.converters.JSON
import org.joda.time.DateTime

class ProjectDayProfileController {
  FunctionService functionService
  MetaDataService metaDataService
    EntityHelperService entityHelperService
    ProfileHelperService profileHelperService

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

    def toggleUnitCal = {
        Entity projectUnit = Entity.get(params.id)

        def units = []

        def color = '#aaa'

        def title = projectUnit.profile.fullName
        def description = ""
        def dateStart = new DateTime(functionService.convertFromUTC(projectUnit.profile.date))
        def dateEnd = dateStart.plusMinutes(projectUnit.profile.duration.toInteger())
        units << [id: projectUnit.id, title: title, start: dateStart.toDate(), end: dateEnd.toDate(), allDay: false, color: color, description: description]

        def json = units as JSON
        render json
    }

    def addUnit = {
        Entity projectDay = Entity.get(params.id)
        //Entity projectUnitTemplate = Entity.get(params.unit)

        Entity currentEntity = entityHelperService.loggedIn

        Date time = params.date('time', 'HH:mm')
        time = functionService.convertToUTC(time)

        def project = functionService.findByLink(projectDay, null, metaDataService.ltProjectMember)

        Calendar calendar = new GregorianCalendar()
        calendar.setTime(projectDay.profile.date)
        calendar.set(Calendar.HOUR_OF_DAY, time.getHours())
        calendar.set(Calendar.MINUTE, time.getMinutes())

        if (calendar.getTime().getTime() >= projectDay.profile.date.getTime()) {

            // create a new project unit
            EntityType etProjectUnit = metaDataService.etProjectUnit
            Entity projectUnit = entityHelperService.createEntity("projectUnit", etProjectUnit) {Entity ent ->
                ent.profile = profileHelperService.createProfileFor(ent) as Profile
                ent.profile.fullName = params.unit

                calendar.setTime(projectDay.profile.date)
                //calendar.add(Calendar.MINUTE, duration)
                calendar.set(Calendar.HOUR_OF_DAY, time.getHours())
                calendar.set(Calendar.MINUTE, time.getMinutes())
                ent.profile.date = calendar.getTime()
                ent.profile.duration = params.int('duration')
            }

            // save creator
            new Link(source: currentEntity, target: projectUnit, type: metaDataService.ltCreator).save()

            projectDay.profile.addToUnits(projectUnit.id.toString())

            // link the new unit to the project day
            new Link(source: projectUnit, target: projectDay, type: metaDataService.ltProjectDayUnit).save()
        }

        redirect controller: "projectProfile", action: "show", id: project.id, params: [one: projectDay.id]
    }
}
