class TimestampTagLib {
    static namespace = 'cu'

    def timestamp ={

        def today = new Date()
        out << "am " + String.format('%tA %<te %<tB %<ty' ,today) + " um " + String.format('%tR' ,today)
    }
}
