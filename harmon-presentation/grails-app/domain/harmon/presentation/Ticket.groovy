package harmon.presentation

class Ticket {

	static belongsTo = [lecturer: Lecturer, room: Room, group: Group, subject: Subject]
	static hasMany = [term: Term]
	static transients = ['maxPerson','minPerson']
	
	int length
		
    static constraints = {
		lecturer nullable: true
		room nullable: true
		group nullable: true
		subject nullable: true
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
	
	String json(){
		def jsonstr = new String()
		if(lecturer){
			jsonstr += ", 'lecturerid': '" + lecturer.id + "'"
		}
		if(room){
			jsonstr += ", 'roomid': '" + room.id + "'"
		}
		if(group){
			jsonstr += ", 'groupid': '" + group.id + "'"
		}
		if(subject){
			jsonstr += ", 'subjectid': '" + subject.id.toString() + "'"
		}

		return "{'ticketid': '" + id + "'" + jsonstr + "}"
	}
}
