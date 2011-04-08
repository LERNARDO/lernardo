<head>
  <meta name="layout" content="private"/>
  <title><g:message code="child"/> - ${child.profile.fullName}</title>
</head>
<body>
<div class="boxHeader">
  <div class="second">
    <h1><g:message code="child"/> - ${child.profile.fullName}</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">
    <div>

      <table width="100%" border="0" cellspacing="10">
        <tbody>

        <tr>
          <td width="120" valign="middle" class="name-show"><g:message code="child.profile.gender"/></td>
          <td width="200" valign="middle" class="name-show"><g:message code="child.profile.firstName"/></td>
          <td width="280" valign="middle" class="name-show"><g:message code="child.profile.lastName"/></td>
          <td valign="middle" class="name-show"><g:message code="child.profile.birthDate"/></td>
        </tr>

        <tr>
          <td valign="top" class="value-show"><erp:showGender gender="${child.profile.gender}"/></td>
          <td valign="top" class="value-show">${fieldValue(bean: child, field: 'profile.firstName')}</td>
          <td valign="top" class="value-show"><g:link action="show" id="${child.id}" params="[entity:child.id]">${child.profile.lastName}</g:link> <g:if test="${family}">(<g:link controller="groupFamilyProfile" action="show" id="${family.id}">Familie ${family.profile.fullName}</g:link>)</g:if></td>
          <td valign="top" class="value-show"><g:formatDate date="${child.profile.birthDate}" format="dd. MM. yyyy"/></td>
        </tr>

        <g:if test="${child.profile.job}">
          <tr>
            <td width="120" valign="middle" class="name-show"><g:message code="child.profile.job"/></td>
            <td width="200" valign="middle" class="name-show"><g:message code="child.profile.jobType"/></td>
            <td width="280" valign="middle" class="name-show"><g:message code="child.profile.jobIncome"/> (${grailsApplication.config.currency})</td>
            <td valign="middle" class="name-show"><g:message code="child.profile.jobFrequency"/></td>
          </tr>

          <tr>
            <td valign="top" class="value-show"><g:formatBoolean boolean="${child.profile.job}" true="${message(code:'yes')}" false="${message(code:'no')}"/></td>
            <td valign="top" class="value-show">
              <g:if test="${child.profile.jobtypes}">
                <ul>
                  <g:each in="${child.profile.jobtypes}" var="jobtype">
                    <li><g:message code="job.${jobtype}"/></li>
                  </g:each>
                </ul>
              </g:if>
            </td>
            <td valign="top" class="value-show">${fieldValue(bean: child, field: 'profile.jobIncome')}</td>
            <td valign="top" class="value-show">${fieldValue(bean: child, field: 'profile.jobFrequency')}</td>
          </tr>
        </g:if>

        </tbody>
      </table>

      <div class="email">
        <erp:accessCheck entity="${currentEntity}" roles="['ROLE_ADMIN']" types="['Betreiber']">
          <span class="bold"><g:message code="active"/></span>
          <g:formatBoolean boolean="${child.user.enabled}" true="${message(code:'yes')}" false="${message(code:'no')}"/>
        </erp:accessCheck>
        <td width="60" valign="top">
          <span class="bold"><g:message code="child.profile.email"/>:</span>
        </td>
        <td valign="top">${fieldValue(bean: child, field: 'user.email') ?: '<span class="italic">'+message(code:'noData')+'</span>'}</td>
      </div>

    </div>

    <div class="buttons">
      <erp:isMeOrAdminOrOperator entity="${child}" current="${currentEntity}">
        <g:link class="buttonGreen" action="edit" id="${child?.id}"><g:message code="edit"/></g:link>
      </erp:isMeOrAdminOrOperator>
      <erp:accessCheck entity="${currentEntity}" roles="['ROLE_ADMIN']" types="['Betreiber']">
        <g:link class="buttonRed" action="del" id="${child.id}" onclick="${erp.getLinks(id: child.id)}"><g:message code="delete"/></g:link>
      </erp:accessCheck>
      <g:link class="buttonGray" action="list"><g:message code="back"/></g:link>
      <div class="spacer"></div>
    </div>

    <g:render template="/templates/links" model="[entity: child]"/>

  </div>
</div>
</body>
