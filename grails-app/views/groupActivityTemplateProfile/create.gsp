<head>
  <meta name="layout" content="private"/>
  <title>Aktivitätsblockvorlage anlegen</title>
</head>
<body>
<div class="headerGreen">
  <div class="second">
    <h1>Aktivitätsblockvorlage anlegen</h1>
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

          <tr class="prop">
            <td valign="top" class="name"><g:message code="groupActivityTemplate.profile.name"/></td>
            <td valign="top" class="name"><g:message code="groupActivityTemplate.profile.realDuration"/></td>
            <td valign="top" class="name"><g:message code="groupActivityTemplate.profile.status"/></td>
          </tr>

          <tr>
            <td width="500px" valign="top" class="value">
              <g:textField class="countable50 ${hasErrors(bean: group, field: 'profile.fullName', 'errors')}" size="75" name="fullName" value="${fieldValue(bean: group, field: 'profile.fullName').decodeHTML()}"/>
            </td>
            <td width="170px" valign="top" class="value">
              <g:textField class="${hasErrors(bean: group, field: 'profile.realDuration', 'errors')}" size="20" name="realDuration" value="${fieldValue(bean: group, field: 'profile.realDuration').decodeHTML()}"/> (min)
            </td>
            <td valign="top" class="value">
              <g:select name="status" from="${['fertig','in Bearbeitung']}" value="${group?.profile?.status}"/>
            </td>
          </tr>

          <tr class="prop">
            <td colspan="3" valign="top" class="name"><g:message code="groupActivityTemplate.profile.description"/></td>
          </tr>
          <tr>
            <td colspan="3" valign="top" class="value">
              <g:textArea class="countable2000 ${hasErrors(bean: group, field: 'profile.description', 'errors')}" rows="6" cols="125" name="description" value="${fieldValue(bean: group, field: 'profile.description').decodeHTML()}"/>
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