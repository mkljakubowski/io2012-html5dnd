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

	//changes mouse coord to minutes fo day
	function positionToMinute(pos){
		return (pos - 40)*2;
	}
	
	//changes minute of day into coord to place term correctly
	function minuteToPosition(min){
		return min/2 + 20;
	}
	
	//handles mouse move
	function getMousePosition(e){
		mouseX = e.pageX;
		mouseY = e.pageY;
		if(positionMe){				//positions element which had mousey=null
			positionMe.style.top = (e.pageY - 10) + "px";
			positionMe = null;
		}
		if(ajaxreq){				//sends ajaxreq if mousey=null
			ajaxreq.open("GET", ajaxreqstr + positionToMinute(e.pageY), true);
			ajaxreq.send();
			ajaxreq = null;
		}
	};
	
	//sends ajax to get div when ticket dropped
	// day - item to put term into
	// json - data for which to get term
	function getTerm(day, json)
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
			day.innerHTML+=xmlhttp.responseText;
			tic = day.childNodes[day.childNodes.length-1];
		   	tic.style.position="absolute";
			eval("var ticJSON="+tic.getAttribute('data'));
			tic.json = ticJSON;									//assoc json with its object
			tic.style.height = "45px";
		   	if(mouseY){							//if mousey=bull then pass term for positioning
		   		tic.style.top = (mouseY - 10) + "px";
		   	}else{
		   		positionMe = tic;
		   	}		   	
			
			tics = day.childNodes;
			$.each(tics, function(index, tici) {			//add event handlers for this term
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
		};
		
		//send requests if dragging term or ticket
		if(mouseY){
			if(json.termid){
				xmlhttp.open("GET","/harmon-presentation/term/tag?id="+json.termid+"&date="+day.getAttribute('date') + "&minute=" + positionToMinute(mouseY) + "&roomid=" + $("#room").val()  + "&lecturerid=" + $("#lecturer").val() + "&buildingid=" + $("#building").val(), true);
			}else{
				xmlhttp.open("GET","/harmon-presentation/term/tag?ticketid="+json.ticketid+"&date="+obj.getAttribute('date') + "&minute=" + positionToMinute(mouseY) + "&roomid=" + $("#room").val()  + "&lecturerid=" + $("#lecturer").val() + "&buildingid=" + $("#building").val(), true);
			}
			xmlhttp.send();
		}else{
			if(json.termid){
				ajaxreqstr = "/harmon-presentation/term/tag?id="+json.termid+"&date="+day.getAttribute('date') + "&roomid=" + $("#room").val() + "&lecturerid=" + $("#lecturer").val() + "&buildingid=" + $("#building").val() + "&minute=";
			}else{
				ajaxreqstr = "/harmon-presentation/term/tag?ticketid="+json.ticketid+"&date="+day.getAttribute('date') + "&roomid=" + $("#room").val()  + "&lecturerid=" + $("#lecturer").val() + "&buildingid=" + $("#building").val() + "&minute=";
			}
			ajaxreq = xmlhttp;	
		}
	}

	//removes term from db - will need to be used when term is dropped on recycle bin (not yet implemented)
	function removeTerm(id){
		var xmlhttp;
		if (window.XMLHttpRequest){// code for IE7+, Firefox, Chrome, Opera, Safari
			xmlhttp=new XMLHttpRequest();
		}else{// code for IE6, IE5
			xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
		}
		xmlhttp.onreadystatechange=function(){
		};
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
		e.dataTransfer.setData('text/javascript', JSON.stringify(this.json));
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

		// See the section on the DataTransfer object.
		if(e.dataTransfer.getData('text/javascript') != null){
			eval('var data='+e.dataTransfer.getData('text/javascript'));
			if(data != undefined){				//if data was recieved then getterm
				if(data.type == undefined){
					getTerm(this, data);
				}else if(data.type == "ticket"){
					getTerm(this, data);
				}else{
				}
			}else{
				alert("Error: 1571");
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
		this.className = 'tag';

		// See the section on the DataTransfer object.
		if(e.dataTransfer.getData('text/javascript') != null){
			eval('var data='+e.dataTransfer.getData('text/javascript'));
			if(data != undefined){					//if data was recieved after drop on term
				if(data.type == "term"){			//if term then exchange and delete old
					getTerm(this.parentNode, data.id);
					removeTerm(this.id);
					this.parentNode.removeChild(this);
				}else if(data.type == "ticket"){	//if ticket then exchange tickets
					getTicket(this.parentNode, data.id);
				}else if(data.type == "lecturer"){		//otherwise modify term data
					this.json.lecturerid = data.lecturerid;
					requestTicketEdit(this.json, function(str){refreshTickets();});
				}else if(data.type == "group"){
					this.json.groupid = data.groupid;
					requestTicketEdit(this.json, function(str){refreshTickets();});
				}else if(data.type == "room"){
					this.json.roomid = data.roomid;
					requestTicketEdit(this.json, function(str){refreshTickets();});
				}else if(data.type == "subject"){
					this.json.subjectid = data.subjectid;
					requestTicketEdit(this.json, function(str){refreshTickets();});
				}
			}else{
				alert('Error: 1452');
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

	//when building is changed then get rooms for building
	function getRoomPerBuilding(buildingid){
		var xmlhttp;
		if (window.XMLHttpRequest){// code for IE7+, Firefox, Chrome, Opera, Safari
			xmlhttp=new XMLHttpRequest();
		}else{// code for IE6, IE5
			xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
		}
		xmlhttp.onreadystatechange=function(){
			$("#room").html("<option></option>");
			if (xmlhttp.readyState==4 && xmlhttp.status==200){
				$("#room").append(xmlhttp.responseText);
			}
		};
		xmlhttp.open("GET","/harmon-presentation/room/options?buildingid=" + buildingid, true);
		xmlhttp.send();
	}

	function buildingHandleChange(){
		if( $("#building").val() != "" ){
			getRoomPerBuilding($("#building").val());
		}else{
			$("#room").html("<option></option>");
		}
		refreshCalendar();
	}

	function roomHandleChange(){
		refreshCalendar();
	}

	function lecturerHandleChange(){
		refreshCalendar();
	}

	//reloads terms in current calendar
	function refreshTickets(){
		$.each($("div.tag[draggable=true]"), function(index, ticket){
			getTagString(ticket.json, function(str){
				ticket.innerHTML = $(str).html();
			});
		});
	}
	
	//loads new days into calendar
	function dateGroupHandleChange(){
		var calendar = $("div.calendar");
		
		var xmlhttp;
		if (window.XMLHttpRequest){// code for IE7+, Firefox, Chrome, Opera, Safari
			xmlhttp=new XMLHttpRequest();
		}else{// code for IE6, IE5
			xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
		}
		xmlhttp.onreadystatechange=function(){
			if (xmlhttp.readyState==4 && xmlhttp.status==200){
				var data = jQuery.parseJSON(xmlhttp.responseText);
				calendar.html("");
				for(var i=0 ; i < data.length ; i++){
					calendar.append("<div draggable=\"true\" class=\"target\" id=\"" + data[i] + "\" date=\"" + data[i] + "\"></div>");
				}
				refreshCalendar();
			}
		};
		xmlhttp.open("GET","/harmon-presentation/dateGroup/getDays/" + $(this).val(), true);
		xmlhttp.send();
	}
	
	//refreshes handlers for days in calendar
	function refreshCalendar(){
		days = $("div.target[draggable=true]");
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
			$(day).html("<h2>" + day.id + "</h2>");
			getTicketsForDay(day);
		});
	}
	
	//reloads tickets for each day
	function getTicketsForDay(day){
		var buildingid = $("#building").val();
		var lecturerid = $("#lecturer").val();
		var roomid = $("#room").val();

		var xmlhttp;
		if (window.XMLHttpRequest){// code for IE7+, Firefox, Chrome, Opera, Safari
			xmlhttp=new XMLHttpRequest();
		}else{// code for IE6, IE5
			xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
		}
		xmlhttp.onreadystatechange=function(){
			if (xmlhttp.readyState==4 && xmlhttp.status==200){
				$(day).append(xmlhttp.responseText);
				refreshTermPosition();
			}
		};
		xmlhttp.open("GET","/harmon-presentation/term/exactdata?date=" + day.id + "&building=" + buildingid + "&lecturer=" + lecturerid + "&room=" + roomid, true);
		xmlhttp.send();
	}
	
	//positions every loaded term
	function refreshTermPosition(){
		var terms = $("div.tag[draggable=true]");
		$.each(terms, function(index, term) {
			term.addEventListener('mouseover', ticketHandleMouseEnter, false);
			term.addEventListener('mouseout', ticketHandleMouseLeave, false);
			term.addEventListener('drop', ticketHandleDrop, false);
			term.addEventListener('dragleave', ticketHandleDragLeave, false);
			term.addEventListener('dragenter', ticketHandleDragEnter, false);
			term.addEventListener('dragover', ticketHandleDragOver, false);
			term.addEventListener('dragend', ticketHandleDragEnd, false);
			term.addEventListener('dragstart', ticketHandleDragStart, false);
			eval("var ticJSON="+term.getAttribute('data'));
			term.json = ticJSON;
			term.style.position = "absolute";
			term.style.top = minuteToPosition((term.json.hour/100)*60 + term.json.hour%100) + "px";
			term.style.height = "45px";
		});
	}
	
	$(document).ready(function() {
		document.data = {};
		$("#dateGroups").change(dateGroupHandleChange);
		$("#room").change(roomHandleChange);
		$("#lecturer").change(lecturerHandleChange);
		$("#building").change(buildingHandleChange);
		
		$("#dateGroups").change();		//invoke to display days in calendar
	});
