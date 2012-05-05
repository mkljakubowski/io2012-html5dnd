package harmon.presentation

class Ticket {

	static belongsTo = [term: Term, lecturer: Lecturer, room: Room, group: Group, subject: Subject]
	static transients = ['maxPerson','minPerson']
	
	int length
		
    static constraints = {
    }
	
	String toString(){
		return lecturer.name + " " + room.name + " " + new Date().format("HH-mm-ss")
	}
	
	int getMinPerson(){
		return subject.minPerson
	}

	int getMaxPerson(){
		return room.maxPerson > group.maxPerson ? group.maxPerson : room.maxPerson
	}
}
