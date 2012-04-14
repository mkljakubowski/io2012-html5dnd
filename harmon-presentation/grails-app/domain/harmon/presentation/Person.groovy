package harmon.presentation

class Person {

	String name
	static belongsTo = [ticket:Ticket]
    static constraints = {
    }
}
