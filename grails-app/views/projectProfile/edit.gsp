<head>
  <meta name="layout" content="planning"/>
  <title><g:message code="object.edit" args="[message(code: 'project')]"/></title>
</head>
<body>
<div class="boxHeader">
  <h1><g:message code="object.edit" args="[message(code: 'project')]"/></h1>
</div>
<div class="boxGray">

  <g:render template="/templates/errors" model="[bean: project]"/>

  <g:form id="${project.id}">

    <table>

      <tr class="prop">
        <td valign="top" class="name"><g:message code="name"/> <span class="required-indicator">*</span></td>
        <td valign="top" class="value">
          <g:textField data-counter="50" class="${hasErrors(bean: project, field: 'profile.fullName', 'errors')}" required="" size="50" maxlength="80" name="fullName" value="${fieldValue(bean: project, field: 'profile.fullName').decodeHTML()}"/>
        </td>
      </tr>

      <tr class="prop">
        <td valign="top" class="name"><g:message code="description"/></td>
        <td valign="top" class="value">
          <ckeditor:editor name="description" height="200px" toolbar="Basic">
            ${fieldValue(bean:project,field:'profile.description').decodeHTML()}
          </ckeditor:editor>
        </td>
      </tr>

      <tr class="prop">
        <td valign="top" class="name"><g:message code="project.profile.educationalObjective"/></td>
        <td valign="top" class="value">
          <g:select from="['succeeded','notSucceeded']" name="educationalObjective" value="${project.profile.educationalObjective}" noSelection="['': message(code: 'none')]" valueMessagePrefix="goal"/>
        </td>
      </tr>

      <tr class="prop">
        <td valign="top" class="name"><g:message code="project.profile.educationalObjectiveText"/></td>
        <td valign="top" class="value">
          <ckeditor:editor name="educationalObjectiveText" height="200px" toolbar="Basic">
            ${fieldValue(bean:project,field:'profile.educationalObjectiveText').decodeHTML()}
          </ckeditor:editor>
        </td>
      </tr>

    </table>

    <div class="buttons">
      <div class="button"><g:actionSubmit class="buttonGreen" action="update" value="${message(code: 'save')}" /></div>
      <div class="button"><g:link class="buttonGray" action="show" id="${project.id}"><g:message code="cancel"/></g:link></div>
      <div class="clear"></div>
    </div>

  </g:form>
</div>
</body>
