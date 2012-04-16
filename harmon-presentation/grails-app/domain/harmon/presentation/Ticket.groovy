package harmon.presentation

class Ticket {

	static belongsTo = [lecturer:Person, room: Room]
	//Date[] dates
	int minute
		
    static constraints = {
    }
	
	String toString(){
		return lecturer.name + " " + room.name + " " + new Date().format("HH-mm-ss")
	}
}
