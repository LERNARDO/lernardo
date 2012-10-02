<%@ page import="at.uenterprise.erp.Setup" %>
<head>
  <meta name="layout" content="database"/>
  <title><g:message code="object.create" args="[message(code: 'pate')]"/></title>
</head>

<body>
<div class="boxHeader">
  <h1><g:message code="object.create" args="[message(code: 'pate')]"/></h1>
</div>
<div class="boxContent">

    <g:render template="/templates/errors" model="[bean: pate]"/>

    <g:form>

      <table>

        <tr class="prop">
          <td class="name"><g:message code="firstName"/> <span class="required-indicator">*</span></td>
          <td class="value">
            <g:textField data-counter="50" class="${hasErrors(bean: pate, field: 'profile.firstName', 'errors')}" required="" size="30" name="firstName" value="${fieldValue(bean: pate, field: 'profile.firstName').decodeHTML()}"/>
          </td>
        </tr>

        <tr class="prop">
          <td class="name"><g:message code="lastName"/> <span class="required-indicator">*</span></td>
          <td class="value">
            <g:textField data-counter="50" class="${hasErrors(bean: pate, field: 'profile.lastName', 'errors')}" required="" size="30" maxlength="30" name="lastName" value="${fieldValue(bean: pate, field: 'profile.lastName').decodeHTML()}"/>
          </td>
        </tr>

        <tr class="prop">
          <td class="name"><g:message code="pate.profile.motherTongue"/></td>
          <td class="value">
            <g:select name="motherTongue" from="${Setup.list()[0]?.languages}" value="${pate?.profile?.motherTongue}"/>
          </td>
        </tr>

        <tr class="prop">
          <td class="name"><g:message code="pate.profile.languages"/></td>
          <td class="value">
            <g:select name="languages" multiple="true" from="${Setup.list()[0]?.languages}" value="${pate?.profile?.languages}" noSelection="['': message(code: 'none')]"/>
          </td>
        </tr>

        <tr class="prop">
          <td class="name"><g:message code="zip"/></td>
          <td class="value">
            <g:textField class="${hasErrors(bean: pate, field: 'profile.zip', 'errors')}" size="10" name="zip" value="${fieldValue(bean: pate, field: 'profile.zip').decodeHTML()}"/>
          </td>
        </tr>

        <tr class="prop">
          <td class="name"><g:message code="city"/></td>
          <td class="value">
            <g:textField data-counter="50" class="${hasErrors(bean: pate, field: 'profile.city', 'errors')}" size="30" name="city" value="${fieldValue(bean: pate, field: 'profile.city').decodeHTML()}"/>
          </td>
        </tr>

        <tr class="prop">
          <td class="name"><g:message code="street"/></td>
          <td class="value">
            <g:textField data-counter="50" class="${hasErrors(bean: pate, field: 'profile.street', 'errors')}" size="40" name="street" value="${fieldValue(bean: pate, field: 'profile.street').decodeHTML()}"/>
          </td>
        </tr>

        <tr class="prop">
          <td class="name"><g:message code="country"/></td>
          <td class="value">
            <g:select name="country" from="${Setup.list()[0]?.nationalities}" value="${pate?.profile?.country}" noSelection="['': message(code: 'unknown')]"/>
          </td>
        </tr>

      </table>

      <div class="email">
        <table>

          <tr>
            <td width="90" valign="middle">
              <g:message code="active"/>
              <g:checkBox name="enabled" value="${pate?.user?.enabled}"/>
            </td>
            <td width="350" valign="middle">
              <g:message code="email"/> <span class="required-indicator">*</span>
              <g:textField class="${hasErrors(bean: pate, field: 'user.email', 'errors')}" required="" size="40" type="text" maxlength="80" name="email" value="${fieldValue(bean: pate, field: 'user.email')}"/>
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