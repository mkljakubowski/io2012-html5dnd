package harmon.presentation

import java.text.SimpleDateFormat

class Term {

	static belongsTo = [ticket: Ticket]
	
	Date date
	
    static constraints = {
    }

	String json(){
		def jsonstr = new String()
		if(ticket.lecturer){
			jsonstr += ", 'lecturerid': '" + ticket.lecturer.id + "'"
		}
		if(ticket.room){
			jsonstr += ", 'roomid': '" + ticket.room.id + "'"
		}
		if(ticket.group){
			jsonstr += ", 'groupid': '" + ticket.group.id + "'"
		}
		if(ticket.subject){
			jsonstr += ", 'subjectid': '" + ticket.subject.id + "'"
		}
		def formatter = new SimpleDateFormat("HHmm");
		
		return "{'termid': '" + id + "', " + "'ticketid': '" + ticket.id + "', " + "'hour': '" + formatter.format(date) + "'" + jsonstr + "}"
	}

}
