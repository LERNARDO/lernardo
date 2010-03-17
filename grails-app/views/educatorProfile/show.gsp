<head>
  <meta name="layout" content="private"/>
  <title>Lernardo | Profil - ${educator.profile.fullName}</title>
</head>
<body>
<div class="headerBlue">
  <div class="second">
    <h1>Profil - ${educator.profile.fullName}</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">
    <div class="dialog">
      <table class="listing">
        <tbody>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="educatorProfile.title.label" default="Titel"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: educator, field: 'profile.title') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="educatorProfile.firstName.label" default="Vorname"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: educator, field: 'profile.firstName') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="educatorProfile.lastName.label" default="Nachname"/>:
          </td>
          <td valign="top" class="value"><g:link action="show" id="${educator.id}" params="[entity:educator.id]">${educator.profile.lastName}</g:link></td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="educatorProfile.birthDate.label" default="Geburtsdatum"/>:
          </td>
          <td valign="top" class="value"><g:formatDate date="${educator.profile.birthDate}" format="dd. MM. yyyy"/></td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="educatorProfile.email.label" default="E-Mail"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: educator, field: 'user.email') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="educatorProfile.PLZ.label" default="PLZ"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: educator, field: 'profile.PLZ') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="educatorProfile.city.label" default="Stadt"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: educator, field: 'profile.city') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="educatorProfile.street.label" default="Straße"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: educator, field: 'profile.street') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="educatorProfile.contact.label" default="Kontakt"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: educator, field: 'profile.contact') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="educatorProfile.education.label" default="Ausbildung"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: educator, field: 'profile.education') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="educatorProfile.employed.label" default="Angestellt"/>:
          </td>
          <td valign="top" class="value"><app:showBoolean bool="${educator.profile.employed}"/></td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="educatorProfile.function.label" default="Funktion"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: educator, field: 'profile.function') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="educatorProfile.gender.label" default="Geschlecht"/>:
          </td>
          <td valign="top" class="value"><app:showGender gender="${educator.profile.gender}"/></td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="educatorProfile.interests.label" default="Interessen"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: educator, field: 'profile.interests') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="educatorProfile.joinDate.label" default="Eintrittsdatum"/>:
          </td>
          <td valign="top" class="value"><g:formatDate date="${educator.profile.joinDate}" format="dd. MM. yyyy"/></td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="educatorProfile.quitDate.label" default="Austrittsdatum"/>:
          </td>
          <td valign="top" class="value"><g:if test="${educator.profile.quitDate}"><g:formatDate date="${educator.profile.quitDate}" format="dd. MM. yyyy"/></g:if><g:else><div class="italic">keine Daten eingetragen</div></g:else></td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="educatorProfile.languages.label" default="Sprachen"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: educator, field: 'profile.languages')}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="educatorProfile.nationality.label" default="Nationalität"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: educator, field: 'profile.nationality')}</td>
        </tr>

        </tbody>
      </table>
    </div>
    <div class="buttons">
      <g:link class="buttonBlue" action="edit" id="${educator?.id}">Bearbeiten</g:link>
      <div class="spacer"></div>
    </div>
  </div>
</div>
</body>
