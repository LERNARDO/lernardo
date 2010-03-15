<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code:'group.label', default:'Group')}" />
        <title>Edit ${entityName}</title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${resource(dir:'')}">Home</a></span>
            <span class="menuButton"><g:link class="list" action="list">${entityName} List</g:link></span>
            <span class="menuButton"><g:link class="create" action="create">New ${entityName}</g:link></span>
        </div>
        <div class="body">
            <h1>Edit ${entityName}</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${groupInstance}">
            <div class="errors">
                <g:renderErrors bean="${groupInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <input type="hidden" name="id" value="${groupInstance?.id}" />
                <input type="hidden" name="version" value="${groupInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="description">
                                    <g:message code="group.description.label" default="Description" />
                                  </label>

                                </td>
                                <td valign="top" class="value ${hasErrors(bean:groupInstance,field:'description','errors')}">
                                    <textarea rows="5" cols="40" name="description">${fieldValue(bean:groupInstance, field:'description')}</textarea>
                                </td>
                            </tr> 
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="members">
                                    <g:message code="group.members.label" default="Members" />
                                  </label>

                                </td>
                                <td valign="top" class="value ${hasErrors(bean:groupInstance,field:'members','errors')}">
                                    <g:select name="members"
from="${de.uenterprise.ep.Entity.list()}"
size="5" multiple="yes" optionKey="id"
value="${groupInstance?.members}" />

                                </td>
                            </tr> 
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="name">
                                    <g:message code="group.name.label" default="Name" />
                                  </label>

                                </td>
                                <td valign="top" class="value ${hasErrors(bean:groupInstance,field:'name','errors')}">
                                    <input type="text" id="name" name="name" value="${fieldValue(bean:groupInstance,field:'name')}"/>
                                </td>
                            </tr> 
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" value="Update" /></span>
                    <span class="button"><g:actionSubmit class="delete" onclick="return confirm('Are you sure?');" value="Delete" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
