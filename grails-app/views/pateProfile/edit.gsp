<%@ page import="org.springframework.web.servlet.support.RequestContextUtils" %>
<head>
  <meta name="layout" content="private"/>
  <title><g:message code="pate.profile.edit"/></title>
</head>

<body>
<div class="boxHeader">
  <div class="second">
    <h1><g:message code="pate.profile.edit"/></h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <g:render template="/templates/errors" model="[bean: pate]"/>

    <g:form action="update" id="${pate.id}">
      <div class="dialog">
        <table>

          <tr class="prop">
            <td valign="top" class="name"><g:message code="pate.profile.firstName"/></td>
            <td valign="top" class="name"><g:message code="pate.profile.lastName"/></td>
            <td valign="top" class="name"><g:message code="pate.profile.motherTongue"/></td>
            <td valign="top" class="name"><g:message code="pate.profile.languages"/></td>
          </tr>

          <tr>
            <td width="180" valign="top" class="value">
              <g:textField class="countable${pate.profile.constraints.firstName.maxSize} ${hasErrors(bean: pate, field: 'profile.firstName', 'errors')}" size="25" name="firstName" value="${fieldValue(bean: pate, field: 'profile.firstName').decodeHTML()}"/>
            </td>
            <td width="210" valign="top" class="value">
              <g:textField class="countable${pate.profile.constraints.lastName.maxSize} ${hasErrors(bean: pate, field: 'profile.lastName', 'errors')}" size="30" maxlength="30" name="lastName" value="${fieldValue(bean: pate, field: 'profile.lastName').decodeHTML()}"/>
            </td>
            <td width="210" valign="top" class="value">
              <g:select class="drop-down-205" name="motherTongue" from="${grailsApplication.config.languages}" value="${pate?.profile?.motherTongue}" valueMessagePrefix="language"/>
            </td>
            <td width="210" valign="top" class="value">
              <g:select class="liste-200" name="languages" multiple="true" from="${grailsApplication.config.languages}" value="${pate?.profile?.languages}" noSelection="['': message(code: 'none')]" valueMessagePrefix="language"/>
            </td>
          </tr>

        </table>

        <table>
          <tr>
            <td valign="top" class="name"><g:message code="pate.profile.zip"/></td>
            <td valign="top" class="name"><g:message code="pate.profile.city"/></td>
            <td valign="top" class="name"><g:message code="pate.profile.street"/></td>
            <td valign="top" class="name"><g:message code="pate.profile.country"/></td>
          </tr>

          <tr>
            <td width="90" valign="top" class="value">
              <g:textField class="${hasErrors(bean: pate, field: 'profile.zip', 'errors')}" size="10" name="zip" value="${fieldValue(bean: pate, field: 'profile.zip').decodeHTML()}"/>
            </td>
            <td width="215" valign="top" class="value">
              <g:textField class="countable${pate.profile.constraints.city.maxSize} ${hasErrors(bean: pate, field: 'profile.city', 'errors')}" size="30" name="city" value="${fieldValue(bean: pate, field: 'profile.city').decodeHTML()}"/>
            </td>
            <td width="295" valign="top" class="value">
              <g:textField class="countable${pate.profile.constraints.street.maxSize} ${hasErrors(bean: pate, field: 'profile.street', 'errors')}" size="44" name="street" value="${fieldValue(bean: pate, field: 'profile.street').decodeHTML()}"/>
            </td>
            <td width="210" height="35" valign="top" class="value">
              <g:select name="country" from="${grailsApplication.config.nationalities}" value="${pate?.profile?.country}" noSelection="['': message(code: 'unknown')]" valueMessagePrefix="nationality"/>
            </td>
          </tr>
        </table>

        <div class="email">
          <table>
            <tr>
              <erp:isOperator entity="${currentEntity}">
                <td width="80" valign="middle">
                  <g:message code="active"/>
                  <erp:isAdmin entity="${currentEntity}">
                    <g:checkBox name="enabled" value="${pate?.user?.enabled}"/>
                  </erp:isAdmin>
                  <erp:notAdmin entity="${currentEntity}">
                    <g:checkBox name="enabled" value="${pate?.user?.enabled}" disabled="true"/>
                  </erp:notAdmin>
                </td>
              </erp:isOperator>
              <td width="150" valign="middle">
                <g:message code="password"/>:
                <g:link controller="profile" action="changePassword" id="${pate.id}"><g:message code="change"/></g:link>
              </td>

              <td width="280" valign="middle">
                <g:message code="pate.profile.email"/>:
                <g:textField class="${hasErrors(bean: pate, field: 'user.email', 'errors')}" size="30" maxlength="80" id="email" name="email" value="${fieldValue(bean: pate, field: 'user.email')}"/>
              </td>
              <td valign="middle">
                <g:message code="languageSelection"/>:
                <erp:localeSelect class="drop-down-150" name="locale" value="${pate?.user?.locale}"/>
              </td>
            </tr>
          </table>
        </div>

      </div>
      <div class="buttons">
        <g:submitButton name="submitButton" value="${message(code:'save')}"/>
        <erp:isOperator entity="${currentEntity}">
          <g:link class="buttonRed" action="del" id="${pate.id}" onclick="${erp.getLinks(id: pate.id)}"><g:message code="delete"/></g:link>
        </erp:isOperator>
        <g:link class="buttonGray" action="show" id="${pate.id}"><g:message code="cancel"/></g:link>
        <div class="spacer"></div>
      </div>
    </g:form>
  </div>
</div>
</body>
