<%@ page import="org.springframework.web.servlet.support.RequestContextUtils" %>
<head>
  <meta name="layout" content="private"/>
  <title><g:message code="client.profile.edit"/></title>
</head>
<body>
<div class="headerGreen">
  <div class="second">
    <h1><g:message code="client.profile.edit"/></h1>
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
          <tr class="prop"><!-- Prompt-->
            <td valign="top" class="name">
              <label for="gender">
                <g:message code="client.profile.gender"/>
              </label>
            </td>


            <td valign="top" class="name">
              <label for="firstName">
                <g:message code="client.profile.firstName"/>
              </label></td>

            <td valign="top" class="name">
              <label for="lastName">
                <g:message code="client.profile.lastName"/>
              </label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: client, field: 'profile.birthDate', 'errors')}">
              <label for="birthDate">
                <g:message code="client.profile.birthDate"/>
              </label>
            </td>

          </tr>
          <tr><!-- Inhalt-->

            <td width="120" valign="top" class="value ${hasErrors(bean: client, field: 'profile.gender', 'errors')}">
              <g:select name="gender" from="${['1':message(code:'male'),'2':message(code:'female')]}" value="${fieldValue(bean:client,field:'profile.gender')}" optionKey="key" optionValue="value"/>
            </td>
            <td width="200" valign="top" class="value ${hasErrors(bean: client, field: 'profile.firstName', 'errors')}">
              <g:textField class="countable${client.profile.constraints.firstName.maxSize}" size="25" id="firstName" name="firstName" value="${fieldValue(bean: client, field: 'profile.firstName')}"/>
            </td>

            <td width="270" valign="top" class="value ${hasErrors(bean: client, field: 'profile.lastName', 'errors')}">
              <g:textField class="countable${client.profile.constraints.lastName.maxSize}" size="38" id="lastName" name="lastName" value="${fieldValue(bean: client, field: 'profile.lastName')}"/>
            </td>
            <td height="35" valign="top" class="value ${hasErrors(bean: client, field: 'profile.birthDate', 'errors')}">
              <g:datePicker name="birthDate" value="${client?.profile?.birthDate}" precision="day" years="${new Date().getYear()+1800..new Date().getYear()+1900}"/>
            </td>
          </tr>

          <tr>
            <td valign="top" class="name">
              <label for="size">
                <g:message code="client.profile.size"/>
              </label>
            </td>
            <td>
              <label for="weight">
                <g:message code="client.profile.weight"/>
              </label>
            <td colspan="2" valign="top" class="name">
              <label for="interests">
                <g:message code="client.profile.interests"/>
              </label>
            </td>
          </tr>
          <tr>
            <td valign="top" class="value">
              <g:select from="${100..250}" id="size" name="size" value="${fieldValue(bean: client, field: 'profile.size')}"/> (cm)
            </td>
            <td valign="top" class="value">
              <g:select from="${10..150}" id="weight" name="weight" value="${fieldValue(bean: client, field: 'profile.weight')}"/> (kg)
            </td>
            <td colspan="2" valign="top" class="value">
              <g:textArea class="countable${client.profile.constraints.interests.maxSize} ${hasErrors(bean: client, field: 'profile.interests', 'errors')}" id="interests" rows="1" cols="75" name="interests" value="${fieldValue(bean: client, field: 'profile.interests').decodeHTML()}"/>
            </td>
          </tr>
        </table>
        <h4><g:message code="client.profile.curAddress"/></h4>
        <div class="contact">
          <table>
            <tr>
              <td colspan="4" valign="top" class="name">
                <label for="currentColonia">
                  <g:message code="client.profile.currentColonia"/>
                </label>
              </td>
            </tr>
            <tr>
              <td colspan="4" valign="top" class="value">
                <g:select name="currentColonia" from="${allColonias}" id="currentColonia" optionKey="id" optionValue="profile"/>
              </td>
            </tr>
            <tr>
              <td valign="top" class="name">
                <label for="currentStreet">
                  <g:message code="client.profile.currentStreet"/>
                </label>
              </td>
              <td valign="top" class="name">
                <label for="currentZip">
                  <g:message code="client.profile.currentZip"/>
                </label>
              </td>
              <td valign="top" class="name">
                <label for="currentCity">
                  <g:message code="client.profile.currentCity"/>
                </label>
              </td>

              <td valign="top" class="name">
                <label for="currentCountry">
                  <g:message code="client.profile.currentCountry"/>
                </label>
              </td>
            </tr>
            <tr>
              <td width="280" height="35" valign="top" class="value">
                <g:textField class="countable${client.profile.constraints.currentStreet.maxSize} ${hasErrors(bean: client, field: 'profile.currentStreet', 'errors')}" size="41" id="currentStreet" name="currentStreet" value="${fieldValue(bean: client, field: 'profile.currentStreet').decodeHTML()}"/>
              </td>
              <td width="105" valign="top" class="value">
                <g:textField class="${hasErrors(bean: client, field: 'profile.currentZip', 'errors')}" size="12" id="currentZip" name="currentZip" value="${fieldValue(bean: client, field: 'profile.currentZip').decodeHTML()}"/>
              </td>
              <td width="210" valign="top" class="value">
                <g:textField class="countable${client.profile.constraints.currentCity.maxSize} ${hasErrors(bean: client, field: 'profile.currentCity', 'errors')}" size="28" id="currentCity" name="currentCity" value="${fieldValue(bean: client, field: 'profile.currentCity').decodeHTML()}"/>
              </td>
              <td valign="top" class="value">
                <g:textField class="countable${client.profile.constraints.currentCountry.maxSize} ${hasErrors(bean: client, field: 'profile.currentCountry', 'errors')}" size="30" id="currentCountry" name="currentCountry" value="${fieldValue(bean: client, field: 'profile.currentCountry').decodeHTML()}"/>
              </td>
            </tr>
          </table>
        </div>

        <h4><g:message code="client.profile.origin"/></h4>
        <div class="contact">
          <table>
            <tr>
              <td valign="top" class="name">
                <label for="originZip">
                  <g:message code="client.profile.originZip"/>
                </label>
              </td>
              <td valign="top" class="name">
                <label for="originCity">
                  <g:message code="client.profile.originCity"/>
                </label>
              </td>
              <td valign="top" class="name">
                <label for="originCountry">
                  <g:message code="client.profile.originCountry"/>
                </label>
              </td>
            </tr>
            <tr>
              <td width="105" valign="top" class="value">
                <g:textField class="${hasErrors(bean: client, field: 'profile.originZip', 'errors')}" size="12" id="originZip" name="originZip" value="${fieldValue(bean: client, field: 'profile.originZip').decodeHTML()}"/>
              </td>
              <td width="210" valign="top" class="value">
                <g:textField class="countable${client.profile.constraints.originCity.maxSize} ${hasErrors(bean: client, field: 'profile.originCity', 'errors')}" size="30" id="originCity" name="originCity" value="${fieldValue(bean: client, field: 'profile.originCity').decodeHTML()}"/>
              </td>
              <td valign="top" class="value">
                <g:textField class="countable${client.profile.constraints.originCountry.maxSize} ${hasErrors(bean: client, field: 'profile.originCountry', 'errors')}" size="30" id="originCountry" name="originCountry" value="${fieldValue(bean: client, field: 'profile.originCountry').decodeHTML()}"/>
              </td>
            </tr>
          </table>
        </div>

        <h4><g:message code="client.profile.more"/></h4>
        <div class="contact">
          <table>
            <tr class="prop">
              <td valign="top" class="name">
                <label for="familyStatus">
                  <g:message code="client.profile.familyStatus"/>
                </label>
              </td>
              <td valign="top" class="name">
                <label for="languages">
                  <g:message code="client.profile.languages"/>
                </label>
              </td>
              <td valign="top" class="name">
                <label for="school">
                  <g:message code="client.profile.school"/>
                </label>
              </td>
              <td valign="top" class="name">
                <label for="schoolLevel">
                  <g:message code="client.profile.schoolLevel"/>
                </label>
              </td>
            </tr>
            <tr>
              <td width="160px" valign="top" class="value">
                <g:if test="${RequestContextUtils.getLocale(request).toString() == 'es' || RequestContextUtils.getLocale(request).toString() == 'es_ES'}">
                  <g:select class="drop-down-150" name="familyStatus" from="${grailsApplication.config.familyRelation_es}" optionKey="key" optionValue="value"/>
                </g:if>
                <g:if test="${RequestContextUtils.getLocale(request).toString() == 'de' || RequestContextUtils.getLocale(request).toString() == 'de_DE'}">
                  <g:select class="drop-down-150" name="familyStatus" from="${grailsApplication.config.familyRelation_de}" optionKey="key" optionValue="value"/>
                </g:if>
              </td>
              <td width="250" valign="top" class="value">
                <g:if test="${RequestContextUtils.getLocale(request).toString() == 'es' || RequestContextUtils.getLocale(request).toString() == 'es_ES'}">
                  <g:select class="liste-210" name="languages" multiple="true" from="${grailsApplication.config.languages_es}" optionKey="key" optionValue="value"/>
                </g:if>
                <g:if test="${RequestContextUtils.getLocale(request).toString() == 'de' || RequestContextUtils.getLocale(request).toString() == 'de_DE'}">
                  <g:select class="liste-210" name="languages" multiple="true" from="${grailsApplication.config.languages_de}" optionKey="key" optionValue="value"/>
                </g:if>
              </td>
              <td width="230" valign="top" class="value">
                <g:select class="drop-down-200" name="school" id="name" from="${allFacilities}" optionKey="id" optionValue="profile"/>
              </td>
              <td width="210" valign="top" class="value">
                <g:if test="${RequestContextUtils.getLocale(request).toString() == 'es' || RequestContextUtils.getLocale(request).toString() == 'es_ES'}">
                  <g:select class="drop-down-205" name="schoolLevel" id="schoolLevel" from="${grailsApplication.config.schoolLevels_es}" optionKey="key" optionValue="value"/>
                </g:if>
                <g:if test="${RequestContextUtils.getLocale(request).toString() == 'de' || RequestContextUtils.getLocale(request).toString() == 'de_DE'}">
                  <g:select class="drop-down-205" name="schoolLevel" id="schoolLevel" from="${grailsApplication.config.schoolLevels_de}" optionKey="key" optionValue="value"/>
                </g:if>
              </td>
            </tr>
            <tr class="prop">
              <td></td>
              <td valign="top" class="name">
                <label for="schoolDropoutReason">
                  <g:message code="client.profile.schoolDropoutDate"/>
                </label>
              </td>
              <td colspan="2" valign="top" class="name">
                <label for="schoolDropoutDate">
                  <g:message code="client.profile.schoolDropoutReason"/>
                </label>
              </td>
            </tr>
            <tr>
              <td valign="top" class="value">
                <label for="schoolDropout">
                  <g:message code="client.profile.schoolDropout"/>
                </label>
                <g:checkBox name="schoolDropout" value="${client?.profile?.schoolDropout}"/>
              </td>
              <td valign="top" class="value">
                <g:datePicker name="schoolDropoutDate" value="${client?.profile?.schoolDropoutDate}" precision="day"/>
              </td>
              <td colspan="2" valign="top" class="value">
                <g:textField class="countable${client.profile.constraints.schoolDropoutReason.maxSize} ${hasErrors(bean: client, field: 'profile.schoolDropoutReason', 'errors')}" size="64" id="schoolDropoutReason" name="schoolDropoutReason" value="${fieldValue(bean: client, field: 'profile.schoolDropoutReason').decodeHTML()}"/>
              </td>
            </tr>
            <tr class="prop">
              <td></td>
              <td valign="top" class="name">
                <label for="schoolRestartReason">
                  <g:message code="client.profile.schoolRestartDate"/>
                </label>
              </td>
              <td colspan="2" valign="top" class="name">
                <label for="schoolRestartDate">
                  <g:message code="client.profile.schoolRestartReason"/>
                </label>
              </td>
            </tr>
            <tr>
              <td valign="top" class="value">
                <label for="schoolRestart">
                  <g:message code="client.profile.schoolRestart"/>
                </label>
                <g:checkBox name="schoolRestart" value="${client?.profile?.schoolDropout}"/>
              </td>
              <td valign="top" class="value">
                <g:datePicker name="schoolRestartDate" value="${client?.profile?.schoolDropoutDate}" precision="day"/>
              </td>
              <td colspan="2" valign="top" class="value">
                <g:textField class="countable${client.profile.constraints.schoolRestartReason.maxSize} ${hasErrors(bean: client, field: 'profile.schoolRestartReason', 'errors')}" size="64" id="schoolRestartReason" name="schoolRestartReason" value="${fieldValue(bean: client, field: 'profile.schoolRestartReason').decodeHTML()}"/>
              </td>
            </tr>
            <tr><td colspan="4">&nbsp;</td></tr>
            <tr class="prop"><!-- Prompt-->
              <td>&nbsp;</td>
              <td><label for="jobType">
                <g:message code="client.profile.jobType"/>
              </label></td>
              <td><label for="jobIncome">
                <g:message code="client.profile.jobIncome"/>
              </label></td>
              <td><label for="jobFrequency">
                <g:message code="client.profile.jobFrequency"/>
              </label></td>
            </tr>
            <tr><!-- Inhalt-->
              <td valign="top" class="value ${hasErrors(bean: client, field: 'profile.job', 'errors')}">
                <label for="job">
                  <g:message code="client.profile.job"/>
                </label>
                <g:checkBox name="job" value="${client?.profile?.job}"/>
              </td>
              <td height="35" valign="top" class="value ${hasErrors(bean: client, field: 'profile.jobType', 'errors')}">
                <g:if test="${RequestContextUtils.getLocale(request).toString() == 'es' || RequestContextUtils.getLocale(request).toString() == 'es_ES'}">
                  <g:select name="jobType" id="jobType" from="${grailsApplication.config.jobs_es}" optionKey="key" optionValue="value"/>
                </g:if>
                <g:if test="${RequestContextUtils.getLocale(request).toString() == 'de' || RequestContextUtils.getLocale(request).toString() == 'de_DE'}">
                  <g:select name="jobType" id="jobType" from="${grailsApplication.config.jobs_de}" optionKey="key" optionValue="value"/>
                </g:if>
              </td>
              <td valign="top" class="value ${hasErrors(bean: client, field: 'profile.jobIncome', 'errors')}">
                <g:textField id="jobIncome" size="30" name="jobIncome" value="${fieldValue(bean: client, field: 'profile.jobIncome')}"/>
              </td>
              <td class="value ${hasErrors(bean: client, field: 'profile.jobFrequency', 'errors')}">
                <g:textField size="28" maxlength="20" id="jobFrequency" name="jobFrequency" value="${fieldValue(bean: client, field: 'profile.jobFrequency')}"/>
              </td>
            </tr>
            <tr class="prop">
              <td></td>
              <td colspan="3" valign="top" class="name">
                <label for="supportDescription">
                  <g:message code="client.profile.supportDescription"/>
                </label>
              </td>
            </tr>
            <tr>
              <td valign="top" class="value">
                <g:message code="client.profile.support"/>
                <g:checkBox name="support" value="${client?.profile?.support}"/>
              </td>
              <td colspan="3" valign="top" class="value">
                <g:textField class="countable${client.profile.constraints.supportDescription.maxSize} ${hasErrors(bean: client, field: 'profile.supportDescription', 'errors')}" size="30" id="supportDescription" name="supportDescription" value="${client?.profile?.supportDescription}"/>
              </td>
            </tr>

          </table>
        </div>

        <div class="email2">
          <table>
            <tr>
              <td width="90" valign="top">
                <label for="enabled">
                  <g:message code="active"/>
                </label>
              </td>
              <td width="30">
                <g:checkBox name="enabled" value="${client?.user?.enabled}"/>
              </td>
              <td width="85" valign="top">
                <label for="email">
                  <g:message code="client.profile.email"/>
                </label>:
              </td>
              <td width="290" valign="top">
                <g:textField class="${hasErrors(bean: client, field: 'user.email', 'errors')}" size="40" type="text" maxlength="80" id="email" name="email" value="${fieldValue(bean: client, field: 'user.email')}"/>
              </td>
              <td width="140" valign="top">
                <label for="locale">
                  <g:message code="languageSelection"/>
                </label>:
              </td>
              <td valign="top">
                <app:localeSelect class="drop-down-150" name="locale" value="${client?.user?.locale}"/>
              </td>
            </tr>
            <tr>
              <td valign="top">
                <label for="showTips">
                  <g:message code="showTips"/>
                </label>
              </td>
              <td>
                <g:checkBox name="showTips" value="${client?.profile?.showTips}"/>
              </td>
              <td valign="top" class="name">
                <label>
                  <g:message code="password"/>
                </label>:
              </td>
              <td valign="top" class="value">
                <g:link controller="profile" action="changePassword" id="${client.id}">Passwort ändern</g:link>
              </td>
            </tr>
          </table>
        </div>

      </div>

      <div class="buttons">
        <g:submitButton name="submitButton" value="${message(code:'save')}"/>
        <app:isOperator entity="${entity}">
          <g:link class="buttonRed" action="del" id="${client.id}" onclick="${app.getLinks(id: client.id)}"><g:message code="delete"/></g:link>
        </app:isOperator>
        <g:link class="buttonGray" action="show" id="${client.id}"><g:message code="cancel"/></g:link>
        <div class="spacer"></div>
      </div>
    </g:form>
  </div>
</div>
</body>