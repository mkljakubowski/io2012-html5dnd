package harmon.presentation

class Room {

	static belongsTo = [building: Building]
	static hasMany = [ticket: Ticket]
	
	int maxPerson
	String name
	
    static constraints = {
    }
	
	String toString(){
		return name
	}

}
