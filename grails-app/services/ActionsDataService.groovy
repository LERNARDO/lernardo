class ActionDataService {
    boolean transactional = false
    Map actions = [:]

    ActionDataService () {
        initActions()
    }

    def initActions () {

        actions.id_1 = [name:'Weide mit Hindernissen',
            beschreibung:'''Die Bänke werden in Reihen aufgestellt;
                            es können möglichst viele Bewegungsformen ausprobiert werden''',
            dauer:'60 Minuten',
            sozialform:'Großgruppe',
            materialien:'Hammer, Nagel, Stacheldraht, Nitroglycerin',
            gewichtung:[LL:1,BE:2,PK:3,SI:2,HK:1,TLT:0],
            qualifikationen:'keine',
            anzahlPaedagogen:'1']
    }

    def addAction(String name, Map attrs) {
        actions[name] = attrs
    }

    def getAction (String name){
        return (actions[name])
    }

    // returns all all actions, inluding offset and max number
    def listActions (int noffset, int nmax) {

        def list = []
        int offset = 0
        int count = 0

        for ( v in actions ) {
            if (offset >= noffset && count < nmax) {
                list.add(v)
                count++
            }
            offset++
        }
        return list
    }

    // returns the number of actions
    def totalActions () {
        return actions.size()
    }

}

