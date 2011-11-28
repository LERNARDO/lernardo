<%@ page import="at.uenterprise.erp.Setup" %>
<head>
  <meta name="layout" content="database"/>
  <title><g:message code="object.edit" args="[message(code: 'partner')]"/></title>
</head>
<body>
<div class="boxHeader">
  <div class="second">
    <h1><g:message code="object.edit" args="[message(code: 'partner')]"/></h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <g:render template="/templates/errors" model="[bean: partner]"/>

    <g:form id="${partner.id}">
      <div>
        <table>

          <tr class="prop">
            <td class="name"><g:message code="name"/>:</td>
            <td colspan="2" valign="top" class="name"><g:message code="description"/>:</td>
            <td valign="top" class="name"><g:message code="partner.profile.website"/>:</td>
          </tr>

          <tr class="prop">
            <td valign="top" class="value">
              <g:textField class="countable${partner.profile.constraints.fullName.maxSize} ${hasErrors(bean: partner, field: 'profile.fullName', 'errors')}" size="42" id="fullName" name="fullName" value="${fieldValue(bean: partner, field: 'profile.fullName').decodeHTML()}"/>
            </td>
            <td valign="top" colspan="2" class="value">
              <g:textArea class="countable${partner.profile.constraints.description.maxSize} ${hasErrors(bean: partner, field: 'profile.description', 'errors')}" rows="1" cols="45" id="description" name="description" value="${fieldValue(bean: partner, field: 'profile.description').decodeHTML()}"/>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: partner, field: 'profile.website', 'errors')}" size="30" maxlength="80" id="website" name="website" value="${fieldValue(bean: partner, field: 'profile.website')}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name"><g:message code="phone"/>:</td>
            <td colspan="3" valign="top" class="name"><g:message code="partner.profile.services"/>:</td>
          </tr>

          <tr class="prop">
            <td valign="top" width="200" class="value">
              <g:textField class="${hasErrors(bean: partner, field: 'profile.phone', 'errors')}" size="42" id="phone" name="phone" value="${fieldValue(bean: partner, field: 'profile.phone').decodeHTML()}"/>
            <td width="421" colspan="3" class="value">
              <g:select name="services" multiple="true" from="${Setup.list()[0]?.partnerServices}" value="${partner?.profile?.services}" noSelection="['': message(code: 'none')]"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name"><g:message code="street"/>:</td>
            <td valign="top" class="name"><g:message code="zip"/>:</td>
            <td valign="top" class="name"><g:message code="city"/>:</td>
            <td valign="top" class="name"><g:message code="country"/>:</td>
          </tr>

          <tr class="prop">
            <td width="290" valign="top" class="value">
              <g:textField class="countable${partner.profile.constraints.street.maxSize} ${hasErrors(bean: partner, field: 'profile.street', 'errors')}" size="42" id="street" name="street" value="${fieldValue(bean: partner, field: 'profile.street').decodeHTML()}"/>
            </td>
            <td width="101" valign="top" class="value">
              <g:textField class="${hasErrors(bean: partner, field: 'profile.zip', 'errors')}" size="12" id="zip" name="zip" value="${fieldValue(bean: partner, field: 'profile.zip').decodeHTML()}"/>
            </td>
            <td width="220" valign="top" class="value">
              <g:textField class="countable${partner.profile.constraints.city.maxSize} ${hasErrors(bean: partner, field: 'profile.city', 'errors')}" size="30" id="city" name="city" value="${fieldValue(bean: partner, field: 'profile.city').decodeHTML()}"/>
            </td>
            <td width="210" valign="top" class="value">
              <g:select name="country" from="${Setup.list()[0]?.nationalities}" value="${partner?.profile?.country}" noSelection="['': message(code: 'unknown')]"/>
            </td>
          </tr>

        </table>

        <div class="email">
          <table width="100%">
            <tr>
              <erp:accessCheck entity="${currentEntity}" types="['Betreiber']">
                <td>
                  <g:message code="active"/>
                  <g:checkBox name="enabled" value="${partner?.user?.enabled}" style="vertical-align: bottom"/>
                </td>
              </erp:accessCheck>
              <td>
                <g:message code="email"/>:
                <g:textField class="${hasErrors(bean: partner, field: 'user.email', 'errors')}" size="40" type="text" maxlength="80" name="email" value="${fieldValue(bean: partner, field: 'user.email')}"/>
              </td>
              <td>
                <g:message code="languageSelection"/>:
                <erp:localeSelect class="drop-down-150" name="locale" value="${partner?.user?.locale}"/>
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
