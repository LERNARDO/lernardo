<%@ page import="at.uenterprise.erp.Setup" %>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="layout" content="main"/>
  <g:set var="entityName" value="${message(code: 'setup.label', default: 'Setup')}"/>
  <title><g:message code="default.show.label" args="[entityName]"/></title>
</head>

<body>
<div class="nav">
  <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a>
  </span>
  <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label"
                                                                         args="[entityName]"/></g:link></span>
  <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label"
                                                                             args="[entityName]"/></g:link></span>
</div>

<div class="body">
  <h1><g:message code="default.show.label" args="[entityName]"/></h1>
  <g:if test="${flash.message}">
    <div class="message">${flash.message}</div>
  </g:if>
  <div class="dialog">
    <table>
      <tbody>

      <tr class="prop">
        <td valign="top" class="name"><g:message code="setup.id.label" default="Id"/></td>

        <td valign="top" class="value">${fieldValue(bean: setupInstance, field: "id")}</td>

      </tr>

      <tr class="prop">
        <td valign="top" class="name"><g:message code="setup.bloodTypes.label" default="Blood Types"/></td>

        <td valign="top" class="value">${fieldValue(bean: setupInstance, field: "bloodTypes")}</td>

      </tr>

      <tr class="prop">
        <td valign="top" class="name"><g:message code="setup.countries.label" default="Countries"/></td>

        <td valign="top" class="value">${fieldValue(bean: setupInstance, field: "countries")}</td>

      </tr>

      <tr class="prop">
        <td valign="top" class="name"><g:message code="setup.educations.label" default="Educations"/></td>

        <td valign="top" class="value">${fieldValue(bean: setupInstance, field: "educations")}</td>

      </tr>

      <tr class="prop">
        <td valign="top" class="name"><g:message code="setup.employmentStatus.label" default="Employment Status"/></td>

        <td valign="top" class="value">${fieldValue(bean: setupInstance, field: "employmentStatus")}</td>

      </tr>

      <tr class="prop">
        <td valign="top" class="name"><g:message code="setup.familyProblems.label" default="Family Problems"/></td>

        <td valign="top" class="value">${fieldValue(bean: setupInstance, field: "familyProblems")}</td>

      </tr>

      <tr class="prop">
        <td valign="top" class="name"><g:message code="setup.familyStatus.label" default="Family Status"/></td>

        <td valign="top" class="value">${fieldValue(bean: setupInstance, field: "familyStatus")}</td>

      </tr>

      <tr class="prop">
        <td valign="top" class="name"><g:message code="setup.languages.label" default="Languages"/></td>

        <td valign="top" class="value">${fieldValue(bean: setupInstance, field: "languages")}</td>

      </tr>

      <tr class="prop">
        <td valign="top" class="name"><g:message code="setup.maritalStatus.label" default="Marital Status"/></td>

        <td valign="top" class="value">${fieldValue(bean: setupInstance, field: "maritalStatus")}</td>

      </tr>

      <tr class="prop">
        <td valign="top" class="name"><g:message code="setup.responsibilities.label" default="Responsibilities"/></td>

        <td valign="top" class="value">${fieldValue(bean: setupInstance, field: "responsibilities")}</td>

      </tr>

      <tr class="prop">
        <td valign="top" class="name"><g:message code="setup.schoolLevels.label" default="School Levels"/></td>

        <td valign="top" class="value">${fieldValue(bean: setupInstance, field: "schoolLevels")}</td>

      </tr>

      <tr class="prop">
        <td valign="top" class="name"><g:message code="setup.services.label" default="Services"/></td>

        <td valign="top" class="value">${fieldValue(bean: setupInstance, field: "services")}</td>

      </tr>

      <tr class="prop">
        <td valign="top" class="name"><g:message code="setup.workDescriptions.label" default="Work Descriptions"/></td>

        <td valign="top" class="value">${fieldValue(bean: setupInstance, field: "workDescriptions")}</td>

      </tr>

      </tbody>
    </table>
  </div>

  <div class="buttons">
    <g:form>
      <g:hiddenField name="id" value="${setupInstance?.id}"/>
      <span class="button"><g:actionSubmit class="edit" action="edit"
                                           value="${message(code: 'default.button.edit.label', default: 'Edit')}"/></span>
      <span class="button"><g:actionSubmit class="delete" action="delete"
                                           value="${message(code: 'default.button.delete.label', default: 'Delete')}"
                                           onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/></span>
    </g:form>
  </div>
</div>
</body>
</html>
