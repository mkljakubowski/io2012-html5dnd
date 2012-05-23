
<%@ page import="harmon.presentation.Lecturer" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
		<link rel="stylesheet" href="${resource(dir:'css',file:'lecturer.css')}">
		<g:javascript library="jquery" plugin="jquery" />
		<g:javascript library="lecturer" />
        <g:set var="entityName" value="${message(code: 'lecturer.label', default: 'Lecturer')}" />
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
                        
                            <g:sortableColumn property="id" title="${message(code: 'lecturer.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="firstname" title="${message(code: 'lecturer.firstname.label', default: 'Firstname')}" />
                        
                            <g:sortableColumn property="surname" title="${message(code: 'lecturer.surname.label', default: 'Surname')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${lecturerInstanceList}" status="i" var="lecturerInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}" draggable="true" id="${lecturerInstance.id}">
                        
                            <td><g:link action="show">${fieldValue(bean: lecturerInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: lecturerInstance, field: "firstname")}</td>
                        
                            <td>${fieldValue(bean: lecturerInstance, field: "surname")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${lecturerInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
