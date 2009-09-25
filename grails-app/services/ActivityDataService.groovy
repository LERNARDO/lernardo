class ActivityDataService {
    boolean transactional = false
    Map activities = [:]

    ActivityDataService () {
        init()
    }

    def init () {

        activities.id_1 = [actionID:'Weide mit Hindernissen',
            date:setDate('24.09.2009'),
            startTime:setTime('13:00'),
            duration:'60',
            paedList:['regina','martin'],
            clientList:['emil','pascal','marianne']]
        activities.id_2 = [actionID:'Schmetterlinge',
            date:setDate('24.09.2009'),
            startTime:setTime('11:30'),
            duration:'30',
            paedList:['rosa','martin'],
            clientList:['emil','patrick','marianne']]
        activities.id_3 = [actionID:'Luftballonmeer',
            date:setDate('26.09.2009'),
            startTime:setTime('16:00'),
            duration:'45',
            paedList:['birgit','rosa'],
            clientList:['emil','pascal','mathias']]
        activities.id_4 = [actionID:'Musikstopp',
            date:setDate('25.09.2009'),
            startTime:setTime('14:45'),
            duration:'30',
            paedList:['birgit','regina'],
            clientList:['emil','pascal','marianne']]
    }

    def setDate (String sDate) {
         def activityDate = Date.parse("dd.MM.yyyy", sDate).format("dd.MM.yyyy")
         return activityDate
    }

    def setTime (String sTime) {
        def activityTime = Date.parse("HH:mm", sTime).format("HH:mm")
        return activityTime
    }


    // returns all activities, inluding offset and max number
    def getActivities (int noffset, int nmax, int nmonth) {

        def listMonthValue = []
        def listPaginationValue = []

        for ( v in activities ) {
          if (nmonth == Date.parse("dd.MM.yyyy", v.value.date).format("mm")) {

            listMonthValue.add(v)
          }
        } 

        int offset = 0
        int count = 0

        for ( v in listMonthValue ) {
            if (offset >= noffset && count < nmax) {
                listPaginationValue.add(v)
                count++
            }
            offset++
        }
        return listPaginationValue
    }

    // returns the number of activities
    def getActivityCount () {
        return activities.size()
    }

}

