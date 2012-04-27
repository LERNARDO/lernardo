<head>
  <meta name="layout" content="planning"/>
  <title><g:message code="object.create" args="[message(code: 'projectTemplate')]"/></title>
</head>
<body>
<div class="boxHeader">
  <h1><g:message code="object.create" args="[message(code: 'projectTemplate')]"/></h1>
</div>
<div class="boxGray">
  <div class="second">

    <g:render template="/templates/errors" model="[bean: projectTemplate]"/>

    <g:form>

      <table>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="name"/></td>
          <td valign="top" class="value">
            <g:textField class="countable50 ${hasErrors(bean: projectTemplate, field: 'profile.fullName', 'errors')}" size="50" maxlength="50" name="fullName" value="${fieldValue(bean: projectTemplate, field: 'profile.fullName').decodeHTML()}"/>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="status"/></td>
          <td valign="top" class="value">
            <g:select name="status" from="['done','notDone','notDoneOpen']" value="${fieldValue(bean: projectTemplate, field: 'profile.status')}" valueMessagePrefix="status"/>
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
            </ckeditor:editor>
          </td>
        </tr>

      </table>

      <div class="buttons">
        <div class="button"><g:actionSubmit class="buttonGreen" action="save" value="${message(code: 'save')}" /></div>
        <div class="button"><g:actionSubmit class="buttonGray" action="list" value="${message(code: 'cancel')}" /></div>
        <div class="clear"></div>
      </div>
      
    </g:form>
  </div>
</div>
</body>
