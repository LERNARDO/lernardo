<head>
  <meta name="layout" content="database"/>
  <title><g:message code="object.edit" args="[message(code: 'user')]"/></title>
</head>
<body>
<div class="boxHeader">
  <div class="second">
    <h1><g:message code="object.edit" args="[message(code: 'user')]"/></h1>
    %{--<div class="icons" style="text-align: right;">
      <g:link action="show" id="${user.id}"><img src="${resource(dir: 'images/icons', file: 'cross.png')}" alt="${message(code: 'cancel')}" align="top"/></g:link>
    </div>--}%
  </div>
</div>
<div class="boxGray" style="clear: both;">
  <div class="second">

    <g:render template="/templates/errors" model="[bean: user]"/>

    <g:form id="${user.id}">

      <table>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="firstName"/></td>
          <td valign="top" class="value">
            <g:textField class="countable${user.profile.constraints.firstName.maxSize} ${hasErrors(bean:user,field:'profile.firstName','errors')}" size="60" name="firstName" value="${fieldValue(bean:user,field:'profile.firstName').decodeHTML()}"/>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="lastName"/></td>
          <td valign="top" class="value">
            <g:textField class="countable${user.profile.constraints.lastName.maxSize} ${hasErrors(bean:user,field:'profile.lastName','errors')}" size="60" name="lastName" value="${fieldValue(bean:user,field:'profile.lastName').decodeHTML()}"/>
          </td>
        </tr>

      </table>

      <div class="email">
        <table width="100%">
          <tr>
            <erp:isSystemAdmin entity="${currentEntity}">
              <td>
                <g:message code="active"/>
                <g:checkBox name="enabled" value="${user?.user?.enabled}"/>
              </td>
            </erp:isSystemAdmin>
            <td>
              <g:message code="email"/>:
              <g:textField class="${hasErrors(bean: user, field: 'user.email', 'errors')}" size="30" maxlength="80" name="email" value="${fieldValue(bean: user, field: 'user.email')}"/>
            </td>
            %{--<td>
              <g:message code="languageSelection"/>:
              <erp:localeSelect class="drop-down-150" name="locale" value="${user?.user?.locale}"/>
            </td>--}%
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
