
<%@ page import="lernardo.ProjectProfile" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="privat" />
        <g:set var="entityName" value="${message(code:'projectProfile.label', default:'ProjectProfile')}" />
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
            <g:hasErrors bean="${projectProfileInstance}">
            <div class="errors">
                <g:renderErrors bean="${projectProfileInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <input type="hidden" name="id" value="${projectProfileInstance?.id}" />
                <input type="hidden" name="version" value="${projectProfileInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="tagline">
                                    <g:message code="projectProfile.tagline.label" default="Tagline" />
                                  </label>

                                </td>
                                <td valign="top" class="value ${hasErrors(bean:projectProfileInstance,field:'tagline','errors')}">
                                    <input type="text" id="tagline" name="tagline" value="${fieldValue(bean:projectProfileInstance,field:'tagline')}"/>
                                </td>
                            </tr> 
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="fullName">
                                    <g:message code="projectProfile.fullName.label" default="Full Name" />
                                  </label>

                                </td>
                                <td valign="top" class="value ${hasErrors(bean:projectProfileInstance,field:'fullName','errors')}">
                                    <input type="text" maxlength="80" id="fullName" name="fullName" value="${fieldValue(bean:projectProfileInstance,field:'fullName')}"/>
                                </td>
                            </tr> 
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="startDate">
                                    <g:message code="projectProfile.startDate.label" default="Start Date" />
                                  </label>

                                </td>
                                <td valign="top" class="value ${hasErrors(bean:projectProfileInstance,field:'startDate','errors')}">
                                    <g:datePicker name="startDate" value="${projectProfileInstance?.startDate}" precision="minute" />
                                </td>
                            </tr> 
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="endDate">
                                    <g:message code="projectProfile.endDate.label" default="End Date" />
                                  </label>

                                </td>
                                <td valign="top" class="value ${hasErrors(bean:projectProfileInstance,field:'endDate','errors')}">
                                    <g:datePicker name="endDate" value="${projectProfileInstance?.endDate}" precision="minute" />
                                </td>
                            </tr> 
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="projectDays">
                                    <g:message code="projectProfile.projectDays.label" default="Project Days" />
                                  </label>

                                </td>
                                <td valign="top" class="value ${hasErrors(bean:projectProfileInstance,field:'projectDays','errors')}">
                                    <g:select name="projectDays"
from="${lernardo.ProjectDayProfile.list()}"
size="5" multiple="yes" optionKey="id"
value="${projectProfileInstance?.projectDays}" />

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
