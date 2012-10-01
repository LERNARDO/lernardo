<head>
  <meta name="layout" content="database"/>
  <title><g:message code="object.create" args="[message(code: 'user')]"/></title>
</head>
<body>
<div class="boxHeader">
  <h1><g:message code="object.create" args="[message(code: 'user')]"/></h1>
</div>
<div class="boxGray">
  <div class="second">

    <g:render template="/templates/errors" model="[bean: user]"/>

    <g:form>

      <table>

        <tr class="prop">
          <td class="name"><g:message code="firstName"/> <span class="required-indicator">*</span></td>
          <td class="value">
            <g:textField data-counter="50" class="${hasErrors(bean:user,field:'profile.firstName','errors')}" required="" size="60" name="firstName" value="${fieldValue(bean:user,field:'profile.firstName').decodeHTML()}"/>
          </td>
        </tr>

        <tr class="prop">
          <td class="name"><g:message code="lastName"/> <span class="required-indicator">*</span></td>
          <td class="value">
            <g:textField data-counter="50" class="${hasErrors(bean:user,field:'profile.lastName','errors')}" required="" size="60" name="lastName" value="${fieldValue(bean:user,field:'profile.lastName').decodeHTML()}"/>
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
              <g:message code="email"/> <span class="required-indicator">*</span>
              <g:textField class="${hasErrors(bean: user, field: 'user.email', 'errors')}" required="" size="40" type="text" maxlength="80" name="email" value="${fieldValue(bean: user, field: 'user.email')}"/>
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
</div>
</body>