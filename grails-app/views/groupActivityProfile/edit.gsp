<head>
  <meta name="layout" content="private"/>
  <title>Lernardo | Aktivitätsvorlagengruppe bearbeiten</title>
</head>
<body>
<div class="headerBlue">
  <div class="second">
    <h1>Aktivitätsvorlagengruppe bearbeiten</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <g:hasErrors bean="${group}">
      <div class="errors">
        <g:renderErrors bean="${group}" as="list"/>
      </div>
    </g:hasErrors>

    <g:form action="update" method="post" id="${group.id}">
      <div class="dialog">
        <table>
          <tbody>

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

          <tr class="prop">
            <td valign="top" class="name">
              <label for="educationalObjective">
                <g:message code="groupActivity.profile.educationalObjective"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:select from="${['a','b','c']}" id="educationalObjective" name="educationalObjective" value="${fieldValue(bean: group, field: 'profile.educationalObjective')}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="educationalObjectiveText">
                <g:message code="groupActivity.profile.educationalObjectiveText"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textArea class="${hasErrors(bean: group, field: 'profile.educationalObjectiveText', 'errors')}" rows="5" cols="40" name="educationalObjectiveText" value="${fieldValue(bean: group, field: 'profile.educationalObjectiveText')}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="realDuration">
                <g:message code="groupActivity.profile.realDuration"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: group, field: 'profile.realDuration', 'errors')}" id="realDuration" name="realDuration" value="${fieldValue(bean: group, field: 'profile.realDuration')}"/>
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
        <g:link class="buttonGray" action="del" id="${group.id}" onclick="return confirm('Bist du sicher?');"><g:message code="delete"/></g:link>
        <g:link class="buttonGray" action="show" id="${group.id}"><g:message code="cancel"/></g:link>
        <div class="spacer"></div>
      </div>
    </g:form>
  </div>
</div>
</body>
