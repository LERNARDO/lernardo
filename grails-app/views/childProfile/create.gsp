<%@ page import="at.uenterprise.erp.Setup" %>
<head>
  <meta name="layout" content="database"/>
  <title><g:message code="object.create" args="[message(code: 'child')]"/></title>
</head>
<body>

<div class="boxHeader">
  <h1><g:message code="object.create" args="[message(code: 'child')]"/></h1>
</div>
<div class="boxGray">
  <div class="second">

    <g:render template="/templates/errors" model="[bean: child]"/>

    <g:form>

      <table>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="gender"/></td>
          <td valign="top" class="value">
            <g:select name="gender" from="${['1':message(code:'male'),'2':message(code:'female')]}" value="${fieldValue(bean:child,field:'profile.gender')}" optionKey="key" optionValue="value"/>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="firstName"/></td>
          <td valign="top" class="value">
            <g:textField class="countable50 ${hasErrors(bean: child, field: 'profile.firstName', 'errors')}" size="25" name="firstName" value="${fieldValue(bean: child, field: 'profile.firstName').decodeHTML()}"/>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="lastName"/></td>
          <td valign="top" class="value">
            <g:textField class="countable50 ${hasErrors(bean: child, field: 'profile.lastName', 'errors')}" size="35" name="lastName" value="${fieldValue(bean: child, field: 'profile.lastName').decodeHTML()}"/>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="birthDate"/></td>
          <td valign="top" class="value">
            <g:textField class="datepicker-birthday ${hasErrors(bean: child, field: 'profile.birthDate', 'errors')}" name="birthDate" size="30" value="${formatDate(date: child?.profile?.birthDate, format: 'dd. MM. yyyy' )}"/>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="child.profile.job"/></td>
          <td valign="top" class="value">
            <g:checkBox name="job" value="${child?.profile?.job}"/>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="child.profile.jobType"/></td>
          <td valign="top" class="value">
            <g:select name="jobtypes" multiple="true" from="${Setup.list()[0]?.workDescriptions}" value="${child?.profile?.jobtypes}" noSelection="['': message(code: 'unknown')]"/>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="child.profile.jobIncome"/> (${grailsApplication.config.currency})</td>
          <td valign="top" class="value">
            <g:textField size="10" name="jobIncome" value="${fieldValue(bean: child, field: 'profile.jobIncome')}"/>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="child.profile.jobFrequency"/></td>
          <td valign="top" class="value">
            <g:textField class="countable50" size="30" name="jobFrequency" value="${fieldValue(bean: child, field: 'profile.jobFrequency')}"/>
          </td>
        </tr>

      </table>

      <div class="email">
        <g:message code="active"/>
        <g:checkBox name="enabled" value="${child?.user?.enabled}"/>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <g:message code="email"/>:
        : &nbsp;
        <g:textField class="${hasErrors(bean: child, field: 'user.email', 'errors')}" size="60" maxlength="80" name="email" value="${fieldValue(bean: child, field: 'user.email')}"/>
        &nbsp;&nbsp;
        <g:message code="showTips"/>
        <g:checkBox name="showTips" value="${child?.profile?.showTips}"/>
      </div>

      <div class="buttons">
        <div class="button"><g:actionSubmit class="buttonGreen" action="save" value="${message(code: 'save')}" /></div>
        <div class="button"><g:actionSubmit class="buttonGray" action="list" value="${message(code: 'cancel')}" /></div>
        <div class="clear"></div>
      </div>

    </g:form>
  </div>
</div>
</body>
