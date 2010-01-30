
<%@ page import="lernardo.Helper" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code:'helper.label', default:'Helper')}" />
        <title>Show ${entityName}</title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${resource(dir:'')}">Home</a></span>
            <span class="menuButton"><g:link class="list" action="list">${entityName} List</g:link></span>
            <span class="menuButton"><g:link class="create" action="create">New ${entityName}</g:link></span>
        </div>
        <div class="body">
            <h1>Show ${entityName}</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="dialog">
                <table>
                    <tbody>

                    
                        <tr class="prop">
                            <td valign="top" class="name">
                               <g:message code="helper.id.label" default="Id" />:
                            </td>
                            
                            <td valign="top" class="value">${fieldValue(bean:helperInstance, field:'id')}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">
                               <g:message code="helper.title.label" default="Title" />:
                            </td>
                            
                            <td valign="top" class="value">${fieldValue(bean:helperInstance, field:'title')}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">
                               <g:message code="helper.content.label" default="Content" />:
                            </td>
                            
                            <td valign="top" class="value">${fieldValue(bean:helperInstance, field:'content')}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">
                               <g:message code="helper.type.label" default="Type" />:
                            </td>
                            
                            <td valign="top" class="value">${fieldValue(bean:helperInstance, field:'type')}</td>
                            
                        </tr>
                    
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <input type="hidden" name="id" value="${helperInstance?.id}" />
                    <span class="button"><g:actionSubmit class="edit" value="Edit" /></span>
                    <span class="button"><g:actionSubmit class="delete" onclick="return confirm('Are you sure?');" value="Delete" /></span>
                </g:form>
            </div>
        </div>
    </body>
</html>
