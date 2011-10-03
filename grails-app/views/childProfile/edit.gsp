<%@ page import="at.uenterprise.erp.Setup" %>
<head>
  <meta name="layout" content="private"/>
  <title><g:message code="object.edit" args="[message(code: 'child')]"/></title>
</head>

<body>
<div class="boxHeader">
  <div class="second">
    <h1><g:message code="object.edit" args="[message(code: 'child')]"/></h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <g:render template="/templates/errors" model="[bean: child]"/>

    <g:form id="${child.id}">
      <div>

        <table>
          <tbody>
          <tr class="prop">
            <td valign="top" class="name"><g:message code="gender"/></td>
            <td valign="top" class="name"><g:message code="firstName"/></td>
            <td valign="top" class="name"><g:message code="lastName"/></td>
            <td valign="top" class="name"><g:message code="birthDate"/></td>
          </tr>

          <tr>
            <td width="120" height="35" valign="top" class="value">
              <g:select name="gender" from="${['1':message(code:'male'),'2':message(code:'female')]}" value="${fieldValue(bean:child,field:'profile.gender')}" optionKey="key" optionValue="value"/>
            </td>
            <td width="200" valign="top" class="value ${hasErrors(bean: child, field: 'profile.firstName', 'errors')}">
              <g:textField class="countable${child.profile.constraints.firstName.maxSize}" size="25" name="firstName" value="${fieldValue(bean: child, field: 'profile.firstName').decodeHTML()}"/>
            </td>
            <td width="280" valign="top" class="value ${hasErrors(bean: child, field: 'profile.lastName', 'errors')}">
              <g:textField class="countable${child.profile.constraints.lastName.maxSize}" size="35" name="lastName" value="${fieldValue(bean: child, field: 'profile.lastName').decodeHTML()}"/>
            </td>
            <td valign="top" class="value ${hasErrors(bean: child, field: 'profile.birthDate', 'errors')}">
              <g:textField name="birthDate" size="30" class="datepicker-birthday" value="${formatDate(date: child?.profile?.birthDate, format: 'dd. MM. yyyy')}"/>
            </td>
          </tr>

          <tr class="prop">
            <td>&nbsp;</td>
            <td><g:message code="child.profile.jobType"/></td>
            <td><g:message code="child.profile.jobIncome"/> (${grailsApplication.config.currency})</td>
            <td><g:message code="child.profile.jobFrequency"/></td>
          </tr>

          <tr>
            <td valign="top" class="value">
              <g:message code="child.profile.job"/>
              <g:checkBox name="job" value="${child?.profile?.job}"/>
            </td>
            <td height="35" valign="top" class="value ${hasErrors(bean: child, field: 'profile.jobType', 'errors')}">
              <g:select name="jobtypes" multiple="true" from="${Setup.list()[0]?.workDescriptions}" value="${child?.profile?.jobtypes}" noSelection="['': message(code: 'unknown')]"/>
            </td>
            <td valign="top" class="value ${hasErrors(bean: child, field: 'profile.jobIncome', 'errors')}">
              <g:textField size="35" name="jobIncome" value="${fieldValue(bean: child, field: 'profile.jobIncome')}"/>
            </td>
            <td class="value ${hasErrors(bean: child, field: 'profile.jobFrequency', 'errors')}">
              <g:textField size="30" name="jobFrequency" value="${fieldValue(bean: child, field: 'profile.jobFrequency')}"/>
            </td>
          </tr>

        </table>

        <div class="email">
          <table width="100%">
            <tr>
              <erp:accessCheck entity="${currentEntity}" types="['Betreiber']">
                <td>
                  <g:message code="active"/>
                  <g:checkBox name="enabled" value="${child?.user?.enabled}" style="vertical-align: bottom"/>
                </td>
              </erp:accessCheck>
              <td>
                <g:message code="email"/>:
                <g:textField class="${hasErrors(bean: child, field: 'user.email', 'errors')}" size="40" type="text" maxlength="80" name="email" value="${fieldValue(bean: child, field: 'user.email')}"/>
              </td>
              <td>
                <g:message code="languageSelection"/>:
                <erp:localeSelect class="drop-down-150" name="locale" value="${client?.user?.locale}"/>
              </td>
            </tr>
          </table>
        </div>

      </div>

      <div class="buttons">
        <div class="button"><g:actionSubmit class="buttonGreen" action="update" value="${message(code: 'save')}" /></div>
        <div class="button"><g:actionSubmit class="buttonGray" action="show" value="${message(code: 'cancel')}" /></div>
        <div class="spacer"></div>
      </div>
      
    </g:form>
  </div>
</div>
</body>