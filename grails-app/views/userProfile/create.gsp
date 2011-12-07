<head>
  <meta name="layout" content="database"/>
  <title><g:message code="object.create" args="[message(code: 'user')]"/></title>
</head>
<body>
<div class="boxHeader">
  <div class="second">
    <h1><g:message code="object.create" args="[message(code: 'user')]"/></h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <g:render template="/templates/errors" model="[bean: user]"/>

    <g:form>

      <table>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="firstName"/></td>
          <td valign="top" class="value">
            <g:textField class="countable50 ${hasErrors(bean:user,field:'profile.firstName','errors')}" size="60" name="firstName" value="${fieldValue(bean:user,field:'profile.firstName').decodeHTML()}"/>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="lastName"/></td>
          <td valign="top" class="value">
            <g:textField class="countable50 ${hasErrors(bean:user,field:'profile.lastName','errors')}" size="60" name="lastName" value="${fieldValue(bean:user,field:'profile.lastName').decodeHTML()}"/>
          </td>
        </tr>

      </table>

      <div class="email">
        <table>

          <tr>
            <td width="90" valign="middle">
              <g:message code="active"/>
              <g:checkBox name="enabled" value="${user?.user?.enabled}"/>
            </td>
            <td width="350" valign="middle">
              <g:message code="email"/>:
              <g:textField class="${hasErrors(bean: user, field: 'user.email', 'errors')}" size="40" type="text" maxlength="80" name="email" value="${fieldValue(bean: user, field: 'user.email')}"/>
            </td>
            <td>
              <g:message code="languageSelection"/>:
              <erp:localeSelect class="drop-down-200" name="locale" value="${user?.user?.locale}"/>
            </td>
          </tr>

        </table>
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