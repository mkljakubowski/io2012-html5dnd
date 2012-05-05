package harmon.presentation

class Student extends Person{
	
	static belongsTo = [group: Group]

    static constraints = {
    }
	
}
