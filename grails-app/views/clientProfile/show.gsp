<head>
  <meta name="layout" content="private"/>
  <title>Lernardo | Profil - ${client.profile.fullName}</title>
</head>
<body>
<div class="headerBlue">
  <div class="second">
    <h1>Profil - ${client.profile.fullName}</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">
    <div class="dialog">
      <table class="listing">
        <tbody>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="clientProfile.firstName.label" default="Vorname"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: client, field: 'profile.firstName') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="clientProfile.lastName.label" default="Nachname"/>:
          </td>
          <td valign="top" class="value"><g:link action="show" id="${client.id}" params="[entity:client.id]">${client.profile.lastName}</g:link></td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="clientProfile.birthDate.label" default="Geburtsdatum"/>:
          </td>
          <td valign="top" class="value"><g:formatDate date="${client.profile.birthDate}" format="dd. MM. yyyy"/></td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="clientProfile.email.label" default="E-Mail"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: client, field: 'user.email') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="clientProfile.country.label" default="Land"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: client, field: 'profile.country') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="clientProfile.PLZ.label" default="PLZ"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: client, field: 'profile.PLZ') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="clientProfile.city.label" default="Stadt"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: client, field: 'profile.city') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="clientProfile.street.label" default="Straße"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: client, field: 'profile.street') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="clientProfile.country2.label" default="Land #2"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: client, field: 'profile.country2') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="clientProfile.PLZ2.label" default="PLZ #2"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: client, field: 'profile.PLZ2') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="clientProfile.city2.label" default="Stadt #2"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: client, field: 'profile.city2') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="clientProfile.street2.label" default="Straße #2"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: client, field: 'profile.street2') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="clientProfile.joinDate.label" default="Eintrittsdatum"/>:
          </td>
          <td valign="top" class="value"><g:formatDate date="${client.profile.joinDate}" format="dd. MM. yyyy"/></td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="clientProfile.endDate.label" default="Austrittsdatum"/>:
          </td>
          <td valign="top" class="value"><g:formatDate date="${client.profile.endDate}" format="dd. MM. yyyy"/></td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="clientProfile.joinDate2.label" default="Eintrittsdatum #2"/>:
          </td>
          <td valign="top" class="value"><g:formatDate date="${client.profile.joinDate2}" format="dd. MM. yyyy"/></td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="clientProfile.endDate2.label" default="Austrittsdatum #2"/>:
          </td>
          <td valign="top" class="value"><g:formatDate date="${client.profile.endDate2}" format="dd. MM. yyyy"/></td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="clientProfile.notes.label" default="Notizen"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: client, field: 'profile.notes') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="clientProfile.interests.label" default="Interessen"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: client, field: 'profile.interests') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="clientProfile.personalDetails.label" default="Persönliche Details"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: client, field: 'profile.personalDetails') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="clientProfile.attendance.label" default="Anwesenheit"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: client, field: 'profile.attendance') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="clientProfile.doesWork.label" default="Berufstätig"/>:
          </td>
          <td valign="top" class="value"><app:showBoolean bool="${client.profile.doesWork}"/></td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="clientProfile.work.label" default="Arbeit"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: client, field: 'profile.work') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>


        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="clientProfile.income.label" default="Einkommen"/>:
          </td>
          <td valign="top" class="value">${client?.profile?.income?.toInteger() ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="clientProfile.dropout.label" default="Aussteiger"/>:
          </td>
          <td valign="top" class="value"><app:showBoolean bool="${client.profile.dropout}"/></td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="clientProfile.dropoutReason.label" default="Aussteiger Grund"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: client, field: 'profile.dropoutReason') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="clientProfile.gender.label" default="Geschlecht"/>:
          </td>
          <td valign="top" class="value"><app:showGender gender="${client.profile.gender}"/></td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="clientProfile.languages.label" default="Sprachen"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: client, field: 'profile.languages')}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="clientProfile.nationality.label" default="Nationalität"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: client, field: 'profile.nationality')}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="clientProfile.schoolLevel.label" default="Schulstufe"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: client, field: 'profile.schoolLevel')}</td>
        </tr>

        <app:isAdmin>
          <tr class="prop">
            <td valign="top" class="name">
              <g:message code="clientProfile.work.label" default="Aktiv"/>:
            </td>
            <td valign="top" class="value"><app:showBoolean bool="${client.user.enabled}"/></td>
          </tr>
        </app:isAdmin>

        </tbody>
      </table>
    </div>
    <div class="buttons">
      <g:link class="buttonBlue" action="edit" id="${client?.id}">Bearbeiten</g:link>
      <div class="spacer"></div>
    </div>
  </div>
</div>
</body>
