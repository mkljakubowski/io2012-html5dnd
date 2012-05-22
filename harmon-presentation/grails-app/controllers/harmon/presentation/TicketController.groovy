package harmon.presentation

class TicketController {
/*
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [ticketInstanceList: Ticket.list(params), ticketInstanceTotal: Ticket.count()]
    }

    def create = {
        def ticketInstance = new Ticket()
        ticketInstance.properties = params
        return [ticketInstance: ticketInstance]
    }

    def save = {
        def ticketInstance = new Ticket(params)
        if (ticketInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'ticket.label', default: 'Ticket'), ticketInstance.id])}"
            redirect(action: "show", id: ticketInstance.id)
        }
        else {
            render(view: "create", model: [ticketInstance: ticketInstance])
        }
    }

    def show = {
        def ticketInstance = Ticket.get(params.id)
        if (!ticketInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'ticket.label', default: 'Ticket'), params.id])}"
            redirect(action: "list")
        }
        else {
            [ticketInstance: ticketInstance]
        }
    }

    def edit = {
        def ticketInstance = Ticket.get(params.id)
        if (!ticketInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'ticket.label', default: 'Ticket'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [ticketInstance: ticketInstance]
        }
    }

    def update = {
        def ticketInstance = Ticket.get(params.id)
        if (ticketInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (ticketInstance.version > version) {
                    
                    ticketInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'ticket.label', default: 'Ticket')] as Object[], "Another user has updated this Ticket while you were editing")
                    render(view: "edit", model: [ticketInstance: ticketInstance])
                    return
                }
            }
            ticketInstance.properties = params
            if (!ticketInstance.hasErrors() && ticketInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'ticket.label', default: 'Ticket'), ticketInstance.id])}"
                redirect(action: "show", id: ticketInstance.id)
            }
            else {
                render(view: "edit", model: [ticketInstance: ticketInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'ticket.label', default: 'Ticket'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def ticketInstance = Ticket.get(params.id)
        if (ticketInstance) {
            try {
                ticketInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'ticket.label', default: 'Ticket'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'ticket.label', default: 'Ticket'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'ticket.label', default: 'Ticket'), params.id])}"
            redirect(action: "list")
        }
    }
	*/
	def calendar = {
		//[View:View, building:1, year:11/12, lecturer:, week:1, room:1, semester:2, action:calendar, controller:ticket]
		def buildings = Building.list()
		def rooms = Room.list()
		
		if(!params.building){
			rooms = rooms.findAll{ it.building.id == buildings.getAt(0).id }
		}else{
			rooms = rooms.findAll{ it.building.id == params.building.toLong() }
		}
		
		def lecturerid = (params.lecturer)?(params.lecturer.toLong()):(-1)
		def roomid = (params.room)?(params.room.toLong()):(-1)
		def buildingid = (params.building)?(params.building.toLong()):(-1)
		
		def terms = Term.list()
		if(buildingid > 0){
			terms = terms.findAll { term -> term.ticket.room.building.id == buildingid }
		}
		if(roomid > 0){
			terms = terms.findAll { term -> term.ticket.room.id == roomid }
		}
		if(lecturerid > 0){
			terms = terms.findAll { term -> term.ticket.lecturer.id == lecturerid }
		}

		[buildings: buildings, rooms: rooms, lecturers: Lecturer.list(), terms: terms]
	}
	
	def tag = {
		def ticketInstance
		def term
		
		Integer hour = params.minute.toInteger()/60
		Integer minute = params.minute.toInteger()%60
		def date = Date.parse("MM.dd.HH.mm", params.date + "." + hour + "." + minute)
		
		if(params.termid){
			term = Term.get(params.termid)
			term.date = date
			term.save()
			ticketInstance = term.ticket
		}else if(params.ticketid){
			ticketInstance = Ticket.get(params.ticketid)
			term = new Term(ticket: ticketInstance, date: date)
			term.save()
		}

		[ticketInstance: ticketInstance, termInstance: term]
	}
	
	static scaffold = true
}
