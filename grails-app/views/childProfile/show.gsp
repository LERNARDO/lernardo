<head>
  <meta name="layout" content="private"/>
  <title>Lernardo | Profil - ${child.profile.fullName}</title>
</head>
<body>
<div class="headerBlue">
  <div class="second">
    <h1>Profil - ${child.profile.fullName}</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">
    <div class="dialog">
      <table class="listing">
        <tbody>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="child.profile.firstName"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: child, field: 'profile.firstName')}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="child.profile.lastName"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: child, field: 'profile.lastName')}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="child.profile.gender"/>:
          </td>
          <td valign="top" class="value"><app:showGender gender="${child.profile.gender}"/></td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="child.profile.birthDate"/>:
          </td>
          <td valign="top" class="value"><g:formatDate date="${child.profile.birthDate}" format="dd. MM. yyyy"/></td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="child.profile.job"/>:
          </td>
          <td valign="top" class="value"><g:formatBoolean boolean="${child.profile.job}" true="Ja" false="Nein"/></td>
        </tr>

        <g:if test="${child.profile.job}">
          <tr class="prop">
            <td valign="top" class="name">
              <g:message code="child.profile.jobType"/>:
            </td>
            <td valign="top" class="value">${fieldValue(bean: child, field: 'profile.jobType')}</td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <g:message code="child.profile.jobIncome"/>:
            </td>
            <td valign="top" class="value">${fieldValue(bean: child, field: 'profile.jobIncome')}</td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <g:message code="child.profile.jobFrequency"/>:
            </td>
            <td valign="top" class="value">${fieldValue(bean: child, field: 'profile.jobFrequency')}</td>
          </tr>
        </g:if>

        <app:isAdmin>
          <tr class="prop">
            <td valign="top" class="name">
              <g:message code="active"/>:
            </td>
            <td valign="top" class="value"><g:formatBoolean boolean="${child.user.enabled}" true="Ja" false="Nein"/></td>
          </tr>
        </app:isAdmin>

        </tbody>
      </table>
    </div>

    <app:isMeOrAdmin entity="${child}">
      <div class="buttons">
        <g:link class="buttonBlue" action="edit" id="${child?.id}"><g:message code="edit"/></g:link>
        <div class="spacer"></div>
      </div>
    </app:isMeOrAdmin>

  </div>
</div>
</body>
