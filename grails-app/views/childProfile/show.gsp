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
          <td width="120" valign="middle" class="name-show"><g:message code="gender"/></td>
          <td width="200" valign="middle" class="name-show"><g:message code="firstName"/></td>
          <td width="280" valign="middle" class="name-show"><g:message code="lastName"/></td>
          <td valign="middle" class="name-show"><g:message code="birthDate"/></td>
        </tr>

        <tr>
          <td valign="top" class="value-show"><erp:showGender gender="${child.profile.gender}"/></td>
          <td valign="top" class="value-show">${fieldValue(bean: child, field: 'profile.firstName')}</td>
          <td valign="top" class="value-show"><g:link action="show" id="${child.id}" params="[entity:child.id]">${child.profile.lastName}</g:link> <g:if test="${family}">(<g:link controller="groupFamilyProfile" action="show" id="${family.id}">Familie ${family.profile.fullName}</g:link>)</g:if></td>
          <td valign="top" class="value-show"><g:formatDate date="${child.profile.birthDate}" format="dd. MM. yyyy" /></td>
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
                    <li>${jobtype}</li>
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
        <table width="100%">
          <tr>
            <erp:accessCheck entity="${currentEntity}" types="['Betreiber']">
              <td>
                <span class="bold"><g:message code="active"/> </span>
                <g:formatBoolean boolean="${child.user.enabled}" true="${message(code:'yes')}" false="${message(code:'no')}"/>
              </td>
            </erp:accessCheck>
            <td>
              <span class="bold"><g:message code="email"/>: </span>
              ${fieldValue(bean: child, field: 'user.email') ?: '<span class="italic">'+message(code:'noData')+'</span>'}
            </td>
            <erp:isMeOrAdminOrOperator entity="${child}" current="${currentEntity}">
              <td>
                <g:form controller="profile" action="changePassword" id="${child.id}">
                  <span class="bold"><g:message code="password"/>: </span>
                  <g:submitButton name="submit" value="${message(code: 'change')}"/>
                  <div class="clear"></div>
                </g:form>
              </td>
            </erp:isMeOrAdminOrOperator>
          </tr>
        </table>
      </div>

    </div>

    <div class="buttons">
      <g:form id="${child.id}">
        <erp:isMeOrAdminOrOperator entity="${child}" current="${currentEntity}">
          <div class="button"><g:actionSubmit class="buttonGreen" action="edit" value="${message(code: 'edit')}" /></div>
        </erp:isMeOrAdminOrOperator>
        <erp:accessCheck entity="${currentEntity}" types="['Betreiber']">
          <div class="button"><g:actionSubmit class="buttonRed" action="delete" value="${message(code: 'delete')}" onclick="${erp.getLinks(id: child.id)}" /></div>
        </erp:accessCheck>
        <div class="button"><g:actionSubmit class="buttonGray" action="list" value="${message(code: 'back')}" /></div>
      </g:form>
      <div class="spacer"></div>
    </div>

    <g:render template="/templates/links" model="[entity: child]"/>

  </div>
</div>
</body>
