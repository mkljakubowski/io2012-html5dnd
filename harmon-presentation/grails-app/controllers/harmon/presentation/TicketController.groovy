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
		def rooms = Room.list()
		def buildings = Building.list()
		
		if(!params.building){
			rooms = rooms.findAll{ it.building.id == buildings.getAt(0).id }
		}else{
			rooms = rooms.findAll{ it.building.id == params.building.toLong() }
		}

		[buildings: buildings, rooms: rooms, lecturers: Lecturer.list(), dates: DateGroup.list()]
	}
		
	def dropedit = {
		println new Date()
        def ticketInstance = Ticket.get(params.id.toLong())
        if (ticketInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (ticketInstance.version > version) {
                    return
                }
            }
            ticketInstance.properties = params
            ticketInstance.save(flush: true)
        }
		render("")
	}
	
	def dropnew = {
		println new Date()
        def ticketInstance = new Ticket(params)
        ticketInstance.save(flush: true)
		render(view:"tag", model: [ticketInstance])
	}
	
	static scaffold = true
}
