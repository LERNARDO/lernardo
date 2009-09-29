class ActivityDataService {
    boolean transactional = false
    Map activities = [:]

    ActivityDataService () {
        init()
    }

    def init () {

        // all activities happen between 15:30 and 17:00 each day

        activities.id_1 = [title:'Weide mit Hindernissen',
            id:'1',
            owner:'regina',
            date:setDate('01.10.2009'),
            startTime:setTime('15:30'),
            duration:'60',
            paedList:['regina','martin'],
            clientList:['emil','pascal','marianne'],
            einrichtung:'loewenzahn']
        activities.id_2 = [title:'Schmetterlinge',
            id:'2',
            owner:'martin',
            date:setDate('01.10.2009'),
            startTime:setTime('16:30'),
            duration:'30',
            paedList:['rosa','martin'],
            clientList:['emil','patrick','marianne'],
            einrichtung:'loewenzahn']
        activities.id_3 = [title:'Luftballonmeer',
            id:'3',
            owner:'hannah',
            date:setDate('02.10.2009'),
            startTime:setTime('15:30'),
            duration:'45',
            paedList:['birgit','rosa'],
            clientList:['emil','pascal','mathias'],
            einrichtung:'loewenzahn']
        activities.id_4 = [title:'Musikstopp',
            id:'4',
            owner:'birgit',
            date:setDate('02.10.2009'),
            startTime:setTime('16:15'),
            duration:'30',
            paedList:['birgit','regina'],
            clientList:['emil','pascal','marianne'],
            einrichtung:'loewenzahn']
        activities.id_5 = [title:'Körperschema',
            id:'5',
            owner:'regina',
            date:setDate('03.10.2009'),
            startTime:setTime('15:30'),
            duration:'30',
            paedList:['birgit','regina'],
            clientList:['emil','pascal','marianne'],
            einrichtung:'loewenzahn']
        activities.id_6 = [title:'Heizdecke',
            id:'6',
            owner:'martin',
            date:setDate('03.10.2009'),
            startTime:setTime('16:00'),
            duration:'30',
            paedList:['birgit','regina'],
            clientList:['emil','pascal','marianne'],
            einrichtung:'loewenzahn']
        activities.id_7 = [title:'Fliegender Pilz',
            id:'7',
            owner:'martin',
            date:setDate('03.10.2009'),
            startTime:setTime('16:30'),
            duration:'15',
            paedList:['birgit','regina'],
            clientList:['emil','pascal','marianne'],
            einrichtung:'loewenzahn']
    }

    def setDate (String sDate) {
        def activityDate = Date.parse("dd.MM.yyyy", sDate).format("dd.MM.yyyy")
        return activityDate
    }

    def setTime (String sTime) {
        def activityTime = Date.parse("HH:mm", sTime).format("HH:mm")
        return activityTime
    }

    def getActivitiesOfOwner(String owner) {
        def activityList = []
        for ( v in activities ) {
            for ( w in v.value.paedList) {
                if (owner == w) {
                    activityList.add(v)
                }
            }
        }
        return activityList
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

