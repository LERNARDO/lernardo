<head>
  <meta name="layout" content="private"/>
  <title>Lernardo | Profil - ${partner.profile.fullName}</title>
</head>
<body>
<div class="headerBlue">
  <div class="second">
    <h1>Profil - ${partner.profile.fullName}</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">
    <div class="dialog">
      <table class="listing">
        <tbody>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="partnerProfile.fullName.label" default="Name"/>:
          </td>
          <td valign="top" class="value"><g:link action="show" id="${partner.id}" params="[entity:partner.id]">${partner.profile.fullName}</g:link></td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="partnerProfile.description.label" default="Beschreibung"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: partner, field: 'profile.description') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="partnerProfile.PLZ.label" default="PLZ"/>:
          </td>
          <td valign="top" class="value">${partner.profile.PLZ.toInteger() ?: '<div class="italic">keine Daten eingetragen</div>'}</td>

        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="partnerProfile.city.label" default="Stadt"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: partner, field: 'profile.city') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="partnerProfile.street.label" default="Straße"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: partner, field: 'profile.street') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="partnerProfile.tel.label" default="Telefon"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: partner, field: 'profile.tel') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <app:isAdmin>
          <tr class="prop">
            <td valign="top" class="name">
              <g:message code="parentProfile.work.label" default="Aktiv"/>:
            </td>
            <td valign="top" class="value"><app:showBoolean bool="${partner.user.enabled}"/></td>
          </tr>
        </app:isAdmin>

        </tbody>
      </table>
    </div>
    <div class="buttons">
      <g:link class="buttonBlue" action="edit" id="${partner?.id}">Bearbeiten</g:link>
      <div class="spacer"></div>
    </div>
  </div>
</div>
</body>
