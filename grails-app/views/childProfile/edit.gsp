<%@ page import="at.uenterprise.erp.Setup" %>
<head>
  <meta name="layout" content="database"/>
  <title><g:message code="object.edit" args="[message(code: 'child')]"/></title>
</head>

<body>
<div class="boxHeader">
  <h1><g:message code="object.edit" args="[message(code: 'child')]"/></h1>
</div>
<div class="boxContent">

    <g:render template="/templates/errors" model="[bean: child]"/>

    <g:form id="${child.id}">

      <table>

        <tr class="prop">
          <td class="name"><g:message code="gender"/></td>
          <td class="value">
            <g:select name="gender" from="${['1':message(code:'male'),'2':message(code:'female')]}" value="${fieldValue(bean:child,field:'profile.gender')}" optionKey="key" optionValue="value"/>
          </td>
        </tr>

        <tr class="prop">
          <td class="name"><g:message code="firstName"/> <span class="required-indicator">*</span></td>
          <td class="value">
            <g:textField data-counter="50" class="${hasErrors(bean: child, field: 'profile.firstName', 'errors')}" required="" size="25" name="firstName" value="${fieldValue(bean: child, field: 'profile.firstName').decodeHTML()}"/>
          </td>
        </tr>

        <tr class="prop">
          <td class="name"><g:message code="lastName"/> <span class="required-indicator">*</span></td>
          <td class="value">
            <g:textField data-counter="50" class="${hasErrors(bean: child, field: 'profile.lastName', 'errors')}" required="" size="35" name="lastName" value="${fieldValue(bean: child, field: 'profile.lastName').decodeHTML()}"/>
          </td>
        </tr>

        <tr class="prop">
          <td class="name"><g:message code="birthDate"/> <span class="required-indicator">*</span></td>
          <td class="value">
            <g:textField class="datepicker-birthday ${hasErrors(bean: child, field: 'profile.birthDate', 'errors')}" required="" name="birthDate" size="30" value="${formatDate(date: child?.profile?.birthDate, format: 'dd. MM. yyyy' )}"/>
          </td>
        </tr>

        <tr class="prop">
          <td class="name"><g:message code="child.profile.job"/></td>
          <td class="value">
            <g:checkBox name="job" value="${child?.profile?.job}"/>
          </td>
        </tr>

        <tr class="prop">
          <td class="name"><g:message code="child.profile.jobType"/></td>
          <td class="value">
            <g:select name="jobtypes" multiple="true" from="${Setup.list()[0]?.workDescriptions}" value="${child?.profile?.jobtypes}" noSelection="['': message(code: 'unknown')]"/>
          </td>
        </tr>

        <tr class="prop">
          <td class="name"><g:message code="child.profile.jobIncome"/> (${grailsApplication.config.currency})</td>
          <td class="value">
            <g:textField size="10" name="jobIncome" value="${fieldValue(bean: child, field: 'profile.jobIncome')}"/>
          </td>
        </tr>

        <tr class="prop">
          <td class="name"><g:message code="child.profile.jobFrequency"/></td>
          <td class="value">
            <g:textField data-counter="50" size="30" name="jobFrequency" value="${fieldValue(bean: child, field: 'profile.jobFrequency')}"/>
          </td>
        </tr>

      </table>

      <div class="email">
        <table width="100%">
          <tr>
            <erp:accessCheck types="['Betreiber']">
              <td>
                <g:message code="active"/>
                <g:checkBox name="enabled" value="${child?.user?.enabled}" style="vertical-align: bottom"/>
              </td>
            </erp:accessCheck>
            <td>
              <g:message code="email"/> <span class="required-indicator">*</span>
              <g:textField class="${hasErrors(bean: child, field: 'user.email', 'errors')}" required="" size="40" type="text" maxlength="80" name="email" value="${fieldValue(bean: child, field: 'user.email')}"/>
            </td>
          </tr>
        </table>
      </div>

      <div class="buttons cleared">
        <div class="button"><g:actionSubmit class="buttonGreen" action="update" value="${message(code: 'save')}" /></div>
        <div class="button"><g:link class="buttonGray" action="show" id="${child.id}"><g:message code="cancel"/></g:link></div>
      </div>

    </g:form>

</div>
</body>