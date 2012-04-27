<%@ page import="at.uenterprise.erp.Setup" %>
<head>
  <meta name="layout" content="database"/>
  <title><g:message code="object.create" args="[message(code: 'partner')]"/></title>
</head>

<body>
<div class="boxHeader">
  <h1><g:message code="object.create" args="[message(code: 'partner')]"/></h1>
</div>
<div class="boxGray">
  <div class="second">

    <g:render template="/templates/errors" model="[bean: partner]"/>

    <g:form>

      <table>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="name"/></td>
          <td valign="top" class="value">
            <g:textField class="countable50 ${hasErrors(bean: partner, field: 'profile.fullName', 'errors')}" size="42" maxlength="80" name="fullName" value="${fieldValue(bean: partner, field: 'profile.fullName').decodeHTML()}"/>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="description"/></td>
          <td valign="top" class="value">
            <g:textArea class="countable2000 ${hasErrors(bean: partner, field: 'profile.description', 'errors')}" rows="5" cols="50" name="description" value="${fieldValue(bean: partner, field: 'profile.description').decodeHTML()}"/>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="partner.profile.website"/></td>
          <td valign="top" class="value">
            <g:textField class="${hasErrors(bean: partner, field: 'profile.website', 'errors')}" size="30" maxlength="80" name="website" value="${fieldValue(bean: partner, field: 'profile.website')}"/>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="phone"/></td>
          <td valign="top" class="value">
            <g:textField class="${hasErrors(bean: partner, field: 'profile.phone', 'errors')}" size="30" name="phone" value="${fieldValue(bean: partner, field: 'profile.phone').decodeHTML()}"/>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="partner.profile.services"/></td>
          <td valign="top" class="value">
            <g:select name="services" multiple="true" from="${Setup.list()[0]?.partnerServices}" value="${partner?.profile?.services}" noSelection="['': message(code: 'none')]"/>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="street"/></td>
          <td valign="top" class="value">
            <g:textField class="countable50 ${hasErrors(bean: partner, field: 'profile.street', 'errors')}" size="42" name="street" value="${fieldValue(bean: partner, field: 'profile.street').decodeHTML()}"/>
          </td>
        </tr>

        %{--<tr class="prop">
          <td valign="top" class="name"><g:message code="zip"/></td>
          <td valign="top" class="value">
            <g:textField class="${hasErrors(bean: partner, field: 'profile.zip', 'errors')}" size="12" name="zip" value="${fieldValue(bean: partner, field: 'profile.zip').decodeHTML()}"/>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="city"/></td>
          <td valign="top" class="value">
            <g:textField class="countable50 ${hasErrors(bean: partner, field: 'profile.city', 'errors')}" size="30" name="city" value="${fieldValue(bean: partner, field: 'profile.city').decodeHTML()}"/>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="country"/></td>
          <td valign="top" class="value">
            <g:select name="country" from="${Setup.list()[0]?.nationalities}" value="${partner?.profile?.country}" noSelection="['': message(code: 'unknown')]"/>
          </td>
        </tr>--}%

        <tr class="prop">
          <td valign="top" class="name"><g:message code="groupColony"/></td>
          <td valign="top" class="value">
            <g:select name="currentColony" from="${allColonies}" optionKey="id" optionValue="profile"/>
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
            <td width="70" valign="top" class="name"><g:message code="email"/></td>
            <td width="320" valign="top" class="value">
              <g:textField class="${hasErrors(bean: partner, field: 'user.email', 'errors')}" size="47" maxlength="80" id="email" name="email" value="${fieldValue(bean: partner, field: 'user.email')}"/>
            </td>
            %{--<td width="130" valign="top" class="name"><g:message code="languageSelection"/></td>
            <td valign="top" class="value">
              <erp:localeSelect name="locale" value="${partner?.user?.locale}"/>
            </td>--}%
          </tr>
        </table>
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
