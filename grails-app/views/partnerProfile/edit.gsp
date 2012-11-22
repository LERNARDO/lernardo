<%@ page import="at.uenterprise.erp.Setup" %>
<head>
  <meta name="layout" content="database"/>
  <title><g:message code="object.edit" args="[message(code: 'partner')]"/></title>
</head>
<body>
<div class="boxHeader">
  <h1><g:message code="object.edit" args="[message(code: 'partner')]"/></h1>
</div>
<div class="boxContent">

    <g:render template="/templates/errors" model="[bean: partner]"/>

    <g:form id="${partner.id}">

      <table>

        <tr class="prop">
          <td class="name"><g:message code="name"/> <span class="required-indicator">*</span></td>
          <td class="value">
            <g:textField data-counter="50" class="${hasErrors(bean: partner, field: 'profile', 'errors')}" required="" size="42" maxlength="80" name="fullName" value="${fieldValue(bean: partner, field: 'profile').decodeHTML()}"/>
          </td>
        </tr>

        <tr class="prop">
          <td class="name"><g:message code="description"/></td>
          <td class="value">
            <g:textArea data-counter="2000" class="${hasErrors(bean: partner, field: 'profile.description', 'errors')}" rows="5" cols="50" name="description" value="${fieldValue(bean: partner, field: 'profile.description').decodeHTML()}"/>
          </td>
        </tr>

        <tr class="prop">
          <td class="name"><g:message code="partner.profile.website"/></td>
          <td class="value">
            <g:textField class="${hasErrors(bean: partner, field: 'profile.website', 'errors')}" size="30" maxlength="80" name="website" value="${fieldValue(bean: partner, field: 'profile.website')}"/>
          </td>
        </tr>

        <tr class="prop">
          <td class="name"><g:message code="phone"/></td>
          <td class="value">
            <g:textField class="${hasErrors(bean: partner, field: 'profile.phone', 'errors')}" size="30" name="phone" value="${fieldValue(bean: partner, field: 'profile.phone').decodeHTML()}"/>
          </td>
        </tr>

        <tr class="prop">
          <td class="name"><g:message code="partner.profile.services"/></td>
          <td class="value">
            <g:select name="services" multiple="true" from="${Setup.list()[0]?.partnerServices}" value="${partner?.profile?.services}" noSelection="['': message(code: 'none')]"/>
          </td>
        </tr>

          <tr class="prop">
              <td class="name"><g:message code="zip"/></td>
              <td class="value">
                  <g:textField class="${hasErrors(bean: partner, field: 'profile.zip', 'errors')}" size="10" name="zip" value="${fieldValue(bean: partner, field: 'profile.zip').decodeHTML()}"/>
              </td>
          </tr>

        <tr class="prop">
          <td class="name"><g:message code="street"/></td>
          <td class="value">
            <g:textField data-counter="50" class="${hasErrors(bean: partner, field: 'profile.street', 'errors')}" size="42" name="street" value="${fieldValue(bean: partner, field: 'profile.street').decodeHTML()}"/>
          </td>
        </tr>

          <tr class="prop">
              <td class="name"><g:message code="city"/></td>
              <td class="value">
                  <g:textField data-counter="50" class="${hasErrors(bean: partner, field: 'profile.city', 'errors')}" size="30" name="city" value="${fieldValue(bean: partner, field: 'profile.city').decodeHTML()}"/>
              </td>
          </tr>

          <tr class="prop">
              <td class="name"><g:message code="country"/></td>
              <td class="value">
                  <g:textField class="${hasErrors(bean: partner, field: 'profile.country', 'errors')}" size="30" name="street" value="${fieldValue(bean: partner, field: 'profile.country').decodeHTML()}"/>
              </td>
          </tr>

      </table>

      <div class="email">
        <table width="100%">
          <tr>
            <erp:accessCheck types="['Betreiber']">
              <td>
                <g:message code="active"/>
                <g:checkBox name="enabled" value="${partner?.user?.enabled}" style="vertical-align: bottom"/>
              </td>
            </erp:accessCheck>
            <td>
              <g:message code="email"/> <span class="required-indicator">*</span>
              <g:textField class="${hasErrors(bean: partner, field: 'user.email', 'errors')}" required="" size="40" type="text" maxlength="80" name="email" value="${fieldValue(bean: partner, field: 'user.email')}"/>
            </td>
          </tr>
        </table>
      </div>

      <div class="buttons cleared">
        <div class="button"><g:actionSubmit class="buttonGreen" action="update" value="${message(code: 'save')}" /></div>
        <div class="button"><g:link class="buttonGray" action="show" id="${partner.id}"><g:message code="cancel"/></g:link></div>
      </div>

    </g:form>

</div>
</body>
