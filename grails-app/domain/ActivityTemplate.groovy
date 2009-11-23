class ActivityTemplate {

  String name
  String attribution
  String description
  Integer duration
  String socialForm
  String materials
  Integer ll
  Integer be
  Integer pk
  Integer si
  Integer hk
  Integer tlt
  String qualifications
  Integer requiredPaeds

  Date dateCreated
  Date lastUpdated

    static constraints = {
      dateCreated(nullable: true)
      lastUpdated(nullable: true)
      description(maxSize:2000)
    }
}
