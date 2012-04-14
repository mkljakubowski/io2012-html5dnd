package harmon.presentation

class Ticket {

	static hasOne = [lecturer:Person]
	Date[] dates
		
    static constraints = {
    }
}
