package harmon.presentation

class Person {

	String firstname
	String surname
	
    static constraints = {
    }

	String toString(){
		return surname + " " + firstname
	}

}
