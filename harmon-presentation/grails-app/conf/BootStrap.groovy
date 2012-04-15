import harmon.presentation.*;

class BootStrap {

    def init = { servletContext ->
		def jan = new Person(name: "Jan Nowak")
		jan.save()
		
		def rum = new Room(name: "C2 s.214")
		rum.save()
		
		def tic = new Ticket(lecturer: jan, room: rum)
		tic.save()
    }
    def destroy = {
    }
}
