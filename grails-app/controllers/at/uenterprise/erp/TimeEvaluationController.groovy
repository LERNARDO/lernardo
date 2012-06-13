package at.uenterprise.erp

import at.uenterprise.erp.base.Entity
import at.uenterprise.erp.base.EntityHelperService

class TimeEvaluationController {
  EntityHelperService entityHelperService
  MetaDataService metaDataService

  def index = {
    redirect action: "evaluation", params: params
  }

  def evaluation = {}

  def showEvaluation = {
    List employments = Setup.list()[0]?.employmentStatus

    Map educators = [:]

    employments?.eachWithIndex { emp, i ->
      List eds =  Entity.createCriteria().list {
        eq("type", metaDataService.etEducator)
        profile {
          eq('employment', emp)
          order('firstName','asc')
        }
      }
      if (eds.size() > 0)
        educators.putAt(i.toString(), eds)
    }
    List users = Entity.createCriteria().list {
      eq("type", metaDataService.etUser)
      profile {
        order('firstName','asc')
      }
    }

    List workdaycategories = WorkdayCategory.list()

    render template: 'showevaluation', model: [educators: educators,
        users: users,
        workdaycategories: workdaycategories,
        date1: params.date1,
        date2: params.date2]
  }

  def pdf = {
    Date date1 = params.date('date1', 'dd. MM. yy')
    Date date2 = params.date('date2', 'dd. MM. yy')

    List employments = Setup.list()[0]?.employmentStatus

    Map educators = [:]

    employments?.eachWithIndex { emp, i ->
      List eds =  Entity.createCriteria().list {
        eq("type", metaDataService.etEducator)
        profile {
          eq('employment', emp)
          order('firstName','asc')
        }
      }
      if (eds.size() > 0)
        educators.putAt(i.toString(), eds)
    }
    List users = Entity.createCriteria().list {
      eq("type", metaDataService.etUser)
      profile {
        order('firstName','asc')
      }
    }

    List workdaycategories = WorkdayCategory.list()
    Entity currentEntity = entityHelperService.loggedIn

    renderPdf template: 'pdf', model: [educators: educators,
        users: users,
        workdaycategories: workdaycategories,
        entity: currentEntity,
        date1: params.date1,
        date2: params.date2],
        filename: message(code: 'timeEvaluation') + '_' + formatDate(date: date1, format: "dd.MM.yyyy") + '-' + formatDate(date: date2, format: "dd.MM.yyyy") + '.pdf'
  }

}
