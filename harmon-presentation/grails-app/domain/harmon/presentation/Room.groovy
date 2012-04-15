package harmon.presentation

class Room {

	String name
	static hasMany = [tickets: Ticket]
    static constraints = {
    }
}
