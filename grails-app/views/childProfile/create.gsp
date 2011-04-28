<head>
  <meta name="layout" content="private"/>
  <title><g:message code="child.profile.create"/></title>
</head>
<body>

<div class="boxHeader">
  <div class="second">
    <h1><g:message code="child.profile.create"/></h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <g:render template="/templates/errors" model="[bean: child]"/>

    <g:form action="save">

      <div>
        <table>
          <tbody>

          <tr class="prop">
            <td valign="top" class="name"><g:message code="child.profile.gender"/></td>
            <td valign="top" class="name"><g:message code="child.profile.firstName"/></td>
            <td valign="top" class="name"><g:message code="child.profile.lastName"/></td>
            <td valign="top" class="name"><g:message code="child.profile.birthDate"/></td>
          </tr>

          <tr>
            <td width="120" height="35" valign="top" class="value">
              <g:select name="gender" from="${['1':message(code:'male'),'2':message(code:'female')]}" value="${fieldValue(bean:child,field:'profile.gender')}" optionKey="key" optionValue="value"/>
            </td>
            <td width="200" valign="top" class="value">
              <g:textField class="countable50 ${hasErrors(bean: child, field: 'profile.firstName', 'errors')}" size="25" name="firstName" value="${fieldValue(bean: child, field: 'profile.firstName').decodeHTML()}"/>
            </td>
            <td width="280" valign="top" class="value">
              <g:textField class="countable50 ${hasErrors(bean: child, field: 'profile.lastName', 'errors')}" size="35" name="lastName" value="${fieldValue(bean: child, field: 'profile.lastName').decodeHTML()}"/>
            </td>
            <td height="35" valign="top" class="value">
              <g:textField class="datepicker-birthday ${hasErrors(bean: child, field: 'profile.birthDate', 'errors')}" name="birthDate" size="30" value="${formatDate(date: child?.profile?.birthDate, format: 'dd. MM. yyyy', timeZone: TimeZone.getTimeZone(grailsApplication.config.timeZone.toString()))}"/>
            </td>
          </tr>

          <tr class="prop">
            <td>&nbsp;</td>
            <td><g:message code="child.profile.jobType"/></td>
            <td><g:message code="child.profile.jobIncome"/>  (${grailsApplication.config.currency})</td>
            <td><g:message code="child.profile.jobFrequency"/></td>
          </tr>

          <tr>
            <td valign="top" class="value">
              <g:message code="child.profile.job"/>
              <g:checkBox name="job" value="${child?.profile?.job}"/>
            </td>
            <td valign="top" class="value ${hasErrors(bean: child, field: 'profile.jobType', 'errors')}">
              <g:select name="jobtypes" multiple="true" from="${grailsApplication.config.jobs}" value="${child?.profile?.jobtypes}" noSelection="['': message(code: 'unknown')]" valueMessagePrefix="job"/>
            </td>
            <td valign="top" class="value ${hasErrors(bean: child, field: 'profile.jobIncome', 'errors')}">
              <g:textField size="35" name="jobIncome" value="${fieldValue(bean: child, field: 'profile.jobIncome')}"/>
            </td>
            <td class="value ${hasErrors(bean: child, field: 'profile.jobFrequency', 'errors')}">
              <g:textField class="countable50" size="30" name="jobFrequency" value="${fieldValue(bean: child, field: 'profile.jobFrequency')}"/>
            </td>
          </tr>
          </tbody>
        </table>

        <div class="email">
          <g:message code="active"/>
          <g:checkBox name="enabled" value="${child?.user?.enabled}"/>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          <g:message code="child.profile.email"/>:
          : &nbsp;
          <g:textField class="${hasErrors(bean: child, field: 'user.email', 'errors')}" size="60" maxlength="80" name="email" value="${fieldValue(bean: child, field: 'user.email')}"/>
          &nbsp;&nbsp;
          <g:message code="showTips"/>
          <g:checkBox name="showTips" value="${child?.profile?.showTips}"/>
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
