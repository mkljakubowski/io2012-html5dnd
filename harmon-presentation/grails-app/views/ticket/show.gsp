
<%@ page import="harmon.presentation.Ticket" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'ticket.label', default: 'Ticket')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.show.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="dialog">
                <table>
                    <tbody>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="ticket.id.label" default="Id" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: ticketInstance, field: "id")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="ticket.group.label" default="Group" /></td>
                            
                            <td valign="top" class="value"><g:link controller="group" action="show" id="${ticketInstance?.group?.id}">${ticketInstance?.group?.encodeAsHTML()}</g:link></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="ticket.lecturer.label" default="Lecturer" /></td>
                            
                            <td valign="top" class="value"><g:link controller="lecturer" action="show" id="${ticketInstance?.lecturer?.id}">${ticketInstance?.lecturer?.encodeAsHTML()}</g:link></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="ticket.length.label" default="Length" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: ticketInstance, field: "length")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="ticket.room.label" default="Room" /></td>
                            
                            <td valign="top" class="value"><g:link controller="room" action="show" id="${ticketInstance?.room?.id}">${ticketInstance?.room?.encodeAsHTML()}</g:link></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="ticket.subject.label" default="Subject" /></td>
                            
                            <td valign="top" class="value"><g:link controller="subject" action="show" id="${ticketInstance?.subject?.id}">${ticketInstance?.subject?.encodeAsHTML()}</g:link></td>
                            
                        </tr>

                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${ticketInstance?.id}" />
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </g:form>
            </div>
        </div>
    </body>
</html>
