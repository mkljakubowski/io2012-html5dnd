<g:each in="${terms}" status="i" var="termInstance">
	<div class="tag" id="${ termInstance.id }" draggable="true" data="${ termInstance.json() }">
		${termInstance.ticket.label()}
	</div>
</g:each>
