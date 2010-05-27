<head>
  <meta name="layout" content="private"/>
  <title>Aktivitätsvorlagengruppe anlegen</title>
</head>
<body>
<div class="headerBlue">
  <div class="second">
    <h1>Aktivitätsvorlagengruppe anlegen</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <g:hasErrors bean="${group}">
      <div class="errors">
        <g:renderErrors bean="${group}" as="list"/>
      </div>
    </g:hasErrors>

    <g:form action="save" method="post">
      <div class="dialog">
        <table>
          <tbody>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="fullName">
                <g:message code="groupActivityTemplate.profile.name"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: group, field: 'profile.fullName', 'errors')}" size="50" id="fullName" name="fullName" value="${fieldValue(bean: group, field: 'profile.fullName').decodeHTML()}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="description">
                <g:message code="groupActivityTemplate.profile.description"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textArea class="${hasErrors(bean: group, field: 'profile.description', 'errors')}" rows="6" cols="50" name="description" value="${fieldValue(bean: group, field: 'profile.description').decodeHTML()}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="realDuration">
                <g:message code="groupActivityTemplate.profile.realDuration"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: group, field: 'profile.realDuration', 'errors')}" size="10" name="realDuration" value="${fieldValue(bean: group, field: 'profile.realDuration').decodeHTML()}"/> (min)
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="status">
                <g:message code="groupActivityTemplate.profile.status"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:select id="status" name="status" from="${['fertig','unfertig']}" value="${group?.profile?.status}"/>
            </td>
          </tr>

%{--      <tr class="prop">
            <td valign="top" class="name">
              <label for="templates">
                <g:message code="groupActivityTemplateProfile.description.label" default="Aktivitätsvorlagen"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:select multiple="true" name="templates" from="${templates}" optionKey="id" optionValue="profile"/>
            </td>
          </tr>--}%
                   
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