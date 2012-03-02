<%@ page import="at.uenterprise.erp.Setup" %>
<head>
  <meta name="layout" content="database"/>
  <title><g:message code="object.edit" args="[message(code: 'parent')]"/></title>
</head>
<body>
<div class="boxHeader">
  <div class="second">
    <h1><g:message code="object.edit" args="[message(code: 'parent')]"/></h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <g:render template="/templates/errors" model="[bean: parent]"/>

    <g:form id="${parent.id}">

      <table>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="gender"/></td>
          <td valign="top" class="value">
            <g:select name="gender" from="${['1':message(code:'male'),'2':message(code:'female')]}" value="${fieldValue(bean:parent,field:'profile.gender')}" optionKey="key" optionValue="value"/>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="firstName"/></td>
          <td valign="top" class="value">
            <g:textField class="countable50 ${hasErrors(bean: parent, field: 'profile.firstName', 'errors')}" size="25" name="firstName" value="${fieldValue(bean: parent, field: 'profile.firstName').decodeHTML()}"/>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="lastName"/></td>
          <td valign="top" class="value">
            <g:textField class="countable50 ${hasErrors(bean: parent, field: 'profile.lastName', 'errors')}" size="25" maxlength="30" name="lastName" value="${fieldValue(bean: parent, field: 'profile.lastName').decodeHTML()}"/>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="birthDate"/></td>
          <td valign="top" class="value">
            <g:textField name="birthDate" class="datepicker-birthday ${hasErrors(bean: parent, field: 'profile.birthDate', 'errors')}" value="${formatDate(date: parent?.profile?.birthDate, format: 'dd. MM. yyyy')}"/>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="parent.profile.maritalStatus"/></td>
          <td valign="top" class="value">
            <g:select name="maritalStatus" from="${Setup.list()[0]?.maritalStatus}" value="${parent?.profile?.maritalStatus}"/>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="languages"/></td>
          <td valign="top" class="value">
            <g:select name="languages" multiple="true" from="${Setup.list()[0]?.languages}" value="${parent?.profile?.languages}" noSelection="['': message(code: 'none')]"/>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="parent.profile.description"/></td>
          <td valign="top" class="value">
            <g:textArea class="countable2000" name="comment" rows="5" cols="50" value="${fieldValue(bean: parent, field: 'profile.comment').decodeHTML()}"/>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="parent.profile.education"/></td>
          <td valign="top" class="value">
            <g:select name="education" from="${Setup.list()[0]?.schoolLevels}" value="${parent?.profile?.education}" noSelection="['': message(code: 'none')]"/>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="parent.profile.job"/></td>
          <td valign="top" class="value">
            <g:checkBox name="job" value="${parent?.profile?.job}"/>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="parent.profile.jobType"/></td>
          <td valign="top" class="value">
            <g:select name="jobtypes" multiple="true" from="${Setup.list()[0]?.workDescriptions}" value="${parent?.profile?.jobtypes}" noSelection="['': message(code: 'unknown')]"/>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="parent.profile.jobIncome"/> (${grailsApplication.config.currency})</td>
          <td valign="top" class="value">
            <g:textField class="${hasErrors(bean: parent, field: 'profile.jobIncome', 'errors')}" size="20" name="jobIncome" value="${parent?.profile?.jobIncome?.toInteger()}"/>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="parent.profile.jobFrequency"/></td>
          <td valign="top" class="value">
            <g:textField class="${hasErrors(bean: parent, field: 'profile.jobFrequency', 'errors')}" size="30" name="jobFrequency" value="${parent?.profile?.jobFrequency}"/>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="groupColony"/></td>
          <td valign="top" class="value">
            <g:select name="currentColony" from="${allColonies}" optionKey="id" optionValue="profile" value="${colony?.id}"/>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="street"/></td>
          <td valign="top" class="value">
            <g:textField class="countable50 ${hasErrors(bean: parent, field: 'profile.currentStreet', 'errors')}" size="30" name="currentStreet" value="${fieldValue(bean: parent, field: 'profile.currentStreet').decodeHTML()}"/>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="socialSecurityNumber"/></td>
          <td valign="top" class="value">
            <g:textField class="${hasErrors(bean: parent, field: 'profile.socialSecurityNumber', 'errors')}" size="10" name="socialSecurityNumber" value="${fieldValue(bean: parent, field: 'profile.socialSecurityNumber')}"/>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="phone"/></td>
          <td valign="top" class="value">
            <g:textField class="${hasErrors(bean: parent, field: 'profile.phone', 'errors')}" size="30" name="phone" value="${fieldValue(bean: parent, field: 'profile.phone')}"/>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="citizenship"/></td>
          <td valign="top" class="value">
            <g:textField class="${hasErrors(bean: parent, field: 'profile.citizenship', 'errors')}" size="30" name="citizenship" value="${fieldValue(bean: parent, field: 'profile.citizenship')}"/>
          </td>
        </tr>

      </table>

      <div class="email">
        <table width="100%">
          <tr>
            <erp:accessCheck types="['Betreiber']">
              <td>
                <g:message code="active"/>
                <g:checkBox name="enabled" value="${parent?.user?.enabled}" style="vertical-align: bottom"/>
              </td>
            </erp:accessCheck>
            <td>
              <g:message code="email"/>:
              <g:textField class="${hasErrors(bean: parent, field: 'user.email', 'errors')}" size="40" type="text" maxlength="80" name="email" value="${fieldValue(bean: parent, field: 'user.email')}"/>
            </td>
            %{--<td>
              <g:message code="languageSelection"/>:
              <erp:localeSelect name="locale" value="${parent?.user?.locale}"/>
            </td>--}%
          </tr>
        </table>
      </div>

      <div class="buttons">
        <div class="button"><g:actionSubmit class="buttonGreen" action="update" value="${message(code: 'save')}" /></div>
        <div class="button"><g:actionSubmit class="buttonGray" action="show" value="${message(code: 'cancel')}" /></div>
        <div class="clear"></div>
      </div>

    </div>
  </g:form>

</div>
</body>