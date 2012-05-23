
<%@ page import="harmon.presentation.Room" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
		<link rel="stylesheet" href="${resource(dir:'css',file:'room.css')}">
		<g:javascript library="jquery" plugin="jquery" />
		<g:javascript library="room" />
        <g:set var="entityName" value="${message(code: 'room.label', default: 'Room')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
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
                        
                            <g:sortableColumn property="id" title="${message(code: 'room.id.label', default: 'Id')}" />
                        
                            <th><g:message code="room.building.label" default="Building" /></th>
                        
                            <g:sortableColumn property="maxPerson" title="${message(code: 'room.maxPerson.label', default: 'Max Person')}" />
                        
                            <g:sortableColumn property="name" title="${message(code: 'room.name.label', default: 'Name')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${roomInstanceList}" status="i" var="roomInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}" draggable="true" id="${roomInstance.id}">
                        
                            <td><g:link action="show">${fieldValue(bean: roomInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: roomInstance, field: "building")}</td>
                        
                            <td>${fieldValue(bean: roomInstance, field: "maxPerson")}</td>
                        
                            <td>${fieldValue(bean: roomInstance, field: "name")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${roomInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
