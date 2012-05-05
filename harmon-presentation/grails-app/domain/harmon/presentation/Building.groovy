package harmon.presentation

class Building {

	static hasMany = [rooms: Room]
	
	String name
	
    static constraints = {
    }
	
}
