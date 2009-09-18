class ProfileDataService {
    boolean transactional = false
    Map profiles = [:]


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
            strasse:'Hauptstraße 12']
        profiles.kaumberg = [type:'einrichtung',
            role:'Einrichtung',
            name:'kaumberg',
            fullName:'Hort Kaumberg',
            plz:'2572',
            ort:'Kaumberg',
            strasse:'???']
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
            tel: '0676 / 4303 145']
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
            tel: '-']
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
            tel: '0664 / 3774 559']
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
            tel: '-']
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
            tel: '-']
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
            klasse: '?']
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
            klasse: '?']
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
            ansprechperson: 'Stephanie Pirkfellner']
        profiles.lernardo = [type:'betreiber',
            role:'Betreiber',
            name:'lernardo',
            fullName:'LERNARDO Lernen - Wachsen',
            plz:'2560',
            ort:'Berndorf',
            strasse:'Leobersdorfer Straße 42',
            gemeinnutzigkeit: 'ja',
            ansprechperson: 'Johannes Zeitelberger']
    }

    def addProfile(String name, Map attrs) {
        profiles[name] = attrs
    }

    def getProfile (String name){
        return (profiles[name])
    }

    def listProfiles (String profileType, def nStart, def nMax) {
        // todo: apply filter

        def list = []

        if (profileType == 'all') {
            for ( v in profiles ) {
                list.add(v)
            }
        }
        else {
            for ( v in profiles ) {
                for ( w in v.value.values() ) {
                    if (w == profileType) {
                        list.add(v)
                    }
                }
            }
        }
        return list
        //        def profileCount = 0
        //        for ( v in profiles.values() ) {
        //            for ( w in v.values() ) {
        //                if (w == profileType)
        //                    profileCount++
        //            }
        //        }
        //        return profileCount
    }

}
