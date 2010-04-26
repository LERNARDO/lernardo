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

        <!-- karin todo begin -->

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="childProfile.firstName.label" default="First Name"/>:
          </td>

          <td valign="top" class="value">${fieldValue(bean: child, field: 'profile.firstName')}</td>

        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="childProfile.lastName.label" default="Last Name"/>:
          </td>

          <td valign="top" class="value">${fieldValue(bean: child, field: 'profile.lastName')}</td>

        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="childProfile.job.label" default="Job"/>:
          </td>

          <td valign="top" class="value"><g:formatBoolean boolean="${child.profile.job}" true="Ja" false="Nein"/></td>

        </tr>

        <g:if test="${child.profile.job}">
        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="childProfile.jobType.label" default="Job Type"/>:
          </td>

          <td valign="top" class="value">${fieldValue(bean: child, field: 'profile.jobType')}</td>

        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="childProfile.jobIncome.label" default="Job Income"/>:
          </td>

          <td valign="top" class="value">${fieldValue(bean: child, field: 'profile.jobIncome')}</td>

        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="childProfile.jobFrequency.label" default="Job Frequency"/>:
          </td>

          <td valign="top" class="value">${fieldValue(bean: child, field: 'profile.jobFrequency')}</td>

        </tr>
        </g:if>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="childProfile.gender.label" default="Gender"/>:
          </td>

          <td valign="top" class="value"><app:showGender gender="${child.profile.gender}"/></td>

        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="childProfile.birthDate.label" default="Birth Date"/>:
          </td>

          <td valign="top" class="value"><g:formatDate date="${child.profile.birthDate}" format="dd. MM. yyyy"/></td>

        </tr>

        <app:isAdmin>
          <tr class="prop">
            <td valign="top" class="name">
              <g:message code="childProfile.work.label" default="Aktiv"/>:
            </td>
            <td valign="top" class="value"><g:formatBoolean boolean="${child.user.enabled}" true="Ja" false="Nein"/></td>
          </tr>
        </app:isAdmin>

        <!-- karin todo end -->

        </tbody>
      </table>
    </div>

    <app:isMeOrAdmin entity="${child}">
      <div class="buttons">
        <g:link class="buttonBlue" action="edit" id="${child?.id}">Bearbeiten</g:link>
        <div class="spacer"></div>
      </div>
    </app:isMeOrAdmin>

  </div>
</div>
</body>
