<%@ page import="org.springframework.web.servlet.support.RequestContextUtils" %>
<head>
  <meta name="layout" content="private"/>
  <title><g:message code="child.profile.edit"/></title>
</head>

<body>
<div class="headerGreen">
  <div class="second">
    <h1><g:message code="child.profile.edit"/></h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <g:render template="/templates/errors" model="[bean: child]"/>

    <g:form action="update" id="${child.id}">
      <div class="dialog">

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
            <td width="200" valign="top" class="value ${hasErrors(bean: child, field: 'profile.firstName', 'errors')}">
              <g:textField class="countable${child.profile.constraints.firstName.maxSize}" size="25" name="firstName" value="${fieldValue(bean: child, field: 'profile.firstName').decodeHTML()}"/>
            </td>
            <td width="280" valign="top" class="value ${hasErrors(bean: child, field: 'profile.lastName', 'errors')}">
              <g:textField class="countable${child.profile.constraints.lastName.maxSize}" size="35" name="lastName" value="${fieldValue(bean: child, field: 'profile.lastName').decodeHTML()}"/>
            </td>
            <td valign="top" class="value ${hasErrors(bean: child, field: 'profile.birthDate', 'errors')}">
              <g:textField name="birthDate" size="30" class="datepicker-birthday" value="${child.profile.birthDate.format('dd. MM. yyyy')}"/>
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
              <g:if test="${RequestContextUtils.getLocale(request).toString() == 'es' || RequestContextUtils.getLocale(request).toString() == 'es_ES'}">
                <g:select name="jobtypes" multiple="true" from="${grailsApplication.config.jobs_es}" optionKey="key" optionValue="value" value="${child.profile.jobtypes}" noSelection="['': message(code: 'unknown')]"/>
              </g:if>
              <g:if test="${RequestContextUtils.getLocale(request).toString() == 'de' || RequestContextUtils.getLocale(request).toString() == 'de_DE'}">
                <g:select name="jobtypes" multiple="true" from="${grailsApplication.config.jobs_de}" optionKey="key" optionValue="value" value="${child.profile.jobtypes}" noSelection="['': message(code: 'unknown')]"/>
              </g:if>
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
          <erp:isOperator entity="${currentEntity}">
            <g:message code="active"/>
            <g:checkBox name="enabled" value="${child?.user?.enabled}"/>
          </erp:isOperator>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          <g:message code="child.profile.email"/>
          : &nbsp;
          <g:textField class="${hasErrors(bean: child, field: 'user.email', 'errors')}" size="60" maxlength="80" name="email" value="${fieldValue(bean: child, field: 'user.email')}"/>
          &nbsp; &nbsp; &nbsp;
          <g:message code="showTips"/>
          <g:checkBox name="showTips" value="${child?.profile?.showTips}"/>
        </div>

      </div>

      <div class="buttons">
        <g:submitButton name="submitButton" value="${message(code:'save')}"/>
        <erp:isOperator entity="${currentEntity}">
          <g:link class="buttonRed" action="del" id="${child.id}" onclick="${erp.getLinks(id: child.id)}"><g:message code="delete"/></g:link>
        </erp:isOperator>
        <g:link class="buttonGray" action="list"><g:message code="cancel"/></g:link>
        <div class="spacer"></div>
      </div>
      
    </g:form>
  </div>
</div>
</body>