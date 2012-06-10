package harmon.presentation

class DateGroupController {

	static scaffold = true
	
	def getDays = {		//gets list of days for current group in json
		DateGroup dg = DateGroup.get(params.id)
		render dg.json()
	}
}
