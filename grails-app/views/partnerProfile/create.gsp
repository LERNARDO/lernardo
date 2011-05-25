<%@ page import="at.uenterprise.erp.Setup" %>
<head>
  <meta name="layout" content="private"/>
  <title><g:message code="partner.profile.create"/></title>
</head>

<body>
<div class="boxHeader">
  <div class="second">
    <h1><g:message code="partner.profile.create"/></h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <g:render template="/templates/errors" model="[bean: partner]"/>

    <g:form>
      <div>

        <table>

          <tr class="prop">
            <td valign="top" class="name"><g:message code="partner.profile.name"/>:</td>
            <td colspan="2" valign="top" class="name"><g:message code="partner.profile.description"/>:</td>
            <td valign="top" class="name"><g:message code="partner.profile.website"/>:</td>
          </tr>

          <tr class="prop">
            <td valign="top" class="value">
              <g:textField class="countable50 ${hasErrors(bean: partner, field: 'profile.fullName', 'errors')}" size="42" maxlength="80" name="fullName" value="${fieldValue(bean: partner, field: 'profile.fullName').decodeHTML()}"/>
            </td>
            <td valign="top" colspan="2" class="value">
              <g:textArea class="countable2000 ${hasErrors(bean: partner, field: 'profile.description', 'errors')}" rows="1" cols="45" name="description" value="${fieldValue(bean: partner, field: 'profile.description').decodeHTML()}"/>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: partner, field: 'profile.website', 'errors')}" size="30" maxlength="80" name="website" value="${fieldValue(bean: partner, field: 'profile.website')}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name"><g:message code="partner.profile.phone"/>:</td>
            <td colspan="3" valign="top" class="name"><g:message code="partner.profile.services"/>:</td>
          </tr>

          <tr class="prop">
            <td valign="top" width="200" class="value">
              <g:textField class="${hasErrors(bean: partner, field: 'profile.phone', 'errors')}" size="42" name="phone" value="${fieldValue(bean: partner, field: 'profile.phone').decodeHTML()}"/>
            <td width="421" colspan="3" class="value">
              <g:select name="services" multiple="true" from="${grailsApplication.config.partners}" value="${partner?.profile?.services}" noSelection="['': message(code: 'none')]" valueMessagePrefix="partner"/>
            </td>
          </tr>

          %{-- AAZ (01.09.2010): not required anymore by customer --}%
          %{--<tr class="prop">
            <td colspan="4" valign="middle" class="name"><g:message code="partner.profile.colonia"/>:</td>
          </tr>

          <tr class="prop">
            <td colspan="4" valign="middle" class="value">
              <g:select from="${allColonias}" class="drop-down-240" name="colonia" optionKey="id" optionValue="profile"/>
            </td>
          </tr>--}%

          <tr class="prop">
            <td valign="top" class="name"><g:message code="partner.profile.street"/>:</td>
            <td valign="top" class="name"><g:message code="partner.profile.zip"/>:</td>
            <td valign="top" class="name"><g:message code="partner.profile.city"/>:</td>
            <td valign="top" class="name"><g:message code="partner.profile.country"/>:</td>
          </tr>

          <tr class="prop">
            <td width="290" valign="top" class="value">
              <g:textField class="countable50 ${hasErrors(bean: partner, field: 'profile.street', 'errors')}" size="42" name="street" value="${fieldValue(bean: partner, field: 'profile.street').decodeHTML()}"/>
            </td>
            <td width="101" valign="top" class="value">
              <g:textField class="${hasErrors(bean: partner, field: 'profile.zip', 'errors')}" size="12" name="zip" value="${fieldValue(bean: partner, field: 'profile.zip').decodeHTML()}"/>
            </td>
            <td width="220" valign="top" class="value">
              <g:textField class="countable50 ${hasErrors(bean: partner, field: 'profile.city', 'errors')}" size="30" name="city" value="${fieldValue(bean: partner, field: 'profile.city').decodeHTML()}"/>
            </td>
            <td width="210" valign="top" class="value">
              <g:select name="country" from="${Setup.list()[0]?.nationalities}" value="${partner?.profile?.country}" noSelection="['': message(code: 'unknown')]"/>
            </td>
          </tr>

        </table>

        <div class="email">
          <table>
            <tr class="prop">
              <td width="60" valign="top" class="name"><g:message code="active"/></td>
              <td width="40" valign="top" class="value">
                <g:checkBox name="enabled" value="${partner?.user?.enabled}"/>
              </td>
              <td width="70" valign="top" class="name"><g:message code="partner.profile.email"/></td>
              <td width="320" valign="top" class="value">
                <g:textField class="${hasErrors(bean: partner, field: 'user.email', 'errors')}" size="47" maxlength="80" id="email" name="email" value="${fieldValue(bean: partner, field: 'user.email')}"/>
              </td>
              <td width="130" valign="top" class="name"><g:message code="languageSelection"/></td>
              <td valign="top" class="value">
                <erp:localeSelect class="drop-down-150" name="locale" value="${partner?.user?.locale}"/>
              </td>
            </tr>
          </table>
        </div>

      </div>

      <div class="buttons">
        <div class="button"><g:actionSubmit class="buttonGreen" action="save" value="${message(code: 'save')}" /></div>
        <div class="button"><g:actionSubmit class="buttonGray" action="list" value="${message(code: 'cancel')}" /></div>
        <div class="spacer"></div>
      </div>

    </g:form>
  </div>
</div>
</body>
