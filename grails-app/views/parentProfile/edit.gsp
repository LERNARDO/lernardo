<head>
  <meta name="layout" content="private"/>
  <title>Lernardo | Erziehungsberechtigten bearbeiten</title>
</head>
<body>
<div class="headerBlue">
  <div class="second">
    <h1>Erziehungsberechtigten bearbeiten</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

  %{--TODO: figure out why error messages are not shown?!?--}%
    <g:hasErrors bean="${parent}">
      <div class="errors">
        <g:renderErrors bean="${parent}" as="list"/>
      </div>
    </g:hasErrors>

    <g:form action="update" method="post" id="${parent.id}">
      <div class="dialog">
        <table>
          <tbody>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="firstName">
                <g:message code="parentProfile.firstName.label" default="Vorname"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean:parent,field:'profile.firstName','errors')}" size="30" id="firstName" name="firstName" value="${fieldValue(bean:parent,field:'profile.firstName')}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="lastName">
                <g:message code="parentProfile.lastName.label" default="Nachname"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: parent, field: 'profile.lastName', 'errors')}" size="30" id="lastName" name="lastName" value="${fieldValue(bean: parent, field: 'profile.lastName')}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label>
                <g:message code="parentProfile.birthDate.label" default="Geburtsdatum"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:datePicker name="birthDate" value="${parent?.profile?.birthDate}" precision="day"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="email">
                <g:message code="parentProfile.email.label" default="E-Mail"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: parent, field: 'user.email', 'errors')}" size="30" maxlength="80" id="email" name="email" value="${fieldValue(bean: parent, field: 'user.email')}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="PLZ">
                <g:message code="parentProfile.PLZ.label" default="PLZ"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: parent, field: 'profile.PLZ', 'errors')}" size="30" id="PLZ" name="PLZ" value="${fieldValue(bean: parent, field: 'profile.PLZ')}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="city">
                <g:message code="parentProfile.city.label" default="Stadt"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: parent, field: 'profile.city', 'errors')}" size="30" id="city" name="city" value="${fieldValue(bean: parent, field: 'profile.city')}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="street">
                <g:message code="parentProfile.street.label" default="Straße"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: parent, field: 'profile.street', 'errors')}" size="30" id="street" name="street" value="${fieldValue(bean: parent, field: 'profile.street')}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="familyStatus">
                <g:message code="parentProfile.familyStatus.label" default="Familienstand"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:select name="familyStatus" from="${['ledig','verheiratet','getrennt lebend','geschieden','verwitwet','verpartnert','unbekannt']}" value="${fieldValue(bean:parent,field:'profile.familyStatus')}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="gender">
                <g:message code="parentProfile.gender.label" default="Geschlecht"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:select name="gender" from="${[1:'Männlich',2:'Weiblich']}" value="${fieldValue(bean:parent,field:'profile.gender')}" optionKey="key" optionValue="value"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="languages">
                <g:message code="parentProfile.languages.label" default="Sprachen"/>
              </label>
            </td>
            <td valign="top" class="value">
              %{--TODO: figure out how to highlight the currently selected values--}%
              <g:select multiple="true" name="languages" from="${['Deutsch', 'Englisch', 'Französisch', 'Spanisch','Tsotsil','Tseltal','Zoque','Tojolabal','Kanjobal','Lacandon','Quiche','Chol','Cakchiquel']}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="nationality">
                <g:message code="parentProfile.nationality.label" default="Nationalität"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:select name="nationality" from="${['Deutschland', 'England', 'Frankreich', 'Spanien', 'Portugal','Österreich']}"  value="${parent.profile.nationality}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="qualification">
                <g:message code="parentProfile.qualification.label" default="Qualifikationen"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textArea class="${hasErrors(bean: parent, field: 'profile.qualification', 'errors')}" rows="6" cols="50" id="qualification" name="qualification" value="${fieldValue(bean: parent, field: 'profile.qualification')}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="doesWork">
                <g:message code="parentProfile.doesWork.label" default="Berufstätig?"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:checkBox name="doesWork" value="${parent.profile.doesWork}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="work">
                <g:message code="parentProfile.work.label" default="Arbeit"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: parent, field: 'profile.work', 'errors')}" size="30" id="work" name="work" value="${fieldValue(bean: parent, field: 'profile.work')}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="lang">
                <g:message code="parentProfile.lang.label" default="Spracheinstellung"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:select name="lang" from="${[1:'Deutsch', 2:'Spanisch']}" optionKey="key" optionValue="value"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="showTips">
                <g:message code="parentProfile.showTips.label" default="Tipps"/>
              </label>

            </td>
            <td valign="top" class="value">
              <g:checkBox name="showTips" value="${parent.profile.showTips}"/>
            </td>
          </tr>

          <app:isAdmin>
            <tr class="prop">
              <td valign="top" class="name">
                <label for="enabled">
                  <g:message code="parentProfile.enabled.label" default="Aktiv?"/>
                </label>

              </td>
              <td valign="top" class="value">
                <g:checkBox name="enabled" value="${parent.user.enabled}"/>
              </td>
            </tr>
          </app:isAdmin>

          <tr class="prop">
            <td valign="top" class="name">
              <label>
                <g:message code="pateProfile.showTips.label" default="Passwort"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:link controller="profile" action="changePassword" id="${pate.id}">Passwort ändern</g:link>
            </td>
          </tr>

          </tbody>
        </table>
      </div>
      <div class="buttons">
        <g:submitButton name="submitButton" value="Aktualisieren"/>
        <g:link class="buttonGray" action="del" id="${parent.id}" onclick="return confirm('Bist du sicher?');">Löschen</g:link>
        <g:link class="buttonGray" action="show" id="${parent.id}">Zurück</g:link>
        <div class="spacer"></div>
      </div>
    </g:form>
  </div>
</div>
</body>