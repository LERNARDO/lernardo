class ProfileDataService {
    boolean transactional = false
    Map profiles = [:]

    ProfileDataService () {
        init()
    }

    def init () {
        initLernardoMitarbeiter()
        initEinrichtungen()
        initPaedagogen()
        initBetreute()
        initBetreiber()
    }

    def initLernardoMitarbeiter() {
        profiles.johannes = [type:'mitarbeiter',
            role:'Lernardo Mitarbeiter',
            name:'johannes',
            title: '-',
            fullName:'Johannes Zeitelberger',
            firstName:'Johannes',
            lastName:'Zeitelberger',
            birthDate:'04.09.1963',
            plz:'2560',
            ort:'Berndorf',
            strasse:'Wankengasse 10',
            mail: 'jlz@lkult.at',
            tel: '0664 / 840 66 20',
            friends:['lernardo':'Betreiber','alpha':'Betreiber','patrizia':'Lernardo Mitarbeiterin','alexander':'Lernardo Mitarbeiter'],
            image:'johannes_zeitelberger.jpg']
        profiles.patrizia = [type:'mitarbeiter',
            role:'Lernardo Mitarbeiter',
            name:'patrizia',
            title: '-',
            fullName:'Patrizia Rosenkranz',
            firstName:'Patrizia',
            lastName:'Rosenkranz',
            birthDate:'20.07.1983',
            plz:'2560',
            ort:'Berndorf',
            strasse:'-',
            mail: 'pcr@lkult.at',
            tel: '0664 / 840 66 27',
            friends:['lernardo':'Betreiber','alpha':'Betreiber','johannes':'Lernardo Mitarbeiter','alexander':'Lernardo Mitarbeiter'],
            image:'patrizia_rosenkranz.jpg']
        profiles.alexander = [type:'mitarbeiter',
            role:'Lernardo Mitarbeiter',
            name:'alexander',
            title: '-',
            fullName:'Alexander Zeillinger',
            firstName:'Alexander',
            lastName:'Zeillinger',
            birthDate:'22.02.1982',
            plz:'2352',
            ort:'Gumpoldskirchen',
            strasse:'Rudolf Tamchina Straße 5/5',
            mail: 'aaz@lkult.at',
            tel: '0664 / 840 66 32',
            friends:['lernardo':'Betreiber','alpha':'Betreiber','patrizia':'Lernardo Mitarbeiterin','johannes':'Lernardo Mitarbeiter'],
            image:'none.jpg']
    }

    def initEinrichtungen () {
        profiles.loewenzahn = [type:'einrichtung',
            role:'Einrichtung',
            name:'loewenzahn',
            fullName:'Hort Löwenzahn',
            plz:'2564',
            ort:'Weissenbach',
            strasse:'Hauptstraße 12',
            friends:['regina':'Pädagogin','martin':'Pädagoge','rosa':'Pädagogin','birgit':'Pädagogin','raphael':'Betreuter','alpha':'Betreiber'],
            image:'loewenzahn.jpg',
            beschreibung:'''Der Hort befindet sich im Ortszentrum, nur wenige Meter von der Volksschule
                            und dem Kindergarten entfernt. Für den Hortbetrieb steht ein Hortgruppenraum
                            mit ca. 62m² und ein Aufenthaltsraum mit mehr als 24 m² sowie eine Garderobe
                            und Toilettenanlagen getrennt für Mädchen und Buben zur Verfügung. Des Weiteren
                            können in Kooperation mit der Gemeinde Schulräumlichkeiten in der örtlichen
                            Volksschule, sowie Räume der Hauptschule und der Volksschulgarten bzw. Spielplatz
                            genutzt werden.<br>
                            Im Hort selbst stehen ein Essbereich, ein Lernbereich, ein Kreativ- und
                            Spielbereich und ein Ruhebereich zur Verfügung.''',
        telefon:'0676 / 880 604 001',
        oeffnungszeiten:'Mo-Fr, 11 bis 18 Uhr',
        ansprechperson:'Martin Golja']
        profiles.kaumberg = [type:'einrichtung',
            role:'Einrichtung',
            name:'kaumberg',
            fullName:'Hort Kaumberg',
            plz:'2572',
            ort:'Kaumberg',
            strasse:'-',
            friends:['hannah':'Pädagogin','emil':'Betreuter','lernardo':'Betreiber','marianne':'Betreute','mathias':'Betreuter','patrick':'Betreuter'],
            image:'hort_kaumberg.jpg',
            beschreibung:'-',
            telefon:'0660 / 461 1106',
            oeffnungszeiten:'-',
            ansprechperson:'Hannah Mutzbauer']
    }

    def initPaedagogen () {
        profiles.regina = [type:'paed',
            role:'Pädagogin',
            name:'regina',
            title: '-',
            fullName:'Regina Toncourt',
            firstName:'Regina',
            lastName:'Toncourt',
            birthDate:'04.11.1962',
            plz:'2565',
            ort:'Neuhaus',
            strasse:'Hirschbahngasse 3',
            mail: 'regina.toncourt@gmx.at',
            tel: '0676 / 4303 145',
            friends:['loewenzahn':'Einrichtung','martin':'Pädagoge','rosa':'Pädagogin','birgit':'Pädagogin','raphael':'Betreuter','alpha':'Betreiber'],
            image:'regina_toncourt.jpg',
            lebenslauf:'''<b>1977 – 1980:</b> Friseur-Perückenmacherlehre, Maskenbildnerkurse, Gesellenprüfung<br>
                          <b>1980 – 1983:</b> während der Ferienzeit Betreuerin beim Wr. Jugendhilfswerk<br>
                          <b>1984 – 1987:</b> Verkäuferin in einem Papierfachgeschäft, halbtags<br>
                          <b>1987 - 1993:</b> Tennisschule „Team Tennis“ (Verkauf, Service, Werbung, Administration, Kinderbetreuung)<br>
                          <b>1993 - 1997:</b> Verein Wr.Jugendzentren – Kinder- und Jugendbetreuung.<br>
                          1jährige Fortbildung: „Soziokulturelle Animation“;<br>
                          laufend Fort- und Weiterbildungen (u.a. sex. Missbrauch, Drogen- und
                          Gewaltprävention, außergerichtlicher Tatausgleich, Konflikt als Chance,
                          Outdoor- und Erlebnispädagogik)<br>
                          <b>1998 - 2001:</b> verlängerte Karenz; Ausbildung bei Dr. Sindelar zur Trainerin bei TLS (Teilleistungsschwächen)<br>
                          <b>2001 – 2004:</b> Karenz, Montessori-Ausbildung bei Claus-Dieter Kaul<br>
                          <b>2005:</b> Montessori-Diplom<br>
                          <b>seit 2005:</b> Tagesmutter und Trainerin bei TLS beim NÖ Hilfswerk''']
        profiles.martin = [type:'paed',
            role:'Pädagoge',
            name:'martin',
            title: 'Mag.',
            fullName:'Martin Golja',
            firstName:'Martin',
            lastName:'Golja',
            birthDate:'31.12.1969',
            plz:'2563',
            ort:'Pottenstein',
            strasse:'Obere Marktfeldstraße 20',
            mail: '-',
            tel: '-',
            friends:['loewenzahn':'Einrichtung','regina':'Pädagogin','rosa':'Pädagogin','birgit':'Pädagogin','raphael':'Betreuter','alpha':'Betreiber'],
            image:'martin_golja.jpg',
            lebenslauf:'''<b>1976-1980</b> Volksschule Pottenstein<br>
                          <b>1980-1988</b> Neusprachlicher Zweig des Bundesrealgymnasiums Berndorf<br>
                          <b>1988</b> Matura<br>
                          <b>1988-1989</b> Präsenzdienst in der Martinekkaserne in Baden<br>
                          <b>1989-2006</b> Übungsleitertätigkeit bei der Union Pottenstein für Kinder und Jugendliche; Altersstufen 3-6, 6-10, 10-15<br>
                          <b>1989</b> Inskription Geographie und Wirtschaftskunde, Germanistik<br>
                          <b>1992</b> Inskription Geographie und Wirtschaftskunde, Leibeserziehung<br>
                          <b>1995</b> Beginn Dienstverhältnis auf der Marktgemeinde Pottenstein<br>
                          <b>1998</b> Ablegung der Prüfungen zum Standesbeamten und Staatsbürgerschaftsevidenzführer<br>
                          <b>1998</b> Inskription von Geographie und Wirtschaftskunde, Psychologie, Pädagogik, Philosophie<br>
                          <b>1998-2001</b> Standesbeamter und Staatsbürgerschaftsevidenzführer am Standesamt Pottenstein<br>
                          <b>1990-2002</b> Mitgesellschafter als staatlich geprüfter Diplomskilehrer in der Skischule St.Anton am Arlberg<br>
                          <b>1997-2002</b> Ausbildnertätigkeit Ski am Universitätssportinstitut Wien<br>
                          <b>2001-2003</b> Skilehrerausbildner beim Wiener Ski- und Snowboardlehrerverband, sowie Snowsportsacademy Holland<br>
                          <b>2002-2003</b> Beschäftigung als Disponent in der Neuwagendisposition Citroen Österreich<br>
                          <b>2003</b> Ablegung der Diplomprüfung an der Universität Wien<br>
                          <b>2004-2005</b> Beschäftigung als Erzieher im Landesjugendheim Pottenstein über den Verein „Jugend und Arbeit“ der NÖ Landesregierung (Lehrerbörse)<br>
                          <b>2005-2006</b> Unterrichtspraktikum am BG/BRG Baden und am BG/BRG Berndorf<br>
                          <b>2005-laufend</b> geschäftsführender Gemeinderat der Marktgemeinde Pottenstein<br>
                          <b>2006-laufend</b> Beschäftigung als Springer in der schulischen Nachmittagsbetreuung beim Verein „Hand in Hand“ des NÖ Familienreferates''']
        profiles.rosa  = [type:'paed',
            role:'Pädagogin',
            name:'rosa',
            title: '-',
            fullName:'Rosa Gober',
            firstName:'Rosa',
            lastName:'Gober',
            birthDate:'16.12.1961',
            plz:'2565',
            ort:'Neuhaus',
            strasse:'Schwarzenseer Straße 19',
            mail: '-',
            tel: '0664 / 3774 559',
            friends:['loewenzahn':'Einrichtung','regina':'Pädagogin','martin':'Pädagoge','birgit':'Pädagogin','raphael':'Betreuter','alpha':'Betreiber'],
            image:'rosa_gober.jpg',
            lebenslauf:'''<b>1977 – 1980:</b> Fa. Laurenz-Hofbauer: Lehre Einzelhandelskaufmann, Gesellenprüfung<br>
                          <b>1980 – 1983:</b> ebendort EH-Kaufmann bis Firmenliquidierung<br>
                          <b>1983 – 1998:</b> Filialleiterin der Fa. L .Schumits & Co GmbH. in Leobersdorf<br>
                          <b>1996 – 2004:</b> Karenz und Hausfrau<br>
                          <b>seit 2004:</b> Fa. L. Schumits & Co GmbH in Pfaffstätten (geringfügig)''']
        profiles.birgit  = [type:'paed',
            role:'Pädagogin',
            name:'birgit',
            title: '-',
            fullName:'Birgit Blaesen',
            firstName:'Birgit',
            lastName:'Blaesen',
            birthDate:'19.03.1970',
            plz:'2560',
            ort:'Hernstein',
            strasse:'Gartengasse 5',
            mail: '-',
            tel: '-',
            friends:['loewenzahn':'Einrichtung','regina':'Pädagogin','martin':'Pädagoge','rosa':'Pädagogin','raphael':'Betreuter','alpha':'Betreiber'],
            image:'birgit_blaesen.jpg',
            lebenslauf:'-']
        profiles.hannah  = [type:'paed',
            role:'Pädagogin',
            name:'hannah',
            title: '-',
            fullName:'Hannah Mutzbauer',
            firstName:'Hannah',
            lastName:'Mutzbauer',
            birthDate:'22.02.1985',
            plz:'2564',
            ort:'Weissenbach an der Triesting',
            strasse:'Hauptstraße 14',
            mail: '-',
            tel: '-',
            friends:['kaumberg':'Einrichtung','emil':'Betreuter','lernardo':'Betreiber'],
            image:'none.jpg',
            lebenslauf:'-']
    }

    def initBetreute () {
        profiles.raphael = [type:'client',
            role:'Betreuter',
            name:'raphael',
            fullName:'Raphael Cucuiet',
            firstName:'Raphael',
            lastName:'Cucuiet',
            birthDate:'05.05.2000',
            plz:'2572',
            ort:'Kaumberg',
            strasse:'Unterer Sonnenhang 20',
            mail: '-',
            tel: '02755-684',
            schule: 'VS Kaumberg',
            klasse: '-',
            friends:['loewenzahn':'Einrichtung','regina':'Pädagogin','rosa':'Pädagogin','birgit':'Pädagogin','pascal':'Betreute'],
            image:'none.jpg',
            allergien:'nein',
            krankheiten:'nein',
            einschraenkungen:'-']
        profiles.emil = [type:'client',
            role:'Betreuter',
            name:'emil',
            fullName:'Emil Horny',
            firstName:'Emil',
            lastName:'Horny',
            birthDate:'-',
            plz:'2572',
            ort:'Kaumberg',
            strasse:'Markt 144',
            mail: '-',
            tel: '0664-4500112',
            schule: 'VS Kaumberg',
            klasse: '-',
            friends:['kaumberg':'Einrichtung','hannah':'Pädagogin','lernardo':'Betreiber','patrick':'Betreute','marianne':'Betreute'],
            image:'emil_horny.jpg',
            allergien:'-',
            krankheiten:'-',
            einschraenkungen:'-']
        profiles.pascal = [type:'client',
            role:'Betreuter',
            name:'pascal',
            fullName:'Pascal Jerabek',
            firstName:'Pascal',
            lastName:'Jerabek',
            birthDate:'08.04.2002',
            plz:'2572',
            ort:'Kaumberg',
            strasse:'Bergsiedlung 27',
            mail: '-',
            tel: '0664-4085422',
            schule: 'VS Kaumberg',
            klasse: '-',
            friends:['loewenzahn':'Einrichtung','regina':'Pädagogin','rosa':'Pädagogin','birgit':'Pädagogin','raphael':'Betreuter'],
            image:'none.jpg',
            allergien:'-',
            krankheiten:'-',
            einschraenkungen:'-']
        profiles.patrick = [type:'client',
            role:'Betreuter',
            name:'patrick',
            fullName:'Patrick Lintner',
            firstName:'Patrick',
            lastName:'Lintner',
            birthDate:'13.06.1999',
            plz:'2572',
            ort:'Kaumberg',
            strasse:'Markt 30',
            mail: '-',
            tel: '0664-4022395',
            schule: 'VS Kaumberg',
            klasse: '-',
            friends:['kaumberg':'Einrichtung','hannah':'Pädagogin','lernardo':'Betreiber','emil':'Betreuter'],
            image:'patrick_lintner.jpg',
            allergien:'nein',
            krankheiten:'nein',
            einschraenkungen:'-']
        profiles.mathias = [type:'client',
            role:'Betreuter',
            name:'mathias',
            fullName:'Mathias Lintner',
            firstName:'Mathias',
            lastName:'Lintner',
            birthDate:'19.12.2000',
            plz:'2572',
            ort:'Kaumberg',
            strasse:'Markt 30',
            mail: '-',
            tel: '0664-4022395',
            schule: 'VS Kaumberg',
            klasse: '-',
            friends:['kaumberg':'Einrichtung','hannah':'Pädagogin','lernardo':'Betreiber','emil':'Betreuter','patrick':'Betreuter'],
            image:'none.jpg',
            allergien:'nein',
            krankheiten:'nein',
            einschraenkungen:'-']
        profiles.marianne = [type:'client',
            role:'Betreute',
            name:'marianne',
            fullName:'Marianne Lintner',
            firstName:'Marianne',
            lastName:'Lintner',
            birthDate:'07.11.2002',
            plz:'2572',
            ort:'Kaumberg',
            strasse:'Markt 30',
            mail: '-',
            tel: '0664-4022395',
            schule: 'VS Kaumberg',
            klasse: '-',
            friends:['kaumberg':'Einrichtung','hannah':'Pädagogin','lernardo':'Betreiber','emil':'Betreuter','patrick':'Betreuter'],
            image:'marianne_lintner.jpg',
            allergien:'nein',
            krankheiten:'nein',
            einschraenkungen:'-']
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
            image:'alpha.jpg']
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
            image:'lernardo.jpg']
    }

    def addProfile(String name, Map attrs) {
        profiles[name] = attrs
    }

    def getProfile (String name) {
        return (profiles[name])
    }

    // returns all profiles which match a certain profile type
    // accepts an offset and max number of profiles
    def getProfiles (String profileType, int noffset, int nmax) {

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
    def getProfileCount (String profileType) {

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
