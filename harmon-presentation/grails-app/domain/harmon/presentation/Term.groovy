package harmon.presentation

class Term {

	static belongsTo = [ticket: Ticket]
	
	Date date
	
    static constraints = {
    }
	
}
