<head>
  <meta name="layout" content="private"/>
  <title>Lernardo | Erziehungsberechtigten anlegen</title>
</head>
<body>
<div class="headerBlue">
  <div class="second">
    <h1>Erziehungsberechtigten anlegen</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <g:hasErrors bean="${parent}">
      <div class="errors">
        <g:renderErrors bean="${parent}" as="list"/>
      </div>
    </g:hasErrors>

    <g:form action="save" method="post">
      <div class="dialog">
        <table>
          <tbody>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="firstName">
                <g:message code="parent.profile.firstName"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean:parent,field:'profile.firstName','errors')}" size="30" id="firstName" name="firstName" value="${fieldValue(bean:parent,field:'profile.firstName').decodeHTML()}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="lastName">
                <g:message code="parent.profile.lastName"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: parent, field: 'profile.lastName', 'errors')}" size="30" id="lastName" name="lastName" value="${fieldValue(bean: parent, field: 'profile.lastName').decodeHTML()}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label>
                <g:message code="parent.profile.birthDate"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:datePicker name="birthDate" value="${parent?.profile?.birthDate}" precision="day"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="gender">
                <g:message code="parent.profile.gender"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:select name="gender" from="${[1:'Männlich',2:'Weiblich']}" value="${fieldValue(bean:parent,field:'profile.gender')}" optionKey="key" optionValue="value"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="email">
                <g:message code="parent.profile.email"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: parent, field: 'user.email', 'errors')}" size="30" maxlength="80" id="email" name="email" value="${fieldValue(bean: parent, field: 'user.email')}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="currentCountry">
                <g:message code="parent.profile.currentCountry"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: parent, field: 'profile.country', 'errors')}" size="30" id="currentCountry" name="currentCountry" value="${fieldValue(bean: parent, field: 'profile.currentCountry').decodeHTML()}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="currentZip">
                <g:message code="parent.profile.currentZip"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: parent, field: 'profile.currentZip', 'errors')}" size="30" id="currentZip" name="currentZip" value="${fieldValue(bean: parent, field: 'profile.currentZip').decodeHTML()}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="currentCity">
                <g:message code="parent.profile.currentCity"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: parent, field: 'profile.currentCity', 'errors')}" size="30" id="currentCity" name="currentCity" value="${fieldValue(bean: parent, field: 'profile.currentCity').decodeHTML()}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="currentStreet">
                <g:message code="parent.profile.currentStreet"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: parent, field: 'profile.currentStreet', 'errors')}" size="30" id="currentStreet" name="currentStreet" value="${fieldValue(bean: parent, field: 'profile.currentStreet').decodeHTML()}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="maritalStatus">
                <g:message code="parent.profile.maritalStatus"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:select name="maritalStatus" from="${['ledig','verheiratet','getrennt lebend','geschieden','verwitwet','verpartnert','unbekannt']}" value="${fieldValue(bean:parent,field:'profile.maritalStatus')}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="languages">
                <g:message code="parent.profile.languages"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:select class="${hasErrors(bean: parent, field: 'profile.languages', 'errors')}" multiple="true" name="languages" from="${grailsApplication.config.languages}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="education">
                <g:message code="parent.profile.education"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:select id="education" name="education" from="${['1. Primaria', '2. Primaria', '3. Primaria', '4. Primaria', '5. Primaria', '6. Primaria', '1. Secundaria', '2. Secundaria', '3. Secundaria', '1. Präparatoria', '2. Präparatoria', '3. Präparatoria']}" value="${fieldValue(bean: parent, field: 'profile.education')}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="job">
                <g:message code="parent.profile.job"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:checkBox name="job" value="${parent?.profile?.job}"/>
            </td>
          </tr>
         
          <tr class="prop">
            <td valign="top" class="name">
              <label for="jobType">
                <g:message code="parent.profile.jobType"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: parent, field: 'profile.jobType', 'errors')}" size="30" id="jobType" name="jobType" value="${fieldValue(bean: parent, field: 'profile.jobType').decodeHTML()}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="jobIncome">
                <g:message code="parent.profile.jobIncome"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: parent, field: 'profile.jobIncome', 'errors')}" size="30" id="jobIncome" name="jobIncome" value="${parent?.profile?.jobIncome?.toInteger()}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="jobFrequency">
                <g:message code="parent.profile.jobFrequency"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: parent, field: 'profile.jobFrequency', 'errors')}" size="30" id="jobFrequency" name="jobFrequency" value="${parent?.profile?.jobFrequency?.toInteger()}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="locale">
                <g:message code="languageSelection"/>
              </label>
            </td>
            <td valign="top" class="value">
              <app:localeSelect name="locale" value="${parent?.user?.locale}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="enabled">
                <g:message code="active"/>
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
        <g:submitButton name="submitButton" value="${message(code:'save')}"/>
        <g:link class="buttonGray" action="list"><g:message code="cancel"/></g:link>
        <div class="spacer"></div>
      </div>
    </g:form>
  </div>
</div>
</body>
