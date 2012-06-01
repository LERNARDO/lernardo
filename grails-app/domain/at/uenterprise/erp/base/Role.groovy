package at.uenterprise.erp.base

class Role {
	static hasMany    = [people: Account]
  static belongsTo  = Account

	String description
	String authority

	static constraints = {
		authority blank: false, unique: true
	}

}
