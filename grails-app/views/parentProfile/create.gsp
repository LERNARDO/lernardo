<%@ page import="at.uenterprise.erp.Setup" %>
<head>
  <meta name="layout" content="private"/>
  <title><g:message code="object.create" args="[message(code: 'parent')]"/></title>
</head>
<body>
<div class="boxHeader">
  <div class="second">
    <h1><g:message code="object.create" args="[message(code: 'parent')]"/></h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <g:render template="/templates/errors" model="[bean: parent]"/>

    <g:form>
      <div>

        <table width="100%" border="0" cellspacing="10">
          <tbody>

          <tr>
            <td width="90" valign="middle" class="name"><g:message code="gender"/>:</td>
            <td width="120" valign="middle" class="name"><g:message code="firstName"/>:</td>
            <td width="180" valign="middle" class="name"><g:message code="lastName"/>:</td>
            <td width="210" valign="middle" class="name"><g:message code="birthDate"/>:</td>
          </tr>

          <tr>
            <td valign="top" class="value">
              <g:select name="gender" from="${['1':message(code:'male'),'2':message(code:'female')]}" value="${fieldValue(bean:parent,field:'profile.gender')}" optionKey="key" optionValue="value"/>
            </td>
            <td valign="top" class="value">
              <g:textField class="countable50 ${hasErrors(bean:parent,field:'profile.firstName','errors')}" size="30" name="firstName" value="${fieldValue(bean:parent,field:'profile.firstName').decodeHTML()}"/>
            </td>
            <td valign="top" class="value">
              <g:textField class="countable50 ${hasErrors(bean: parent, field: 'profile.lastName', 'errors')}" size="30" name="lastName" value="${fieldValue(bean: parent, field: 'profile.lastName').decodeHTML()}"/>
            </td>
            <td valign="top" class="value">
              <g:textField name="birthDate" size="30" class="datepicker-birthday ${hasErrors(bean: parent, field: 'profile.birthDate', 'errors')}" value="${formatDate(date: parent?.profile?.birthDate, format: 'dd. MM. yyyy')}"/>
            </td>
          </tr>

          <tr>
            <td valign="middle" class="name"><g:message code="parent.profile.maritalStatus"/>:</td>
            <td valign="middle" class="name"><g:message code="parent.profile.languages"/>:</td>
            <td valign="middle" class="name"><g:message code="parent.profile.description"/>:</td>
            <td valign="middle" class="name"><g:message code="parent.profile.education"/>:</td>
          </tr>

          <tr>
            <td valign="top" class="value">
              <g:select class="drop-down-200" name="maritalStatus" from="${Setup.list()[0]?.maritalStatus}" value="${parent?.profile?.maritalStatus}"/>
            </td>
            <td valign="top" class="value">
              <g:select class="liste-200" name="languages" multiple="true" from="${Setup.list()[0]?.languages}" value="${parent?.profile?.languages}" noSelection="['': message(code: 'none')]"/>
            </td>
            <td valign="top" class="value">
              <g:textArea class="countable2000" name="comment" rows="3" cols="27" value="${fieldValue(bean: parent, field: 'profile.comment').decodeHTML()}"/>
            </td>
            <td valign="top" class="value">
              <g:select class="drop-down-205" name="education" from="${Setup.list()[0]?.schoolLevels}" value="${parent?.profile?.education}" noSelection="['': message(code: 'none')]"/>
            </td>
          </tr>

          <tr>
            <td valign="middle" class="name">&nbsp;</td>
            <td valign="middle" class="name"><g:message code="parent.profile.jobType"/>:</td>
            <td valign="middle" class="name"><g:message code="parent.profile.jobIncome"/> (${grailsApplication.config.currency}):</td>
            <td valign="middle" class="name"><g:message code="parent.profile.jobFrequency"/>:</td>
          </tr>

          <tr>
            <td valign="top" class="value-comb"><g:message code="parent.profile.job"/>:
              <g:checkBox name="job" value="${parent?.profile?.job}"/>
            </td>
            <td valign="top" class="value">
              <g:select name="jobtypes" multiple="true" from="${Setup.list()[0]?.workDescriptions}" value="${parent?.profile?.jobtypes}" noSelection="['': message(code: 'unknown')]"/>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: parent, field: 'profile.jobIncome', 'errors')}" size="30" name="jobIncome" value="${parent?.profile?.jobIncome?.toInteger()}"/>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: parent, field: 'profile.jobFrequency', 'errors')}" size="30" name="jobFrequency" value="${parent?.profile?.jobFrequency}"/>
            </td>
          </tr>

          <tr>
            <td valign="top" class="name"><g:message code="country"/></td>
            <td valign="top" class="name"><g:message code="city"/></td>
            <td valign="top" class="name"><g:message code="street"/></td>
            <td valign="top" class="name"><g:message code="zip"/></td>
          </tr>

          <tr>
            <td valign="top" class="value">
              <g:select name="currentCountry" from="${Setup.list()[0]?.nationalities}" value="${parent?.profile?.currentCountry}" noSelection="['': message(code: 'unknown')]"/>
            </td>
            <td width="105" valign="top" class="value">
              <g:textField class="countable50 ${hasErrors(bean: parent, field: 'profile.currentCity', 'errors')}" size="30" name="currentCity" value="${fieldValue(bean: parent, field: 'profile.currentCity').decodeHTML()}"/>
            </td>
            <td width="210" valign="top" class="value">
              <g:textField class="countable50 ${hasErrors(bean: parent, field: 'profile.currentStreet', 'errors')}" size="30" name="currentStreet" value="${fieldValue(bean: parent, field: 'profile.currentStreet').decodeHTML()}"/>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: parent, field: 'profile.currentZip', 'errors')}" size="30" name="currentZip" value="${fieldValue(bean: parent, field: 'profile.currentZip').decodeHTML()}"/>
            </td>
          </tr>

        </table>

        <table>

          <tr>
            <td valign="top" class="name"><g:message code="client.profile.socialSecurityNumber"/></td>
            <td valign="top" class="name"><g:message code="phone"/></td>
            <td valign="top" class="name"><g:message code="client.profile.citizenship"/></td>
          <tr>

          <tr>
            <td width="210" valign="top" class="value">
              <g:textField class="${hasErrors(bean: parent, field: 'profile.socialSecurityNumber', 'errors')}" size="10" name="socialSecurityNumber" value="${fieldValue(bean: parent, field: 'profile.socialSecurityNumber')}"/>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: parent, field: 'profile.phone', 'errors')}" size="30" name="phone" value="${fieldValue(bean: parent, field: 'profile.phone')}"/>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: parent, field: 'profile.citizenship', 'errors')}" size="30" name="citizenship" value="${fieldValue(bean: parent, field: 'profile.citizenship')}"/>
            </td>
          </tr>

        </table>

        <div class="email">
          <table>
            <tr>
              <td width="80" valign="middle">
                <g:message code="active"/>
                <g:checkBox name="enabled" value="${parent?.user?.enabled}"/>
              </td>
              <td width="280" valign="middle">
                <g:message code="email"/>
                <g:textField class="${hasErrors(bean: parent, field: 'user.email', 'errors')}" size="30" maxlength="80" name="email" value="${fieldValue(bean: parent, field: 'user.email')}"/>
              </td>
              <td valign="middle">
                <g:message code="languageSelection"/>
                <erp:localeSelect class="drop-down-150" name="locale" value="${parent?.user?.locale}"/>
              </td>
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
