<head>
  <meta name="layout" content="private"/>
  <title><g:message code="user.profile.edit"/></title>
</head>
<body>
<div class="boxHeader">
  <div class="second">
    <h1 style="float: left"><g:message code="user.profile.edit"/></h1>
    <div class="icons" style="text-align: right;">
      <g:link action="show" id="${user.id}"><img src="${resource(dir: 'images/icons', file: 'icon_cancel.png')}" alt="${message(code: 'cancel')}" align="top"/></g:link>
    </div>
  </div>
</div>
<div class="boxGray" style="clear: both;">
  <div class="second">

    <g:render template="/templates/errors" model="[bean: user]"/>

    <g:form action="update" id="${user.id}">

      <div>
        <table>
          <tbody>

          <tr class="prop">
            <td valign="top" class="name"><g:message code="user.profile.firstName"/></td>
            <td valign="top" class="name"><g:message code="user.profile.lastName"/></td>
          </tr>

          <tr class="prop">
            <td width="440" valign="top" class="value">
              <g:textField class="countable${user.profile.constraints.firstName.maxSize} ${hasErrors(bean:user,field:'profile.firstName','errors')}" size="60" name="firstName" value="${fieldValue(bean:user,field:'profile.firstName').decodeHTML()}"/>
            </td>
            <td width="440" valign="top" class="value">
              <g:textField class="countable${user.profile.constraints.lastName.maxSize} ${hasErrors(bean:user,field:'profile.lastName','errors')}" size="60" name="lastName" value="${fieldValue(bean:user,field:'profile.lastName').decodeHTML()}"/>
            </td>
          </tr>

          </tbody>
        </table>
      </div>

      <div class="email">
        <table>
          <tr>
            <erp:isSysAdmin>
              <td width="85" valign="middle">
                <g:message code="active"/>
                <erp:isAdmin entity="${currentEntity}">
                  <g:checkBox name="enabled" value="${user?.user?.enabled}"/>
                </erp:isAdmin>
                <erp:notAdmin entity="${currentEntity}">
                  <g:checkBox name="enabled" value="${user?.user?.enabled}" disabled="true"/>
                </erp:notAdmin>
              </td>
            </erp:isSysAdmin>

            <td width="150" valign="middle">
              <g:message code="password"/>:
              <g:link controller="profile" action="changePassword" id="${user.id}"><g:message code="change"/></g:link>
            </td>

            <td width="270" valign="middle">
              <g:message code="user.profile.email"/>:
              <g:textField class="${hasErrors(bean: user, field: 'user.email', 'errors')}" size="30" maxlength="80" name="email" value="${fieldValue(bean: user, field: 'user.email')}"/>
            </td>

            <td valign="middle">
              <g:message code="languageSelection"/>:
              <erp:localeSelect class="drop-down-150" name="locale" value="${user?.user?.locale}"/>
            </td>
          </tr>
        </table>
      </div>

      <div class="buttons">
        <g:submitButton name="submitButton" value="${message(code:'save')}"/>
        <g:link class="buttonGray" action="show" id="${user.id}"><g:message code="cancel"/></g:link>
        <div class="spacer"></div>
      </div>
    </g:form>
  </div>
</div>
</body>
