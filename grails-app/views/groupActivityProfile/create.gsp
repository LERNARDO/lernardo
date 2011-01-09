<head>
  <meta name="layout" content="private"/>
  <title><g:message code="groupActivity.create"/></title>
</head>
<body>
<div class="boxHeader">
  <div class="second">
    <h1><g:message code="groupActivity.create"/></h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <g:render template="/templates/errors" model="[bean: group]"/>

    <g:form action="save" params="[template: template.id]">
      <div class="dialog">
        <table>
          <tbody>

          %{--<tr class="prop">
            <td height="30" colspan="3" valign="top" class="name">
              <label for="fullName">
                <g:message code="groupActivityTemplate"/>:
              </label>

              <g:link controller="groupActivityTemplateProfile" action="show" id="${template?.id}">${fieldValue(bean: template, field: 'profile.fullName')}</g:link>
            </td>
          </tr>--}%

          <tr class="prop">
            <td valign="top" class="name"><g:message code="groupActivity.profile.name"/></td>
            <td valign="top" class="name"><g:message code="groupActivity.profile.realDuration"/></td>
            <td valign="top" class="name"><g:message code="groupActivity.profile.date"/></td>
          </tr>

          <tr>
            <td width="280px" valign="top" class="value">
              <g:textField class="countable50 ${hasErrors(bean: group, field: 'profile.fullName', 'errors')}" size="40" name="fullName" value="${fieldValue(bean: template, field: 'profile.fullName').decodeHTML()}"/>
            </td>
            <td width="180px" valign="top" class="value">
              <g:textField class="${hasErrors(bean: group, field: 'profile.realDuration', 'errors')}" size="15" name="realDuration" value="${fieldValue(bean: group, field: 'profile.realDuration')}"/> (min)
            </td>
            <td valign="top" class="value">
              <g:textField name="date" class="datetimepicker" value=""/>
              %{--<g:datePicker name="date" value="${group?.profile?.date}" precision="minute"/>--}%
            </td>
          </tr>

          %{--<tr class="prop">
            <td valign="top" class="name">
              <label for="educationalObjective">
                <g:message code="groupActivity.profile.educationalObjective"/>
              </label>
            </td>
            <td colspan="2" valign="top" class="name">
              <label for="educationalObjectiveText">
                <g:message code="groupActivity.profile.educationalObjectiveText"/>
              </label>
            </td>
          </tr>--}%
          %{--<tr class="prop">
            <td valign="top" class="value">
              <g:select from="${['a','b','c']}" class="drop-down-240" id="educationalObjective" name="educationalObjective" value="${fieldValue(bean: group, field: 'profile.educationalObjective').decodeHTML()}"/>
            </td>

            <td colspan="2" valign="top" class="value">
              <g:textArea class="${hasErrors(bean: group, field: 'profile.educationalObjectiveText', 'errors')}" rows="1" cols="80" name="educationalObjectiveText" value="${fieldValue(bean: group, field: 'profile.educationalObjectiveText').decodeHTML()}"/>
            </td>
          </tr>--}%

          </tbody>
        </table>
      </div>
      <p>Errechnete Gesamtdauer: ${calculatedDuration} Minuten</p>
      <div class="buttons">
        <g:submitButton name="submitButton" value="${message(code:'save')}"/>
        <g:link class="buttonGray" action="list"><g:message code="cancel"/></g:link>
        <div class="spacer"></div>
      </div>
    </g:form>
  </div>
</div>
</body>