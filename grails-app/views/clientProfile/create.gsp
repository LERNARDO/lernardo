<head>
  <meta name="layout" content="private"/>
  <title>Lernardo | Betreuten anlegen</title>
</head>
<body>
<div class="headerBlue">
  <div class="second">
    <h1>Betreuten anlegen</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <g:hasErrors bean="${client}">
      <div class="errors">
        <g:renderErrors bean="${client}" as="list"/>
      </div>
    </g:hasErrors>

    <g:form action="save" method="post">
      <div class="dialog">
        <table>
          <tbody>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="firstName">
                <g:message code="clientProfile.firstName.label" default="Vorname"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: client, field: 'profile.firstName', 'errors')}" size="30" id="firstName" name="firstName" value="${fieldValue(bean: client, field: 'profile.firstName').decodeHTML()}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="lastName">
                <g:message code="clientProfile.lastName.label" default="Nachname"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: client, field: 'profile.lastName', 'errors')}" size="30" id="lastName" name="lastName" value="${fieldValue(bean: client, field: 'profile.lastName').decodeHTML()}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="email">
                <g:message code="clientProfile.email.label" default="E-Mail"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: client, field: 'user.email', 'errors')}" size="30" maxlength="80" id="email" name="email" value="${fieldValue(bean: client, field: 'user.email')}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="birthDate">
                <g:message code="clientProfile.birthDate.label" default="Geburtsdatum"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:datePicker name="birthDate" value="${client?.profile?.birthDate}" precision="day"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="country">
                <p class="bold">Derzeitige Adresse</p>
              </label>
            </td>
            <td valign="top" class="value">
              &nbsp;
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="street">
                <g:message code="clientProfile.street.label" default="Straße"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: client, field: 'profile.street', 'errors')}" size="30" id="street" name="street" value="${fieldValue(bean: client, field: 'profile.street').decodeHTML()}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="city">
                <g:message code="clientProfile.city.label" default="Stadt"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: client, field: 'profile.city', 'errors')}" size="30" id="city" name="city" value="${fieldValue(bean: client, field: 'profile.city').decodeHTML()}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="PLZ">
                <g:message code="clientProfile.PLZ.label" default="PLZ"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: client, field: 'profile.PLZ', 'errors')}" size="30" id="PLZ" name="PLZ" value="${fieldValue(bean: client, field: 'profile.PLZ').decodeHTML()}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="country">
                <g:message code="clientProfile.country.label" default="Land"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: client, field: 'profile.country', 'errors')}" size="30" id="country" name="country" value="${fieldValue(bean: client, field: 'profile.country').decodeHTML()}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="country">
                <p class="bold">Herkunft</p>
              </label>
            </td>
            <td valign="top" class="value">
              &nbsp;
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="street2">
                <g:message code="clientProfile.street2.label" default="Straße"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: client, field: 'profile.street2', 'errors')}" size="30" id="street2" name="street2" value="${fieldValue(bean: client, field: 'profile.street2').decodeHTML()}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="city2">
                <g:message code="clientProfile.city2.label" default="Stadt"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: client, field: 'profile.city2', 'errors')}" size="30" id="city2" name="city2" value="${fieldValue(bean: client, field: 'profile.city2').decodeHTML()}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="PLZ2">
                <g:message code="clientProfile.PLZ2.label" default="PLZ"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: client, field: 'profile.PLZ2', 'errors')}" size="30" id="PLZ2" name="PLZ2" value="${fieldValue(bean: client, field: 'profile.PLZ2').decodeHTML()}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="country2">
                <g:message code="clientProfile.country2.label" default="Land"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: client, field: 'profile.country2', 'errors')}" size="30" id="country2" name="country2" value="${fieldValue(bean: client, field: 'profile.country2').decodeHTML()}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="country">
                <p class="bold">Weitere Daten</p>
              </label>
            </td>
            <td valign="top" class="value">
              &nbsp;
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="joinDate">
                <g:message code="clientProfile.joinDate.label" default="Eintrittsdatum"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:datePicker name="joinDate" value="${client?.profile?.joinDate}" precision="day" default="none" noSelection="['':'']"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="endDate">
                <g:message code="clientProfile.endDate.label" default="Austrittsdatum"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:datePicker name="endDate" value="${client?.profile?.endDate}" precision="day" default="none" noSelection="['':'']"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="joinDate2">
                <g:message code="clientProfile.joinDate2.label" default="Eintrittsdatum #2"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:datePicker name="joinDate2" value="${client?.profile?.joinDate2}" precision="day" default="none" noSelection="['':'']"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="endDate2">
                <g:message code="clientProfile.endDate2.label" default="Austrittsdatum #2"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:datePicker name="endDate2" value="${client?.profile?.endDate2}" precision="day" default="none" noSelection="['':'']"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="notes">
                <g:message code="clientProfile.notes.label" default="Notizen"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textArea class="${hasErrors(bean: client, field: 'profile.notes', 'errors')}" id="notes" rows="6" cols="50" name="notes" value="${fieldValue(bean: client, field: 'profile.notes').decodeHTML()}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="interests">
                <g:message code="clientProfile.interests.label" default="Interessen"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textArea class="${hasErrors(bean: client, field: 'profile.interests', 'errors')}" id="interests" rows="6" cols="50" name="interests" value="${fieldValue(bean: client, field: 'profile.interests').decodeHTML()}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="personalDetails">
                <g:message code="clientProfile.personalDetails.label" default="Persönliche Details"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textArea class="${hasErrors(bean: client, field: 'profile.personalDetails', 'errors')}" id="personalDetails" rows="6" cols="50" name="personalDetails" value="${fieldValue(bean: client, field: 'profile.personalDetails').decodeHTML()}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="attendance">
                <g:message code="clientProfile.attendance.label" default="Anwesenheit"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: client, field: 'profile.attendance', 'errors')}" size="30" id="attendance" name="attendance" value="${fieldValue(bean: client, field: 'profile.attendance').decodeHTML()}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="doesWork">
                <g:message code="clientProfile.doesWork.label" default="Berufstätig?"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:checkBox name="doesWork" value="${client?.profile?.doesWork}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="work">
                <g:message code="clientProfile.work.label" default="Arbeit"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: client, field: 'profile.work', 'errors')}" size="30" id="work" name="work" value="${fieldValue(bean: client, field: 'profile.work').decodeHTML()}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="income">
                <g:message code="clientProfile.income.label" default="Einkommen"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: client, field: 'profile.income', 'errors')}" size="30" id="income" name="income" value="${fieldValue(bean: client, field: 'profile.income')}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="gender">
                <g:message code="clientProfile.gender.label" default="Geschlecht"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:select name="gender" from="${[1:'Männlich',2:'Weiblich']}" value="${fieldValue(bean:client,field:'profile.gender')}" optionKey="key" optionValue="value"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="languages">
                <g:message code="clientProfile.languages.label" default="Sprachen"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:select class="${hasErrors(bean: client, field: 'profile.languages', 'errors')}" multiple="true" name="languages" from="${grailsApplication.config.languages}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="nationality">
                <g:message code="clientProfile.nationality.label" default="Nationalität"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:select name="nationality" from="${grailsApplication.config.nationalities}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="school">
                <g:message code="clientProfile.schoolLevel.label" default="Schule"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:select id="school" name="school" from="${1..12}" value="${fieldValue(bean: client, field: 'profile.school')}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="schoolLevel">
                <g:message code="clientProfile.schoolLevel.label" default="Schulstufe"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:select id="schoolLevel" name="schoolLevel" from="${1..12}" value="${fieldValue(bean: client, field: 'profile.schoolLevel')}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="dropout">
                <g:message code="clientProfile.dropout.label" default="Aussteiger?"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:checkBox name="dropout" value="${client?.profile?.dropout}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="dropoutReason">
                <g:message code="clientProfile.dropoutReason.label" default="Aussteiger Grund"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: client, field: 'profile.dropoutReason', 'errors')}" size="30" id="dropoutReason" name="dropoutReason" value="${fieldValue(bean: client, field: 'profile.dropoutReason').decodeHTML()}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="lang">
                <g:message code="clientProfile.lang.label" default="Spracheinstellung"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:select name="lang" from="${[1:'Deutsch', 2:'Spanisch']}" optionKey="key" optionValue="value"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="enabled">
                <g:message code="clientProfile.enabled.label" default="Aktiv?"/>
              </label>

            </td>
            <td valign="top" class="value">
              <g:checkBox name="enabled" value="${client?.user?.enabled}"/>
            </td>
          </tr>

          </tbody>
        </table>
      </div>
      <div class="buttons">
        <g:submitButton name="submitButton" value="Speichern"/>
        <g:link class="buttonGray" action="list">Abbrechen</g:link>
        <div class="spacer"></div>
      </div>
    </g:form>
  </div>
</div>
</body>
 