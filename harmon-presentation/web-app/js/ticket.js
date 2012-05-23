	var tickets = [];
	
	function handleDragStart(e) {
		this.style.opacity = '0.4'; // this / e.target is the source node.
		e.dataTransfer.effectAllowed = 'move';
		e.dataTransfer.setData('text/javascript', JSON.stringify({ "type":"ticket", "ticketid": this.id}));
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
		tickets = $(".ticket[draggable=true]");	
		$.each(tickets, function(index, ticket) {
			ticket.addEventListener('dragstart', handleDragStart, false);
			ticket.addEventListener('dragover', handleDragOver, false);
			ticket.addEventListener('dragend', handleDragEnd, false);
		});
	});
