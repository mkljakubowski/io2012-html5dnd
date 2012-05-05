package harmon.presentation

class Subject {

	static hasMany = [ticket: Ticket]
	
	int minPerson
	String name
	
    static constraints = {
    }
	
}
