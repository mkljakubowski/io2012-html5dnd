package harmon.presentation

class RoomController {

	static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

	def index = {
		redirect(action: "list", params: params)
	}

	def list = {
		params.max = Math.min(params.max ? params.int('max') : 10, 100)
		[roomInstanceList: Room.list(params), roomInstanceTotal: Room.count()]
	}

	def create = {
		def roomInstance = new Room()
		roomInstance.properties = params
		return [roomInstance: roomInstance]
	}

	def save = {
		println params
		def roomInstance = new Room(params)
		if (roomInstance.save(flush: true)) {
			flash.message = "${message(code: 'default.created.message', args: [message(code: 'room.label', default: 'Room'), roomInstance.id])}"
			redirect(action: "show", id: roomInstance.id)
		}
		else {
			render(view: "create", model: [roomInstance: roomInstance])
		}
	}

	def show = {
		def roomInstance = Room.get(params.id)
		if (!roomInstance) {
			flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'room.label', default: 'Room'), params.id])}"
			redirect(action: "list")
		}
		else {
			[roomInstance: roomInstance]
		}
	}

	def edit = {
		def roomInstance = Room.get(params.id)
		if (!roomInstance) {
			flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'room.label', default: 'Room'), params.id])}"
			redirect(action: "list")
		}
		else {
			return [roomInstance: roomInstance]
		}
	}

	def update = {
		def roomInstance = Room.get(params.id)
		if (roomInstance) {
			if (params.version) {
				def version = params.version.toLong()
				if (roomInstance.version > version) {
					
					roomInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'room.label', default: 'Room')] as Object[], "Another user has updated this Room while you were editing")
					render(view: "edit", model: [roomInstance: roomInstance])
					return
				}
			}
			roomInstance.properties = params
			if (!roomInstance.hasErrors() && roomInstance.save(flush: true)) {
				flash.message = "${message(code: 'default.updated.message', args: [message(code: 'room.label', default: 'Room'), roomInstance.id])}"
				redirect(action: "show", id: roomInstance.id)
			}
			else {
				render(view: "edit", model: [roomInstance: roomInstance])
			}
		}
		else {
			flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'room.label', default: 'Room'), params.id])}"
			redirect(action: "list")
		}
	}

	def delete = {
		def roomInstance = Room.get(params.id)
		if (roomInstance) {
			try {
				roomInstance.delete(flush: true)
				flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'room.label', default: 'Room'), params.id])}"
				redirect(action: "list")
			}
			catch (org.springframework.dao.DataIntegrityViolationException e) {
				flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'room.label', default: 'Room'), params.id])}"
				redirect(action: "show", id: params.id)
			}
		}
		else {
			flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'room.label', default: 'Room'), params.id])}"
			redirect(action: "list")
		}
	}
	
	def options = {
		def buildingid = params.buildingid.toLong()
		if(buildingid)
			[rooms: Room.list().findAll { it.building.id == buildingid }]
	}

}

