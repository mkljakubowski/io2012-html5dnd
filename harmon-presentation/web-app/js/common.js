
function requestTicketEdit(ticket, onexit)		//ticket = { id:1, }       onexit = function(string)
{
	requestTicketTemplate(ticket, onexit, "dropedit?id="+ticket.ticketid+"&");
}

function requestTicketNew(ticket, onexit)		//ticket = { id:1, }       onexit = function(string)
{
	requestTicketTemplate(ticket, onexit, "dropnew?");
}

function requestTicketTemplate(ticket, onexit, type){		//type = destination of the request
	var xmlhttp;
	var reqstr = "";
	if (window.XMLHttpRequest){// code for IE7+, Firefox, Chrome, Opera, Safari
		xmlhttp=new XMLHttpRequest();
	}else{// code for IE6, IE5
		xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
	}
	xmlhttp.onreadystatechange=function(){
	  if (xmlhttp.readyState==4 && xmlhttp.status==200){
		  onexit(xmlhttp.responseText);
	  }
	};
	if(ticket.groupid){
		if(reqstr!=""){ reqstr+="&"; }
		reqstr+="group.id=" + ticket.groupid;
	}
	if(ticket.lecturerid){
		if(reqstr!=""){ reqstr+="&"; }
		reqstr+="lecturer.id=" + ticket.lecturerid; 
	}
	if(ticket.roomid){
		if(reqstr!=""){ reqstr+="&"; }
		reqstr+="room.id=" + ticket.roomid; 
	}
	if(ticket.subjectid){
		if(reqstr!=""){ reqstr+="&"; }
		reqstr+="subject.id=" + ticket.subjectid; 
	}
	xmlhttp.open("GET","/harmon-presentation/ticket/"+type+reqstr, true);
	xmlhttp.send();
}


function getTagString(json, onexit){
	var xmlhttp;
	if (window.XMLHttpRequest){// code for IE7+, Firefox, Chrome, Opera, Safari
		xmlhttp=new XMLHttpRequest();
	}else{// code for IE6, IE5
		xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
	}
	xmlhttp.onreadystatechange=function(){
	  if (xmlhttp.readyState==4 && xmlhttp.status==200){
		  onexit(xmlhttp.responseText);
	  }
	};
	if(json.termid){
		xmlhttp.open("GET","/harmon-presentation/term/simpletag?id="+json.termid, true);
		xmlhttp.send();
	}
}