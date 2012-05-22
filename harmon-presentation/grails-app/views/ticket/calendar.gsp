<!DOCTYPE HTML>

<%@ page import="java.lang.Double" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="layout" content="main" />
<g:set var="entityName"
	value="${message(code: 'person.label', default: 'Person')}" />
<title>Calendar</title>
<style>
.over {
	background: #fff url(../images/backgroundplan.png);
}

.overtag {
	background: #aaa;
}

.target {
	background: #EEE;
	display: block;
	background: #fff url(../images/backgroundplan.png);
}

.tag {
	background: #DDD;
	display: block;
}

.calendar {
	padding-left: 100px;
	padding-top: 50px;
	padding-bottom: 10px;
	padding-right: 10px;
	width: 100%;
	height: 100%;
}
table {
	table-layout:fixed;
}
[draggable] {
  -moz-user-select: none;
  -khtml-user-select: none;
  -webkit-user-select: none;
  user-select: none;
}

h2 {
	color: #48802C;
	font-weight: normal;
	font-size: 16px;
	margin: .4em 0 .4em 0;
	text-align: center;
}
</style>
<g:javascript library="jquery" plugin="jquery" />
<script type="text/javascript">
	var hours = [];
	var column = 0;
	var width = 100;
	var height = 40;
	var row = 0;
	var srcObj = null;
	var days = [];
	var mouseX = 0, mouseY = 0;
	var positionMe = null;
	var ajaxreq = null;
	var ajaxreqstr = null;
	
	document.onmousemove = getMousePosition;
	document.onmouseup = getMousePosition;

	function positionToMinute(pos){
		return (pos - 40)*2;
	}
	
	function getMousePosition(e){
		mouseX = e.pageX;
		mouseY = e.pageY;
		if(positionMe){
			positionMe.style.top = (e.pageY - 10) + "px";
			positionMe = null;
		}
		if(ajaxreq){
			ajaxreq.open("GET", ajaxreqstr + positionToMinute(e.pageY), true);
			ajaxreq.send();
			ajaxreq = null;
		}
	};

	function getTicket(obj, id)
	{
		$(document).mousemove();
		var xmlhttp;
		var tic = null;
		var tics = [];
		var sendpos = 0;
		if (window.XMLHttpRequest){// code for IE7+, Firefox, Chrome, Opera, Safari
			xmlhttp=new XMLHttpRequest();
		}else{// code for IE6, IE5
			xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
		}
		xmlhttp.onreadystatechange=function(){
		  if (xmlhttp.readyState==4 && xmlhttp.status==200){
			obj.innerHTML+=xmlhttp.responseText;
			tic = obj.childNodes[obj.childNodes.length-1];
		   	tic.style.position="absolute";
		   	if(mouseY){
		   		tic.style.top = (mouseY - 10) + "px";
		   		sendpos = mouseY - 10;
		   	}else{
		   		positionMe = tic;
		   	}
		   	
			tic.style.height = "90px";
			
			tics = obj.childNodes;
			$.each(tics, function(index, tici) {
				if(tici.className=="tag"){
					tici.addEventListener('mouseover', ticketHandleMouseEnter, false);
					tici.addEventListener('mouseout', ticketHandleMouseLeave, false);
					tici.addEventListener('drop', ticketHandleDrop, false);
					tici.addEventListener('dragleave', ticketHandleDragLeave, false);
					tici.addEventListener('dragenter', ticketHandleDragEnter, false);
					tici.addEventListener('dragover', ticketHandleDragOver, false);
					tici.addEventListener('dragend', ticketHandleDragEnd, false);
					tici.addEventListener('dragstart', ticketHandleDragStart, false);
				}
			});
		  }
		}
		if(mouseY){
			xmlhttp.open("GET","/harmon-presentation/ticket/tag?ticketid="+id+"&date="+obj.getAttribute('date') + "&minute=" + positionToMinute(mouseY), true);
			xmlhttp.send();
		}else{
			ajaxreq = xmlhttp;	
			ajaxreqstr = "/harmon-presentation/ticket/tag?ticketid="+id+"&date="+obj.getAttribute('date') + "&minute=";
		}
	}
	
	function getTerm(obj, id)
	{
		$(document).mousemove();
		var xmlhttp;
		var tic = null;
		var tics = [];
		var sendpos = 0;
		if (window.XMLHttpRequest){// code for IE7+, Firefox, Chrome, Opera, Safari
			xmlhttp=new XMLHttpRequest();
		}else{// code for IE6, IE5
			xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
		}
		xmlhttp.onreadystatechange=function(){
		  if (xmlhttp.readyState==4 && xmlhttp.status==200){
			obj.innerHTML+=xmlhttp.responseText;
			tic = obj.childNodes[obj.childNodes.length-1];
		   	tic.style.position="absolute";
		   	if(mouseY){
		   		tic.style.top = (mouseY - 10) + "px";
		   		sendpos = mouseY - 10;
		   	}else{
		   		positionMe = tic;
		   	}
		   	
			tic.style.height = "90px";
			
			tics = obj.childNodes;
			$.each(tics, function(index, tici) {
				if(tici.className=="tag"){
					tici.addEventListener('mouseover', ticketHandleMouseEnter, false);
					tici.addEventListener('mouseout', ticketHandleMouseLeave, false);
					tici.addEventListener('drop', ticketHandleDrop, false);
					tici.addEventListener('dragleave', ticketHandleDragLeave, false);
					tici.addEventListener('dragenter', ticketHandleDragEnter, false);
					tici.addEventListener('dragover', ticketHandleDragOver, false);
					tici.addEventListener('dragend', ticketHandleDragEnd, false);
					tici.addEventListener('dragstart', ticketHandleDragStart, false);
				}
			});
		  }
		}
		if(mouseY){
			xmlhttp.open("GET","/harmon-presentation/ticket/tag?termid="+id+"&date="+obj.getAttribute('date') + "&minute=" + positionToMinute(mouseY), true);
			xmlhttp.send();
		}else{
			ajaxreq = xmlhttp;	
			ajaxreqstr = "/harmon-presentation/ticket/tag?termid="+id+"&date="+obj.getAttribute('date') + "&minute=";
		}
	}

	function removeTerm(id){
		var xmlhttp;
		if (window.XMLHttpRequest){// code for IE7+, Firefox, Chrome, Opera, Safari
			xmlhttp=new XMLHttpRequest();
		}else{// code for IE6, IE5
			xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
		}
		xmlhttp.onreadystatechange=function(){
		}
		xmlhttp.open("GET","/harmon-presentation/term/remove/" + id, true);
		xmlhttp.send();
	}

	function ticketHandleMouseEnter(e){
		$.each(days, function(index, day) {
			day.setAttribute("draggable", "false");
		});
	}
	
	function ticketHandleMouseLeave(){
		$.each(days, function(index, day) {
			day.setAttribute("draggable", "true");
		});
	}
	
	function ticketHandleDragStart(e) {
		this.style.opacity = '0.4'; // this / e.target is the source node.
		srcObj = this;
		e.dataTransfer.effectAllowed = 'move';
		e.dataTransfer.setData('text/javascript', JSON.stringify({ "type":"term", "id": this.id }));
	}

	function dayHandleDragOver(e) {
		if (e.preventDefault) {
			e.preventDefault(); // Necessary. Allows us to drop.
		}
		e.dataTransfer.dropEffect = 'move'; // See the section on the DataTransfer object.
		return false;
	}

	function ticketHandleDragOver(e) {
		if (e.preventDefault) {
			e.preventDefault(); // Necessary. Allows us to drop.
		}
		e.dataTransfer.dropEffect = 'move'; // See the section on the DataTransfer object.
		this.parentNode.className = 'target';
		return false;
	}

	function dayHandleDragEnter(e) {
		// this / e.target is the current hover target.
		this.className = 'over';
	}

	function ticketHandleDragEnter(e) {
		// this / e.target is the current hover target.
		this.className = 'overtag';
		$.each(days, function(index, day) {
			day.setAttribute("draggable", "false");
		});
		this.parentNode.className = 'target';
	}

	function dayHandleDragLeave(e) {
		this.className = 'target'; // this / e.target is previous target element.
	}

	function ticketHandleDragLeave(e) {
		this.className = 'tag'; // this / e.target is previous target element.
		$.each(days, function(index, day) {
			day.setAttribute("draggable", "true");
		});
	}

	function dayHandleDrop(e) {
		// this / e.target is current target element.
		if (e.stopPropagation) {
			e.stopPropagation(); // stops the browser from redirecting.
		}
		//this.className = 'hour';
		// See the section on the DataTransfer object.
		
		if(e.dataTransfer.getData('text/javascript') != null){
			eval('var data='+e.dataTransfer.getData('text/javascript'));
			if(!isNaN( parseInt( data.id ) )){
				if(data.type == "term"){
					getTerm(this, data.id);
				}else if(data.type == "ticket"){
					getTicket(this, data.id);
				}
			}else{
				getTerm(this, srcObj.id);
				srcObj.parentNode.removeChild(srcObj);
			}
		}
		this.className = 'target';
		return false;
	}

	function ticketHandleDrop(e) {
		// this / e.target is current target element.
		if (e.stopPropagation) {
			e.stopPropagation(); // stops the browser from redirecting.
		}
		//this.className = 'hour';
		// See the section on the DataTransfer object.
		if(e.dataTransfer.getData('text/javascript') != null){
			eval('var data='+e.dataTransfer.getData('text/javascript'));
			if(!isNaN( data.id )){
				if(data.type == "term"){
					//update, for now delete and show dragged term
					getTerm(this.parentNode, data.id);
					removeTerm(this.id);
					this.parentNode.removeChild(this);
				}else if(data.type == "ticket"){
					getTicket(this.parentNode, data.id);
				}
			}else{
				srcObj.innerHTML = this.innerHTML;
				this.innerHTML = e.dataTransfer.getData('text/javascript');
			}
		}
		this.className = 'tag';
		return false;
	}

	function dayHandleDragEnd(e) {
		// this/e.target is the source node.
		this.style.opacity = '1.0';
		$.each(days, function(index, day) {
			day.className = 'target';
		});
	}

	function ticketHandleDragEnd(e) {
		// this/e.target is the source node.
		this.style.opacity = '1.0';
		srcObj = null;
		$.each(days, function(index, day) {
			day.setAttribute("draggable", "true");
		});
		this.parentNode.removeChild(this);
	}

	function getRoomPerBuilding(buildingid){
		var xmlhttp;
		if (window.XMLHttpRequest){// code for IE7+, Firefox, Chrome, Opera, Safari
			xmlhttp=new XMLHttpRequest();
		}else{// code for IE6, IE5
			xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
		}
		xmlhttp.onreadystatechange=function(){
			if (xmlhttp.readyState==4 && xmlhttp.status==200){
				$("#room").html(xmlhttp.responseText);
			}
		}
		xmlhttp.open("GET","/harmon-presentation/room/options?buildingid=" + buildingid, true);
		xmlhttp.send();
	}

	function buildingHandleChange(){
		if( $("#building").val() != "" ){
			getRoomPerBuilding($("#building").val());
		}else{
			$("#room").html("<option></option>");
		}
	}

	function roomHandleChange(){
	}

	function lecturerHandleChange(){
	}
	
	$(document).ready(function() {
		days = document.querySelectorAll("div.target");
		var weekno = 1;
		$.each(days, function(index, day) {
			day.style.position = "absolute";
			day.style.top = "10px";
			day.style.left = 100 + index*151 + "px";
			day.style.width = "150px";
			day.style.height = "750px";
			day.addEventListener('drop', dayHandleDrop, false);
			day.addEventListener('dragleave', dayHandleDragLeave, false);
			day.addEventListener('dragenter', dayHandleDragEnter, false);
			day.addEventListener('dragover', dayHandleDragOver, false);
			day.addEventListener('dragend', dayHandleDragEnd, false);
			day.innerHTML += "<h2></h2>";
			day.childNodes[0].innerHTML = day.id;
		});
		for(weekno = 1; weekno < 16 ; weekno++){
			$("#week").append("<option value=" + weekno + ">" + weekno + "</option>");
		}
		$("#week").append("<option value=\"all\">1 - 15</option>");
	});

</script>
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
