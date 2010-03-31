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
                <g:message code="groupActivityTemplateProfile.fullName.label" default="Name"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: group, field: 'profile.fullName', 'errors')}" size="50" id="fullName" name="fullName" value="${fieldValue(bean: group, field: 'profile.fullName').decodeHTML()}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="description">
                <g:message code="groupActivityTemplateProfile.description.label" default="Beschreibung"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textArea class="${hasErrors(bean: group, field: 'profile.description', 'errors')}" rows="6" cols="50" name="description" value="${fieldValue(bean: group, field: 'profile.description').decodeHTML()}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="templates">
                <g:message code="groupActivityTemplateProfile.description.label" default="Aktivitätsvorlagen"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:select multiple="true" name="templates" from="${templates}" optionKey="id" optionValue="profile"/>
            </td>
          </tr>
          </tbody>
        </table>
      </div>

      <div class="buttons">
        <g:submitButton name="submitButton" value="Speichern"/>
        <g:link class="buttonGray" action="del" id="${group.id}" onclick="return confirm('Bist du sicher?');">Löschen</g:link>
        <g:link class="buttonGray" action="show" id="${group.id}">Abbrechen</g:link>
        <div class="spacer"></div>
      </div>
    </g:form>
  </div>
</div>
</body>
