<%@ page import="org.springframework.web.servlet.support.RequestContextUtils" %>
<%@ page import="at.openfactory.ep.Entity" %>
<head>
  <meta name="layout" content="private"/>
  <title><g:message code="client.profile.create"/></title>
</head>
<body>
<div class="headerGreen">
  <div class="second">
    <h1><g:message code="client.profile.create"/></h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <g:render template="/templates/errors" model="[bean: client]"/>

    <g:form action="save" method="post">
      <div class="dialog">

        <table>
          <tbody>

          <tr class="prop">
            <td valign="top" class="name"><g:message code="client.profile.gender"/></td>
            <td valign="top" class="name"><g:message code="client.profile.firstName"/></td>
            <td valign="top" class="name"><g:message code="client.profile.lastName"/></td>
            <td valign="top" class="name"><g:message code="client.profile.birthDate"/></td>
          </tr>

          <tr>
            <td width="120" valign="top" class="value">
              <g:select name="gender" from="${['1':message(code:'male'),'2':message(code:'female')]}" value="${fieldValue(bean:client,field:'profile.gender')}" optionKey="key" optionValue="value"/>
            </td>

            <td width="200" valign="top" class="value">
              <g:textField class="countable50 ${hasErrors(bean: client, field: 'profile.firstName', 'errors')}" size="25" name="firstName" value="${fieldValue(bean: client, field: 'profile.firstName').decodeHTML()}"/>
            </td>

            <td width="270" valign="top" class="value">
              <g:textField class="countable50 ${hasErrors(bean: client, field: 'profile.lastName', 'errors')}" size="38" name="lastName" value="${fieldValue(bean: client, field: 'profile.lastName').decodeHTML()}"/>
            </td>

            <td height="35" valign="top" class="value ${hasErrors(bean: client, field: 'profile.birthDate', 'errors')}">
              <g:textField name="birthDate" size="30" class="datepicker-birthday  ${hasErrors(bean: client, field: 'profile.birthDate', 'errors')}" value="${client?.profile?.birthDate?.format('dd. MM. yyyy')}"/>
            </td>
          </tr>

          <tr>
            <td valign="top" class="name"><g:message code="client.profile.size"/></td>
            <td valign="top" class="name"><g:message code="client.profile.weight"/></td>
            <td colspan="2" valign="top" class="name"><g:message code="client.profile.interests"/></td>
          </tr>

          <tr>
            <td valign="top" class="value">
              <g:select from="${100..250}" name="size" value="${fieldValue(bean: client, field: 'profile.size')}"/> (cm)
            </td>
            <td valign="top" class="value">
              <g:select from="${10..150}" name="weight" value="${fieldValue(bean: client, field: 'profile.weight')}"/> (kg)
            </td>
            <td colspan="2" valign="top" class="value">
              <g:textArea class="countable2000 ${hasErrors(bean: client, field: 'profile.interests', 'errors')}" rows="1" cols="75" name="interests" value="${fieldValue(bean: client, field: 'profile.interests').decodeHTML()}"/>
            </td>
          </tr>

          </tbody>
        </table>

        <h4><g:message code="client.profile.curAddress"/></h4>
        <div class="contact">
          <table>

            <tr>
              <td colspan="4" valign="top" class="name"><g:message code="client.profile.currentColonia"/></td>
            </tr>

            <tr>
              <td valign="top" class="value">
                <g:select name="currentColonia" from="${allColonias}" optionKey="id" optionValue="profile"/>
              </td>
            </tr>

            <tr>
              <td valign="top" class="name"><g:message code="client.profile.currentStreet"/></td>
              <td valign="top" class="name"><g:message code="client.profile.currentZip"/></td>
              <td valign="top" class="name"><g:message code="client.profile.currentCity"/></td>
              <td valign="top" class="name"><g:message code="client.profile.currentCountry"/></td>
            </tr>

            <tr>
              <td width="280" height="35" valign="top" class="value">
                <g:textField class="countable50 ${hasErrors(bean: client, field: 'profile.currentStreet', 'errors')}" size="41" name="currentStreet" value="${fieldValue(bean: client, field: 'profile.currentStreet').decodeHTML()}"/>
              </td>
              <td width="105" valign="top" class="value">
                <g:textField class="${hasErrors(bean: client, field: 'profile.currentZip', 'errors')}" size="12" name="currentZip" value="${fieldValue(bean: client, field: 'profile.currentZip').decodeHTML()}"/>
              </td>
              <td width="210" valign="top" class="value">
                <g:textField class="countable50 ${hasErrors(bean: client, field: 'profile.currentCity', 'errors')}" size="28" name="currentCity" value="${fieldValue(bean: client, field: 'profile.currentCity').decodeHTML()}"/>
              </td>
              <td valign="top" class="value">
                <g:textField class="countable50 ${hasErrors(bean: client, field: 'profile.currentCountry', 'errors')}" size="30" name="currentCountry" value="${fieldValue(bean: client, field: 'profile.currentCountry').decodeHTML()}"/>
              </td>
            </tr>

          </table>
        </div>

        <h4><g:message code="client.profile.origin"/></h4>
        <div class="contact">
          <table>

            <tr>
              <td valign="top" class="name"><g:message code="client.profile.originZip"/></td>
              <td valign="top" class="name"><g:message code="client.profile.originCity"/></td>
              <td colspan="2" valign="top" class="name"><g:message code="client.profile.originCountry"/></td>
            </tr>

            <tr>
              <td width="105" valign="top" class="value">
                <g:textField class="${hasErrors(bean: client, field: 'profile.originZip', 'errors')}" size="12" name="originZip" value="${fieldValue(bean: client, field: 'profile.originZip').decodeHTML()}"/>
              </td>
              <td width=",210" valign="top" class="value">
                <g:textField class="countable50 ${hasErrors(bean: client, field: 'profile.originCity', 'errors')}" size="30" name="originCity" value="${fieldValue(bean: client, field: 'profile.originCity').decodeHTML()}"/>
              </td>
              <td colspan="2" valign="top" class="value">
                <g:textField class="countable50 ${hasErrors(bean: client, field: 'profile.originCountry', 'errors')}" size="30" name="originCountry" value="${fieldValue(bean: client, field: 'profile.originCountry').decodeHTML()}"/>
              </td>
            </tr>

          </table>
        </div>

        <h4><g:message code="client.profile.more"/></h4>
        <div class="contact">
          <table>

            <tr class="prop">
              <td valign="top" class="name"><g:message code="client.profile.familyStatus"/></td>
              <td valign="top" class="name"><g:message code="client.profile.languages"/></td>
              <td valign="top" class="name"><g:message code="client.profile.school"/></td>
              <td valign="top" class="name"><g:message code="client.profile.schoolLevel"/></td>
            </tr>

            <tr>
              <td width="160px" valign="top" class="value">
                <g:if test="${RequestContextUtils.getLocale(request).toString() == 'es' || RequestContextUtils.getLocale(request).toString() == 'es_ES'}">
                  <g:select class="drop-down-150" name="familyStatus" from="${grailsApplication.config.familyRelation_es}" optionKey="key" optionValue="value" value="${client?.profile?.familyStatus}"/>
                </g:if>
                <g:if test="${RequestContextUtils.getLocale(request).toString() == 'de' || RequestContextUtils.getLocale(request).toString() == 'de_DE'}">
                  <g:select class="drop-down-150" name="familyStatus" from="${grailsApplication.config.familyRelation_de}" optionKey="key" optionValue="value" value="${client?.profile?.familyStatus}"/>
                </g:if>
              </td>
              <td width="250" valign="top" class="value">
                <g:if test="${RequestContextUtils.getLocale(request).toString() == 'es' || RequestContextUtils.getLocale(request).toString() == 'es_ES'}">
                  <g:select class="liste-210" name="languages" multiple="true" from="${grailsApplication.config.languages_es}" optionKey="key" optionValue="value" value="${client?.profile?.languages}"/>
                </g:if>
                <g:if test="${RequestContextUtils.getLocale(request).toString() == 'de' || RequestContextUtils.getLocale(request).toString() == 'de_DE'}">
                  <g:select class="liste-210" name="languages" multiple="true" from="${grailsApplication.config.languages_de}" optionKey="key" optionValue="value" value="${client?.profile?.languages}"/>
                </g:if>
              </td>
              <td width="230" valign="top" class="value">
                <g:select class="drop-down-200" name="school" id="allFacilities" from="${allFacilities}" optionKey="id" optionValue="profile"/>
              </td>
              <td width="210" valign="top" class="value">
                <g:if test="${RequestContextUtils.getLocale(request).toString() == 'es' || RequestContextUtils.getLocale(request).toString() == 'es_ES'}">
                  <g:select class="drop-down-205" name="schoolLevel" id="schoolLevel" from="${grailsApplication.config.schoolLevels_es}" optionKey="key" optionValue="value" value="${client?.profile?.schoolLevel}"/>
                </g:if>
                <g:if test="${RequestContextUtils.getLocale(request).toString() == 'de' || RequestContextUtils.getLocale(request).toString() == 'de_DE'}">
                  <g:select class="drop-down-205" name="schoolLevel" id="schoolLevel" from="${grailsApplication.config.schoolLevels_de}" optionKey="key" optionValue="value" value="${client?.profile?.schoolLevel}"/>
                </g:if>
              </td>
            </tr>

            <tr class="prop">
              <td></td>
              <td valign="top" class="name"><g:message code="client.profile.schoolDropoutDate"/></td>
              <td colspan="2" valign="top" class="name"><g:message code="client.profile.schoolDropoutReason"/></td>
            </tr>

            <tr>
              <td valign="top" class="value">
                <g:message code="client.profile.schoolDropout"/>
                <g:checkBox name="schoolDropout" value="${client?.profile?.schoolDropout}"/>
              </td>
              <td valign="top" class="value">
                <g:textField name="schoolDropoutDate" size="30" class="datepicker-birthday" value="${client?.profile?.schoolDropoutDate?.format('dd. MM. yyyy')}"/>
              </td>
              <td colspan="2" valign="top" class="value">
                <g:textField class="countable500 ${hasErrors(bean: client, field: 'profile.schoolDropoutReason', 'errors')}" size="64" name="schoolDropoutReason" value="${fieldValue(bean: client, field: 'profile.schoolDropoutReason').decodeHTML()}"/>
              </td>
            </tr>

            <tr class="prop">
              <td></td>
              <td valign="top" class="name"><g:message code="client.profile.schoolRestartDate"/></td>
              <td colspan="2" valign="top" class="name"><g:message code="client.profile.schoolRestartReason"/></td>
            </tr>
            
            <tr>
              <td valign="top" class="value">
                <g:message code="client.profile.schoolRestart"/>
                <g:checkBox name="schoolRestart" value="${client?.profile?.schoolDropout}"/>
              </td>
              <td valign="top" class="value">
                <g:textField name="schoolRestartDate" size="30" class="datepicker-birthday" value="${client?.profile?.schoolRestartDate?.format('dd. MM. yyyy')}"/>
              </td>
              <td colspan="2" valign="top" class="value">
                <g:textField class="countable500 ${hasErrors(bean: client, field: 'profile.schoolRestartReason', 'errors')}" size="64" name="schoolRestartReason" value="${fieldValue(bean: client, field: 'profile.schoolRestartReason').decodeHTML()}"/>
              </td>
            </tr>

            <tr>
              <td colspan="4">&nbsp;</td>
            </tr>

            <tr class="prop">
              <td></td>
              <td><g:message code="client.profile.jobType"/></td>
              <td><g:message code="client.profile.jobIncome"/></td>
              <td><g:message code="client.profile.jobFrequency"/></td>
            </tr>

            <tr>
              <td valign="top" class="value">
                <g:message code="client.profile.job"/>
                <g:checkBox name="job" value="${client?.profile?.job}"/>
              </td>
              <td height="35" valign="top" class="value ${hasErrors(bean: client, field: 'profile.jobType', 'errors')}">
                <g:if test="${RequestContextUtils.getLocale(request).toString() == 'es' || RequestContextUtils.getLocale(request).toString() == 'es_ES'}">
                  <g:select name="jobType" from="${grailsApplication.config.jobs_es}" optionKey="key" optionValue="value" value="${client?.profile?.jobType}"/>
                </g:if>
                <g:if test="${RequestContextUtils.getLocale(request).toString() == 'de' || RequestContextUtils.getLocale(request).toString() == 'de_DE'}">
                  <g:select name="jobType" from="${grailsApplication.config.jobs_de}" optionKey="key" optionValue="value" value="${client?.profile?.jobType}"/>
                </g:if>
              </td>
              <td valign="top" class="value ${hasErrors(bean: client, field: 'profile.jobIncome', 'errors')}">
                <g:textField size="30" name="jobIncome" value="${fieldValue(bean: client, field: 'profile.jobIncome')}"/>
              </td>
              <td valign="top" class="value ${hasErrors(bean: client, field: 'profile.jobFrequency', 'errors')}">
                <g:textField size="28" maxlength="20" name="jobFrequency" value="${fieldValue(bean: client, field: 'profile.jobFrequency')}"/>
              </td>
            </tr>

            <tr class="prop">
              <td></td>
              <td colspan="3" valign="top" class="name"><g:message code="client.profile.supportDescription"/></td>
            </tr>

            <tr>
              <td valign="top" class="value">
                <g:message code="client.profile.support"/>
                <g:checkBox name="support" value="${client?.profile?.support}"/>
              </td>
              <td colspan="3" valign="top" class="value">
                <g:textField class="countable500 ${hasErrors(bean: client, field: 'profile.supportDescription', 'errors')}" size="30" name="supportDescription" value="${client?.profile?.supportDescription?.toInteger()}"/>
              </td>
            </tr>

          </table>
        </div>

        <div class="email">
          <table>
            <tr>
              <td width="90" valign="top">
                <g:message code="active"/>
                <g:checkBox name="enabled" value="${client?.user?.enabled}"/>
              </td>
              <td width="350" valign="top">
                <g:message code="client.profile.email"/>:
                <g:textField class="${hasErrors(bean: client, field: 'user.email', 'errors')}" size="40" type="text" maxlength="80" name="email" value="${fieldValue(bean: client, field: 'user.email')}"/>
              </td>
              <td>
                <g:message code="languageSelection"/>:
                <app:localeSelect class="drop-down-200" name="locale" value="${client?.user?.locale}"/>
              </td>
            </tr>
          </table>
        </div>

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
 