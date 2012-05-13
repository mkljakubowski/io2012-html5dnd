import harmon.presentation.*

class BootStrap {

    def init = { servletContext ->
		def jan = new Lecturer(firstname: "Jan", surname: "Nowak")
		jan.save()
		
		def building = new Building(name: "D17")
		building.save()
		
		def rum = new Room(name: "2.14", maxPerson: 25, building: building)
		rum.save()
		
		def group = new Group(name: "A1", maxPerson: 25)
		group.save()
		
		def sub = new Subject(name: "Inzynieria Oprogramowania", minPerson: 4)
		sub.save()
		
		def tic = new Ticket(lecturer: jan, room: rum, minute: 90, group: group, subject: sub)
		tic.save()
    }
    def destroy = {
    }
}
