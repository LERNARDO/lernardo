<head>
  <meta name="layout" content="private"/>
  <title><g:message code="parent"/> - ${parent.profile.fullName}</title>
</head>
<body>
<div class="boxHeader">
  <div class="second">
    <h1><g:message code="parent"/> - ${parent.profile.fullName}</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">
    <div>

      <table>
        <tbody>

        <tr class="prop">
          <td class="one"><g:message code="gender"/>:</td>
          <td class="two"><erp:showGender gender="${parent.profile.gender}"/></td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="firstName"/>:</td>
          <td class="two">${fieldValue(bean: parent, field: 'profile.firstName') ?: '<span class="italic">' + message(code: 'noData') + '</span>'}</td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="lastName"/>:</td>
          <td class="two"><g:link action="show" id="${parent.id}" params="[entity:parent.id]">${parent.profile.lastName}</g:link> <g:if test="${family}">(<g:link controller="groupFamilyProfile" action="show" id="${family.id}">Familie ${family.profile.fullName}</g:link>)</g:if></td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="birthDate"/>:</td>
          <td class="two"><g:formatDate date="${parent.profile.birthDate}" format="dd. MM. yyyy"/></td>
        </tr>

        </tbody>
      </table>

      <h4><g:message code="educator.profile.curAddress"/></h4>
      <table width="100%" border="0" cellspacing="10">
              <tbody>
        <tr>
          <td valign="top" class="name-show"><g:message code="country"/></td>
          <td valign="top" class="name-show"><g:message code="city"/></td>
          <td valign="top" class="name-show"><g:message code="street"/></td>
          <td valign="top" class="name-show"><g:message code="zip"/></td>
        </tr>

        <tr>
          <td valign="middle" class="value-show">
            ${fieldValue(bean: parent, field: 'profile.currentCountry') ?: '<div class="italic">'+message(code:'empty')+'</div>'}
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

      <h4><g:message code="client.profile.more"/></h4>
      <table width="100%" border="0" cellspacing="10">
        <tbody>

        <tr>
          <td valign="top" class="name-show"><g:message code="client.profile.socialSecurityNumber"/></td>
          <td valign="top" class="name-show"><g:message code="phone"/></td>
          <td valign="top" class="name-show"><g:message code="client.profile.citizenship"/></td>
        </tr>

        <tr>
          <td valign="middle" class="value-show">
            ${fieldValue(bean: parent, field: 'profile.socialSecurityNumber') ?: '<div class="italic">'+message(code:'empty')+'</div>'}
          </td>
          <td width="105" valign="middle" class="value-show">
            ${fieldValue(bean: parent, field: 'profile.phone') ?: '<div class="italic">'+message(code:'empty')+'</div>'}
          </td>
          <td width="105" valign="middle" class="value-show">
            ${fieldValue(bean: parent, field: 'profile.citizenship') ?: '<div class="italic">'+message(code:'empty')+'</div>'}
          </td>
        </tr>

        <tr>
          <td width="120" valign="middle" class="name-show"><g:message code="parent.profile.maritalStatus"/></td>
          <td width="200" valign="middle" class="name-show"><g:message code="languages"/></td>
          <td width="220" valign="middle" class="name-show"><g:message code="parent.profile.description"/></td>
          <td width="250" valign="middle" class="name-show"><g:message code="parent.profile.education"/></td>
        </tr>

        <tr>
          <td valign="top" class="value-show">
            ${parent.profile.maritalStatus}
          </td>
          <td valign="top" class="value-show-block">
            <g:if test="${parent.profile.languages}">
              <ul>
                <g:each in="${parent.profile.languages}" var="language">
                  <li>${language}</li>
                </g:each>
              </ul>
            </g:if>
            <g:else>
              <div class="italic"><g:message code="none"/></div>
            </g:else>
          </td>
          <td valign="top" class="value-show-block">
            ${fieldValue(bean: parent, field: 'profile.comment') ?: '<div class="italic">'+message(code:'empty')+'</div>'}
          </td>
          <td valign="top" class="value-show">
            <g:if test="${parent.profile.education}">
              ${parent.profile.education}
            </g:if>
            <g:else>
              <div class="italic"><g:message code="none"/></div>
            </g:else>
          </td>
        </tr>

        <g:if test="${parent.profile.job}">
          <tr>
            <td width="120" valign="middle" class="name-show"><g:message code="parent.profile.job"/></td>
            <td width="200" valign="middle" class="name-show"><g:message code="parent.profile.jobType"/></td>
            <td width="280" valign="middle" class="name-show"><g:message code="parent.profile.jobIncome"/> (${grailsApplication.config.currency})</td>
            <td valign="middle" class="name-show"><g:message code="parent.profile.jobFrequency"/></td>
          </tr>

          <tr>
            <td valign="top" class="value-show">
              <g:formatBoolean boolean="${parent.profile.job}" true="${message(code:'yes')}" false="${message(code:'no')}"/>
            </td>
            <td valign="top" class="value-show">
              <g:if test="${parent.profile.jobtypes}">
                <ul>
                  <g:each in="${parent.profile.jobtypes}" var="jobtype">
                    <li>${jobtype}</li>
                  </g:each>
                </ul>
              </g:if>
            </td>
            <td valign="top" class="value-show">${fieldValue(bean: parent, field: 'profile.jobIncome')}</td>
            <td valign="top" class="value-show">${fieldValue(bean: parent, field: 'profile.jobFrequency')}</td>
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
                <g:formatBoolean boolean="${parent.user.enabled}" true="${message(code:'yes')}" false="${message(code:'no')}"/>
              </td>
            </erp:accessCheck>
            <td>
              <span class="bold"><g:message code="email"/>: </span>
              ${fieldValue(bean: parent, field: 'user.email') ?: '<span class="italic">'+message(code:'noData')+'</span>'}
            </td>
            <erp:accessCheck entity="${currentEntity}" types="['Betreiber']" me="${parent}">
              <td>
                <g:form controller="profile" action="changePassword" id="${parent.id}">
                  <span class="bold"><g:message code="password"/>: </span>
                  <g:submitButton name="submit" value="${message(code: 'change')}"/>
                  <div class="clear"></div>
                </g:form>
              </td>
            </erp:accessCheck>
          </tr>
        </table>
      </div>

    </div>

    <div class="buttons">
      <g:form id="${parent.id}">
        <erp:accessCheck entity="${currentEntity}" types="['Betreiber']" me="${parent}">
          <div class="button"><g:actionSubmit class="buttonGreen" action="edit" value="${message(code: 'edit')}" /></div>
        </erp:accessCheck>
        <erp:accessCheck entity="${currentEntity}" types="['Betreiber']">
          <div class="button"><g:actionSubmit class="buttonRed" action="delete" value="${message(code: 'delete')}" onclick="${erp.getLinks(id: parent.id)}" /></div>
        </erp:accessCheck>
        <div class="button"><g:actionSubmit class="buttonGray" action="list" value="${message(code: 'back')}" /></div>
        <erp:getFavorite entity="${parent}"/>
      </g:form>
      <div class="spacer"></div>
    </div>

    <g:render template="/templates/links" model="[entity: parent]"/>

  </div>
</div>
</body>
