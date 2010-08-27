<head>
  <meta name="layout" content="private"/>
  <title><g:message code="user"/> - ${user.profile.fullName}</title>
</head>
<body>
<div class="headerGreen">
  <div class="second">
    <h1 style="float: left"><g:message code="user"/> - ${user.profile.fullName}</h1>
    <div class="icons" style="text-align: right;">
      <g:link action="edit" id="${user.id}"><img src="${resource(dir: 'images/icons', file: 'icon_edit.png')}" alt="${message(code: 'edit')}" align="top"/></g:link>
    </div>
  </div>
</div>
<div class="boxGray" style="clear: both;">
  <div class="second">
    <div class="dialog">
      <table>
        <tbody>

        <tr class="prop">
          <td valign="top" class="name-show"><g:message code="user.profile.firstName"/>:</td>
          <td valign="top" class="name-show"><g:message code="user.profile.lastName"/>:</td>
        </tr>

        <tr class="prop">
          <td valign="top" width="400" class="value-show">${fieldValue(bean: user, field: 'profile.firstName').decodeHTML()}</td>
          <td valign="top" width="400" class="value-show">${fieldValue(bean: user, field: 'profile.lastName').decodeHTML()}</td>
        </tr>

        </tbody>
      </table>
    </div>

    <div class="email">
      <table>
        <tr class="prop">

          <app:isSysAdmin>
            <td width="60" valign="top"><g:message code="active"/>:</td>
            <td width="50" valign="top"><g:formatBoolean boolean="${user.user.enabled}" true="${message(code:'yes')}" false="${message(code:'no')}"/></td>
          </app:isSysAdmin>

          <td width="60" valign="top"><g:message code="user.profile.email"/>:</td>
          <td valign="top">${fieldValue(bean: user, field: 'user.email') ?: '<div class="italic"><g:message code="noData"/></div>'}</td>

        </tr>
      </table>
    </div> <!-- div email close -->

    <app:isMeOrAdmin entity="${user}">
      <div class="buttons">
        <g:link class="buttonGreen" action="edit" id="${user?.id}"><g:message code="edit"/></g:link>
        <g:link class="buttonGray" action="list"><g:message code="back"/></g:link>
        <div class="spacer"></div>
      </div>
    </app:isMeOrAdmin>

  </div>
</div>
</body>
