

package lernardo

import at.openfactory.ep.EntityType
import at.openfactory.ep.Entity
import at.openfactory.ep.Link
import at.openfactory.ep.EntityException
import standard.MetaDataService
import at.openfactory.ep.EntityHelperService
import standard.FunctionService
import at.openfactory.ep.Profile
import at.openfactory.ep.ProfileHelperService

class AppointmentProfileController {
    MetaDataService metaDataService
    EntityHelperService entityHelperService
    FunctionService functionService
    ProfileHelperService profileHelperService

    def beforeInterceptor = [
          action:{
            params.beginDate = params.beginDate ? Date.parse("dd. MM. yy, hh:mm", params.beginDate) : null
            params.endDate = params.endDate ? Date.parse("dd. MM. yy, hh:mm", params.endDate) : null},
            only:['save','update']
    ]

    def index = {
        redirect action:"list", params:params 
    }

    // the delete, save and update actions only accept POST requests
    static allowedMethods = [delete:'POST', save:'POST', update:'POST']

    def list = {
        params.max = Math.min( params.max ? params.max.toInteger() : 10,  100)
        [ appointmentProfileInstanceList: Entity.findAllByType(metaDataService.etAppointment, params), appointmentProfileInstanceTotal: Entity.countByType(metaDataService.etAppointment)]
    }

    def show = {
      Entity appointment = Entity.get(params.id)
      Entity entity = params.entity ? appointment : entityHelperService.loggedIn

      if (!appointment) {
        flash.message = "Appointment not found with id ${params.id}"
        redirect(action: list)
        return
      }

      return [appointmentProfileInstance : appointment]
    }

    def delete = {
        def appointmentProfileInstance = AppointmentProfile.get( params.id )
        if(appointmentProfileInstance) {
            try {
                appointmentProfileInstance.delete(flush:true)
                flash.message = "AppointmentProfile ${params.id} deleted"
                redirect(action:"list")
            }
            catch(org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "AppointmentProfile ${params.id} could not be deleted"
                redirect(action:"show",id:params.id)
            }
        }
        else {
            flash.message = "AppointmentProfile not found with id ${params.id}"
            redirect(action:"list")
        }
    }

    def edit = {
      Entity appointment = Entity.get(params.id)

    if (!appointment) {
      flash.message = "Appointment not found with id ${params.id}"
      redirect action: 'list'
      return
    }

    return [ appointmentProfileInstance : appointment ]

    }

    def update = {
      Entity appointment = Entity.get(params.id)

      appointment.profile.properties = params

      if (!appointment.hasErrors() && appointment.save()) {
        flash.message = message(code: "appointment.updated", args: [appointment.profile.fullName])
        redirect action: 'show', id: appointment.id
      }
      else {
        render view: 'edit', model: [appointmentProfileInstance: appointment]
      }
    }

    def create = {

    }

    def save = {
      EntityType etAppointment = metaDataService.etAppointment
      Entity currentEntity = entityHelperService.loggedIn

      try {
        Entity entity = entityHelperService.createEntity('appointment', etAppointment) {Entity ent ->
          ent.profile = profileHelperService.createProfileFor(ent) as Profile
          ent.profile.properties = params
        }

        // create link to owner
        new Link(source: entity, target: currentEntity, type: metaDataService.ltAppointment).save()

        flash.message = message(code: "appointment.created", args: [entity.profile.fullName])
        redirect action: 'show', id: entity.id
      } catch (EntityException ee) {
        render(view: "create", model: [client: ee.entity])
        return
      }

    }

}
