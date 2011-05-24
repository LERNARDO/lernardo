<%@ page import="at.uenterprise.erp.Setup" %>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="layout" content="main"/>
  <g:set var="entityName" value="${message(code: 'setup.label', default: 'Setup')}"/>
  <title><g:message code="default.edit.label" args="[entityName]"/></title>
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
  <h1><g:message code="default.edit.label" args="[entityName]"/></h1>
  <g:if test="${flash.message}">
    <div class="message">${flash.message}</div>
  </g:if>
  <g:hasErrors bean="${setupInstance}">
    <div class="errors">
      <g:renderErrors bean="${setupInstance}" as="list"/>
    </div>
  </g:hasErrors>
  <g:form method="post">
    <g:hiddenField name="id" value="${setupInstance?.id}"/>
    <g:hiddenField name="version" value="${setupInstance?.version}"/>
    <div class="dialog">
      <table>
        <tbody>

        <tr class="prop">
          <td valign="top" class="name">
            <label for="bloodTypes"><g:message code="setup.bloodTypes.label" default="Blood Types"/></label>
          </td>
          <td valign="top" class="value ${hasErrors(bean: setupInstance, field: 'bloodTypes', 'errors')}">

          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <label for="countries"><g:message code="setup.countries.label" default="Countries"/></label>
          </td>
          <td valign="top" class="value ${hasErrors(bean: setupInstance, field: 'countries', 'errors')}">

          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <label for="educations"><g:message code="setup.educations.label" default="Educations"/></label>
          </td>
          <td valign="top" class="value ${hasErrors(bean: setupInstance, field: 'educations', 'errors')}">

          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <label for="employmentStatus"><g:message code="setup.employmentStatus.label"
                                                     default="Employment Status"/></label>
          </td>
          <td valign="top" class="value ${hasErrors(bean: setupInstance, field: 'employmentStatus', 'errors')}">

          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <label for="familyProblems"><g:message code="setup.familyProblems.label" default="Family Problems"/></label>
          </td>
          <td valign="top" class="value ${hasErrors(bean: setupInstance, field: 'familyProblems', 'errors')}">

          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <label for="familyStatus"><g:message code="setup.familyStatus.label" default="Family Status"/></label>
          </td>
          <td valign="top" class="value ${hasErrors(bean: setupInstance, field: 'familyStatus', 'errors')}">

          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <label for="languages"><g:message code="setup.languages.label" default="Languages"/></label>
          </td>
          <td valign="top" class="value ${hasErrors(bean: setupInstance, field: 'languages', 'errors')}">

          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <label for="maritalStatus"><g:message code="setup.maritalStatus.label" default="Marital Status"/></label>
          </td>
          <td valign="top" class="value ${hasErrors(bean: setupInstance, field: 'maritalStatus', 'errors')}">

          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <label for="responsibilities"><g:message code="setup.responsibilities.label"
                                                     default="Responsibilities"/></label>
          </td>
          <td valign="top" class="value ${hasErrors(bean: setupInstance, field: 'responsibilities', 'errors')}">

          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <label for="schoolLevels"><g:message code="setup.schoolLevels.label" default="School Levels"/></label>
          </td>
          <td valign="top" class="value ${hasErrors(bean: setupInstance, field: 'schoolLevels', 'errors')}">

          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <label for="services"><g:message code="setup.services.label" default="Services"/></label>
          </td>
          <td valign="top" class="value ${hasErrors(bean: setupInstance, field: 'services', 'errors')}">

          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <label for="workDescriptions"><g:message code="setup.workDescriptions.label"
                                                     default="Work Descriptions"/></label>
          </td>
          <td valign="top" class="value ${hasErrors(bean: setupInstance, field: 'workDescriptions', 'errors')}">

          </td>
        </tr>

        </tbody>
      </table>
    </div>

    <div class="buttons">
      <span class="button"><g:actionSubmit class="save" action="update"
                                           value="${message(code: 'default.button.update.label', default: 'Update')}"/></span>
      <span class="button"><g:actionSubmit class="delete" action="delete"
                                           value="${message(code: 'default.button.delete.label', default: 'Delete')}"
                                           onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/></span>
    </div>
  </g:form>
</div>
</body>
</html>
