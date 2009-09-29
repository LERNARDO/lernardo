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
            date:setDate('21.10.2009'),
            startTime:setTime('15:30'),
            duration:'30',
            paedList:['birgit','regina'],
            clientList:['emil','pascal','marianne'],
            einrichtung:'loewenzahn']
        activities.id_6 = [title:'Heizdecke',
            id:'6',
            owner:'martin',
            date:setDate('19.10.2009'),
            startTime:setTime('16:00'),
            duration:'30',
            paedList:['birgit','regina'],
            clientList:['emil','pascal','marianne'],
            einrichtung:'loewenzahn']
        activities.id_7 = [title:'Fliegender Pilz',
            id:'7',
            owner:'martin',
            date:setDate('19.10.2009'),
            startTime:setTime('16:30'),
            duration:'15',
            paedList:['birgit','regina'],
            clientList:['emil','pascal','marianne'],
            einrichtung:'loewenzahn']
         activities.id_8 = [title:'Bewegungslandschaft',
            id:'8',
            owner:'hannah',
            date:setDate('29.10.2009'),
            startTime:setTime('15:30'),
            duration:'90',
            paedList:['birgit','regina'],
            clientList:['emil','pascal','marianne'],
            einrichtung:'kaumberg']
         activities.id_9 = [title:'Schatten',
            id:'9',
            owner:'hannah',
            date:setDate('05.10.2009'),
            startTime:setTime('18:00'),
            duration:'60',
            paedList:['birgit','regina'],
            clientList:['emil','pascal','marianne'],
            einrichtung:'kaumberg']
         activities.id_10 = [title:'Blättertanz',
            id:'10',
            owner:'hannah',
            date:setDate('06.10.2009'),
            startTime:setTime('15:30'),
            duration:'5',
            paedList:['birgit','regina'],
            clientList:['emil','pascal','marianne'],
            einrichtung:'kaumberg']
         activities.id_11 = [title:'Renn- und Schleichrunde',
            id:'11',
            owner:'hannah',
            date:setDate('07.10.2009'),
            startTime:setTime('15:45'),
            duration:'10',
            paedList:['birgit','regina'],
            clientList:['emil','pascal','marianne'],
            einrichtung:'kaumberg']
         activities.id_12 = [title:'Sinnliches Blatt',
            id:'12',
            owner:'hannah',
            date:setDate('07.10.2009'),
            startTime:setTime('16:00'),
            duration:'10',
            paedList:['birgit','regina'],
            clientList:['emil','pascal','marianne'],
            einrichtung:'kaumberg']
         activities.id_13 = [title:'Blatt fällt solo',
            id:'13',
            owner:'hannah',
            date:setDate('08.10.2009'),
            startTime:setTime('15:45'),
            duration:'10',
            paedList:['birgit','regina'],
            clientList:['emil','pascal','marianne'],
            einrichtung:'kaumberg']
         activities.id_14 = [title:'Blatt fällt Gruppe',
            id:'15',
            owner:'hannah',
            date:setDate('09.10.2009'),
            startTime:setTime('16:45'),
            duration:'10',
            paedList:['birgit','regina'],
            clientList:['emil','pascal','marianne'],
            einrichtung:'kaumberg']
         activities.id_15 = [title:'ZeitungsträgerIn',
            id:'15',
            owner:'hannah',
            date:setDate('30.10.2009'),
            startTime:setTime('15:15'),
            duration:'30',
            paedList:['birgit','regina'],
            clientList:['emil','pascal','marianne'],
            einrichtung:'kaumberg']
         activities.id_16 = [title:'Sinnliches Blatt',
            id:'16',
            owner:'hannah',
            date:setDate('28.10.2009'),
            startTime:setTime('15:45'),
            duration:'10',
            paedList:['birgit','regina'],
            clientList:['emil','pascal','marianne'],
            einrichtung:'kaumberg']
         activities.id_17 = [title:'Faltzeitung',
            id:'17',
            owner:'hannah',
            date:setDate('27.10.2009'),
            startTime:setTime('15:15'),
            duration:'15',
            paedList:['birgit','regina'],
            clientList:['emil','pascal','marianne'],
            einrichtung:'kaumberg']
         activities.id_18 = [title:'Spiele mit Zeitungspapier',
            id:'18',
            owner:'hannah',
            date:setDate('12.10.2009'),
            startTime:setTime('15:15'),
            duration:'15',
            paedList:['birgit','regina'],
            clientList:['emil','pascal','marianne'],
            einrichtung:'kaumberg']
         activities.id_19 = [title:'Musikstopp',
            id:'19',
            owner:'hannah',
            date:setDate('13.10.2009'),
            startTime:setTime('16:15'),
            duration:'30',
            paedList:['birgit','regina'],
            clientList:['emil','pascal','marianne'],
            einrichtung:'kaumberg']
         activities.id_20 = [title:'Pizzamassage',
            id:'20',
            owner:'hannah',
            date:setDate('13.10.2009'),
            startTime:setTime('16:45'),
            duration:'15',
            paedList:['birgit','regina'],
            clientList:['emil','pascal','marianne'],
            einrichtung:'kaumberg']
         activities.id_21 = [title:'Ballschaukel',
            id:'21',
            owner:'hannah',
            date:setDate('14.10.2009'),
            startTime:setTime('15:00'),
            duration:'30',
            paedList:['birgit','regina'],
            clientList:['emil','pascal','marianne'],
            einrichtung:'kaumberg']
         activities.id_22 = [title:'Sinnliches Blatt',
            id:'22',
            owner:'hannah',
            date:setDate('15.10.2009'),
            startTime:setTime('16:00'),
            duration:'10',
            paedList:['birgit','regina'],
            clientList:['emil','pascal','marianne'],
            einrichtung:'kaumberg']
         activities.id_23 = [title:'Klopapierturm',
            id:'23',
            owner:'hannah',
            date:setDate('16.10.2009'),
            startTime:setTime('15:15'),
            duration:'15',
            paedList:['birgit','regina'],
            clientList:['emil','pascal','marianne'],
            einrichtung:'kaumberg']
         activities.id_24 = [title:'Körperschema',
            id:'24',
            owner:'hannah',
            date:setDate('23.10.2009'),
            startTime:setTime('16:25'),
            duration:'30',
            paedList:['birgit','regina'],
            clientList:['emil','pascal','marianne'],
            einrichtung:'kaumberg']
         activities.id_25 = [title:'Luftballonmeer',
            id:'25',
            owner:'hannah',
            date:setDate('26.10.2009'),
            startTime:setTime('15:30'),
            duration:'45',
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

