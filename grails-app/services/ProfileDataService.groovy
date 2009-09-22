class ProfileDataService {
    boolean transactional = false
    Map profiles = [:]

    ProfileDataService () {
        initProfiles()
    }

    def initProfiles () {
        initEinrichtungen()
        initPaedagogen()
        initBetreute()
        initBetreiber()
    }

    def initEinrichtungen () {
        profiles.loewenzahn = [type:'einrichtung',
            role:'Einrichtung',
            name:'loewenzahn',
            fullName:'Hort Löwenzahn',
            plz:'2564',
            ort:'Weissenbach',
            strasse:'Hauptstraße 12',
            friends:['regina':'Pädagogin','martin':'Pädagoge','rosa':'Pädagogin','birgit':'Pädagogin','moritz':'Betreuter','alpha':'Betreiber'],
            image:'../images/avatar/loewenzahn.jpg',
            beschreibung:'''Hort Löwenzahn ist die erste Einrichtung die Lernardo anbietet. Auf
            knapp 100m2 stehen den Kindern ...''']
        profiles.kaumberg = [type:'einrichtung',
            role:'Einrichtung',
            name:'kaumberg',
            fullName:'Hort Kaumberg',
            plz:'2572',
            ort:'Kaumberg',
            strasse:'???',
            friends:['hannah':'Pädagogin','sebastian':'Betreuter','lernardo':'Betreiber'],
            image:'../images/avatar/none.jpg',
            beschreibung:'???']
    }

    def initPaedagogen () {
        profiles.regina = [type:'paed',
            role:'Pädagogin',
            name:'regina',
            title: '-',
            firstName:'Regina',
            lastName:'Toncourt',
            birthDate:'04.11.1962',
            plz:'2565',
            ort:'Neuhaus',
            strasse:'Hirschbahngasse 3',
            mail: 'regina.toncourt@gmx.at',
            tel: '0676 / 4303 145',
            friends:['loewenzahn':'Einrichtung','martin':'Pädagoge','rosa':'Pädagogin','birgit':'Pädagogin','moritz':'Betreuter','alpha':'Betreiber'],
            image:'../images/avatar/regina_toncourt.jpg',
            lebenslauf:'?']
        profiles.martin = [type:'paed',
            role:'Pädagoge',
            name:'martin',
            title: 'Mag.',
            firstName:'Martin',
            lastName:'Golja',
            birthDate:'31.12.1969',
            plz:'2563',
            ort:'Pottenstein',
            strasse:'Obere Marktfeldstraße 20',
            mail: '-',
            tel: '-',
            friends:['loewenzahn':'Einrichtung','regina':'Pädagogin','rosa':'Pädagogin','birgit':'Pädagogin','moritz':'Betreuter','alpha':'Betreiber'],
            image:'../images/avatar/martin_golja.jpg',
            lebenslauf:'?']
        profiles.rosa  = [type:'paed',
            role:'Pädagogin',
            name:'rosa',
            title: '-',
            firstName:'Rosa',
            lastName:'Gober',
            birthDate:'16.12.1961',
            plz:'2565',
            ort:'Neuhaus',
            strasse:'Schwarzenseer Straße 19',
            mail: '-',
            tel: '0664 / 3774 559',
            friends:['loewenzahn':'Einrichtung','regina':'Pädagogin','martin':'Pädagoge','birgit':'Pädagogin','moritz':'Betreuter','alpha':'Betreiber'],
            image:'../images/avatar/none.jpg',
            lebenslauf:'?']
        profiles.birgit  = [type:'paed',
            role:'Pädagogin',
            name:'birgit',
            title: '-',
            firstName:'Birgit',
            lastName:'Blaesen',
            birthDate:'19.03.1970',
            plz:'2560',
            ort:'Hernstein',
            strasse:'Gartengasse 5',
            mail: '-',
            tel: '-',
            friends:['loewenzahn':'Einrichtung','regina':'Pädagogin','martin':'Pädagoge','rosa':'Pädagogin','moritz':'Betreuter','alpha':'Betreiber'],
            image:'../images/avatar/none.jpg',
            lebenslauf:'?']
        profiles.hannah  = [type:'paed',
            role:'Pädagogin',
            name:'hannah',
            title: '-',
            firstName:'Hannah',
            lastName:'Mutzbauer',
            birthDate:'22.02.1985',
            plz:'2564',
            ort:'Weissenbach an der Triesting',
            strasse:'Hauptstraße 14',
            mail: '-',
            tel: '-',
            friends:['kaumberg':'Einrichtung','sebastian':'Betreuter','lernardo':'Betreiber'],
            image:'../images/avatar/none.jpg',
            lebenslauf:'?']
    }

    def initBetreute () {
        profiles.moritz = [type:'client',
            role:'Betreuter',
            name:'moritz',
            firstName: 'Moritz',
            lastName:'Bauer',
            birthDate:'?',
            plz:'?',
            ort:'?',
            strasse:'?',
            mail: '?',
            tel: '?',
            schule: '?',
            klasse: '?',
            friends:['loewenzahn':'Einrichtung','regina':'Pädagogin','rosa':'Pädagogin','birgit':'Pädagogin','julia':'Betreute'],
            image:'../images/avatar/none.jpg']
        profiles.sebastian = [type:'client',
            role:'Betreuter',
            name:'sebastian',
            firstName: 'Sebastian',
            lastName:'Cettl',
            birthDate:'?',
            plz:'?',
            ort:'?',
            strasse:'?',
            mail: '?',
            tel: '?',
            schule: '?',
            klasse: '?',
            friends:['kaumberg':'Einrichtung','hannah':'Pädagogin','lernardo':'Betreiber','michelle':'Betreute'],
            image:'../images/avatar/none.jpg']
        profiles.julia = [type:'client',
            role:'Betreute',
            name:'julia',
            firstName: 'Julia',
            lastName:'Drauch',
            birthDate:'?',
            plz:'?',
            ort:'?',
            strasse:'?',
            mail: '?',
            tel: '?',
            schule: '?',
            klasse: '?',
            friends:['loewenzahn':'Einrichtung','regina':'Pädagogin','rosa':'Pädagogin','birgit':'Pädagogin','moritz':'Betreuter'],
            image:'../images/avatar/none.jpg']
        profiles.michelle = [type:'client',
            role:'Betreute',
            name:'michelle',
            firstName: 'Michelle',
            lastName:'Fürlinger',
            birthDate:'?',
            plz:'?',
            ort:'?',
            strasse:'?',
            mail: '?',
            tel: '?',
            schule: '?',
            klasse: '?',
            friends:['kaumberg':'Einrichtung','hannah':'Pädagogin','lernardo':'Betreiber','sebastian':'Betreuter'],
            image:'../images/avatar/none.jpg']
    }

    def initBetreiber () {
        profiles.alpha = [type:'betreiber',
            role:'Betreiber',
            name:'alpha',
            fullName:'Verein Alpha - Frauen für die Zukunft',
            plz:'2563',
            ort:'Pottenstein',
            strasse:'Hainfelderstrasse 29',
            gemeinnutzigkeit: 'ja',
            ansprechperson: 'Stephanie Pirkfellner',
            friends:['loewenzahn':'Einrichtung'],
            image:'../images/avatar/alpha.jpg']
        profiles.lernardo = [type:'betreiber',
            role:'Betreiber',
            name:'lernardo',
            fullName:'LERNARDO Lernen - Wachsen',
            plz:'2560',
            ort:'Berndorf',
            strasse:'Leobersdorfer Straße 42',
            gemeinnutzigkeit: 'ja',
            ansprechperson: 'Johannes Zeitelberger',
            friends:['kaumberg':'Einrichtung'],
            image:'../images/avatar/none.jpg']
    }

    def addProfile(String name, Map attrs) {
        profiles[name] = attrs
    }

    def getProfile (String name){
        return (profiles[name])
    }

    def getProfiles () {
        return profiles
    }

    // returns all profiles which match a certain profile type, inluding offset and max number
    def listProfiles (String profileType, int noffset, int nmax) {

        def list = []
        int offset = 0
        int count = 0

        if (profileType == 'all') {
            for ( v in profiles ) {
                if (offset >= noffset && count < nmax) {
                    list.add(v)
                    count++
                }
                offset++
            }
        }
        else {
            for ( v in profiles ) {
                for ( w in v.value.values() ) {
                    if (w == profileType) {
                        if (offset >= noffset && count < nmax) {
                            list.add(v)
                            count++
                        }
                        offset++
                    }
                }
            }
        }
        return list
    }

    // returns the number of profiles with a certain profile type
    def totalProfiles (String profileType) {

        int count = 0

        if (profileType == 'all') {
            for ( v in profiles ) {
                count++
            }
        }
        else {
            for ( v in profiles ) {
                for ( w in v.value.values() ) {
                    if (w == profileType) {
                        count++
                    }
                }
            }
        }
        return count
    }

}
