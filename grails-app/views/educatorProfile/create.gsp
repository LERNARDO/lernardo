<head>
  <meta name="layout" content="private"/>
  <title>Lernardo | Pädagoge anlegen</title>
</head>
<body>
<div class="headerBlue">
  <div class="second">
    <h1>Pädagoge anlegen</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <g:hasErrors bean="${educator}">
      <div class="errors">
        <g:renderErrors bean="${educator}" as="list"/>
      </div>
    </g:hasErrors>

    <g:form action="save" method="post">
      <div class="dialog">
        <table>
          <tbody>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="title">
                <g:message code="educatorProfile.title.label" default="Titel"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: educator, field: 'profile.title', 'errors')}" size="30" id="title" name="title" value="${fieldValue(bean: educator, field: 'profile.title')}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="firstName">
                <g:message code="educatorProfile.firstName.label" default="Vorname"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: educator, field: 'profile.firstName', 'errors')}" size="30" id="firstName" name="firstName" value="${fieldValue(bean: educator, field: 'profile.firstName')}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="lastName">
                <g:message code="educatorProfile.lastName.label" default="Nachname"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: educator, field: 'profile.lastName', 'errors')}" size="30" id="lastName" name="lastName" value="${fieldValue(bean: educator, field: 'profile.lastName')}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="email">
                <g:message code="educatorProfile.email.label" default="E-Mail"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: educator, field: 'user.email', 'errors')}" size="30" type="text" maxlength="80" id="email" name="email" value="${fieldValue(bean: educator, field: 'user.email')}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="birthDate">
                <g:message code="educatorProfile.birthDate.label" default="Geburtsdatum"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:datePicker name="birthDate" value="${educator?.profile?.birthDate}" precision="day"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="PLZ">
                <g:message code="educatorProfile.PLZ.label" default="PLZ"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: educator, field: 'profile.PLZ', 'errors')}" size="30" id="PLZ" name="PLZ" value="${fieldValue(bean: educator, field: 'profile.PLZ')}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="city">
                <g:message code="educatorProfile.city.label" default="Stadt"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: educator, field: 'profile.city', 'errors')}" size="30" id="city" name="city" value="${fieldValue(bean: educator, field: 'profile.city')}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="street">
                <g:message code="educatorProfile.street.label" default="Straße"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: educator, field: 'profile.street', 'errors')}" size="30" id="street" name="street" value="${fieldValue(bean: educator, field: 'profile.street')}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="contact">
                <g:message code="educatorProfile.contact.label" default="Kontakt"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: educator, field: 'profile.contact', 'errors')}" size="30" id="contact" name="contact" value="${fieldValue(bean: educator, field: 'profile.contact')}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="education">
                <g:message code="educatorProfile.education.label" default="Ausbildung"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:select name="education" from="${['Pädagoge','Psychologe','Soziologe','Lehrer (staatl. Ausbildung)','Erzieher','Psychopädagoge','Bildender Künstler','Arzt','Krankenschwester','Wirtschafter','Buchhalter/Steuerberater']}" value="${fieldValue(bean:educator,field:'profile.education')}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label>
                <g:message code="educatorProfile.employed.label" default="Angestellt?"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:checkBox name="employed" value="${educator?.profile?.employed}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="function">
                <g:message code="educatorProfile.function.label" default="Funktion"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:select name="function" from="${['Direktion','Programmkoordination','Programm','Projekt','Bereiche','Tutor','Köchin','Freiwilliger']}" value="${fieldValue(bean:educator,field:'profile.function')}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="gender">
                <g:message code="educatorProfile.gender.label" default="Geschlecht"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:select name="gender" from="${[1:'Männlich',2:'Weiblich']}" value="${fieldValue(bean:educator,field:'profile.gender')}" optionKey="key" optionValue="value"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="interests">
                <g:message code="educatorProfile.interests.label" default="Interessen"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: educator, field: 'profile.interests', 'errors')}" size="30" id="interests" name="interests" value="${fieldValue(bean: educator, field: 'profile.interests')}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="joinDate">
                <g:message code="educatorProfile.joinDate.label" default="Eintrittsdatum"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:datePicker name="joinDate" value="${educator?.profile?.joinDate}" precision="day"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="quitDate">
                <g:message code="educatorProfile.quitDate.label" default="Austrittsdatum"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:datePicker name="quitDate" value="${educator?.profile?.quitDate}" precision="day"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="languages">
                <g:message code="educatorProfile.languages.label" default="Sprachen"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:select multiple="true" name="languages" from="${['Deutsch', 'Englisch', 'Französisch', 'Spanisch','Tsotsil','Tseltal','Zoque','Tojolabal','Kanjobal','Lacandon','Quiche','Chol','Cakchiquel']}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="nationality">
                <g:message code="educatorProfile.nationality.label" default="Nationalität"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:select name="nationality" from="${['Deutschland', 'England', 'Frankreich', 'Spanien', 'Portugal','Österreich']}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="enabled">
                <g:message code="educatorProfile.enabled.label" default="Aktiv?"/>
              </label>

            </td>
            <td valign="top" class="value">
              <g:checkBox name="enabled" value="${parent?.user?.enabled}"/>
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
</div>
</body>
