<head>
  <meta name="layout" content="private"/>
  <title>Lernardo | Profil - ${user.profile.fullName}</title>
</head>
<body>
<div class="headerBlue">
  <div class="second">
    <h1>Profil - ${user.profile.fullName}</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">
    <div class="dialog">
      <table class="listing">
        <tbody>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="user.profile.firstName"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: user, field: 'profile.firstName')}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="user.profile.lastName"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: user, field: 'profile.lastName')}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="user.profile.email"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: user, field: 'user.email')}</td>
        </tr>

        <app:isAdmin>
          <tr class="prop">
            <td valign="top" class="name">
              <g:message code="active"/>:
            </td>
            <td valign="top" class="value"><g:formatBoolean boolean="${user.user.enabled}" true="Ja" false="Nein"/></td>
          </tr>
        </app:isAdmin>

        </tbody>
      </table>
    </div>

    <app:isMeOrAdmin entity="${user}">
      <div class="buttons">
        <g:link class="buttonBlue" action="edit" id="${user?.id}"><g:message code="edit"/></g:link>
        <div class="spacer"></div>
      </div>
    </app:isMeOrAdmin>

  </div>
</div>
</body>
