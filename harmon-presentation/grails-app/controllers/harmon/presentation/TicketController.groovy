package harmon.presentation

class TicketController {

	/*
	 * display calendar
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
	
	/*
	 * happens when someone drops a lecturer|room|building on a term = update ticket
	 */
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
	
	/*
	 * happens when someone drops a lecturer|room|building on calendar = creates new ticket
	 */
	def dropnew = {
		println new Date()
        def ticketInstance = new Ticket(params)
        ticketInstance.save(flush: true)
		render(view:"tag", model: [ticketInstance])
	}
	
	static scaffold = true
}
