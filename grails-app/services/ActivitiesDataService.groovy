class ActivitiesDataService {
    boolean transactional = false
    Map activities = [:]

    ActivitiesDataService () {
        initActivities()
    }

    def initActivities () {

        activities.id_1 = [actionID:'Weide mit Hindernissen',
            date:'23.09.2009',
            startTime:'11:00',
            duration:'60',
            paedList:['regina','martin'],
            clientList:['emil','pascal','marianne']]
        activities.id_2 = [actionID:'Schmetterlinge',
            date:'24.09.2009',
            startTime:'13:00',
            duration:'30',
            paedList:['rosa','martin'],
            clientList:['emil','patrick','marianne']]
        activities.id_3 = [actionID:'Luftballonmeer',
            date:'25.09.2009',
            startTime:'15:00',
            duration:'45',
            paedList:['birgit','rosa'],
            clientList:['emil','pascal','mathias']]
        activities.id_4 = [actionID:'Musikstopp',
            date:'25.09.2009',
            startTime:'12:00',
            duration:'30',
            paedList:['birgit','regina'],
            clientList:['emil','pascal','marianne']]
    }

    def addActivity(String name, Map attrs) {
        activities[name] = attrs
    }

    def getActivity (String name){
        return (activities[name])
    }

    // returns all all actions, inluding offset and max number
    def listActivities (int noffset, int nmax) {

        def list = []
        int offset = 0
        int count = 0

        for ( v in activities ) {
            if (offset >= noffset && count < nmax) {
                list.add(v)
                count++
            }
            offset++
        }
        return list
    }

    // returns the number of actions
    def totalActivities () {
        return activities.size()
    }

}

