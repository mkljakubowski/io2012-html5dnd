package harmon.presentation

import grails.converters.JSON

class DateGroup {

	String name
	String datesStr
		
    static constraints = {
    }
	
	def json() {
		def map = []
		datesStr.tokenize(';').each { range ->
			def rlist = []
			range.tokenize(',').each { day ->
				rlist += day
			}
			map.add(rlist)
		}
		map as JSON		// output: [["06.04"],["06.11"],["06.18","06.25"]]
	}
	
	String toString(){ name }
	
}
