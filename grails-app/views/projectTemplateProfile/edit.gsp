<head>
  <meta name="layout" content="planning"/>
  <title><g:message code="object.edit" args="[message(code: 'projectTemplate')]"/></title>
</head>
<body>
<div class="boxHeader">
  <h1><g:message code="object.edit" args="[message(code: 'projectTemplate')]"/></h1>
</div>
<div class="boxGray">
  <div class="second">

    <g:render template="/templates/errors" model="[bean: projectTemplate]"/>

    <g:form id="${projectTemplate?.id}">

      <table>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="name"/> <span class="required-indicator">*</span></td>
          <td valign="top" class="value">
            <g:textField class="countable${projectTemplate.profile.constraints.fullName.maxSize} ${hasErrors(bean: projectTemplate, field: 'profile.fullName', 'errors')}" required="" size="50" maxlength="50" name="fullName" value="${fieldValue(bean: projectTemplate, field: 'profile.fullName').decodeHTML()}"/>
          </td>
        </tr>

        <erp:accessCheck types="['Betreiber']" creatorof="${projectTemplate}">
        <tr class="prop">
          <td valign="top" class="name"><g:message code="status"/></td>
          <td valign="top" class="value">
            <g:select name="status" from="['done','notDone','notDoneOpen']" value="${fieldValue(bean: projectTemplate, field: 'profile.status')}" valueMessagePrefix="status"/>
          </td>
        </tr>
        </erp:accessCheck>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="description"/></td>
          <td valign="top" class="value">
            <ckeditor:editor name="description" height="200px" toolbar="Basic">
              ${fieldValue(bean:projectTemplate,field:'profile.description').decodeHTML()}
            </ckeditor:editor>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="projectTemplate.profile.educationalObjectiveText"/></td>
          <td valign="top" class="value">
            <ckeditor:editor name="educationalObjectiveText" height="200px" toolbar="Basic">
              ${fieldValue(bean:projectTemplate,field:'profile.educationalObjectiveText').decodeHTML()}
            </ckeditor:editor>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="activityTemplate.ageFrom"/></td>
          <td valign="top" class="value">
            <g:textField class="${hasErrors(bean:projectTemplate,field:'profile.ageFrom','errors')}" size="5" name="ageFrom" value="${fieldValue(bean:projectTemplate,field:'profile.ageFrom').decodeHTML()}"/>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="activityTemplate.ageTo"/></td>
          <td valign="top" class="value">
            <g:textField class="${hasErrors(bean:projectTemplate,field:'profile.ageTo','errors')}" size="5" name="ageTo" value="${fieldValue(bean:projectTemplate,field:'profile.ageTo').decodeHTML()}"/>
          </td>
        </tr>

      </table>

      <div class="buttons">
        <div class="button"><g:actionSubmit class="buttonGreen" action="update" value="${message(code: 'save')}" /></div>
        <div class="button"><g:link class="buttonGray" action="show" id="${projectTemplate.id}"><g:message code="cancel"/></g:link></div>
        <div class="clear"></div>
      </div>

    </g:form>
  </div>
</div>
</body>