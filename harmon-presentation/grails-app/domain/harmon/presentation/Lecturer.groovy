package harmon.presentation

class Lecturer extends Person{

	static hasMany = [ticket: Ticket]
	
    static constraints = {
    }
	
}
