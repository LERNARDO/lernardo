class TimestampTagLib {
    static namespace = 'cu'

    def timestamp ={

        def today = new Date()
        out << "am " + String.format('%tA %<te %<tB %<tY' ,today) + " um " + String.format('%tR' ,today)
    }
}
