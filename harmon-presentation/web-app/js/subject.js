	var subjects = [];
						
	function handleDragStart(e) {
		this.style.opacity = '0.4'; // this / e.target is the source node.
		e.dataTransfer.effectAllowed = 'move';
		e.dataTransfer.setData('text/javascript', JSON.stringify({ "type":"subject", "subjectid": this.id}));
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
		subjects = $("[draggable*=true]");	
		$.each(subjects, function(index, subject) {
			subject.addEventListener('dragstart', handleDragStart, false);
			subject.addEventListener('dragover', handleDragOver, false);
			subject.addEventListener('dragend', handleDragEnd, false);
		});
	});
