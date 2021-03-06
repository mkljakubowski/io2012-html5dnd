package harmon.presentation

import java.text.SimpleDateFormat

class TermController {

	def remove = {
		if(params.id){
			def term = Term.get(params.id)
			term.delete(flush: true)
		}
	}

	/*
	 * happens after user drops a ticket or term on calendar
	 * modifies object and return html.div object filled with data to display on page
	 * params: [tickeid|id, roomid, minute(in day), date(list od days), lecturerid]
	 */
	def tag = {
		println "tag: " + new Date()
		def ticket
		def term

		Integer hour = params.minute.toLong()/60
		Integer minute = params.minute.toLong()%60


		if(params.id){
			term = Term.get(params.id)
			params.ticketid = term.ticket.id.toString()
			term.delete()
		}
		if(params.ticketid){
			params.date.tokenize(',').each{ separate_date ->
				def date = Date.parse("MM.dd.HH.mm", separate_date + "." + hour + "." + minute)
				ticket = Ticket.get(params.ticketid.toLong())
				if(params.roomid != ""){
					if(params.roomid.toLong() != ticket.room.id){
						def ticketb = Ticket.list().find{ it.lecturer == ticket.lecturer && it.room.id == params.roomid.toLong() && it.group == ticket.group && it.subject == ticket.subject }
						if(ticketb == null){
							ticketb = new Ticket()
							ticketb.lecturer = ticket.lecturer
							ticketb.group = ticket.group
							ticketb.room = Room.get(params.roomid)
							ticketb.subject = ticket.subject
							ticketb.save()
							ticket = ticketb
						}else{
							ticket = ticketb
						}
					}
				}
				if(params.lecturerid != ""){
					if(params.lecturerid.toLong() != ticket.lecturer.id){
						def ticketb = Ticket.list().find{ it.lecturer.id == params.lecturerid.toLong() && it.room == ticket.room && it.group == ticket.group && it.subject == ticket.subject }
						if(ticketb == null){
							ticketb = new Ticket()
							ticketb.lecturer = Lecturer.get(params.lecturerid)
							ticketb.group = ticket.group
							ticketb.room = ticket.room
							ticketb.subject = ticket.subject
							ticketb.save()
							ticket = ticketb
						}else{
							ticket = ticketb
						}
					}
				}
				term = new Term(ticket: ticket, date: date)
				term.save()
			}
		}

		[ticketInstance: ticket, termInstance: term]
	}

	
	/*
	 * gets html.div for term id
	 */
	def simpletag = {
		println new Date()
		def term

		if(params.id){
			term = Term.get(params.id)
			render (view: "tag", model: [ticketInstance: term.ticket, termInstance: term])
		}
	}

	/*
	 * gets list if html.divs for supplied data
	 * params;[lectuerid, roomid, buildingid]
	 */
	def exactdata = {
		def lecturerid = (params.lecturer)?(params.lecturer.toLong()):(-1)
		def roomid = (params.room)?(params.room.toLong()):(-1)
		def buildingid = (params.building)?(params.building.toLong()):(-1)
		def formatter = new SimpleDateFormat("MM.dd");

		def terms = Term.list()
		terms = terms.findAll { term ->
			params.date.tokenize(',').find{	formatter.format(term.date) == it }
		}
		if(buildingid > 0){
			terms = terms.findAll { term -> term.ticket.room.building.id == buildingid }
		}
		if(roomid > 0){
			terms = terms.findAll { term -> term.ticket.room.id == roomid }
		}
		if(lecturerid > 0){
			terms = terms.findAll { term -> term.ticket.lecturer.id == lecturerid }
		}
		formatter = new SimpleDateFormat("HHmm");
		terms = terms.unique{a,b -> (formatter.format(a.date) == formatter.format(b.date))?0:1}
		[terms: terms]
	}

	static scaffold = true
}
