<head>
  <meta name="layout" content="private"/>
  <title>Lernardo | Pate</title>
</head>
<body>
<div class="headerBlue">
  <h1>Pate</h1>
</div>
<div class="boxGray">
  <div class="body">
    <div class="dialog">
      <table class="listing">
        <tbody>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="pateProfile.firstName.label" default="Vorname"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: pate, field: 'profile.firstName') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="pateProfile.lastName.label" default="Nachname"/>:
          </td>
          <td valign="top" class="value"><g:link action="show" id="${pate.id}" params="[entity:pate.id]">${pate.profile.lastName}</g:link></td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="pateProfile.PLZ.label" default="PLZ"/>:
          </td>
          <td valign="top" class="value">${pate.profile.PLZ.toInteger() ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="pateProfile.city.label" default="Stadt"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: pate, field: 'profile.city') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="pateProfile.street.label" default="Straße"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: pate, field: 'profile.street') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="pateProfile.emails.label" default="E-Mails"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: pate, field: 'profile.emails')}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="pateProfile.languages.label" default="Sprachen"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: pate, field: 'profile.languages')}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="pateProfile.nationality.label" default="Nationalität"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: pate, field: 'profile.nationality')}</td>
        </tr>

        <app:isAdmin>
          <tr class="prop">
            <td valign="top" class="name">
              <g:message code="parentProfile.work.label" default="Aktiv"/>:
            </td>
            <td valign="top" class="value"><app:showBoolean bool="${pate.user.enabled}"/></td>
          </tr>
        </app:isAdmin>

        </tbody>
      </table>
    </div>
    <div class="buttons">
      <g:link class="buttonBlue" action="edit" id="${pate?.id}">Bearbeiten</g:link>
      <g:link class="buttonGray" action="del" id="${pate?.id}" onclick="return confirm('Bist du sicher?');">Löschen</g:link>
      <g:link class="buttonGray" action="list">Zurück</g:link>
      <div class="spacer"></div>
    </div>
  </div>
</div>
</body>
