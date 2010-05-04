package lernardo

class SubTheme {

    static hasMany = [projects: ProjectProfile]

    String name
    Date startDate
    Date endDate
    String description

    static constraints = {
      name (blank: false, size: 2..50)
      description (blank: true, maxSize: 2000)
    }
}
