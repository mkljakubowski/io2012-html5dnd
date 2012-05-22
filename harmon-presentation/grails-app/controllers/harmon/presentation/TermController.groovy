package harmon.presentation

class TermController {

	def remove = {
		if(params.id){
			def term = Term.get(params.id)
			term.delete(flush: true)
		}
	}
	
	static scaffold = true
}
