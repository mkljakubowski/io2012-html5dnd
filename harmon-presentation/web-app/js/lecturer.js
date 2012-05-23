	var lecturers = [];
						
	function handleDragStart(e) {
		this.style.opacity = '0.4'; // this / e.target is the source node.
		e.dataTransfer.effectAllowed = 'move';
		e.dataTransfer.setData('text/javascript', JSON.stringify({ "type":"lecturer", "lecturerid": this.id}));
	}

	function handleDragOver(e) {
		if (e.preventDefault) {
			e.preventDefault(); // Necessary. Allows us to drop.
		}

		e.dataTransfer.dropEffect = 'move'; // See the section on the DataTransfer object.

		return false;
	}

	function handleDragEnd(e) {
		// this/e.target is the source node.
		this.style.opacity = '1.0';
	}

	$(document).ready(function() {
		lecturers = $("[draggable=true]");	
		$.each(lecturers, function(index, lecturer) {
			lecturer.addEventListener('dragstart', handleDragStart, false);
			lecturer.addEventListener('dragover', handleDragOver, false);
			lecturer.addEventListener('dragend', handleDragEnd, false);
		});
	});
