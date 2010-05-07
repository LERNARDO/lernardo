<head>
  <meta name="layout" content="private"/>
  <title>Lernardo | Pädagogen bearbeiten</title>
</head>
<body>
<div class="headerBlue">
  <div class="second">
    <h1>Pädagogen bearbeiten</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <g:hasErrors bean="${educator}">
      <div class="errors">
        <g:renderErrors bean="${educator}" as="list"/>
      </div>
    </g:hasErrors>

    <g:form action="update" method="post" id="${educator.id}">
      <div class="dialog">
        <table>
          <tbody>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="title">
                <g:message code="educator.profile.title"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: educator, field: 'profile.title', 'errors')}" size="30" id="title" name="title" value="${fieldValue(bean: educator, field: 'profile.title').decodeHTML()}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="firstName">
                <g:message code="educator.profile.firstName"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: educator, field: 'profile.firstName', 'errors')}" size="30" id="firstName" name="firstName" value="${fieldValue(bean: educator, field: 'profile.firstName').decodeHTML()}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="lastName">
                <g:message code="educator.profile.lastName"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: educator, field: 'profile.lastName', 'errors')}" size="30" id="lastName" name="lastName" value="${fieldValue(bean: educator, field: 'profile.lastName').decodeHTML()}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="email">
                <g:message code="educator.profile.email"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: educator, field: 'user.email', 'errors')}" size="30" type="text" maxlength="80" id="email" name="email" value="${fieldValue(bean: educator, field: 'user.email')}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="birthDate">
                <g:message code="educator.profile.birthDate"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:datePicker name="birthDate" value="${educator?.profile?.birthDate}" precision="day"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="gender">
                <g:message code="educator.profile.gender"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:select name="gender" from="${[1:'Männlich',2:'Weiblich']}" value="${fieldValue(bean:educator,field:'profile.gender')}" optionKey="key" optionValue="value"/>
            </td>
          </tr>

          <tr>
            <td><span class="bold">Derzeitige Adresse</span></td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="currentStreet">
                <g:message code="educator.profile.currentStreet"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: educator, field: 'profile.currentStreet', 'errors')}" size="30" id="currentStreet" name="currentStreet" value="${fieldValue(bean: educator, field: 'profile.currentStreet').decodeHTML()}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="currentCity">
                <g:message code="educator.profile.currentCity"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: educator, field: 'profile.currentCity', 'errors')}" size="30" id="currentCity" name="currentCity" value="${fieldValue(bean: educator, field: 'profile.currentCity').decodeHTML()}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="currentZip">
                <g:message code="educator.profile.currentZip"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: educator, field: 'profile.currentZip', 'errors')}" size="30" id="currentZip" name="currentZip" value="${fieldValue(bean: educator, field: 'profile.currentZip').decodeHTML()}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="currentCountry">
                <g:message code="educator.profile.currentCountry"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: educator, field: 'profile.currentCountry', 'errors')}" size="30" id="currentCountry" name="currentCountry" value="${fieldValue(bean: educator, field: 'profile.currentCountry').decodeHTML()}"/>
            </td>
          </tr>

          <tr>
            <td><span class="bold">Herkunft</span></td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="originStreet">
                <g:message code="educator.profile.originStreet"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: educator, field: 'profile.originStreet', 'errors')}" size="30" id="originStreet" name="originStreet" value="${fieldValue(bean: educator, field: 'profile.originStreet').decodeHTML()}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="originCity">
                <g:message code="educator.profile.originCity"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: educator, field: 'profile.originCity', 'errors')}" size="30" id="originCity" name="originCity" value="${fieldValue(bean: educator, field: 'profile.originCity').decodeHTML()}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="originZip">
                <g:message code="educator.profile.originZip"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: educator, field: 'profile.originZip', 'errors')}" size="30" id="originZip" name="originZip" value="${fieldValue(bean: educator, field: 'profile.originZip').decodeHTML()}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="originCountry">
                <g:message code="educator.profile.originCountry"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: educator, field: 'profile.originCountry', 'errors')}" size="30" id="originCountry" name="originCountry" value="${fieldValue(bean: educator, field: 'profile.originCountry').decodeHTML()}"/>
            </td>
          </tr>

          <tr>
            <td><span class="bold">Kontakt im Notfall</span></td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="contactStreet">
                <g:message code="educator.profile.contactStreet"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: educator, field: 'profile.contactStreet', 'errors')}" size="30" id="contactStreet" name="contactStreet" value="${fieldValue(bean: educator, field: 'profile.contactStreet').decodeHTML()}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="contactCity">
                <g:message code="educator.profile.contactCity"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: educator, field: 'profile.contactCity', 'errors')}" size="30" id="contactCity" name="contactCity" value="${fieldValue(bean: educator, field: 'profile.contactCity').decodeHTML()}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="contactZip">
                <g:message code="educator.profile.contactZip"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: educator, field: 'profile.contactZip', 'errors')}" size="30" id="contactZip" name="contactZip" value="${fieldValue(bean: educator, field: 'profile.contactZip').decodeHTML()}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="contactCountry">
                <g:message code="educator.profile.contactCountry"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: educator, field: 'profile.contactCountry', 'errors')}" size="30" id="contactCountry" name="contactCountry" value="${fieldValue(bean: educator, field: 'profile.contactCountry').decodeHTML()}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="contactPhone">
                <g:message code="educator.profile.contactPhone"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: educator, field: 'profile.contactPhone', 'errors')}" size="30" id="contactPhone" name="contactPhone" value="${fieldValue(bean: educator, field: 'profile.contactPhone').decodeHTML()}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="contactMail">
                <g:message code="educator.profile.contactMail"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: educator, field: 'profile.contactMail', 'errors')}" size="30" id="contactMail" name="contactMail" value="${fieldValue(bean: educator, field: 'profile.contactMail').decodeHTML()}"/>
            </td>
          </tr>

          <!-- end contact -->

          <tr class="prop">
            <td valign="top" class="name">
              <label for="languages">
                <g:message code="educator.profile.languages"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:select class="${hasErrors(bean: educator, field: 'profile.languages', 'errors')}" multiple="true" name="languages" from="${grailsApplication.config.languages}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="education">
                <g:message code="educator.profile.education"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:select name="education" from="${['Pädagoge','Psychologe','Soziologe','Lehrer (staatl. Ausbildung)','Erzieher','Psychopädagoge','Bildender Künstler','Arzt','Krankenschwester','Wirtschafter','Buchhalter/Steuerberater']}" value="${fieldValue(bean:educator,field:'profile.education')}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="interests">
                <g:message code="educator.profile.interests"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: educator, field: 'profile.interests', 'errors')}" size="30" id="interests" name="interests" value="${fieldValue(bean: educator, field: 'profile.interests').decodeHTML()}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="inChargeOf">
                <g:message code="educator.profile.inChargeOf"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:select name="inChargeOf" from="${['Direktion','Programmkoordination','Programm','Projekt','Bereiche','Tutor','Köchin','Freiwilliger']}" multiple="true" value="${fieldValue(bean:educator,field:'profile.inChargeOf')}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label>
                <g:message code="educator.profile.employment"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:select name="employment" from="${['Angestellt','Freier Mitarbeiter','Freiwilliger']}" value="${fieldValue(bean:educator,field:'profile.employment')}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label>
                <g:message code="educator.profile.enlistet"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:select name="enlisted" from="${partner}" value="" noSelection="['':'kein']" optionKey="id" optionValue="profile"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="locale">
                <g:message code="languageSelection"/>
              </label>
            </td>
            <td valign="top" class="value">
              <app:localeSelect name="locale" value="${educator?.user?.locale}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="showTips">
                <g:message code="showTips"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:checkBox name="showTips" value="${educator?.profile?.showTips}"/>
            </td>
          </tr>

          <app:isAdmin>
            <tr class="prop">
              <td valign="top" class="name">
                <label for="enabled">
                  <g:message code="active"/>
                </label>

              </td>
              <td valign="top" class="value">
                <g:checkBox name="enabled" value="${educator?.user?.enabled}"/>
              </td>
            </tr>
          </app:isAdmin>

          <tr class="prop">
            <td valign="top" class="name">
              <label>
                <g:message code="password"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:link controller="profile" action="changePassword" id="${educator.id}">Passwort ändern</g:link>
            </td>
          </tr>

          </tbody>
        </table>
      </div>
      <div class="buttons">
        <g:submitButton name="submitButton" value="${message(code:'save')}"/>
        <g:link class="buttonGray" action="show" id="${educator.id}"><g:message code="cancel"/></g:link>
        <div class="spacer"></div>
      </div>
    </g:form>
  </div>
</div>
</body>