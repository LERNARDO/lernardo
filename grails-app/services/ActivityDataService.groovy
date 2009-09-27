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
            clientList:['emil','pascal','marianne'],
            einrichtung:'loewenzahn']
        activities.id_2 = [actionID:'Schmetterlinge',
            date:setDate('24.09.2009'),
            startTime:setTime('11:30'),
            duration:'30',
            paedList:['rosa','martin'],
            clientList:['emil','patrick','marianne'],
            einrichtung:'loewenzahn']
        activities.id_3 = [actionID:'Luftballonmeer',
            date:setDate('26.09.2009'),
            startTime:setTime('16:00'),
            duration:'45',
            paedList:['birgit','rosa'],
            clientList:['emil','pascal','mathias'],
            einrichtung:'loewenzahn']
        activities.id_4 = [actionID:'Musikstopp',
            date:setDate('25.09.2009'),
            startTime:setTime('14:45'),
            duration:'30',
            paedList:['birgit','regina'],
            clientList:['emil','pascal','marianne'],
            einrichtung:'loewenzahn']
        activities.id_5 = [actionID:'Musikstopp',
            date:setDate('25.11.2009'),
            startTime:setTime('14:45'),
            duration:'30',
            paedList:['birgit','regina'],
            clientList:['emil','pascal','marianne'],
            einrichtung:'loewenzahn']
        activities.id_6 = [actionID:'Musikstopp',
            date:setDate('25.04.2009'),
            startTime:setTime('14:45'),
            duration:'30',
            paedList:['birgit','regina'],
            clientList:['emil','pascal','marianne'],
            einrichtung:'loewenzahn']
        activities.id_7 = [actionID:'Musikstopp',
            date:setDate('25.04.2009'),
            startTime:setTime('14:45'),
            duration:'30',
            paedList:['birgit','regina'],
            clientList:['emil','pascal','marianne'],
            einrichtung:'loewenzahn']
        activities.id_8 = [actionID:'Musikstopp',
            date:setDate('25.03.2009'),
            startTime:setTime('14:45'),
            duration:'30',
            paedList:['birgit','regina'],
            clientList:['emil','pascal','marianne'],
            einrichtung:'loewenzahn']
        activities.id_9 = [actionID:'Musikstopp',
            date:setDate('25.02.2009'),
            startTime:setTime('14:45'),
            duration:'30',
            paedList:['birgit','regina'],
            clientList:['emil','pascal','marianne'],
            einrichtung:'kaumberg']
        activities.id_10 = [actionID:'Musikstopp',
            date:setDate('25.01.2009'),
            startTime:setTime('14:45'),
            duration:'30',
            paedList:['birgit','regina'],
            clientList:['emil','pascal','marianne'],
            einrichtung:'kaumberg']
        activities.id_11 = [actionID:'Musikstopp',
            date:setDate('25.01.2009'),
            startTime:setTime('14:45'),
            duration:'30',
            paedList:['birgit','regina'],
            clientList:['emil','pascal','marianne'],
            einrichtung:'kaumberg']
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
    def getActivities (int noffset, int nmax, String nmonth) {

        def listMonthValue = []
        def listPaginationValue = []

        if (nmonth == "alle") {
            listMonthValue = activities
        }
        else {
            for ( v in activities ) {
                if (nmonth == Date.parse("dd.MM.yyyy", v.value.date).format("MM")) {
                    listMonthValue.add(v)
                }
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
    def getActivityCount (String nmonth) {

        if (nmonth == "alle") {
            return activities.size()
        }
        else {
            int count = 0
            for ( v in activities ) {
                if (nmonth == Date.parse("dd.MM.yyyy", v.value.date).format("MM")) {
                    count ++
                }
            }
            return count
        }
    }

    def findById (def idVal) {
      def res = null
      activities.each {key, val->
        if (key == "id_${idVal}")
          res = val ;
      }
      return res ;
    }

    List findActivitiesByNameAndType (String name, String type) {
      def result = [] ;

      activities.each {key, val->
        def xlist = val["${type}List"]
        if (xlist?.contains (name)) {
          val.id = key.startsWith ("id_") ? key[3..-1] : "42"
          result << val ;
        }
      }

      return result ;
    }

}

