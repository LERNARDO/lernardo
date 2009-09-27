class ArticleDataService {
    boolean transactional = false
    Map articles = [:]

    ArticleDataService () {
        init()
    }

    def init () {

        articles.id_1 = [id:'1',
            title:'Lernardo im Hort Kaumberg',
            teaser:'''Mit Beginn September 2009 erweitert Lernardo aufgrund der hohen Nachfrage und positiven
            Resonanz seine Einrichtungen mit einem neuen Standort in Kaumberg.''',
            content:'''Dank Kaumberg's Bürgermeister Michael Singraber konnte im Sommer 2009 sehr schnell
            passende Räumlichkeiten gefunden werden. Zur Verfügung gestellt wurde ein Klassenraum der Volksschule
            Kaumberg in dem ca. 10 Kinder zwischen 7 und 10 Jahre betreut werden. Der Beginn erfolgt am 07.
            September, als Hortleiterin wird Hannah Mutzbauer eingesetzt, die sich bereits in Hort Löwenzahn
            bewährt hat. Den Kindern stehen neben dem Klassenraum die Wiese sowie die Freizeitanlage der Schule
            zur vollen Verfügung.''',
            author:'Alexander Zeillinger',
            dateCreated:'31. August 2009']
        articles.id_2 = [id:'2',
            title:'Gesund durch Ernährungsexpertin',
            teaser:'''Hort Löwenzahn freut sich über die Unterstützung durch Birgit Blaesen, einer
            Ernährungsexpertin mit langjähriger Erfahrung, die das Pädagogen Team im Hinblick auf die optimale
            und vielseitige Ernährung der Kinder unterstützen wird.''',
            content:'''Birgit Blaesen absolvierte 1997 bis 1998 die makrobiotische Kochschule in Schweden
            und erweiterte ihr Fachwissen in den darauf folgenden Jahren mit der Ausbildung in traditioneller
            chinesischer Medizin. Von 2002 bis 2003 absolvierte sie die Ausbildung zur Ernährungsberaterin in
            der Wiener Schule für TCM. Zu ihren weiteren Kenntnissen gehört Shiatsu, Zen und Naikan und Ashtanga
            Yoga. Zu ihren bisherigen beruflichen Tätigkeiten zählen u.A. die makrobiotische Küchenleitung im
            Technischen Verlag der Uni Graz, die Unternehmensgründung von "Buntes Brot" im Juni 2001,
            Ernährungprojekt "besser essen - besser leben", diverse Tätigkeiten im Shiatsu Bereich, sowie
            Gründung und Leitung eines Gesundheitszentrums in Pottenstein in 2009.''',
            author:'Alexander Zeillinger',
            dateCreated:'31. August 2009']
        articles.id_3 = [id:'3',
            title:'Hort Löwenzahn erhält Auszeichnung',
            teaser:'''Beim 4. jährlichen Kinderbetreuungspreis organisiert vom Bundesministerium für Wirtschaft,
            Familie und Jugend erhielt der Hort "Löwenzahn Weissenbach" den 4. Preis und eine Prämie von
            €500,-.''',
            content:'''Der Ferienhort Löwenzahn wird für die Sommerferien den Kindern in der Region Triestingtal
            und im Speziellen den Kindern der Marktgemeinde Weissenbach angeboten. Es bietet ein
            abwechslungsreiches Programm für 6-13 Jährige: Themen wie woher kommt das Essen; das Wasser lebt;
            Ferien am Pool; das magische Baumhaus; Natur als Klettergarten; Lernen und Spielen werden behandelt
            bzw. erlebt. Lernen und Spielen versteht sich während der letzten beiden Ferienwochen als
            Vorbereitung für das kommende Schuljahr. Bei diesem Ferienhort gibt es sogar einen sogenannten Tag
            der Ruhe, an dem die Kinder selber entscheiden können, was sie machen möchten. Am 31.8 gibt es einen
            Abschlussausflug in den Märchenpark St. Margarethen.''',
            author:'Alexander Zeillinger',
            dateCreated:'31. August 2009']
    }

    def getArticles () {
        return articles
    }

    def getArticle (String tID) {
        for (v in articles) {
            if (v.value.id == tID) {
                return v
            }
        }
    }

}