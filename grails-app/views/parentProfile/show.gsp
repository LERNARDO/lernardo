<head>
  <meta name="layout" content="private"/>
  <title>Lernardo | Profil - ${parent.profile.fullName}</title>
</head>
<body>
<div class="headerBlue">
  <div class="second">
    <h1>Profil - ${parent.profile.fullName}</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">
    <div class="dialog">
      <table class="listing">
        <tbody>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="parent.profile.firstName"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: parent, field: 'profile.firstName') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="parent.profile.lastName"/>:
          </td>
          <td valign="top" class="value"><g:link action="show" id="${parent.id}" params="[entity:parent.id]">${parent.profile.lastName}</g:link></td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="parent.profile.birthDate"/>:
          </td>
          <td valign="top" class="value"><g:formatDate date="${parent.profile.birthDate}" format="dd. MM. yyyy"/></td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="parent.profile.email"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: parent, field: 'user.email') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="parent.profile.currentCountry"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: parent, field: 'profile.currentCountry') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="parent.profile.currentZip"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: parent, field: 'profile.currentZip') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="parent.profile.currentCity"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: parent, field: 'profile.currentCity') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="parent.profile.currentStreet"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: parent, field: 'profile.currentStreet') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="parent.profile.maritalStatus"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: parent, field: 'profile.maritalStatus') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="parent.profile.gender"/>:
          </td>
          <td valign="top" class="value"><app:showGender gender="${parent.profile.gender}"/></td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="parent.profile.languages"/>:
          </td>
          <td valign="top" class="value"><ul><g:each in="${parent.profile.languages}" var="language"><li>${language}</li></g:each></ul></td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="parent.profile.education"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: parent, field: 'profile.education') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="parent.profile.job"/>:
          </td>
          <td valign="top" class="value"><g:formatBoolean boolean="${parent.profile.job}" true="${message(code:'yes')}" false="${message(code:'no')}"/></td>
        </tr>

        <g:if test="${parent.profile.job}">
          <tr class="prop">
            <td valign="top" class="name">
              <g:message code="parent.profile.jobType"/>:
            </td>
            <td valign="top" class="value">${fieldValue(bean: parent, field: 'profile.jobType') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
          </tr>
  
          <tr class="prop">
            <td valign="top" class="name">
              <g:message code="parent.profile.jobIncome"/>:
            </td>
            <td valign="top" class="value">${fieldValue(bean: parent, field: 'profile.jobIncome') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <g:message code="parent.profile.jobFrequency"/>:
            </td>
            <td valign="top" class="value">${fieldValue(bean: parent, field: 'profile.jobFrequency') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
          </tr>
        </g:if>

        <app:isAdmin>
          <tr class="prop">
            <td valign="top" class="name">
              <g:message code="active"/>:
            </td>
            <td valign="top" class="value"><g:formatBoolean boolean="${parent.user.enabled}" true="${message(code:'yes')}" false="${message(code:'no')}"/></td>
          </tr>
        </app:isAdmin>

        </tbody>
      </table>
    </div>

    <app:isMeOrAdmin entity="${parent}">
      <div class="buttons">
        <g:link class="buttonBlue" action="edit" id="${parent?.id}"><g:message code="edit"/></g:link>
        <div class="spacer"></div>
      </div>
    </app:isMeOrAdmin>

  </div>
</div>
</body>
