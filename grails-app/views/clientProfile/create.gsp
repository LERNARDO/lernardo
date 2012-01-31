<%@ page import="at.uenterprise.erp.Setup; at.openfactory.ep.Entity" %>
<head>
  <meta name="layout" content="database"/>
  <title><g:message code="object.create" args="[message(code: 'client')]"/></title>
</head>
<body>
<div class="boxHeader">
  <div class="second">
    <h1><g:message code="object.create" args="[message(code: 'client')]"/></h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <g:render template="/templates/errors" model="[bean: client]"/>

    <g:form>
      <div>

        <table>

          <tr class="prop">
            <td valign="top" class="name"><g:message code="gender"/></td>
            <td valign="top" class="value">
              <g:select name="gender" from="${['1':message(code:'male'),'2':message(code:'female')]}" value="${fieldValue(bean:client,field:'profile.gender')}" optionKey="key" optionValue="value"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name"><g:message code="firstName"/></td>
            <td valign="top" class="value">
              <g:textField class="countable50 ${hasErrors(bean: client, field: 'profile.firstName', 'errors')}" size="40" name="firstName" value="${fieldValue(bean: client, field: 'profile.firstName').decodeHTML()}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name"><g:message code="lastName"/></td>
            <td valign="top" class="value">
              <g:textField class="countable50 ${hasErrors(bean: client, field: 'profile.lastName', 'errors')}" size="40" name="lastName" value="${fieldValue(bean: client, field: 'profile.lastName').decodeHTML()}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name"><g:message code="birthDate"/></td>
            <td valign="top" class="value">
              <g:textField name="birthDate" class="datepicker-birthday ${hasErrors(bean: client, field: 'profile.birthDate', 'errors')}" value="${formatDate(date: client?.profile?.birthDate, format: 'dd. MM. yyyy')}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name"><g:message code="client.profile.interests"/></td>
            <td valign="top" class="value">
              <g:textArea class="countable2000 ${hasErrors(bean: client, field: 'profile.interests', 'errors')}" rows="4" cols="50" name="interests" value="${fieldValue(bean: client, field: 'profile.interests').decodeHTML()}"/>
            </td>
          </tr>

        </table>

        <h4><g:message code="client.profile.curAddress"/></h4>

        <table>

          <tr class="prop">
            <td valign="top" class="name"><g:message code="street"/></td>
            <td valign="top" class="value">
              <g:textField class="countable50 ${hasErrors(bean: client, field: 'profile.currentStreet', 'errors')}" size="40" name="currentStreet" value="${fieldValue(bean: client, field: 'profile.currentStreet').decodeHTML()}"/>
            </td>
          </tr>

          %{--<tr class="prop">
            <td valign="top" class="name"><g:message code="zip"/></td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: client, field: 'profile.currentZip', 'errors')}" size="10" name="currentZip" value="${fieldValue(bean: client, field: 'profile.currentZip').decodeHTML()}"/>
            </td>
          </tr>--}%

          <tr class="prop">
            <td valign="top" class="name"><g:message code="groupColony"/></td>
            <td valign="top" class="value">
              <g:select name="currentColony" from="${allColonies}" optionKey="id" optionValue="profile"/>
            </td>
          </tr>

          %{--<tr class="prop">
            <td valign="top" class="name"><g:message code="country"/></td>
            <td valign="top" class="value">
              <g:textField class="countable50 ${hasErrors(bean: client, field: 'profile.currentCountry', 'errors')}" size="30" name="currentCountry" value="${fieldValue(bean: client, field: 'profile.currentCountry').decodeHTML()}"/>
            </td>
          </tr>--}%

        </table>

        <h4><g:message code="client.profile.origin"/></h4>

        <table>

          <tr class="prop">
            <td valign="top" class="name"><g:message code="zip"/></td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: client, field: 'profile.originZip', 'errors')}" size="10" name="originZip" value="${fieldValue(bean: client, field: 'profile.originZip').decodeHTML()}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name"><g:message code="city"/></td>
            <td valign="top" class="value">
              <g:textField class="countable50 ${hasErrors(bean: client, field: 'profile.originCity', 'errors')}" size="30" name="originCity" value="${fieldValue(bean: client, field: 'profile.originCity').decodeHTML()}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name"><g:message code="country"/></td>
            <td valign="top" class="value">
              <g:textField class="countable50 ${hasErrors(bean: client, field: 'profile.originCountry', 'errors')}" size="30" name="originCountry" value="${fieldValue(bean: client, field: 'profile.originCountry').decodeHTML()}"/>
            </td>
          </tr>

        </table>

        <h4><g:message code="client.profile.more"/></h4>

        <table>

          <tr class="prop">
            <td valign="top" class="name"><g:message code="client.profile.familyStatus"/></td>
            <td valign="top" class="value">
              <g:select name="familyStatus" from="${Setup.list()[0]?.familyStatus}" value="${client?.profile?.familyStatus}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name"><g:message code="languages"/></td>
            <td valign="top" class="value">
              <g:select name="languages" multiple="true" from="${Setup.list()[0]?.languages}" value="${client?.profile?.languages}" noSelection="['': message(code: 'none')]"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name"><g:message code="client.profile.school"/></td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: client, field: 'profile.school', 'errors')}" size="20" name="school" value="${fieldValue(bean: client, field: 'profile.school').decodeHTML()}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name"><g:message code="client.profile.schoolLevel"/></td>
            <td valign="top" class="value">
              <g:select name="schoolLevel" from="${Setup.list()[0]?.schoolLevels}" value="${client?.profile?.schoolLevel}" noSelection="['': message(code: 'none')]"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name"><g:message code="client.profile.schoolDropout"/></td>
            <td valign="top" class="value">
              <g:checkBox name="schoolDropout" value="${client?.profile?.schoolDropout}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name"><g:message code="client.profile.schoolDropoutDate"/></td>
            <td valign="top" class="value">
              <g:textField name="schoolDropoutDate" size="30" class="datepicker-birthday" value="${formatDate(date: client?.profile?.schoolDropoutDate, format: 'dd. MM. yyyy')}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name"><g:message code="client.profile.schoolDropoutReason"/></td>
            <td valign="top" class="value">
              <g:textField class="countable500 ${hasErrors(bean: client, field: 'profile.schoolDropoutReason', 'errors')}" size="60" name="schoolDropoutReason" value="${fieldValue(bean: client, field: 'profile.schoolDropoutReason').decodeHTML()}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name"><g:message code="client.profile.schoolRestart"/></td>
            <td valign="top" class="value">
              <g:checkBox name="schoolRestart" value="${client?.profile?.schoolRestart}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name"><g:message code="client.profile.schoolRestartDate"/></td>
            <td valign="top" class="value">
              <g:textField name="schoolRestartDate" size="30" class="datepicker-birthday" value="${formatDate(date: client?.profile?.schoolRestartDate, format: 'dd. MM. yyyy')}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name"><g:message code="client.profile.schoolRestartReason"/></td>
            <td valign="top" class="value">
              <g:textField class="countable500 ${hasErrors(bean: client, field: 'profile.schoolRestartReason', 'errors')}" size="60" name="schoolRestartReason" value="${fieldValue(bean: client, field: 'profile.schoolRestartReason').decodeHTML()}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name"><g:message code="client.profile.job"/></td>
            <td valign="top" class="value">
              <g:checkBox name="job" value="${client?.profile?.job}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name"><g:message code="client.profile.jobType"/></td>
            <td valign="top" class="value">
              <g:select name="jobtypes" multiple="true" from="${Setup.list()[0]?.workDescriptions}" value="${client?.profile?.jobtypes}" noSelection="['': message(code: 'unknown')]"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name"><g:message code="client.profile.jobIncome"/> (${grailsApplication.config.currency})</td>
            <td valign="top" class="value">
              <g:textField size="10" name="jobIncome" value="${fieldValue(bean: client, field: 'profile.jobIncome')}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name"><g:message code="client.profile.jobFrequency"/></td>
            <td valign="top" class="value">
              <g:textField size="30" name="jobFrequency" value="${fieldValue(bean: client, field: 'profile.jobFrequency')}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name"><g:message code="client.profile.support"/></td>
            <td valign="top" class="value">
              <g:checkBox name="support" value="${client?.profile?.support}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name"><g:message code="client.profile.supportDescription"/></td>
            <td valign="top" class="value">
              <g:textField class="countable500 ${hasErrors(bean: client, field: 'profile.supportDescription', 'errors')}" size="30" name="supportDescription" value="${client?.profile?.supportDescription}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name"><g:message code="citizenship"/></td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: client, field: 'profile.citizenship', 'errors')}" size="15" name="citizenship" value="${fieldValue(bean: client, field: 'profile.citizenship')}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name"><g:message code="socialSecurityNumber"/></td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: client, field: 'profile.socialSecurityNumber', 'errors')}" size="30" name="socialSecurityNumber" value="${fieldValue(bean: client, field: 'profile.socialSecurityNumber')}"/>
            </td>
          </tr>

        </table>

        <div class="email">
          <table width="100%">
            <tr>
              <td valign="top">
                <g:message code="active"/>
                <g:checkBox name="enabled" value="${client?.user?.enabled}"/>
              </td>
              <td valign="top">
                <g:message code="email"/>:
                <g:textField class="${hasErrors(bean: client, field: 'user.email', 'errors')}" size="40" type="text" maxlength="80" name="email" value="${fieldValue(bean: client, field: 'user.email')}"/>
              </td>
              %{--<td>
                <g:message code="languageSelection"/>:
                <erp:localeSelect class="drop-down-200" name="locale" value="${client?.user?.locale}"/>
              </td>--}%
            </tr>
          </table>
        </div>

      </div>
      <div class="buttons">
        <div class="button"><g:actionSubmit class="buttonGreen" action="save" value="${message(code: 'save')}" /></div>
        <div class="button"><g:actionSubmit class="buttonGray" action="list" value="${message(code: 'cancel')}" /></div>
        <div class="spacer"></div>
      </div>
    </g:form>
  </div>
</div>
</body>
 