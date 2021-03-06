package at.uenterprise.erp.profiles

import at.uenterprise.erp.base.EntityType
import at.uenterprise.erp.base.Entity
import at.uenterprise.erp.base.Link
import at.uenterprise.erp.base.EntityException
import at.uenterprise.erp.MetaDataService
import at.uenterprise.erp.base.EntityHelperService
import at.uenterprise.erp.FunctionService
import at.uenterprise.erp.base.Profile
import at.uenterprise.erp.base.ProfileHelperService

class AppointmentProfileController {
    MetaDataService metaDataService
    EntityHelperService entityHelperService
    FunctionService functionService
    ProfileHelperService profileHelperService

    def beforeInterceptor = [
          action:{
            params.beginDate = params.date('beginDate', 'dd. MM. yy, HH:mm')
            params.endDate = params.date('endDate', 'dd. MM. yy, HH:mm')},
            only:['save','update']
    ]

    def index = {
        redirect action: "list", params: params
    }

    // the delete, save and update actions only accept POST requests
    static allowedMethods = [delete: 'POST', save: 'POST', update: 'POST']

    def list = {
      params.offset = params.int('offset') ?: 0
      params.sort = params.sort ?: 'beginDate'

      Entity entity = Entity.get(params.id) ?: entityHelperService.loggedIn

      List appointments = functionService.findAllByLink(null, entity, metaDataService.ltAppointment)
      appointments = appointments.findAll {it.profile.endDate > new Date()}

      appointments.sort {it.profile[params.sort]}

      if (params.order == "desc")
        appointments = appointments.reverse()

      def resulttotal = appointments.size()

      def upperBound = params.offset + 10 < resulttotal ? params.offset + 10 : resulttotal
      appointments = appointments.subList(params.offset, upperBound)

      render template: "list", model: [appointmentProfileInstanceList: appointments,
       appointmentProfileInstanceTotal: resulttotal,
       entity: entity]
    }

    def listold = {
      params.offset = params.int('offset') ?: 0
      params.sort = params.sort ?: 'beginDate'

      Entity entity = Entity.get(params.id) ?: entityHelperService.loggedIn

      List appointments = functionService.findAllByLink(null, entity, metaDataService.ltAppointment)
      appointments = appointments.findAll {it.profile.endDate < new Date()}

      appointments.sort {it.profile[params.sort]}

      if (params.order == "desc")
        appointments = appointments.reverse()

      def resulttotal = appointments.size()

      def upperBound = params.offset + 10 < resulttotal ? params.offset + 10 : resulttotal
      appointments = appointments.subList(params.offset, upperBound)

      render template: "listold", model: [appointmentProfileInstanceList: appointments,
       appointmentProfileInstanceTotal: resulttotal,
       entity: entity]
    }

    def show = {
      Entity appointment = Entity.get(params.id)

      if (appointment) {
        // find owner of appointment
        Entity belongsTo = functionService.findByLink(appointment, null, metaDataService.ltAppointment)

        render template: "show", model: [appointment: appointment, entity: appointment, belongsTo: belongsTo]
      }
      else {
        flash.message = message(code: "object.notFound", args: [message(code: "appointment")])
        redirect action: "list"
      }

    }

    def delete = {
      Entity appointment = Entity.get(params.id)

      if(appointment) {
        functionService.deleteReferences(appointment)
        try {
          flash.message = message(code: "object.deleted", args: [message(code: "appointment"), appointment.profile])
          appointment.delete(flush:true)
          redirect(action: "list")
        }
        catch(org.springframework.dao.DataIntegrityViolationException ignore) {
          flash.message = message(code: "object.notDeleted", args: [message(code: "appointment"), appointment.profile])
          redirect(action: "show", id: params.id)
        }
      }
      else {
        flash.message = message(code: "object.notFound", args: [message(code: "appointment")])
        redirect action: "list"
      }
    }

    def edit = {
      Entity appointment = Entity.get(params.id)

    if (!appointment) {
      flash.message = message(code: "object.notFound", args: [message(code: "appointment")])
      redirect action: 'list'
      return
    }

    render template: "edit", model: [ appointmentProfileInstance : appointment ]

    }

    def update = {
      Entity appointment = Entity.get(params.id)

      appointment.profile.properties = params
      appointment.profile.beginDate = functionService.convertToUTC(appointment.profile.beginDate)
      appointment.profile.endDate = functionService.convertToUTC(appointment.profile.endDate)

      if (appointment.profile.beginDate > appointment.profile.endDate) {
        render view: "edit", model: [appointmentProfileInstance: appointment]
        return
      }

      if (appointment.profile.save() && appointment.save()) {
        flash.message = message(code: "object.updated", args: [message(code: "appointment"), appointment.profile])
        redirect action: 'show', id: appointment.id
      }
      else {
        render template: 'edit', model: [appointmentProfileInstance: appointment]
      }
    }

    def create = {
      Entity entity = Entity.get(params.id)
      render template: "create", model: [createdFor: entity, entity: entity]
    }

    def save = {
      EntityType etAppointment = metaDataService.etAppointment
      Entity owner = Entity.get(params.id)

      try {
        Entity entity = entityHelperService.createEntity('appointment', etAppointment) {Entity ent ->
          ent.profile = profileHelperService.createProfileFor(ent) as Profile
          ent.profile.properties = params
          ent.profile.beginDate = functionService.convertToUTC(ent.profile.beginDate)
          ent.profile.endDate = functionService.convertToUTC(ent.profile.endDate)
        }

        // create link to owner
        new Link(source: entity, target: owner, type: metaDataService.ltAppointment).save(failOnError: true)

        if (params.fromCalendar)
            redirect controller:  "calendar", action: "show"
        else {
            flash.message = message(code: "object.created", args: [message(code: "appointment"), entity.profile])
            redirect action: 'show', id: entity.id
        }
      } catch (EntityException ee) {
        render template: "create", model: [appointmentProfileInstance: ee.entity, createdFor: owner, owner: owner]
      }

    }

}
