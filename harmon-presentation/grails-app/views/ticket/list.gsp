
<%@ page import="harmon.presentation.Ticket" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'ticket.label', default: 'Ticket')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    <g:javascript library="jquery" plugin="jquery" />
        <style>
        	.ticket {
        		#background: #2D7;
        	}
        	.ticket:hover{
        		#background: #7D2;
        	}
        	[draggable] {
			  -moz-user-select: none;
			  -khtml-user-select: none;
			  -webkit-user-select: none;
			  user-select: none;
			}
        </style>
		<script type="text/javascript">
			var tickets = [];
								
			function handleDragStart(e) {
				this.style.opacity = '0.4'; // this / e.target is the source node.
				e.dataTransfer.effectAllowed = 'move';
				e.dataTransfer.setData('text/javascript', JSON.stringify({ "type":"ticket", "id": this.id}));
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
//				this.className = 'over';
			}
		
			function handleDragLeave(e) {
//				this.className = 'hour'; // this / e.target is previous target element.
			}
		
			/*function handleDrop(e) {
				// this / e.target is current target element.
				if (e.stopPropagation) {
					e.stopPropagation(); // stops the browser from redirecting.
				}
				//this.className = 'hour';
				// See the section on the DataTransfer object.
				if(e.dataTransfer.getData('text/html') != null){
					getTicket(this, e.dataTransfer.getData('text/javascript'));
				}
				return false;
			}*/
		
			function handleDragEnd(e) {
				// this/e.target is the source node.
				this.style.opacity = '1.0';
			}
		
			$(document).ready(function() {
				tickets = document.querySelectorAll("td.ticket");	
				$.each(tickets, function(index, ticket) {
					ticket.innerHTML = "";
					ticket.style.position = "relative";
					//hour.style.top = 50 + row * height + "px";
					//hour.style.left = 100 + column * width + "px";
					//ticket.style.height = "31px";
					//ticket.style.width = "31px";
					ticket.addEventListener('dragstart', handleDragStart, false);
					ticket.addEventListener('dragenter', handleDragEnter, false)
					ticket.addEventListener('dragover', handleDragOver, false);
					ticket.addEventListener('dragleave', handleDragLeave, false);
					ticket.addEventListener('drop', handleDrop, false);
					ticket.addEventListener('dragend', handleDragEnd, false);
				});
			});
		</script>
		        
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.list.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                            <g:sortableColumn property="id" title="${message(code: 'ticket.id.label', default: 'Id')}" />
                        
                            <th><g:message code="ticket.group.label" default="Group" /></th>
                        
                            <th><g:message code="ticket.lecturer.label" default="Lecturer" /></th>
                        
                            <g:sortableColumn property="length" title="${message(code: 'ticket.length.label', default: 'Length')}" />
                        
                            <th><g:message code="ticket.room.label" default="Room" /></th>
                        
                            <th><g:message code="ticket.subject.label" default="Subject" /></th>
                            
                            <th>Drag</th>
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${ticketInstanceList}" status="i" var="ticketInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${ticketInstance.id}">${fieldValue(bean: ticketInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: ticketInstance, field: "group")}</td>
                        
                            <td>${fieldValue(bean: ticketInstance, field: "lecturer")}</td>
                        
                            <td>${fieldValue(bean: ticketInstance, field: "length")}</td>
                        
                            <td>${fieldValue(bean: ticketInstance, field: "room")}</td>
                        
                            <td>${fieldValue(bean: ticketInstance, field: "subject")}</td>
                        
                        	<td draggable="true" class="ticket" id="${fieldValue(bean: ticketInstance, field: "id")}"></td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${ticketInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
