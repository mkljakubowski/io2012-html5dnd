	var rooms = [];
						
	function handleDragStart(e) {
		this.style.opacity = '0.4'; // this / e.target is the source node.
		e.dataTransfer.effectAllowed = 'move';
		e.dataTransfer.setData('text/javascript', JSON.stringify({ "type":"room", "roomid": this.id}));
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
		rooms = $("[draggable=true]");	
		$.each(rooms, function(index, room) {
			room.addEventListener('dragstart', handleDragStart, false);
			room.addEventListener('dragover', handleDragOver, false);
			room.addEventListener('dragend', handleDragEnd, false);
		});
	});
