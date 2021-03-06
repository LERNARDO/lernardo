<head>
  <meta name="layout" content="planning"/>
  <title><g:message code="object.create" args="[message(code: 'groupActivityTemplate')]"/></title>
</head>
<body>
<div class="boxHeader">
  <h1><g:message code="object.create" args="[message(code: 'groupActivityTemplate')]"/></h1>
</div>
<div class="boxContent">

    <g:render template="/templates/errors" model="[bean: group]"/>

    <g:form>

      <table>

        <tr class="prop">
          <td class="name"><g:message code="name"/> <span class="required-indicator">*</span></td>
          <td class="value">
            <g:textField data-counter="50" class="${hasErrors(bean: group, field: 'profile', 'errors')}" required="" size="50" name="fullName" value="${fieldValue(bean: group, field: 'profile').decodeHTML()}"/>
          </td>
        </tr>

        <tr class="prop">
          <td class="name"><g:message code="groupActivityTemplate.profile.realDuration"/> <span class="required-indicator">*</span></td>
          <td class="value">
            <g:textField class="${hasErrors(bean: group, field: 'profile.realDuration', 'errors')}" required="" size="20" name="realDuration" value="${fieldValue(bean: group, field: 'profile.realDuration').decodeHTML()}"/> (<g:message code="minutes"/>)
          </td>
        </tr>

        <tr class="prop">
          <td class="name"><g:message code="status"/></td>
          <td class="value">
            <g:select name="status" from="['done','notDone','notDoneOpen']" value="${group?.profile?.status}" valueMessagePrefix="status"/>
          </td>
        </tr>

        <tr class="prop">
          <td class="name"><g:message code="activityTemplate.ageFrom"/></td>
          <td class="value">
            <g:textField class="${hasErrors(bean:group,field:'profile.ageFrom','errors')}" size="5" name="ageFrom" value="${fieldValue(bean:group,field:'profile.ageFrom').decodeHTML()}"/>
          </td>
        </tr>

        <tr class="prop">
          <td class="name"><g:message code="activityTemplate.ageTo"/></td>
          <td class="value">
            <g:textField class="${hasErrors(bean:group,field:'profile.ageTo','errors')}" size="5" name="ageTo" value="${fieldValue(bean:group,field:'profile.ageTo').decodeHTML()}"/>
          </td>
        </tr>

        <tr class="prop">
          <td class="name"><g:message code="description"/></td>
          <td class="value">
            <ckeditor:editor name="description" height="200px" toolbar="Basic">
              ${fieldValue(bean:group,field:'profile.description').decodeHTML()}
            </ckeditor:editor>
          </td>
        </tr>

        <tr class="prop">
          <td class="name"><g:message code="groupActivityTemplate.profile.educationalObjectiveText"/></td>
          <td class="value">
            <ckeditor:editor name="educationalObjectiveText" height="200px" toolbar="Basic">
              ${fieldValue(bean:group,field:'profile.educationalObjectiveText').decodeHTML()}
            </ckeditor:editor>
          </td>
        </tr>

      </table>

      <div class="buttons cleared">
        <div class="button"><g:actionSubmit class="buttonGreen" action="save" value="${message(code: 'save')}" /></div>
        <div class="button"><g:link class="buttonGray" action="list"><g:message code="cancel"/></g:link></div>
      </div>

    </g:form>

</div>
</body>