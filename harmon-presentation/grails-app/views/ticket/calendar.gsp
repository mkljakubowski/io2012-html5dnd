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
					<tr><td class="caption">Week</td></tr>
					<tr><td class="option">
						<select id="week" name="week" class="formlist">
						</select>
					</td></tr>
					<tr><td class="caption">Year</td></tr>
					<tr><td class="option">
						<select id="year" name="year" class="formlist">
							<option selected="selected" value="11/12">2011/2012</option>
						</select>
					</td></tr>
					<tr><td class="caption">Semester</td></tr>
					<tr><td class="option">
						<select id="semester" name="semester" class="formlist">
							<option value="1">I</option>
							<option value="2" selected="selected">II</option>
						</select>
					</td></tr>
					<tr><td><hr /></td></tr>
					<tr><td class="caption">Building</td></tr>
					<tr><td class="option">
						<select id="building" name="building" class="formlist" onchange="buildingHandleChange()">
							<option></option>
							<g:each in="${buildings}" status="i" var="building">
								<option value="${building.id}" ${ i==0?"selected=\"selected\"":"" }>${ building }</option>
							</g:each>
						</select>
					</td></tr>
					<tr><td class="caption">Room</td></tr>
					<tr><td class="option">
						<select id="room" name="room" class="formlist" onchange="roomHandleChange()">
							<option></option>
							<g:each in="${rooms}" status="i" var="room">
								<option value="${room.id}" ${ i==0?"selected=\"selected\"":"" }>${ room }</option>
							</g:each>
						</select>
					</td></tr>
					<tr><td><hr /></td></tr>
					<tr><td class="caption">Lecturer</td></tr>
					<tr><td class="option">
						<select id="lecturer" name="lecturer" class="formlist" onchange="lecturerHandleChange()">
							<option selected="selected"></option>
							<g:each in="${lecturers}" status="i" var="lecturer">
								<option value="${lecturer.id}">${ lecturer }</option>
							</g:each>
						</select>
					</td></tr>
					<tr><td><hr /></td></tr>
					<tr><td class="option"><g:submitButton name="View" action="calendar"/></td></tr>
					<g:each in="${terms}" status="i" var="term">
						<tr><td>${ term.id }</td></tr>
					</g:each>
				</table>
			</form>
		</div>
		<div class="calendar">
			<div draggable="true" class="target" id="monday" date="28.04"></div>
			<div draggable="true" class="target" id="tuesday" date="29.04"></div>
			<div draggable="true" class="target" id="wednesday" date="30.04"></div>
			<div draggable="true" class="target" id="thursday" date="01.05"></div>
			<div draggable="true" class="target" id="friday" date="02.05"></div>
			<div draggable="true" class="target" id="saturday" date="03.05"></div>
			<div draggable="true" class="target" id="sunday" date="04.05"></div>
		</div>
	</div>
</body>
</html>
