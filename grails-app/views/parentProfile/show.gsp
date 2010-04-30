<head>
  <meta name="layout" content="private"/>
  <title>Lernardo | Profil - ${parent.profile.fullName}</title>
</head>
<body>
<div class="headerBlue">
  <div class="second">
    <h1>Profil - ${parent.profile.fullName}</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">
    <div class="dialog">
      <table class="listing">
        <tbody>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="parentProfile.firstName.label" default="Vorname"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: parent, field: 'profile.firstName') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="parentProfile.lastName.label" default="Nachname"/>:
          </td>
          <td valign="top" class="value"><g:link action="show" id="${parent.id}" params="[entity:parent.id]">${parent.profile.lastName}</g:link></td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="parentProfile.birthDate.label" default="Geburtsdatum"/>:
          </td>
          <td valign="top" class="value"><g:formatDate date="${parent.profile.birthDate}" format="dd. MM. yyyy"/></td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="parentProfile.email.label" default="E-Mail"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: parent, field: 'user.email') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="parentProfile.currentCountry.label" default="Land"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: parent, field: 'profile.currentCountry') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="parentProfile.currentZip.label" default="PLZ"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: parent, field: 'profile.currentZip') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="parentProfile.currentCity.label" default="Stadt"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: parent, field: 'profile.currentCity') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="parentProfile.currentStreet.label" default="Straße"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: parent, field: 'profile.currentStreet') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="parentProfile.maritalStatus.label" default="Familienstand"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: parent, field: 'profile.maritalStatus') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="parentProfile.gender.label" default="Geschlecht"/>:
          </td>
          <td valign="top" class="value"><app:showGender gender="${parent.profile.gender}"/></td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="parentProfile.languages.label" default="Sprachen"/>:
          </td>
          <td valign="top" class="value"><ul><g:each in="${parent.profile.languages}" var="language"><li>${language}</li></g:each></ul></td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="parentProfile.education.label" default="Schulbildung"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: parent, field: 'profile.education') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="parentProfile.job.label" default="Berufstätig"/>:
          </td>
          <td valign="top" class="value"><g:formatBoolean boolean="${parent.profile.job}" true="Ja" false="Nein"/></td>
        </tr>

        <g:if test="${parent.profile.job}">
          <tr class="prop">
            <td valign="top" class="name">
              <g:message code="parentProfile.jobType.label" default="Arbeit"/>:
            </td>
            <td valign="top" class="value">${fieldValue(bean: parent, field: 'profile.jobType') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
          </tr>
  
          <tr class="prop">
            <td valign="top" class="name">
              <g:message code="parentProfile.jobIncome.label" default="Einkommen"/>:
            </td>
            <td valign="top" class="value">${fieldValue(bean: parent, field: 'profile.jobIncome') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <g:message code="parentProfile.jobFrequency.label" default="Jobhäufigkeit"/>:
            </td>
            <td valign="top" class="value">${fieldValue(bean: parent, field: 'profile.jobFrequency') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
          </tr>
        </g:if>

        <app:isAdmin>
          <tr class="prop">
            <td valign="top" class="name">
              <g:message code="parentProfile.work.label" default="Aktiv"/>:
            </td>
            <td valign="top" class="value"><g:formatBoolean boolean="${parent.user.enabled}" true="Ja" false="Nein"/></td>
          </tr>
        </app:isAdmin>

        </tbody>
      </table>
    </div>

    <app:isMeOrAdmin entity="${parent}">
      <div class="buttons">
        <g:link class="buttonBlue" action="edit" id="${parent?.id}">Bearbeiten</g:link>
        <div class="spacer"></div>
      </div>
    </app:isMeOrAdmin>

  </div>
</div>
</body>
