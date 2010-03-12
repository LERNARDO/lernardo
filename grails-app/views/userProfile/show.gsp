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
            <g:message code="userProfile.firstName.label" default="First Name"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: user, field: 'profile.firstName')}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="userProfile.lastName.label" default="Last Name"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: user, field: 'profile.lastName')}</td>
        </tr>

        <app:isAdmin>
          <tr class="prop">
            <td valign="top" class="name">
              <g:message code="userProfile.work.label" default="Aktiv"/>:
            </td>
            <td valign="top" class="value"><app:showBoolean bool="${user.user.enabled}"/></td>
          </tr>
        </app:isAdmin>

        </tbody>
      </table>
    </div>
    <div class="buttons">
      <g:link class="buttonBlue" action="edit" id="${user?.id}">Bearbeiten</g:link>
      <div class="spacer"></div>
    </div>
  </div>
</div>
</body>
