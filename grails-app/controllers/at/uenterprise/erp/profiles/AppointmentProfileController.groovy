package at.uenterprise.erp.profiles

import at.openfactory.ep.EntityType
import at.openfactory.ep.Entity
import at.openfactory.ep.Link
import at.openfactory.ep.EntityException
import at.uenterprise.erp.MetaDataService
import at.openfactory.ep.EntityHelperService
import at.uenterprise.erp.FunctionService
import at.openfactory.ep.Profile
import at.openfactory.ep.ProfileHelperService

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
        redirect action:"list", params:params 
    }

    // the delete, save and update actions only accept POST requests
    static allowedMethods = [delete:'POST', save:'POST', update:'POST']

    def list = {
      params.offset = params.int('offset') ?: 0
      params.sort = params.sort ?: 'beginDate'

      Entity entity = Entity.get(params.id) ?: entityHelperService.loggedIn

      List appointments = functionService.findAllByLink(null, entity, metaDataService.ltAppointment)
      appointments = appointments.findAll {it.profile.endDate > new Date()}

      appointments.sort {it.profile[params.sort]}
      /*if (params.sort == "fullName")
        appointments.sort {it.profile.fullName}
      else if (params.sort == "beginDate")
        appointments.sort {it.profile.beginDate}
      else if (params.sort == "endDate")
        appointments.sort {it.profile.endDate}
      else if (params.sort == "allDay")
        appointments.sort {it.profile.allDay}
      else if (params.sort == "isPrivate")
        appointments.sort {it.profile.isPrivate}*/

      if (params.order == "desc")
        appointments = appointments.reverse()

      def resulttotal = appointments.size()

      def upperBound = params.offset + 10 < resulttotal ? params.offset + 10 : resulttotal
      appointments = appointments.subList(params.offset, upperBound)

      [appointmentProfileInstanceList: appointments,
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
      /*if (params.sort == "fullName")
        appointments.sort {it.profile.fullName}
      else if (params.sort == "beginDate")
        appointments.sort {it.profile.beginDate}
      else if (params.sort == "endDate")
        appointments.sort {it.profile.endDate}
      else if (params.sort == "allDay")
        appointments.sort {it.profile.allDay}
      else if (params.sort == "isPrivate")
        appointments.sort {it.profile.isPrivate}*/

      if (params.order == "desc")
        appointments = appointments.reverse()

      def resulttotal = appointments.size()

      def upperBound = params.offset + 10 < resulttotal ? params.offset + 10 : resulttotal
      appointments = appointments.subList(params.offset, upperBound)

      [appointmentProfileInstanceList: appointments,
       appointmentProfileInstanceTotal: resulttotal,
       entity: entity]
    }

    def show = {
      Entity appointment = Entity.get(params.id)

      if (appointment) {
        // find owner of appointment
        Entity belongsTo = functionService.findByLink(appointment, null, metaDataService.ltAppointment)

        [appointment: appointment, entity: appointment, belongsTo: belongsTo]
      }
      else {
        flash.message = message(code: "object.notFound", args: [message(code: "appointment")])
        redirect action: list
      }

    }

    def delete = {
      Entity appointment = Entity.get(params.id)

      if(appointment) {
        functionService.deleteReferences(appointment)
        try {
          flash.message = message(code: "object.deleted", args: [message(code: "appointment"), appointment.profile.fullName])
          appointment.delete(flush:true)
          redirect(action:"list")
        }
        catch(org.springframework.dao.DataIntegrityViolationException e) {
          flash.message = message(code: "object.notDeleted", args: [message(code: "appointment"), appointment.profile.fullName])
          redirect(action:"show",id:params.id)
        }
      }
      else {
        flash.message = message(code: "object.notFound", args: [message(code: "appointment")])
        redirect(action:"list")
      }
    }

    def edit = {
      Entity appointment = Entity.get(params.id)

    if (!appointment) {
      flash.message = message(code: "object.notFound", args: [message(code: "appointment")])
      redirect action: 'list'
      return
    }

    return [ appointmentProfileInstance : appointment ]

    }

    def update = {
      Entity appointment = Entity.get(params.id)

      appointment.profile.properties = params
      appointment.profile.beginDate = functionService.convertToUTC(appointment.profile.beginDate)
      appointment.profile.endDate = functionService.convertToUTC(appointment.profile.endDate)

      if (appointment.profile.beginDate > appointment.profile.endDate) {
        render (view: "edit", model: [appointmentProfileInstance: appointment])
        return
      }

      if (appointment.profile.save() && appointment.save()) {
        flash.message = message(code: "object.updated", args: [message(code: "appointment"), appointment.profile.fullName])
        redirect action: 'show', id: appointment.id
      }
      else {
        render view: 'edit', model: [appointmentProfileInstance: appointment]
      }
    }

    def create = {
      Entity entity = Entity.get(params.id)
      return [createdFor: entity, entity: entity]
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

        flash.message = message(code: "object.created", args: [message(code: "appointment"), entity.profile.fullName])
        redirect action: 'show', id: entity.id, params: [entity: entity]
      } catch (EntityException ee) {
        render(view: "create", model: [appointmentProfileInstance: ee.entity, createdFor: owner, owner: owner])
      }

    }

}
