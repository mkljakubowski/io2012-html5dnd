package harmon.presentation

class LecturerController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [lecturerInstanceList: Lecturer.list(params), lecturerInstanceTotal: Lecturer.count()]
    }

    def create = {
        def lecturerInstance = new Lecturer()
        lecturerInstance.properties = params
        return [lecturerInstance: lecturerInstance]
    }

    def save = {
        def lecturerInstance = new Lecturer(params)
        if (lecturerInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'lecturer.label', default: 'Lecturer'), lecturerInstance.id])}"
            redirect(action: "show", id: lecturerInstance.id)
        }
        else {
            render(view: "create", model: [lecturerInstance: lecturerInstance])
        }
    }

    def show = {
        def lecturerInstance = Lecturer.get(params.id)
        if (!lecturerInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'lecturer.label', default: 'Lecturer'), params.id])}"
            redirect(action: "list")
        }
        else {
            [lecturerInstance: lecturerInstance]
        }
    }

    def edit = {
        def lecturerInstance = Lecturer.get(params.id)
        if (!lecturerInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'lecturer.label', default: 'Lecturer'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [lecturerInstance: lecturerInstance]
        }
    }

    def update = {
        def lecturerInstance = Lecturer.get(params.id)
        if (lecturerInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (lecturerInstance.version > version) {
                    
                    lecturerInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'lecturer.label', default: 'Lecturer')] as Object[], "Another user has updated this Lecturer while you were editing")
                    render(view: "edit", model: [lecturerInstance: lecturerInstance])
                    return
                }
            }
            lecturerInstance.properties = params
            if (!lecturerInstance.hasErrors() && lecturerInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'lecturer.label', default: 'Lecturer'), lecturerInstance.id])}"
                redirect(action: "show", id: lecturerInstance.id)
            }
            else {
                render(view: "edit", model: [lecturerInstance: lecturerInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'lecturer.label', default: 'Lecturer'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def lecturerInstance = Lecturer.get(params.id)
        if (lecturerInstance) {
            try {
                lecturerInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'lecturer.label', default: 'Lecturer'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'lecturer.label', default: 'Lecturer'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'lecturer.label', default: 'Lecturer'), params.id])}"
            redirect(action: "list")
        }
    }
}
