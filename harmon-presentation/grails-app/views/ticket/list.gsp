
<%@ page import="harmon.presentation.Ticket" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <link rel="stylesheet" href="${resource(dir:'css',file:'ticket.css')}">
		<g:javascript library="jquery" plugin="jquery" />
		<g:javascript library="ticket" />
        <g:set var="entityName" value="${message(code: 'ticket.label', default: 'Ticket')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
		<script type="text/javascript">
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
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${ticketInstanceList}" status="i" var="ticketInstance">
                        <tr class="ticket" draggable="true" id="${fieldValue(bean: ticketInstance, field: "id")}">
                        
                            <td><g:link action="show" id="${ticketInstance.id}">${fieldValue(bean: ticketInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: ticketInstance, field: "group")}</td>
                        
                            <td>${fieldValue(bean: ticketInstance, field: "lecturer")}</td>
                        
                            <td>${fieldValue(bean: ticketInstance, field: "length")}</td>
                        
                            <td>${fieldValue(bean: ticketInstance, field: "room")}</td>
                        
                            <td>${fieldValue(bean: ticketInstance, field: "subject")}</td>
                        
                        </tr>
                    </g:each>
                        <tr class="" draggable="true">
                        	<td colspan="6">Drop content here to create new ticket</td>
                        </tr>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${ticketInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
