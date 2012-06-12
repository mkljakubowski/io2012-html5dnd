import harmon.presentation.*

class BootStrap {

    def init = { servletContext ->
		def jan = new Lecturer(firstname: "Jan", surname: "Nowak")
		jan.save()
		
		def gosia = new Lecturer(firstname: "Gosia", surname: "Lis")
		gosia.save()

		def building = new Building(name: "D17")
		building.save()

		def building2 = new Building(name: "C2")
		building2.save()

		def rum = new Room(name: "2.14", maxPerson: 25, building: building)
		rum.save()
		
		def rum2 = new Room(name: "423", maxPerson: 25, building: building2)
		rum2.save()
		
		def rum3 = new Room(name: "108", maxPerson: 100, building: building2)
		rum3.save()
		
		def group = new Group(name: "A1", maxPerson: 25)
		group.save()
		
		def sub = new Subject(name: "Inzynieria Oprogramowania", minPerson: 4)
		sub.save()
		
		def tic = new Ticket(lecturer: jan, room: rum, minute: 90, group: group, subject: sub)
		tic.save()
		
		def mondays = new DateGroup(name: "Poniedzialki", datesStr: "06.04 06.11 06.18 06.25")
		mondays.save()

		def tuesdays = new DateGroup(name: "Wtorki", datesStr: "06.05 06.12 06.19 06.26")
		tuesdays.save()
    }
    def destroy = {
    }
}
