<%@ page import="at.uenterprise.erp.Setup" %>
<head>
  <meta name="layout" content="database"/>
  <title><g:message code="object.create" args="[message(code: 'parent')]"/></title>
</head>
<body>
<div class="boxHeader">
  <h1><g:message code="object.create" args="[message(code: 'parent')]"/></h1>
</div>
<div class="boxContent">

    <g:render template="/templates/errors" model="[bean: parent]"/>

    <g:form>

      <table>

        <tr class="prop">
          <td class="name"><g:message code="gender"/></td>
          <td class="value">
            <g:select name="gender" from="${['1':message(code:'male'),'2':message(code:'female')]}" value="${fieldValue(bean:parent,field:'profile.gender')}" optionKey="key" optionValue="value"/>
          </td>
        </tr>

        <tr class="prop">
          <td class="name"><g:message code="firstName"/> <span class="required-indicator">*</span></td>
          <td class="value">
            <g:textField data-counter="50" class="${hasErrors(bean: parent, field: 'profile.firstName', 'errors')}" required="" size="25" name="firstName" value="${fieldValue(bean: parent, field: 'profile.firstName').decodeHTML()}"/>
          </td>
        </tr>

        <tr class="prop">
          <td class="name"><g:message code="lastName"/> <span class="required-indicator">*</span></td>
          <td class="value">
            <g:textField data-counter="50" class="${hasErrors(bean: parent, field: 'profile.lastName', 'errors')}" required="" size="25" maxlength="30" name="lastName" value="${fieldValue(bean: parent, field: 'profile.lastName').decodeHTML()}"/>
          </td>
        </tr>

        <tr class="prop">
          <td class="name"><g:message code="birthDate"/></td>
          <td class="value">
            <g:textField name="birthDate" class="datepicker-birthday ${hasErrors(bean: parent, field: 'profile.birthDate', 'errors')}" value="${formatDate(date: parent?.profile?.birthDate, format: 'dd. MM. yyyy')}"/>
          </td>
        </tr>

        <tr class="prop">
          <td class="name"><g:message code="parent.profile.maritalStatus"/></td>
          <td class="value">
            <g:select name="maritalStatus" from="${Setup.list()[0]?.maritalStatus}" value="${parent?.profile?.maritalStatus}"/>
          </td>
        </tr>

        <tr class="prop">
          <td class="name"><g:message code="languages"/></td>
          <td class="value">
            <g:select name="languages" multiple="true" from="${Setup.list()[0]?.languages}" value="${parent?.profile?.languages}" noSelection="['': message(code: 'none')]"/>
          </td>
        </tr>

        <tr class="prop">
          <td class="name"><g:message code="parent.profile.description"/></td>
          <td class="value">
            <g:textArea data-counter="2000" name="comment" rows="5" cols="50" value="${fieldValue(bean: parent, field: 'profile.comment').decodeHTML()}"/>
          </td>
        </tr>

        <tr class="prop">
          <td class="name"><g:message code="parent.profile.education"/></td>
          <td class="value">
            <g:select name="education" from="${Setup.list()[0]?.schoolLevels}" value="${parent?.profile?.education}" noSelection="['': message(code: 'none')]"/>
          </td>
        </tr>

        <tr class="prop">
          <td class="name"><g:message code="parent.profile.job"/></td>
          <td class="value">
            <g:checkBox name="job" value="${parent?.profile?.job}"/>
          </td>
        </tr>

        <tr class="prop">
          <td class="name"><g:message code="parent.profile.jobType"/></td>
          <td class="value">
            <g:select name="jobtypes" multiple="true" from="${Setup.list()[0]?.workDescriptions}" value="${parent?.profile?.jobtypes}" noSelection="['': message(code: 'unknown')]"/>
          </td>
        </tr>

        <tr class="prop">
          <td class="name"><g:message code="parent.profile.jobIncome"/> (${grailsApplication.config.currency})</td>
          <td class="value">
            <g:textField class="${hasErrors(bean: parent, field: 'profile.jobIncome', 'errors')}" size="20" name="jobIncome" value="${parent?.profile?.jobIncome?.toInteger()}"/>
          </td>
        </tr>

          <tr class="prop">
              <td class="name"><g:message code="parent.profile.incomeFrequency"/></td>
              <td class="value">
                  <g:select name="incomeFrequency" from="['monthly','biweekly','weekly']" value="${parent?.profile?.incomeFrequency}" valueMessagePrefix="incomeFrequency" noSelection="['': message(code: 'none')]"/>
              </td>
          </tr>

        <tr class="prop">
          <td class="name"><g:message code="parent.profile.jobFrequency"/></td>
          <td class="value">
            <g:textField class="${hasErrors(bean: parent, field: 'profile.jobFrequency', 'errors')}" size="30" name="jobFrequency" value="${parent?.profile?.jobFrequency}"/>
          </td>
        </tr>

        <tr class="prop">
          <td class="name"><g:message code="groupColony"/></td>
          <td class="value">
            <g:select name="currentColony" from="${allColonies}" optionKey="id" optionValue="profile"/>
          </td>
        </tr>

        <tr class="prop">
          <td class="name"><g:message code="street"/></td>
          <td class="value">
            <g:textField data-counter="50" class="${hasErrors(bean: parent, field: 'profile.currentStreet', 'errors')}" size="30" name="currentStreet" value="${fieldValue(bean: parent, field: 'profile.currentStreet').decodeHTML()}"/>
          </td>
        </tr>

        <tr class="prop">
          <td class="name"><g:message code="socialSecurityNumber"/></td>
          <td class="value">
            <g:textField class="${hasErrors(bean: parent, field: 'profile.socialSecurityNumber', 'errors')}" size="10" name="socialSecurityNumber" value="${fieldValue(bean: parent, field: 'profile.socialSecurityNumber')}"/>
          </td>
        </tr>

        <tr class="prop">
          <td class="name"><g:message code="phone"/></td>
          <td class="value">
            <g:textField class="${hasErrors(bean: parent, field: 'profile.phone', 'errors')}" size="30" name="phone" value="${fieldValue(bean: parent, field: 'profile.phone')}"/>
          </td>
        </tr>

        <tr class="prop">
          <td class="name"><g:message code="citizenship"/></td>
          <td class="value">
            <g:textField class="${hasErrors(bean: parent, field: 'profile.citizenship', 'errors')}" size="30" name="citizenship" value="${fieldValue(bean: parent, field: 'profile.citizenship')}"/>
          </td>
        </tr>

          <tr class="prop">
              <td class="name"><g:message code="entryDate"/> <span class="required-indicator">*</span></td>
              <td class="value">
                  <g:textField class="datepicker" required="" size="12" name="entryDate" value=""/>
              </td>
          </tr>

      </table>

      <div class="email">
        <table>
          <tr>
            %{--<td width="80" valign="middle">
              <g:message code="active"/>
              <g:checkBox name="enabled" value="${parent?.user?.enabled}"/>
            </td>--}%
            <td width="280" valign="middle">
              <g:message code="email"/> <span class="required-indicator">*</span>
              <g:textField class="${hasErrors(bean: parent, field: 'user.email', 'errors')}" required="" size="30" maxlength="80" name="email" value="${fieldValue(bean: parent, field: 'user.email')}"/>
            </td>
          </tr>
        </table>
      </div>

      <div class="buttons cleared">
        <div class="button"><g:actionSubmit class="buttonGreen" action="save" value="${message(code: 'save')}" /></div>
        <div class="button"><g:link class="buttonGray" action="list"><g:message code="cancel"/></g:link></div>
      </div>

    </g:form>    

</div>
</body>
