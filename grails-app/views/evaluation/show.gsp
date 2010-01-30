
<%@ page import="lernardo.Evaluation" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code:'evaluation.label', default:'Evaluation')}" />
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
                               <g:message code="evaluation.id.label" default="Id" />:
                            </td>
                            
                            <td valign="top" class="value">${fieldValue(bean:evaluationInstance, field:'id')}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">
                               <g:message code="evaluation.description.label" default="Description" />:
                            </td>
                            
                            <td valign="top" class="value">${fieldValue(bean:evaluationInstance, field:'description')}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">
                               <g:message code="evaluation.action.label" default="Action" />:
                            </td>
                            
                            <td valign="top" class="value">${fieldValue(bean:evaluationInstance, field:'action')}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">
                               <g:message code="evaluation.writer.label" default="Writer" />:
                            </td>
                            
                            <td valign="top" class="value"><g:link controller="entity" action="show" id="${evaluationInstance?.writer?.id}">${evaluationInstance?.writer?.encodeAsHTML()}</g:link></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">
                               <g:message code="evaluation.dateCreated.label" default="Date Created" />:
                            </td>
                            
                            <td valign="top" class="value">${fieldValue(bean:evaluationInstance, field:'dateCreated')}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">
                               <g:message code="evaluation.lastUpdated.label" default="Last Updated" />:
                            </td>
                            
                            <td valign="top" class="value">${fieldValue(bean:evaluationInstance, field:'lastUpdated')}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">
                               <g:message code="evaluation.owner.label" default="Owner" />:
                            </td>
                            
                            <td valign="top" class="value"><g:link controller="entity" action="show" id="${evaluationInstance?.owner?.id}">${evaluationInstance?.owner?.encodeAsHTML()}</g:link></td>
                            
                        </tr>
                    
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <input type="hidden" name="id" value="${evaluationInstance?.id}" />
                    <span class="button"><g:actionSubmit class="edit" value="Edit" /></span>
                    <span class="button"><g:actionSubmit class="delete" onclick="return confirm('Are you sure?');" value="Delete" /></span>
                </g:form>
            </div>
        </div>
    </body>
</html>
