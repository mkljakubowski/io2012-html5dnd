
<%@ page import="harmon.presentation.Subject" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <link rel="stylesheet" href="${resource(dir:'css',file:'subject.css')}">
		<g:javascript library="jquery" plugin="jquery" />
		<g:javascript library="subject" />
        <g:set var="entityName" value="${message(code: 'subject.label', default: 'Subject')}" />
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
                        
                            <g:sortableColumn property="id" title="${message(code: 'subject.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="minPerson" title="${message(code: 'subject.minPerson.label', default: 'Min Person')}" />
                        
                            <g:sortableColumn property="name" title="${message(code: 'subject.name.label', default: 'Name')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${subjectInstanceList}" status="i" var="subjectInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}" draggable="true" id="${subjectInstance.id}">
                        
                            <td><g:link action="show">${fieldValue(bean: subjectInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: subjectInstance, field: "minPerson")}</td>
                        
                            <td>${fieldValue(bean: subjectInstance, field: "name")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${subjectInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
