<head>
  <meta name="layout" content="private"/>
  <title>Lernardo | Profil - ${user.profile.fullName}</title>
</head>
<body>
<div class="headerGreen">
  <div class="second">
    <h1 style="float: left">Profil - ${user.profile.fullName}</h1>
    <div class="icons" style="text-align: right;">
      <g:link action="edit" id="${user.id}"><img src="${resource (dir:'images/icons', file:'icon_edit.png')}" alt="${message(code:'edit')}" align="top"/></g:link>
    </div>
  </div>
</div>
<div class="boxGray" style="clear: both;">
  <div class="second">
    <div class="dialog">
      <table >
        <tbody>

        <tr class="prop">
          <td valign="top" class="name-show">
            <g:message code="user.profile.firstName"/>:
          </td>
          <td valign="top" width="700" class="value-show">${fieldValue(bean: user, field: 'profile.firstName').decodeHTML()}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name-show">
            <g:message code="user.profile.lastName"/>:
          </td>
          <td valign="top" class="value-show">${fieldValue(bean: user, field: 'profile.lastName').decodeHTML()}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name-show">
            <g:message code="user.profile.email"/>:
          </td>
          <td valign="top" class="value-show">${fieldValue(bean: user, field: 'user.email')}</td>
        </tr>

        <app:isAdmin>
          <tr class="prop">
            <td valign="top" class="name-show">
              <g:message code="active"/>:
            </td>
            <td valign="top" class="value-show"><g:formatBoolean boolean="${user.user.enabled}" true="${message(code:'yes')}" false="${message(code:'no')}"/></td>
          </tr>
        </app:isAdmin>

        </tbody>
      </table>
    </div>

    <app:isMeOrAdmin entity="${user}">
      <div class="buttons">
        <g:link class="buttonGreen" action="edit" id="${user?.id}"><g:message code="edit"/></g:link>
        <div class="spacer"></div>
      </div>
    </app:isMeOrAdmin>

  </div>
</div>
</body>
