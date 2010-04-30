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
              <g:textField class="${hasErrors(bean:parent,field:'profile.firstName','errors')}" size="30" id="firstName" name="firstName" value="${fieldValue(bean:parent,field:'profile.firstName').decodeHTML()}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="lastName">
                <g:message code="parentProfile.lastName.label" default="Nachname"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: parent, field: 'profile.lastName', 'errors')}" size="30" id="lastName" name="lastName" value="${fieldValue(bean: parent, field: 'profile.lastName').decodeHTML()}"/>
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
              <label for="currentCountry">
                <g:message code="parentProfile.currentCountry.label" default="Land"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: parent, field: 'profile.country', 'errors')}" size="30" id="currentCountry" name="currentCountry" value="${fieldValue(bean: parent, field: 'profile.currentCountry').decodeHTML()}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="currentZip">
                <g:message code="parentProfile.currentZip.label" default="PLZ"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: parent, field: 'profile.currentZip', 'errors')}" size="30" id="currentZip" name="currentZip" value="${fieldValue(bean: parent, field: 'profile.currentZip').decodeHTML()}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="currentCity">
                <g:message code="parentProfile.currentCity.label" default="Stadt"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: parent, field: 'profile.currentCity', 'errors')}" size="30" id="currentCity" name="currentCity" value="${fieldValue(bean: parent, field: 'profile.currentCity').decodeHTML()}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="currentStreet">
                <g:message code="parentProfile.currentStreet.label" default="Straße"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: parent, field: 'profile.currentStreet', 'errors')}" size="30" id="currentStreet" name="currentStreet" value="${fieldValue(bean: parent, field: 'profile.currentStreet').decodeHTML()}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="maritalStatus">
                <g:message code="parentProfile.maritalStatus.label" default="Familienstand"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:select name="maritalStatus" from="${['ledig','verheiratet','getrennt lebend','geschieden','verwitwet','verpartnert','unbekannt']}" value="${fieldValue(bean:parent,field:'profile.maritalStatus')}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="languages">
                <g:message code="parentProfile.languages.label" default="Sprachen"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:select class="${hasErrors(bean: parent, field: 'profile.languages', 'errors')}" multiple="true" name="languages" from="${grailsApplication.config.languages}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="education">
                <g:message code="parentProfile.education.label" default="Schulbildung"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:select id="education" name="education" from="${1..12}" value="${fieldValue(bean: parent, field: 'profile.education')}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="job">
                <g:message code="parentProfile.job.label" default="Berufstätig?"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:checkBox name="job" value="${parent?.profile?.job}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="jobType">
                <g:message code="parentProfile.jobType.label" default="Arbeit"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: parent, field: 'profile.jobType', 'errors')}" size="30" id="jobType" name="jobType" value="${fieldValue(bean: parent, field: 'profile.jobType').decodeHTML()}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="jobIncome">
                <g:message code="parentProfile.jobIncome.label" default="Einkommen"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: parent, field: 'profile.jobIncome', 'errors')}" size="30" id="jobIncome" name="jobIncome" value="${parent?.profile?.jobIncome?.toInteger()}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="jobFrequency">
                <g:message code="parentProfile.jobFrequency.label" default="Jobhäufigkeit"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: parent, field: 'profile.jobFrequency', 'errors')}" size="30" id="jobFrequency" name="jobFrequency" value="${parent?.profile?.jobFrequency?.toInteger()}"/>
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
                <g:message code="parentProfile.showTips.label" default="Passwort"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:link controller="profile" action="changePassword" id="${parent.id}">Passwort ändern</g:link>
            </td>
          </tr>

          </tbody>
        </table>
      </div>
      <div class="buttons">
        <g:submitButton name="submitButton" value="Speichern"/>
        <g:link class="buttonGray" action="show" id="${parent.id}">Abbrechen</g:link>
        <div class="spacer"></div>
      </div>
    </g:form>
  </div>
</div>
</body>