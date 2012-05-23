

<%@ page import="harmon.presentation.Room" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'room.label', default: 'Room')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${roomInstance}">
            <div class="errors">
                <g:renderErrors bean="${roomInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${roomInstance?.id}" />
                <g:hiddenField name="version" value="${roomInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="building"><g:message code="room.building.label" default="Building" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: roomInstance, field: 'building', 'errors')}">
                                    <g:select name="building.id" from="${harmon.presentation.Building.list()}" optionKey="id" value="${roomInstance?.building?.id}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="maxPerson"><g:message code="room.maxPerson.label" default="Max Person" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: roomInstance, field: 'maxPerson', 'errors')}">
                                    <g:textField name="maxPerson" value="${fieldValue(bean: roomInstance, field: 'maxPerson')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="name"><g:message code="room.name.label" default="Name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: roomInstance, field: 'name', 'errors')}">
                                    <g:textField name="name" value="${roomInstance?.name}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="ticket"><g:message code="room.ticket.label" default="Ticket" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: roomInstance, field: 'ticket', 'errors')}">
                                    
<ul>
<g:each in="${roomInstance?.ticket?}" var="t">
    <li><g:link controller="ticket" action="show" id="${t.id}">${t?.encodeAsHTML()}</g:link></li>
</g:each>
</ul>
<g:link controller="ticket" action="create" params="['room.id': roomInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'ticket.label', default: 'Ticket')])}</g:link>

                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
