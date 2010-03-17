<head>
  <meta name="layout" content="private"/>
  <title>Lernardo | Ressource</title>
</head>
<body>
<div class="headerBlue">
  <div class="second">
    <h1>Ressource</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">
    <div class="dialog">
      <table class="listing">
        <tbody>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="resourceProfile.fullName.label" default="Name"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: resource, field: 'profile.fullName')}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="resourceProfile.description.label" default="Beschreibung"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: resource, field: 'profile.description')}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="resourceProfile.type.label" default="Typ"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: resource, field: 'profile.type')}</td>
        </tr>

        </tbody>
      </table>
    </div>
    <div class="buttons">
      <g:link class="buttonBlue" action="edit" id="${resource?.id}">Bearbeiten</g:link>
      <g:link class="buttonGray" action="list">Zurück</g:link>
      <div class="spacer"></div>
    </div>
  </div>
</div>
</body>
