package harmon.presentation

import harmon.presentation.Room;

class RoomController {

	def options = {
		def buildingid = params.buildingid.toLong()
		if(buildingid)
			[rooms: Room.list().findAll { it.building.id == buildingid }]
	}
	
	static scaffold = true
}
