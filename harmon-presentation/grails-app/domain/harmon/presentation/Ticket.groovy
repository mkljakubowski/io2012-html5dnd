package harmon.presentation

class Ticket {

	static belongsTo = [lecturer: Lecturer, room: Room, group: Group, subject: Subject]
	static hasMany = [term: Term]
	static transients = ['maxPerson','minPerson']
	
	int length
		
    static constraints = {
    }
	
	int getMinPerson(){
		return subject.minPerson
	}

	int getMaxPerson(){
		return room.maxPerson > group.maxPerson ? group.maxPerson : room.maxPerson
	}
	
	String toString(){
		return id
	}

	String label(){
		return subject.name + " " + room.building.name + " " + room.name + " " + lecturer
	}
}
