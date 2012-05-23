	var groups = [];
						
	function handleDragStart(e) {
		this.style.opacity = '0.4'; // this / e.target is the source node.
		e.dataTransfer.effectAllowed = 'move';
		e.dataTransfer.setData('text/javascript', JSON.stringify({ "type":"group", "groupid": this.id}));
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
		groups = $("[draggable=true]");	
		$.each(groups, function(index, group) {
			group.addEventListener('dragstart', handleDragStart, false);
			group.addEventListener('dragover', handleDragOver, false);
			group.addEventListener('dragend', handleDragEnd, false);
		});
	});
