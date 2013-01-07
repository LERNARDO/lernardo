package at.uenterprise.erp

/**
 * Created with IntelliJ IDEA.
 * User: Alex
 * Date: 22.11.12
 * Time: 12:51
 * To change this template use File | Settings | File Templates.
 */
class UpdateJob {

    FunctionService functionService
    //def timeout = 5000l // execute job once in 5 seconds

    //static triggers = {
    //    cron name: 'myTrigger', cronExpression: "0 0 * * * ?" // execute every day at midnight
    //}

    def group = "MyGroup"

    def execute(){
        //functionService.updateStatus()
    }

}
