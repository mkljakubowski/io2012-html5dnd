package harmon.presentation

class Term {

	static hasOne = [ticket: Ticket]
	static hasMany = [dates: Date]
	
    static constraints = {
    }
	
}
