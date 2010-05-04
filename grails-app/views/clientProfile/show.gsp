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
            <g:message code="clientProfile.gender.label" default="Geschlecht"/>:
          </td>
          <td valign="top" class="value"><app:showGender gender="${client.profile.gender}"/></td>
        </tr>

        <tr>
          <td><span class="bold">Derzeitige Adresse</span></td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="clientProfile.currentStreet.label" default="Straße"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: client, field: 'profile.currentStreet') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="clientProfile.currentCity.label" default="Stadt"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: client, field: 'profile.currentCity') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="clientProfile.currentZip.label" default="PLZ"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: client, field: 'profile.currentZip') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="clientProfile.currentCountry.label" default="Land"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: client, field: 'profile.currentCountry') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr>
          <td><span class="bold">Herkunft</span></td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="clientProfile.originCity.label" default="Stadt"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: client, field: 'profile.originCity') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="clientProfile.originZip.label" default="PLZ"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: client, field: 'profile.originZip') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="clientProfile.originCountry.label" default="Land"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: client, field: 'profile.originCountry') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr>
          <td><span class="bold">Weitere Daten</span></td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="clientProfile.languages.label" default="Sprachen"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: client, field: 'profile.languages')}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="clientProfile.school.label" default="Schule"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: client, field: 'profile.school')}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="clientProfile.schoolLevel.label" default="Schulstufe"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: client, field: 'profile.schoolLevel')}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="clientProfile.schoolDropout.label" default="Aussteiger?"/>:
          </td>
          <td valign="top" class="value"><g:formatBoolean boolean="${client.profile.schoolDropout}" true="Ja" false="Nein"/></td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="clientProfile.schoolDropoutReason.label" default="Aussteiger Grund"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: client, field: 'profile.schoolDropoutReason') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="clientProfile.schoolDropoutDate.label" default="Aussteiger Datum"/>:
          </td>
          <td valign="top" class="value"><g:formatDate date="${client.profile.schoolDropoutDate}" format="dd. MM. yyyy"/></td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="clientProfile.schoolRestart.label" default="Einsteiger?"/>:
          </td>
          <td valign="top" class="value"><g:formatBoolean boolean="${client.profile.schoolRestart}" true="Ja" false="Nein"/></td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="clientProfile.schoolRestartReason.label" default="Einsteiger Grund"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: client, field: 'profile.schoolRestartReason') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="clientProfile.schoolRestartDate.label" default="Einsteiger Datum"/>:
          </td>
          <td valign="top" class="value"><g:formatDate date="${client.profile.schoolRestartDate}" format="dd. MM. yyyy"/></td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="clientProfile.interests.label" default="Interessen"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: client, field: 'profile.interests') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

       <tr class="prop">
          <td valign="top" class="name">
            <g:message code="clientProfile.size.label" default="Größe"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: client, field: 'profile.size') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="clientProfile.weight.label" default="Gewicht"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: client, field: 'profile.weight') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="clientProfile.job.label" default="Berufstätig"/>:
          </td>
          <td valign="top" class="value"><g:formatBoolean boolean="${client.profile.job}" true="Ja" false="Nein"/></td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="clientProfile.jobType.label" default="Arbeit"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: client, field: 'profile.jobType') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="clientProfile.jobIncome.label" default="Einkommen"/>:
          </td>
          <td valign="top" class="value">${client?.profile?.jobIncome?.toInteger() ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="clientProfile.jobFrequency.label" default="Jobhäufigkeit"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: client, field: 'profile.jobFrequency') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <app:isAdmin>
          <tr class="prop">
            <td valign="top" class="name">
              <g:message code="clientProfile.work.label" default="Aktiv"/>:
            </td>
            <td valign="top" class="value"><g:formatBoolean boolean="${client.user.enabled}" true="Ja" false="Nein"/></td>
          </tr>
        </app:isAdmin>

        </tbody>
      </table>
    </div>

    <app:isMeOrAdmin entity="${client}">
      <div class="buttons">
        <g:link class="buttonBlue" action="edit" id="${client?.id}">Bearbeiten</g:link>
        <div class="spacer"></div>
      </div>
    </app:isMeOrAdmin>

  </div>
</div>
</body>
