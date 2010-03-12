<head>
  <meta name="layout" content="private"/>
  <title>Lernardo | Ressource bearbeiten</title>
</head>
<body>
<div class="headerBlue">
  <div class="second">
    <h1>Ressource bearbeiten</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">
  %{--TODO: figure out why error messages are not shown?!?--}%
    <g:hasErrors bean="${resource}">
      <div class="errors">
        <g:renderErrors bean="${resource}" as="list"/>
      </div>
    </g:hasErrors>
    <g:form action="update" method="post" id="${resource?.id}">
      <input type="hidden" name="id" value="${resource?.id}"/>
      <input type="hidden" name="version" value="${resource?.version}"/>
      <div class="dialog">
        <table>
          <tbody>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="fullName">
                <g:message code="resourceProfile.profile.fullName.label" default="Name"/>
              </label>

            </td>
            <td valign="top" class="value ${hasErrors(bean: resource, field: 'profile.fullName', 'errors')}">
              <input type="text" maxlength="80" id="fullName" name="fullName" value="${fieldValue(bean: resource, field: 'profile.fullName')}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="description">
                <g:message code="resourceProfile.profile.description.label" default="Beschreibung"/>
              </label>

            </td>
            <td valign="top" class="value ${hasErrors(bean: resource, field: 'profile.description', 'errors')}">
              <textarea rows="5" cols="40" name="description">${fieldValue(bean: resource, field: 'profile.description')}</textarea>
            </td>
          </tr>

          </tbody>
        </table>
      </div>
      <div class="buttons">
        <g:submitButton name="submitButton" value="Aktualisieren"/>
        <g:link class="buttonGray" action="del" id="${resource?.id}" onclick="return confirm('Bist du sicher?');">Löschen</g:link>
        <g:link class="buttonGray" action="show" id="${resource?.id}">Zurück</g:link>
        <div class="spacer"></div>
      </div>
    </g:form>
  </div>
</div>
</body>
