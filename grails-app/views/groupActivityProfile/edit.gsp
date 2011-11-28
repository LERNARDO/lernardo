<head>
  <meta name="layout" content="planning"/>
  <title><g:message code="object.edit" args="[message(code: 'groupActivity')]"/></title>
</head>
<body>
<div class="boxHeader">
  <div class="second">
    <h1><g:message code="object.edit" args="[message(code: 'groupActivity')]"/></h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <g:render template="/templates/errors" model="[bean: group]"/>

    <g:form id="${group.id}">
      <div>

        <table>

          <tr class="prop">
            <td valign="top" class="name"><g:message code="name"/></td>
            <td valign="top" class="name"><g:message code="groupActivity.profile.realDuration"/></td>
            <td valign="top" class="name"><g:message code="date"/></td>
          </tr>

          <tr>
            <td width="280px" valign="top" class="value">
              <g:textField class="countable${group.profile.constraints.fullName.maxSize} ${hasErrors(bean: group, field: 'profile.fullName', 'errors')}" size="40" name="fullName" value="${fieldValue(bean: group, field: 'profile.fullName')?.decodeHTML()}"/>
            </td>
            <td width="180px" valign="top" class="value">
              <g:textField class="${hasErrors(bean: group, field: 'profile.realDuration', 'errors')}" size="15" name="realDuration" value="${fieldValue(bean: group, field: 'profile.realDuration')}"/> (min)
            </td>
            <td valign="top" class="value">
              <g:textField name="date" class="datetimepicker" value="${formatDate(date: group?.profile?.date, format: 'dd. MM. yyyy HH:mm', timeZone: TimeZone.getTimeZone(grailsApplication.config.timeZone.toString()))}"/>
            </td>
          </tr>

          <tr class="prop">
            <td colspan="3" valign="top" class="name"><g:message code="groupActivity.profile.educationalObjective"/></td>
          </tr>

          <tr class="prop">
            <td colspan="3" valign="top" class="value">
              <g:select class="drop-down-240" from="['succeeded','notSucceeded']" name="educationalObjective" value="${group.profile.educationalObjective}" noSelection="['': message(code: 'none')]" valueMessagePrefix="goal"/>
            </td>
          </tr>

          <tr class="prop">
            <td colspan="3" valign="top" class="name"><g:message code="groupActivity.profile.educationalObjectiveText"/></td>
          </tr>

          <tr class="prop">
            <td colspan="3" valign="top" class="value">
              <ckeditor:editor name="educationalObjectiveText" height="200px" width="800px" toolbar="Basic">
                ${fieldValue(bean:group,field:'profile.educationalObjectiveText').decodeHTML()}
              </ckeditor:editor>
            </td>
          </tr>

          <tr class="prop">
            <td colspan="3" valign="top" class="name"><g:message code="description"/></td>
          </tr>

          <tr class="prop">
            <td colspan="3" valign="top" class="value">
              <ckeditor:editor name="description" height="200px" width="800px" toolbar="Basic">
                ${fieldValue(bean:group,field:'profile.description').decodeHTML()}
              </ckeditor:editor>
            </td>
          </tr>

        </table>

      </div>

      <div class="buttons">
        <div class="button"><g:actionSubmit class="buttonGreen" action="update" value="${message(code: 'save')}" /></div>
        <div class="button"><g:actionSubmit class="buttonGray" action="show" value="${message(code: 'cancel')}" /></div>
        <div class="spacer"></div>
      </div>

    </g:form>
  </div>
</div>
</body>
