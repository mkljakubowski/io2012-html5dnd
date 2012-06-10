<!DOCTYPE HTML>

<%@ page import="java.lang.Double" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="layout" content="main" />
<link rel="stylesheet" href="${resource(dir:'css',file:'calendar.css')}">
<g:javascript library="jquery" plugin="jquery" />
<g:javascript library="common" />
<g:javascript library="calendar" />
<g:set var="entityName"
	value="${message(code: 'person.label', default: 'Person')}" />
<title>Calendar</title>
</head>
<body>
	<div class="body">
		<div id="choosecalendar">
			<form method="post">
				<table>
					<tr><td class="caption">Dates</td></tr>
					<tr><td class="option">
						<select id="dateGroups" name="dateGroups" class="formlist">
							<g:each in="${dates}" status="i" var="dateInstance">
								<option value="${dateInstance.id}" ${ i==0?"selected=\"selected\"":"" } ">${ dateInstance }</option>
							</g:each>
						</select>
					</td></tr>
					<tr><td><hr /></td></tr>
					<tr><td class="caption">Building</td></tr>
					<tr><td class="option">
						<select id="building" name="building" class="formlist">
							<option></option>
							<g:each in="${buildings}" status="i" var="building">
								<option value="${building.id}" ${ i==0?"selected=\"selected\"":"" }>${ building }</option>
							</g:each>
						</select>
					</td></tr>
					<tr><td class="caption">Room</td></tr>
					<tr><td class="option">
						<select id="room" name="room" class="formlist">
							<option></option>
							<g:each in="${rooms}" status="i" var="room">
								<option value="${room.id}" ${ i==0?"selected=\"selected\"":"" }>${ room }</option>
							</g:each>
						</select>
					</td></tr>
					<tr><td><hr /></td></tr>
					<tr><td class="caption">Lecturer</td></tr>
					<tr><td class="option">
						<select id="lecturer" name="lecturer" class="formlist">
							<option selected="selected"></option>
							<g:each in="${lecturers}" status="i" var="lecturer">
								<option value="${lecturer.id}">${ lecturer }</option>
							</g:each>
						</select>
					</td></tr>
					<tr><td><hr /></td></tr>
					<tr><td class="option"><g:submitButton name="View" action="calendar"/></td></tr>
				</table>
			</form>
		</div>
		<div class="calendar">
		</div>
	</div>
</body>
</html>
