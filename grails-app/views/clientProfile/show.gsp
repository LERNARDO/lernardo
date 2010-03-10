<head>
  <meta name="layout" content="private" />
  <title>Lernardo | Betreuter</title>
</head>
<body>
  <div class="headerBlue">
    <h1>Betreuter</h1>
  </div>
  <div class="boxGray">
    <div class="body">
      <div class="dialog">
        <table class="listing">
          <tbody>

            <tr class="prop">
                <td valign="top" class="name">
                   <g:message code="clientProfile.firstName.label" default="Vorname" />:
                </td>

                <td valign="top" class="value">${fieldValue(bean:client, field:'profile.firstName') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name">
                   <g:message code="clientProfile.lastName.label" default="Nachname" />:
                </td>

                <td valign="top" class="value">${fieldValue(bean:client, field:'profile.lastName') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name">
                   <g:message code="clientProfile.PLZ.label" default="PLZ" />:
                </td>

                <td valign="top" class="value">${fieldValue(bean:client, field:'profile.PLZ') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name">
                   <g:message code="clientProfile.endDate.label" default="Austrittsdatum" />:
                </td>

                <td valign="top" class="value">${fieldValue(bean:client, field:'profile.endDate') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name">
                   <g:message code="clientProfile.rejoinDate.label" default="Wiedereintritt" />:
                </td>

                <td valign="top" class="value">${fieldValue(bean:client, field:'profile.rejoinDate') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name">
                   <g:message code="clientProfile.endDate2.label" default="Austrittsdatum #2" />:
                </td>

                <td valign="top" class="value">${fieldValue(bean:client, field:'profile.endDate2') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name">
                   <g:message code="clientProfile.rejoinDate2.label" default="Wiedereintritt #2" />:
                </td>

                <td valign="top" class="value">${fieldValue(bean:client, field:'profile.rejoinDate2') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name">
                   <g:message code="clientProfile.notes.label" default="Notizen" />:
                </td>

                <td valign="top" class="value">${fieldValue(bean:client, field:'profile.notes') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name">
                   <g:message code="clientProfile.interests.label" default="Interessen" />:
                </td>

                <td valign="top" class="value">${fieldValue(bean:client, field:'profile.interests') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name">
                   <g:message code="clientProfile.personalDetails.label" default="Persönliche Details" />:
                </td>

                <td valign="top" class="value">${fieldValue(bean:client, field:'profile.personalDetails') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name">
                   <g:message code="clientProfile.PLZ2.label" default="PLZ #2" />:
                </td>

                <td valign="top" class="value">${fieldValue(bean:client, field:'profile.PLZ2') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name">
                   <g:message code="clientProfile.attendance.label" default="Anwesenheit" />:
                </td>

                <td valign="top" class="value">${fieldValue(bean:client, field:'profile.attendance') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name">
                   <g:message code="clientProfile.birthDate.label" default="Geburtsdatum" />:
                </td>

                <td valign="top" class="value">${fieldValue(bean:client, field:'profile.birthDate')}</td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name">
                   <g:message code="clientProfile.city.label" default="Stadt" />:
                </td>

                <td valign="top" class="value">${fieldValue(bean:client, field:'profile.city') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name">
                   <g:message code="clientProfile.city2.label" default="Stadt #2" />:
                </td>

                <td valign="top" class="value">${fieldValue(bean:client, field:'profile.city2') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name">
                   <g:message code="clientProfile.country.label" default="Land" />:
                </td>

                <td valign="top" class="value">${fieldValue(bean:client, field:'profile.country') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name">
                   <g:message code="clientProfile.country2.label" default="Land #2" />:
                </td>

                <td valign="top" class="value">${fieldValue(bean:client, field:'profile.country2') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name">
                   <g:message code="clientProfile.doesWork.label" default="Berufstätig?" />:
                </td>

                <td valign="top" class="value">${fieldValue(bean:client, field:'profile.doesWork')}</td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name">
                   <g:message code="clientProfile.dropout.label" default="Aussteiger" />:
                </td>

                <td valign="top" class="value">${fieldValue(bean:client, field:'profile.dropout')}</td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name">
                   <g:message code="clientProfile.dropoutReason.label" default="Aussteiger Grund" />:
                </td>

                <td valign="top" class="value">${fieldValue(bean:client, field:'profile.dropoutReason') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name">
                   <g:message code="clientProfile.gender.label" default="Geschlecht" />:
                </td>

                <td valign="top" class="value">${fieldValue(bean:client, field:'profile.gender')}</td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name">
                   <g:message code="clientProfile.income.label" default="Einkommen" />:
                </td>

                <td valign="top" class="value">${fieldValue(bean:client, field:'profile.income') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name">
                   <g:message code="clientProfile.joinDate.label" default="Eintrittsdatum" />:
                </td>

                <td valign="top" class="value">${fieldValue(bean:client, field:'profile.joinDate')}</td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name">
                   <g:message code="clientProfile.languages.label" default="Sprachen" />:
                </td>

                <td valign="top" class="value">${fieldValue(bean:client, field:'profile.languages')}</td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name">
                   <g:message code="clientProfile.nationality.label" default="Nationalität" />:
                </td>

                <td valign="top" class="value">${fieldValue(bean:client, field:'profile.nationality')}</td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name">
                   <g:message code="clientProfile.schoolLevel.label" default="Schulstufe" />:
                </td>

                <td valign="top" class="value">${fieldValue(bean:client, field:'profile.schoolLevel')}</td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name">
                   <g:message code="clientProfile.street.label" default="Straße" />:
                </td>

                <td valign="top" class="value">${fieldValue(bean:client, field:'profile.street') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name">
                   <g:message code="clientProfile.street2.label" default="Straße #2" />:
                </td>

                <td valign="top" class="value">${fieldValue(bean:client, field:'profile.street2') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name">
                   <g:message code="clientProfile.work.label" default="Arbeit" />:
                </td>

                <td valign="top" class="value">${fieldValue(bean:client, field:'profile.work') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>

            </tr>
                    
          <ub:isAdmin>
            <tr class="prop">
                <td valign="top" class="name">
                   <g:message code="clientProfile.work.label" default="Aktiv?" />:
                </td>

                <td valign="top" class="value">${fieldValue(bean:client, field:'user.enabled')}</td>

            </tr>
          </ub:isAdmin>

      </tbody>
    </table>
  </div>
  <div class="buttons">
     <g:link class="buttonBlue" action="edit" id="${client?.id}">Bearbeiten</g:link>
     <g:link class="buttonGray" action="del" id="${client?.id}" onclick="return confirm('Bist du sicher?');">Löschen</g:link>
     <g:link class="buttonGray" action="list">Zurück</g:link>
     <div class="spacer"></div>
   </div>
 </div>
 </div>
 </body>
