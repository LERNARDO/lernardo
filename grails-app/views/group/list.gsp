<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code:'group.label', default:'Group')}" />
        <title>${entityName} List</title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${resource(dir:'')}">Home</a></span>
            <span class="menuButton"><g:link class="create" action="create">New ${entityName}</g:link></span>
        </div>
        <div class="body">
            <h1>${entityName} List</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                   	        <g:sortableColumn property="id" title="${message(code:'group.id.label', default:'Id')}" />
                        
                   	        <g:sortableColumn property="description" title="${message(code:'group.description.label', default:'Description')}" />
                        
                   	        <g:sortableColumn property="name" title="${message(code:'group.name.label', default:'Name')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${groupInstanceList}" status="i" var="groupInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${groupInstance.id}">${fieldValue(bean:groupInstance, field:'id')}</g:link></td>
                        
                            <td>${fieldValue(bean:groupInstance, field:'description')}</td>
                        
                            <td>${fieldValue(bean:groupInstance, field:'name')}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${groupInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
