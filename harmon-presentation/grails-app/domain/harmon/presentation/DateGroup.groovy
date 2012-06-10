package harmon.presentation

class DateGroup {

	String name
	String datesStr
		
    static constraints = {
    }
	
	def json() {
		def dates = "{\"days\":["
		def separator = ", "
		datesStr.tokenize().each {
			dates +=  "\"" + it + "\"" + separator
		}
		dates = dates.substring(0, dates.size() - separator.size())
		dates+="]}"
	}
	
	String toString(){ name }
	
}
