package at.uenterprise.erp

class WorkdayCategoryController {

  def index = {
    redirect action: "list", params: params
  }

  // the delete, save and update actions only accept POST requests
  static allowedMethods = [delete: 'POST', save: 'POST', update: 'POST']

  def list = {
    params.max = Math.min(params.int('max') ?: 10, 100)
    params.sort = params.sort ?: "name"
    params.order = params.order ?: "asc"
    [workdayCategoryInstanceList: WorkdayCategory.list(params), workdayCategoryInstanceTotal: WorkdayCategory.count()]
  }

  def show = {
    def workdayCategoryInstance = WorkdayCategory.get(params.id)

    if (workdayCategoryInstance) {
      [workdayCategoryInstance: workdayCategoryInstance]
    }
    else {
      flash.message = message(code: "object.notFound", args: [message(code: "workdayCategory")])
      redirect action: list
    }

  }

  def delete = {
    def workdayCategoryInstance = WorkdayCategory.get(params.id)
    if (workdayCategoryInstance) {
      try {
        workdayCategoryInstance.delete(flush: true)
        flash.message = message(code: "object.deleted", args: [message(code: "workdayCategory"), workdayCategoryInstance.name])
        redirect action: "list"
      }
      catch (org.springframework.dao.DataIntegrityViolationException e) {
        flash.message = message(code: "object.notDeleted", args: [message(code: "workdayCategory"), workdayCategoryInstance.name])
        redirect action: "show", id: params.id
      }
    }
    else {
      flash.message = message(code: "object.notFound", args: [message(code: "workdayCategory")])
      redirect action: "list"
    }
  }

  def edit = {
    def workdayCategoryInstance = WorkdayCategory.get(params.id)

    if (workdayCategoryInstance) {
      [workdayCategoryInstance: workdayCategoryInstance]
    }
    else {
      flash.message = message(code: "object.notFound", args: [message(code: "workdayCategory")])
      redirect action: 'list'
    }

  }

  def update = {
    def workdayCategoryInstance = WorkdayCategory.get(params.id)

    params.beginDate = params.date('beginDate', 'dd. MM. yy')
    params.endDate = params.date('endDate', 'dd. MM. yy')

    if (workdayCategoryInstance) {
      if (params.version) {
        def version = params.version.toLong()
        if (workdayCategoryInstance.version > version) {

          workdayCategoryInstance.errors.rejectValue("version", "workdayCategory.optimistic.locking.failure", "Another user has updated this WorkdayCategory while you were editing.")

          render view: 'edit', model: [workdayCategoryInstance: workdayCategoryInstance]
          return
        }
      }
      workdayCategoryInstance.properties = params
      if (workdayCategoryInstance.save()) {
        flash.message = message(code: "object.updated", args: [message(code: "workdayCategory"), workdayCategoryInstance.name])
        redirect action: 'show', id: workdayCategoryInstance.id
      }
      else {
        render view: 'edit', model: [workdayCategoryInstance: workdayCategoryInstance]
      }
    }
    else {
      flash.message = message(code: "object.notFound", args: [message(code: "workdayCategory")])
      redirect action: 'list'
    }
  }

  def create = {
    def workdayCategoryInstance = new WorkdayCategory()
    workdayCategoryInstance.properties = params
    return ['workdayCategoryInstance': workdayCategoryInstance]
  }

  def save = {
    params.beginDate = params.date('beginDate', 'dd. MM. yy')
    params.endDate = params.date('endDate', 'dd. MM. yy')
    def workdayCategoryInstance = new WorkdayCategory(params)
    if (workdayCategoryInstance.save(flush: true)) {
      flash.message = message(code: "object.created", args: [message(code: "workdayCategory"), workdayCategoryInstance.name])
      redirect action: "show", id: workdayCategoryInstance.id
    }
    else {
      render view: 'create', model: [workdayCategoryInstance: workdayCategoryInstance]
    }
  }
}
