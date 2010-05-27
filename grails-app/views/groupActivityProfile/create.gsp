<head>
  <meta name="layout" content="private"/>
  <title>Aktivitätsgruppe anlegen</title>
</head>
<body>
<div class="headerBlue">
  <div class="second">
    <h1>Aktivitätsgruppe anlegen</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <g:hasErrors bean="${group}">
      <div class="errors">
        <g:renderErrors bean="${group}" as="list"/>
      </div>
    </g:hasErrors>

    <g:form action="save" method="post" params="[template: template.id]">
      <div class="dialog">
        <table>
          <tbody>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="fullName">
                <g:message code="groupActivityTemplate"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:link controller="groupActivityTemplateProfile" action="show" id="${template.id}">${template.profile.fullName}</g:link>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="fullName">
                <g:message code="groupActivity.profile.name"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: group, field: 'profile.fullName', 'errors')}" id="fullName" name="fullName" value="${fieldValue(bean: group, field: 'profile.fullName')}"/>
            </td>
          </tr>

%{--          <tr class="prop">
            <td valign="top" class="name">
              <label for="educationalObjective">
                <g:message code="groupActivityProfile.educationalObjective.label" default="Educational Objective"/>
              </label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: group, field: 'educationalObjective', 'errors')}">
              <input type="text" id="educationalObjective" name="educationalObjective" value="${fieldValue(bean: group, field: 'educationalObjective')}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="educationalObjectiveText">
                <g:message code="groupActivity.profile.educationalObjectiveText"/>
              </label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: group, field: 'educationalObjectiveText', 'errors')}">
              <textarea rows="5" cols="40" name="educationalObjectiveText">${fieldValue(bean: group, field: 'educationalObjectiveText')}</textarea>
            </td>
          </tr>--}%

          <tr class="prop">
            <td valign="top" class="name">
              <label for="realDuration">
                <g:message code="groupActivity.profile.realDuration"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: group, field: 'profile.realDuration', 'errors')}" size="10" id="realDuration" name="realDuration" value="${fieldValue(bean: group, field: 'profile.realDuration')}"/> (min)
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="date">
                <g:message code="groupActivity.profile.date"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:datePicker name="date" value="${group?.profile?.date}" precision="minute"/>
            </td>
          </tr>

          </tbody>
        </table>
      </div>
      <div class="buttons">
        <g:submitButton name="submitButton" value="${message(code:'save')}"/>
        <g:link class="buttonGray" action="list"><g:message code="cancel"/></g:link>
        <div class="spacer"></div>
      </div>
    </g:form>
  </div>
</div>
</body>