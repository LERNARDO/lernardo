<%@ page import="org.springframework.web.servlet.support.RequestContextUtils" %>
<head>
  <meta name="layout" content="private"/>
  <title>Lernardo | Betreuten bearbeiten</title>
</head>
<body>
<div class="headerBlue">
  <div class="second">
    <h1>Betreuten bearbeiten</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <g:hasErrors bean="${client}">
      <div class="errors">
        <g:renderErrors bean="${client}" as="list"/>
      </div>
    </g:hasErrors>

    <g:form action="update" method="post" id="${client.id}">
      <div class="dialog">
        <table>
          <tbody>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="firstName">
                <g:message code="client.profile.firstName"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: client, field: 'profile.firstName', 'errors')}" size="30" id="firstName" name="firstName" value="${fieldValue(bean: client, field: 'profile.firstName').decodeHTML()}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="lastName">
                <g:message code="client.profile.lastName"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: client, field: 'profile.lastName', 'errors')}" size="30" id="lastName" name="lastName" value="${fieldValue(bean: client, field: 'profile.lastName').decodeHTML()}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="email">
                <g:message code="client.profile.email"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: client, field: 'user.email', 'errors')}" size="30" maxlength="80" id="email" name="email" value="${fieldValue(bean: client, field: 'user.email')}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="birthDate">
                <g:message code="client.profile.birthDate"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:datePicker name="birthDate" value="${client?.profile?.birthDate}" precision="day"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="gender">
                <g:message code="client.profile.gender"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:select name="gender" from="${['1':message(code:'male'),'2':message(code:'female')]}" value="${fieldValue(bean:client,field:'profile.gender')}" optionKey="key" optionValue="value"/>
            </td>
          </tr>

          <tr>
            <td><span class="bold">Derzeitige Adresse</span></td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="currentStreet">
                <g:message code="client.profile.currentStreet"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: client, field: 'profile.currentStreet', 'errors')}" size="30" id="currentStreet" name="currentStreet" value="${fieldValue(bean: client, field: 'profile.currentStreet').decodeHTML()}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="currentCity">
                <g:message code="client.profile.currentCity"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: client, field: 'profile.currentCity', 'errors')}" size="30" id="currentCity" name="currentCity" value="${fieldValue(bean: client, field: 'profile.currentCity').decodeHTML()}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="currentZip">
                <g:message code="client.profile.currentZip"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: client, field: 'profile.currentZip', 'errors')}" size="30" id="currentZip" name="currentZip" value="${fieldValue(bean: client, field: 'profile.currentZip').decodeHTML()}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="currentCountry">
                <g:message code="client.profile.currentCountry"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: client, field: 'profile.currentCountry', 'errors')}" size="30" id="currentCountry" name="currentCountry" value="${fieldValue(bean: client, field: 'profile.currentCountry').decodeHTML()}"/>
            </td>
          </tr>

          <tr>
            <td><span class="bold">Herkunft</span></td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="originCity">
                <g:message code="client.profile.originCity"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: client, field: 'profile.originCity', 'errors')}" size="30" id="originCity" name="originCity" value="${fieldValue(bean: client, field: 'profile.originCity').decodeHTML()}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="originZip">
                <g:message code="client.profile.originZip"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: client, field: 'profile.originZip', 'errors')}" size="30" id="originZip" name="originZip" value="${fieldValue(bean: client, field: 'profile.originZip').decodeHTML()}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="originCountry">
                <g:message code="client.profile.originCountry"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: client, field: 'profile.originCountry', 'errors')}" size="30" id="originCountry" name="originCountry" value="${fieldValue(bean: client, field: 'profile.originCountry').decodeHTML()}"/>
            </td>
          </tr>

          <tr>
            <td><span class="bold">Weitere Daten</span></td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="familyStatus">
                <g:message code="client.profile.familyStatus"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:select class="${hasErrors(bean: client, field: 'profile.familyStatus', 'errors')}" name="familyStatus" from="${['bei Eltern']}" value="${client.profile.familyStatus}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="languages">
                <g:message code="client.profile.languages"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:if test="${RequestContextUtils.getLocale(request).toString() == 'es'}">
                <g:select name="languages" multiple="true" from="${grailsApplication.config.languages_es}" optionKey="key" optionValue="value"/>
              </g:if>
              <g:if test="${RequestContextUtils.getLocale(request).toString() == 'de'}">
                <g:select name="languages" multiple="true" from="${grailsApplication.config.languages_de}" optionKey="key" optionValue="value"/>
              </g:if>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="schoolLevel">
                <g:message code="client.profile.schoolLevel"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:if test="${RequestContextUtils.getLocale(request).toString() == 'es'}">
                <g:select name="schoolLevel" id="schoolLevel" from="${grailsApplication.config.schoolLevels_es}" optionKey="key" optionValue="value"/>
              </g:if>
              <g:if test="${RequestContextUtils.getLocale(request).toString() == 'de'}">
                <g:select name="schoolLevel" id="schoolLevel" from="${grailsApplication.config.schoolLevels_de}" optionKey="key" optionValue="value"/>
              </g:if>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="schoolDropout">
                <g:message code="client.profile.schoolDropout"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:checkBox name="schoolDropout" value="${client?.profile?.schoolDropout}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="schoolDropoutReason">
                <g:message code="client.profile.schoolDropoutReason"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: client, field: 'profile.schoolDropoutReason', 'errors')}" size="30" id="schoolDropoutReason" name="schoolDropoutReason" value="${fieldValue(bean: client, field: 'profile.schoolDropoutReason').decodeHTML()}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="schoolDropoutDate">
                <g:message code="client.profile.schoolDropoutDate"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:datePicker name="schoolDropoutDate" value="${client?.profile?.schoolDropoutDate}" precision="day"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="schoolRestart">
                <g:message code="client.profile.schoolRestart"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:checkBox name="schoolRestart" value="${client?.profile?.schoolRestart}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="schoolRestartReason">
                <g:message code="client.profile.schoolRestartReason"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: client, field: 'profile.schoolRestartReason', 'errors')}" size="30" id="schoolRestartReason" name="schoolRestartReason" value="${fieldValue(bean: client, field: 'profile.schoolRestartReason').decodeHTML()}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="schoolRestartDate">
                <g:message code="client.profile.schoolRestartDate"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:datePicker name="schoolRestartDate" value="${client?.profile?.schoolRestartDate}" precision="day"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="interests">
                <g:message code="client.profile.interests"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textArea class="${hasErrors(bean: client, field: 'profile.interests', 'errors')}" id="interests" rows="6" cols="50" name="interests" value="${fieldValue(bean: client, field: 'profile.interests').decodeHTML()}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="size">
                <g:message code="client.profile.size"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: client, field: 'profile.size', 'errors')}" size="30" id="size" name="size" value="${fieldValue(bean: client, field: 'profile.size').decodeHTML()}"/> (cm)
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="weight">
                <g:message code="client.profile.weight"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: client, field: 'profile.weight', 'errors')}" size="30" id="weight" name="weight" value="${fieldValue(bean: client, field: 'profile.weight').decodeHTML()}"/> (kg)
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="job">
                <g:message code="client.profile.job"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:checkBox name="job" value="${client?.profile?.job}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="jobType">
                <g:message code="client.profile.jobType"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:if test="${RequestContextUtils.getLocale(request).toString() == 'es'}">
                <g:select name="jobType" id="jobType" from="${grailsApplication.config.jobs_es}" optionKey="key" optionValue="value"/>
              </g:if>
              <g:if test="${RequestContextUtils.getLocale(request).toString() == 'de'}">
                <g:select name="jobType" id="jobType" from="${grailsApplication.config.jobs_de}" optionKey="key" optionValue="value"/>
              </g:if>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="jobIncome">
                <g:message code="client.profile.jobIncome"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: client, field: 'profile.jobIncome', 'errors')}" size="30" id="jobIncome" name="jobIncome" value="${client?.profile?.jobIncome?.toInteger()}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="jobFrequency">
                <g:message code="client.profile.jobFrequency"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: client, field: 'profile.jobFrequency', 'errors')}" size="30" id="jobFrequency" name="jobFrequency" value="${client?.profile?.jobFrequency?.toInteger()}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="support">
                <g:message code="client.profile.support"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:checkBox name="support" value="${client?.profile?.support}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="supportDescription">
                <g:message code="client.profile.supportDescription"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: client, field: 'profile.supportDescription', 'errors')}" size="30" id="supportDescription" name="supportDescription" value="${client?.profile?.supportDescription?.toInteger()}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="locale">
                <g:message code="languageSelection"/>
              </label>
            </td>
            <td valign="top" class="value">
              <app:localeSelect name="locale" value="${client?.user?.locale}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="showTips">
                <g:message code="showTips"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:checkBox name="showTips" value="${client?.profile?.showTips}"/>
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
                <g:checkBox name="enabled" value="${client?.user?.enabled}"/>
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
              <g:link controller="profile" action="changePassword" id="${client.id}">Passwort ändern</g:link>
            </td>
          </tr>

          </tbody>
        </table>
      </div>
      <div class="buttons">
        <g:submitButton name="submitButton" value="${message(code:'save')}"/>
        <g:link class="buttonGray" action="show" id="${client.id}"><g:message code="cancel"/></g:link>
        <div class="spacer"></div>
      </div>
    </g:form>
  </div>
</div>
</body>