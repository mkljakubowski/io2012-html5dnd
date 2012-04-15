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

.hour {
	background: #EEE;
}

.calendar {
	padding-left: 100px;
	padding-top: 50px;
	padding-bottom: 10px;
}
[draggable] {
  -moz-user-select: none;
  -khtml-user-select: none;
  -webkit-user-select: none;
  user-select: none;
}
</style>
<g:javascript library="jquery" plugin="jquery" />
<script type="text/javascript">
	var hours = [];
	var column = 0;
	var width = 100;
	var height = 40;
	var row = 0;

	function getTicket(obj, id)
		{
		var xmlhttp;
		if (window.XMLHttpRequest)
		  {// code for IE7+, Firefox, Chrome, Opera, Safari
			  xmlhttp=new XMLHttpRequest();
		  }
		else
		  {// code for IE6, IE5
			  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
		  }
		xmlhttp.onreadystatechange=function()
		  {
		  if (xmlhttp.readyState==4 && xmlhttp.status==200)
		    {
		    obj.innerHTML=xmlhttp.responseText;
		    }
		  }
		xmlhttp.open("POST","/harmon-presentation/ticket/tag/"+id,true);
		xmlhttp.send();
	}
	
	function handleDragStart(e) {
		this.style.opacity = '0.4'; // this / e.target is the source node.
		e.dataTransfer.effectAllowed = 'move';
		e.dataTransfer.setData('text/html', this.innerHTML);
	}

	function handleDragOver(e) {
		if (e.preventDefault) {
			e.preventDefault(); // Necessary. Allows us to drop.
		}

		e.dataTransfer.dropEffect = 'move'; // See the section on the DataTransfer object.

		return false;
	}
	function handleDragEnter(e) {
		// this / e.target is the current hover target.
		this.className = 'over';
	}

	function handleDragLeave(e) {
		this.className = 'hour'; // this / e.target is previous target element.
	}

	function handleDrop(e) {
		// this / e.target is current target element.
		if (e.stopPropagation) {
			e.stopPropagation(); // stops the browser from redirecting.
		}
		this.className = 'hour';
		// See the section on the DataTransfer object.
		if(e.dataTransfer.getData('text/html') != null){
			getTicket(this, e.dataTransfer.getData('text/html'));
		}
		return false;
	}

	function handleDragEnd(e) {
		// this/e.target is the source node.
		this.style.opacity = '1.0';
		$.each(hours, function(index, hour) {
			hour.className = 'hour';
		});
	}

	$(document).ready(function() {
		hours = document.querySelectorAll("div.hour");
		$.each(hours, function(index, hour) {
			hour.innerHTML = "";
			hour.style.position = "absolute";
			hour.style.top = 50 + row * height + "px";
			hour.style.left = 100 + column * width + "px";
			hour.style.height = height - 1 + "px";
			hour.style.width = width - 1 + "px";
			column++;
			if (column == 7) {
				column = 0;
				row++;
			}
			hour.addEventListener('dragstart', handleDragStart, false);
			hour.addEventListener('dragenter', handleDragEnter, false)
			hour.addEventListener('dragover', handleDragOver, false);
			hour.addEventListener('dragleave', handleDragLeave, false);
			hour.addEventListener('drop', handleDrop, false);
			hour.addEventListener('dragend', handleDragEnd, false);
		});
	});
</script>
</head>
<body>
	<div class="body">
		<div class="calendar">
			<g:each in="${week}" status="hourno" var="hour">
					<div class="hour" draggable="true" id=""></div>
			</g:each>
		</div>
	</div>
</body>
</html>
