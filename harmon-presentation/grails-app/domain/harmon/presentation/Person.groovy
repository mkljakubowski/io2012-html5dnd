package harmon.presentation

class Person {

	String name
	static hasMany = [tickets:Ticket]
    static constraints = {
    }
	
}
