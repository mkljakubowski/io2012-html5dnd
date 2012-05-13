package harmon.presentation

class Group {

	static hasMany = [students: Student, ticket: Ticket]
	
	int maxPerson
	String name
	
    static constraints = {
		
    }
	
	static mapping = {
		table 'harmon_group'
	}
	
	String toString(){
		return name
	}

}
