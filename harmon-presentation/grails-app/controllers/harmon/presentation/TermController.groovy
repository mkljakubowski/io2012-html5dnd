package harmon.presentation

import java.text.SimpleDateFormat

class TermController {

	def remove = {
		if(params.id){
			def term = Term.get(params.id)
			term.delete(flush: true)
		}
	}
	
	def tag = {
		println new Date()
		def ticket
		def term
		
		Integer hour = params.minute.toInteger()/60
		Integer minute = params.minute.toInteger()%60
		def date = Date.parse("MM.dd.HH.mm", params.date + "." + hour + "." + minute)
		
		if(params.id){
			term = Term.get(params.id)
			term.date = date
			term.save()
			ticket = term.ticket
		}else if(params.ticketid){
			ticket = Ticket.get(params.ticketid.toLong())
			term = new Term(ticket: ticket, date: date)
			term.save()
		}

		[ticketInstance: ticket, termInstance: term]
	}
	
	def simpletag = {
		println new Date()
		def term
				
		if(params.id){
			term = Term.get(params.id)
			render (view: "tag", model: [ticketInstance: term.ticket, termInstance: term])
		}
	}
	
	def exactdata = {
		def lecturerid = (params.lecturer)?(params.lecturer.toLong()):(-1)
		def roomid = (params.room)?(params.room.toLong()):(-1)
		def buildingid = (params.building)?(params.building.toLong()):(-1)
		def formatter = new SimpleDateFormat("MM.dd");
		
		def terms = Term.list()
		terms = terms.findAll { term -> formatter.format(term.date) == params.date }
		if(buildingid > 0){
			terms = terms.findAll { term -> term.ticket.room.building.id == buildingid }
		}
		if(roomid > 0){
			terms = terms.findAll { term -> term.ticket.room.id == roomid }
		}
		if(lecturerid > 0){
			terms = terms.findAll { term -> term.ticket.lecturer.id == lecturerid }
		}
		
		[terms: terms]
	}
	
	static scaffold = true
}
