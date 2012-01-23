<head>
  <meta name="layout" content="database"/>
  <title><g:message code="object.edit" args="[message(code: 'operator')]"/></title>
</head>
<body>
<div class="boxHeader">
  <div class="second">
    <h1><g:message code="object.edit" args="[message(code: 'operator')]"/></h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <g:render template="/templates/errors" model="[bean: operator]"/>

    <g:form id="${operator.id}">
      <table>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="name"/></td>
          <td valign="top" class="value">
            <g:textField class="countable50 ${hasErrors(bean: operator, field: 'profile.fullName', 'errors')}" size="50" maxlength="80" name="fullName" value="${fieldValue(bean: operator, field: 'profile.fullName').decodeHTML()}"/>
          </td>
        </tr>

        %{--<tr class="prop">
          <td valign="top" class="name"><g:message code="email"/></td>
          <td valign="top" class="value">
            <g:textField class="${hasErrors(bean: operator, field: 'user.email', 'errors')}" size="50" type="text" maxlength="80" name="email" value="${fieldValue(bean: operator, field: 'user.email').decodeHTML()}"/>
          </td>
        </tr>--}%

        <tr class="prop">
          <td valign="top" class="name"><g:message code="zip"/></td>
          <td valign="top" class="value">
            <g:textField class="${hasErrors(bean: operator, field: 'profile.zip', 'errors')}" size="10" name="zip" value="${fieldValue(bean: operator, field: 'profile.zip').decodeHTML()}"/>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="city"/></td>
          <td valign="top" class="value">
            <g:textField class="countable50 ${hasErrors(bean: operator, field: 'profile.city', 'errors')}" size="50" name="city" value="${fieldValue(bean: operator, field: 'profile.city').decodeHTML()}"/>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="street"/></td>
          <td valign="top" class="value">
            <g:textField class="countable50 ${hasErrors(bean: operator, field: 'profile.street', 'errors')}" size="50" name="street" value="${fieldValue(bean: operator, field: 'profile.street').decodeHTML()}"/>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="description"/></td>
          <td valign="top" class="value">
            <g:textArea class="countable2000 ${hasErrors(bean: operator, field: 'profile.description', 'errors')}" rows="6" cols="50" name="description" value="${fieldValue(bean: operator, field: 'profile.description').decodeHTML()}"/>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="phone"/></td>
          <td valign="top" class="value">
            <g:textField class="${hasErrors(bean: operator, field: 'profile.phone', 'errors')}" size="25" name="phone" value="${fieldValue(bean: operator, field: 'profile.phone').decodeHTML()}"/>
          </td>
        </tr>

      </table>

      <div class="email">
        <table width="100%">
          <tr>
            <erp:accessCheck entity="${currentEntity}" types="['Betreiber']">
              <td>
                <g:message code="active"/>
                <g:checkBox name="enabled" value="${operator?.user?.enabled}" style="vertical-align: bottom"/>
              </td>
            </erp:accessCheck>
            <td>
              <g:message code="email"/>:
              <g:textField class="${hasErrors(bean: operator, field: 'user.email', 'errors')}" size="40" type="text" maxlength="80" name="email" value="${fieldValue(bean: operator, field: 'user.email')}"/>
            </td>
            <td>
              <g:message code="languageSelection"/>:
              <erp:localeSelect class="drop-down-150" name="locale" value="${operator?.user?.locale}"/>
            </td>
            <td>
              <g:message code="showTips"/>
              <g:checkBox name="showTips" value="${operator?.profile?.showTips}" style="vertical-align: bottom"/>
            </td>
          </tr>
        </table>
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