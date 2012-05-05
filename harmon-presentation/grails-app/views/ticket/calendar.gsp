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
	background: #AAA;
}

.target {
	background: #EEE;
	display: block;
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

th {
	width: 120px;
}

th:first-child, td:first-child{
	width: 50px;
	text-align:center;
	font-weight: bold;
}
td {
	overflow: hidden; 
	word-wrap: break-word; 
	width: 120px;
	height: 40px;
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
	
	document.onmousemove = getMousePosition;
	document.onmouseup = getMousePosition;
	
	function getMousePosition(e){
	      mouseX = e.pageX;
	      mouseY = e.pageY;
	      if(positionMe){
	      	positionMe.style.top = (e.pageY - 10) + "px";
	      	positionMe = null;
	      }
	};

	function getTicket(obj, id)
		{
		$(document).mousemove();
		var xmlhttp;
		var tic = null;
		var tics = [];
		if (window.XMLHttpRequest){// code for IE7+, Firefox, Chrome, Opera, Safari
			xmlhttp=new XMLHttpRequest();
		}else{// code for IE6, IE5
			xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
		}
		xmlhttp.onreadystatechange=function(){
		  if (xmlhttp.readyState==4 && xmlhttp.status==200){
		   	var counter = 0;
			obj.innerHTML+=xmlhttp.responseText;
			tic = obj.childNodes[obj.childNodes.length-1];
		   	tic.style.position="absolute";
		   	if(mouseY){
		   		tic.style.top = (mouseY - 10) + "px";
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
		xmlhttp.open("POST","/harmon-presentation/ticket/tag/"+id,true);
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
		e.dataTransfer.setData('text/html', this.innerHTML);
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
		this.className = 'over';
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
		if(e.dataTransfer.getData('text/html') != null){
			if(!isNaN( parseInt( e.dataTransfer.getData('text/html') ) )){
				getTicket(this, e.dataTransfer.getData('text/html'));
			}else{
				getTicket(this, srcObj.id);
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
		if(e.dataTransfer.getData('text/html') != null){
			if(!isNaN( parseInt( e.dataTransfer.getData('text/html') ) )){
				getTicket(this.parentNode, e.dataTransfer.getData('text/html'));
				this.parentNode.removeChild(this);
			}else{
				srcObj.innerHTML = this.innerHTML;
				this.innerHTML = e.dataTransfer.getData('text/html');
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
	}

	$(document).ready(function() {
		days = document.querySelectorAll("div.target");
		$.each(days, function(index, day) {
			day.style.position = "absolute";
			day.style.top = "10px";
			day.style.left = 100 + index*150 + "px";
			day.style.width = "149px";
			day.style.height = "720px";
			day.addEventListener('drop', dayHandleDrop, false);
			day.addEventListener('dragleave', dayHandleDragLeave, false);
			day.addEventListener('dragenter', dayHandleDragEnter, false);
			day.addEventListener('dragover', dayHandleDragOver, false);
			day.addEventListener('dragend', dayHandleDragEnd, false);
			day.innerHTML += "<h2></h2>";
			day.childNodes[0].innerHTML = day.id;
		});
	});

</script>
</head>
<body>
	<div class="body">
		<div class="calendar">
			<div draggable="true" class="target" id="monday"></div>
			<div draggable="true" class="target" id="tuesday"></div>
			<div draggable="true" class="target" id="wednesday"></div>
			<div draggable="true" class="target" id="thursday"></div>
			<div draggable="true" class="target" id="friday"></div>
			<div draggable="true" class="target" id="saturday"></div>
			<div draggable="true" class="target" id="sunday"></div>
		</div>
	</div>
</body>
</html>
