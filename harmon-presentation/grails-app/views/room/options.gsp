<%--<option></option>--%>
<g:each in="${rooms}" status="i" var="room">
	<option value="${room.id}" ${ i==0?"selected=\"selected\"":"" }>${ room }</option>
</g:each>