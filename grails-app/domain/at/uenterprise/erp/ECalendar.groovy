package at.uenterprise.erp

class ECalendar {

    static hasMany = [calendareds: String]
    List calendareds

    Boolean showThemes = true

    static constraints = {
    }
}
