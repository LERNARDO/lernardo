<head>
  <meta name="layout" content="private" />
  <title>Lernardo | Erziehungsberechtigter</title>
</head>
<body>
  <div class="headerBlue">
    <h1>Erziehungsberechtigter</h1>
  </div>
  <div class="boxGray">
    <div class="body">
      <div class="dialog">
        <table class="listing">
          <tbody>

              <tr class="prop">
                  <td valign="top" class="name">
                     <g:message code="parentProfile.firstName.label" default="Vorname" />:
                  </td>

                  <td valign="top" class="value">${fieldValue(bean:parent, field:'profile.firstName') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>

              </tr>

              <tr class="prop">
                  <td valign="top" class="name">
                     <g:message code="parentProfile.lastName.label" default="Nachname" />:
                  </td>

                  <td valign="top" class="value">${fieldValue(bean:parent, field:'profile.lastName') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>

              </tr>

              <tr class="prop">
                  <td valign="top" class="name">
                     <g:message code="parentProfile.PLZ.label" default="PLZ" />:
                  </td>

                  <td valign="top" class="value">${fieldValue(bean:parent, field:'profile.PLZ') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>

              </tr>

              <tr class="prop">
                  <td valign="top" class="name">
                     <g:message code="parentProfile.birthDate.label" default="Geburtsdatum" />:
                  </td>

                  <td valign="top" class="value">${fieldValue(bean:parent, field:'profile.birthDate')}</td>

              </tr>

              <tr class="prop">
                  <td valign="top" class="name">
                     <g:message code="parentProfile.city.label" default="Stadt" />:
                  </td>

                  <td valign="top" class="value">${fieldValue(bean:parent, field:'profile.city') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>

              </tr>

              <tr class="prop">
                  <td valign="top" class="name">
                     <g:message code="parentProfile.doesWork.label" default="Berufstätig?" />:
                  </td>

                  <td valign="top" class="value"><app:showBoolean bool="${parent.profile.doesWork}"/></td>

              </tr>

              <tr class="prop">
                  <td valign="top" class="name">
                     <g:message code="parentProfile.familyStatus.label" default="Familienstand" />:
                  </td>

                  <td valign="top" class="value">${fieldValue(bean:parent, field:'profile.familyStatus') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>

              </tr>

              <tr class="prop">
                  <td valign="top" class="name">
                     <g:message code="parentProfile.gender.label" default="Geschlecht" />:
                  </td>

                  <td valign="top" class="value"><app:showGender gender="${parent.profile.gender}"/></td>

              </tr>

              <tr class="prop">
                  <td valign="top" class="name">
                     <g:message code="parentProfile.languages.label" default="Sprachen" />:
                  </td>

                  <td valign="top" class="value">${fieldValue(bean:parent, field:'profile.languages')}</td>

              </tr>

              <tr class="prop">
                  <td valign="top" class="name">
                     <g:message code="parentProfile.nationality.label" default="Nationalität" />:
                  </td>

                  <td valign="top" class="value">${fieldValue(bean:parent, field:'profile.nationality')}</td>

              </tr>

              <tr class="prop">
                  <td valign="top" class="name">
                     <g:message code="parentProfile.qualification.label" default="Qualifikationen" />:
                  </td>

                  <td valign="top" class="value">${fieldValue(bean:parent, field:'profile.qualification') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>

              </tr>

              <tr class="prop">
                  <td valign="top" class="name">
                     <g:message code="parentProfile.street.label" default="Straße" />:
                  </td>

                  <td valign="top" class="value">${fieldValue(bean:parent, field:'profile.street') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>

              </tr>

              <tr class="prop">
                  <td valign="top" class="name">
                     <g:message code="parentProfile.work.label" default="Arbeit" />:
                  </td>

                  <td valign="top" class="value">${fieldValue(bean:parent, field:'profile.work') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>

              </tr>

              <ub:isAdmin>
                <tr class="prop">
                    <td valign="top" class="name">
                       <g:message code="parentProfile.work.label" default="Aktiv?" />:
                    </td>

                    <td valign="top" class="value">${fieldValue(bean:parent, field:'user.enabled')}</td>

                </tr>
              </ub:isAdmin>

          </tbody>
        </table>
      </div>
      <div class="buttons">
         <g:link class="buttonBlue" action="edit" id="${parent?.id}">Bearbeiten</g:link>
         <g:link class="buttonGray" action="del" id="${parent?.id}" onclick="return confirm('Bist du sicher?');">Löschen</g:link>
         <g:link class="buttonGray" action="list">Zurück</g:link>
         <div class="spacer"></div>
       </div>
   </div>
 </div>
 </body>
