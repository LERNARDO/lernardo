package at.uenterprise.erp

import at.openfactory.ep.Entity

/**
 * This class represents the evaluations that can be created for clients
 *
 * @author  Alexander Zeillinger
 */
class Evaluation {

  static belongsTo = [owner: Entity]

  String  title
  String  description
  String  method
  Entity  writer
  Entity  linkedTo
  Date    dateCreated
  Date    lastUpdated

  static constraints = {
    title      nullable: true, blank: false, maxSize: 100
    description blank: false, maxSize: 2000
    method      blank: true, maxSize: 2000
    linkedTo    nullable: true
  }

}
