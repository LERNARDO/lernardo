<head>
  <meta name="layout" content="private"/>
  <title><g:message code="parent"/> - ${parent.profile.fullName}</title>
</head>
<body>
<div class="headerGreen">
  <div class="second">
    <h1><g:message code="parent"/> - ${parent.profile.fullName}</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">
    <div class="dialog">
      <table width="100%" bgcolor="#dfdfdf" border="0" cellspacing="10">
        <tbody>

        <tr>
          <td width="120" valign="middle" class="name-show"><g:message code="parent.profile.gender"/></td>
          <td width="200" valign="middle" class="name-show"><g:message code="parent.profile.firstName"/></td>
          <td width="280" valign="middle" class="name-show"><g:message code="parent.profile.lastName"/></td>
          <td valign="middle" class="name-show"><g:message code="parent.profile.birthDate"/></td>
        </tr>

        <tr>
          <td valign="top" class="value-show">
            <app:showGender gender="${parent.profile.gender}"/>
          </td>
          <td valign="top" class="value-show">
            ${fieldValue(bean: parent, field: 'profile.firstName').decodeHTML() ?: '<div class="italic">keine Daten eingetragen</div>'}
          </td>
          <td valign="top" class="value-show-block">
            <g:link action="show" id="${parent.id}" params="[entity:parent.id]">${parent.profile.lastName}</g:link> <g:if test="${family}">(<g:link controller="groupFamilyProfile" action="show" id="${family.id}">Familie ${family.profile.fullName}</g:link>)</g:if>
          </td>
          <td valign="top" class="value-show">
            <g:formatDate date="${parent.profile.birthDate}" format="dd. MM. yyyy"/>
          </td>
        </tr>

        <tr>
          <td width="120" valign="middle" class="name-show"><g:message code="parent.profile.maritalStatus"/></td>
          <td width="200" valign="middle" class="name-show"><g:message code="parent.profile.languages"/></td>
          <td width="220" valign="middle" class="name-show"><g:message code="parent.profile.description"/></td>
          <td width="250" valign="middle" class="name-show"><g:message code="parent.profile.education"/></td>
        </tr>

        <tr>
          <td valign="top" class="value-show">
            <app:getMaritalStatus level="${parent.profile.maritalStatus}"/>
          </td>
          <td valign="top" class="value-show-block">
            <ul>
              <g:each in="${parent.profile.languages}" var="language">
                <li><app:getLanguages language="${language}"/></li>
              </g:each>
            </ul>
          </td>
          <td valign="top" class="value-show-block">
            ${fieldValue(bean: parent, field: 'profile.comment')}
          </td>
          <td valign="top" class="value-show">
            <app:getSchoolLevel level="${parent.profile.education}"/>
          </td>
        </tr>

        <g:if test="${parent.profile.job}">
          <tr>
            <td width="120" valign="middle" class="name-show"></td>
            <td width="200" valign="middle" class="name-show"><g:message code="parent.profile.jobType"/></td>
            <td width="280" valign="middle" class="name-show"><g:message code="parent.profile.jobIncome"/></td>
            <td valign="middle" class="name-show"><g:message code="parent.profile.jobFrequency"/></td>
          </tr>

          <tr>
            <td valign="top" class="value-show-comb">
              <g:message code="parent.profile.job"/>:
              <g:formatBoolean boolean="${parent.profile.job}" true="${message(code:'yes')}" false="${message(code:'no')}"/>
            </td>
            <td valign="top" class="value-show"><app:getJobType job="${parent.profile.jobType}"/></td>
            <td valign="top" class="value-show">${fieldValue(bean: parent, field: 'profile.jobIncome')}</td>
            <td valign="top" class="value-show">${fieldValue(bean: parent, field: 'profile.jobFrequency')}</td>
          </tr>
        </g:if>

        <tr>
          <td valign="top" class="name-show"><g:message code="parent.profile.currentCountry"/></td>
          <td valign="top" class="name-show"><g:message code="parent.profile.currentCity"/></td>
          <td valign="top" class="name-show"><g:message code="parent.profile.currentStreet"/></td>
          <td valign="top" class="name-show"><g:message code="parent.profile.currentZip"/></td>
        </tr>

        <tr>
          <td valign="middle" class="value-show">
            <app:getNationalities nationality="${parent.profile.currentCountry}"/>
          </td>
          <td width="105" valign="middle" class="value-show">
            ${fieldValue(bean: parent, field: 'profile.currentCity') ?: '<div class="italic">'+message(code:'empty')+'</div>'}
          </td>
          <td width="210" valign="middle" class="value-show">
            ${fieldValue(bean: parent, field: 'profile.currentStreet') ?: '<div class="italic">'+message(code:'empty')+'</div>'}
          </td>
          <td valign="middle" class="value-show">
            ${fieldValue(bean: parent, field: 'profile.currentZip') ?: '<div class="italic">'+message(code:'empty')+'</div>'}
          </td>
        </tr>

      </table>

      <div class="email">
        <table>
          <tr>

            <app:isOperator entity="${currentEntity}">
              <td width="100" valign="middle">
                <span class="bold"><g:message code="active"/></span>
                <g:formatBoolean boolean="${parent.user.enabled}" true="${message(code:'yes')}" false="${message(code:'no')}"/>
              </td>
            </app:isOperator>

            <td width="280" valign="middle">
              <span class="bold"><g:message code="educator.profile.email"/>:</span>
              ${fieldValue(bean: parent, field: 'user.email') ?: '<div class="italic">'+message(code:'empty')+'</div>'}
            </td>
            <td valign="middle">
              <span class="bold"><g:message code="languageSelection"/>:</span>
              ${parent?.user?.locale?.getDisplayLanguage()}
            </td>

          </tr>
        </table>
      </div>

    </div>

    <div class="buttons">
      <app:isMeOrAdminOrOperator entity="${parent}">
        <g:link class="buttonGreen" action="edit" id="${parent?.id}"><g:message code="edit"/></g:link>
      </app:isMeOrAdminOrOperator>
      <g:link class="buttonGray" action="list"><g:message code="back"/></g:link>
      <div class="spacer"></div>
    </div>

  </div>
</div>
</body>
