<head>
  <meta name="layout" content="private"/>
  <title>Lernardo | Pate anlegen</title>
</head>
<body>
<div class="headerBlue">
  <h1>Pate anlegen</h1>
</div>
<div class="boxGray">
  <g:hasErrors bean="${pate}">
    <div class="errors">
      <g:renderErrors bean="${pate}" as="list"/>
    </div>
  </g:hasErrors>
  <g:form action="save" method="post">
    <div class="dialog">
      <table>
        <tbody>

        <tr class="prop">
          <td valign="top" class="name">
            <label for="firstName">
              <g:message code="pateProfile.firstName.label" default="Vorname"/>
            </label>
          </td>
          <td valign="top" class="value">
            <g:textField class="${hasErrors(bean: partner, field: 'profile.firstName', 'errors')}" size="30" id="firstName" name="firstName" value="${fieldValue(bean: pate, field: 'profile.firstName')}"/>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <label for="lastName">
              <g:message code="pateProfile.lastName.label" default="Nachname"/>
            </label>
          </td>
          <td valign="top" class="value">
            <g:textField class="${hasErrors(bean: partner, field: 'profile.lastName', 'errors')}" size="30" id="lastName" name="lastName" value="${fieldValue(bean: pate, field: 'profile.lastName')}"/>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <label for="email">
              <g:message code="pateProfile.email.label" default="E-Mail"/>
            </label>
          </td>
          <td valign="top" class="value">
            <g:textField class="${hasErrors(bean: pate, field: 'user.email', 'errors')}" size="30" maxlength="80" id="email" name="email" value="${fieldValue(bean: pate, field: 'user.email')}"/>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <label for="PLZ">
              <g:message code="pateProfile.PLZ.label" default="PLZ"/>
            </label>
          </td>
          <td valign="top" class="value">
            <g:textField class="${hasErrors(bean: partner, field: 'profile.PLZ', 'errors')}" size="30" id="PLZ" name="PLZ" value="${fieldValue(bean: pate, field: 'profile.PLZ')}"/>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <label for="city">
              <g:message code="pateProfile.city.label" default="Stadt"/>
            </label>
          </td>
          <td valign="top" class="value">
            <g:textField class="${hasErrors(bean: partner, field: 'profile.city', 'errors')}" size="30" id="city" name="city" value="${fieldValue(bean: pate, field: 'profile.city')}"/>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <label for="street">
              <g:message code="pateProfile.street.label" default="Straße"/>
            </label>
          </td>
          <td valign="top" class="value">
            <g:textField class="${hasErrors(bean: partner, field: 'profile.street', 'errors')}" size="30" id="street" name="street" value="${fieldValue(bean: pate, field: 'profile.street')}"/>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <label for="languages">
              <g:message code="pateProfile.languages.label" default="Sprachen"/>
            </label>
          </td>
          <td valign="top" class="value">
            <g:select multiple="true" name="languages" from="${['Deutsch', 'Englisch', 'Französisch', 'Spanisch', 'Portugiesisch']}"/>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <label for="nationality">
              <g:message code="pateProfile.nationality.label" default="Nationalität"/>
            </label>
          </td>
          <td valign="top" class="value">
            <g:select name="nationality" from="${['Deutschland', 'England', 'Frankreich', 'Spanien', 'Portugal','Österreich']}"/>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <label for="enabled">
              <g:message code="pateProfile.enabled.label" default="Aktiv?"/>
            </label>
          </td>
          <td valign="top" class="value">
            <g:checkBox name="enabled" value="${pate?.user?.enabled}"/>
          </td>
        </tr>

        </tbody>
      </table>
    </div>
    <div class="buttons">
      <g:submitButton name="submitButton" value="Anlegen"/>
      <g:link class="buttonGray" action="list">Zurück</g:link>
      <div class="spacer"></div>
    </div>
  </g:form>
</div>
</body>