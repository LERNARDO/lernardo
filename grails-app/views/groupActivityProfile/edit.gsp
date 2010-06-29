<head>
  <meta name="layout" content="private"/>
  <title>Aktivitätsblock bearbeiten</title>
</head>
<body>
<div class="headerGreen">
  <div class="second">
    <h1>Aktivitätsblock bearbeiten</h1>
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
          <tr class="prop">
            <td valign="top" class="name">
              <label for="fullName">
                <g:message code="groupActivity.profile.name"/>
              </label>
            </td>
            <td valign="top" class="name">
              <label for="realDuration">
                <g:message code="groupActivity.profile.realDuration"/>
              </label>
            </td>
            <td  valign="top" class="name">
              <label for="date">
                <g:message code="groupActivity.profile.date"/>
              </label>
            </td>
            </tr>
            <tr>
            <td width="280px" valign="top" class="value">
              <g:textField class="${hasErrors(bean: group, field: 'profile.fullName', 'errors')}" size="40" id="fullName" name="fullName" value="${fieldValue(bean: group, field: 'profile.fullName')}"/>
            </td>
            <td width="180px" valign="top" class="value">
              <g:textField class="${hasErrors(bean: group, field: 'profile.realDuration', 'errors')}" size="15" id="realDuration" name="realDuration" value="${fieldValue(bean: group, field: 'profile.realDuration')}"/> (min)
            </td>
            <td valign="top" class="value">
              <g:datePicker name="date" value="${group?.profile?.date}" precision="minute"/>
            </td>
          </tr>
         <tr class="prop">
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
          </tr>

          <tr class="prop">
            <td valign="top" class="value">
              <g:select from="${['erreicht','nicht erreicht']}" class="drop-down-240" id="educationalObjective" name="educationalObjective" value="${fieldValue(bean: group, field: 'profile.educationalObjective').decodeHTML()}"/>
            </td>

            <td  colspan="2" valign="top" class="value">
              <g:textArea class="${hasErrors(bean: group, field: 'profile.educationalObjectiveText', 'errors')}" rows="1" cols="80" name="educationalObjectiveText" value="${fieldValue(bean: group, field: 'profile.educationalObjectiveText').decodeHTML()}"/>
            </td>
          </tr>

          </table>

      </div>

      <div class="buttons">
        <g:submitButton name="submitButton" value="${message(code:'save')}"/>
        <app:isOperator entity="${entity}">
          <g:link class="buttonGray" action="del" id="${group.id}" onclick="${app.getLinks(id: group.id)}"><g:message code="delete"/></g:link>
        </app:isOperator>
        <g:link class="buttonGray" action="show" id="${group.id}"><g:message code="cancel"/></g:link>
        <div class="spacer"></div>
      </div>
    </g:form>
  </div>
</div>
</body>
