<head>
  <meta name="layout" content="database"/>
  <title><g:message code="object.edit" args="[message(code: 'user')]"/></title>
</head>
<body>
<div class="boxHeader">
  <h1><g:message code="object.edit" args="[message(code: 'user')]"/></h1>
  %{--<div class="icons" style="text-align: right;">
    <g:link action="show" id="${user.id}"><img src="${resource(dir: 'images/icons', file: 'cross.png')}" alt="${message(code: 'cancel')}" align="top"/></g:link>
  </div>--}%
</div>
<div class="boxContent" style="clear: both;">

    <g:render template="/templates/errors" model="[bean: user]"/>

    <g:form id="${user.id}">

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
        <table width="100%">
          <tr>
            <erp:isSystemAdmin>
              <td>
                <g:message code="active"/>
                <g:checkBox name="enabled" value="${user?.user?.enabled}"/>
              </td>
            </erp:isSystemAdmin>
            <td>
              <g:message code="email"/> <span class="required-indicator">*</span>
              <g:textField class="${hasErrors(bean: user, field: 'user.email', 'errors')}" required="" size="30" maxlength="80" name="email" value="${fieldValue(bean: user, field: 'user.email')}"/>
            </td>
          </tr>
        </table>
      </div>

      <div class="buttons cleared">
        <div class="button"><g:actionSubmit class="buttonGreen" action="update" value="${message(code: 'save')}" /></div>
        <div class="button"><g:link class="buttonGray" action="show" id="${user.id}"><g:message code="cancel"/></g:link></div>
      </div>

    </g:form>

</div>
</body>
