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
      <table width="100%" border="0" cellspacing="10">
        <tbody>

        <tr>
          <td width="120" valign="middle" class="name-show"><g:message code="parent.profile.gender"/></td>
          <td width="200" valign="middle" class="name-show"><g:message code="parent.profile.firstName"/></td>
          <td width="280" valign="middle" class="name-show"><g:message code="parent.profile.lastName"/></td>
          <td valign="middle" class="name-show"><g:message code="parent.profile.birthDate"/></td>
        </tr>

        <tr>
          <td valign="top" class="value-show">
            <erp:showGender gender="${parent.profile.gender}"/>
          </td>
          <td valign="top" class="value-show">
            ${fieldValue(bean: parent, field: 'profile.firstName').decodeHTML() ?: '<span class="italic">'+message(code:'noData')+'</span>'}
          </td>
          <td valign="top" class="value-show-block">
            <g:link action="show" id="${parent.id}" params="[entity:parent.id]">${parent.profile.lastName}</g:link> <g:if test="${family}">(<g:link controller="groupFamilyProfile" action="show" id="${family.id}">Familie ${family.profile.fullName}</g:link>)</g:if>
          </td>
          <td valign="top" class="value-show">
            <g:formatDate date="${parent.profile.birthDate}" format="dd. MM. yyyy" timeZone="${TimeZone.getTimeZone(grailsApplication.config.timeZone.toString())}"/>
          </td>
        </tr>

        <tr>
          <td width="120" valign="middle" class="name-show"><g:message code="parent.profile.maritalStatus"/></td>
          <td width="200" valign="middle" class="name-show"><g:message code="parent.profile.languages"/></td>
          <td width="220" valign="middle" class="name-show"><g:message code="parent.profile.description"/></td>
          <td width="250" valign="middle" class="name-show"><g:if test="${grailsApplication.config.parentProfile.education}"><g:message code="parent.profile.education"/></g:if></td>
        </tr>

        <tr>
          <td valign="top" class="value-show">
            <g:message code="maritalstatus.${parent.profile.maritalStatus}"/>
          </td>
          <td valign="top" class="value-show-block">
            <g:if test="${parent.profile.languages}">
              <ul>
                <g:each in="${parent.profile.languages}" var="language">
                  <li><g:message code="language.${language}"/></li>
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
            <g:if test="${grailsApplication.config.parentProfile.education}">
              <g:if test="${parent.profile.education}">
                <g:message code="schoollevel.${parent.profile.education}"/>
              </g:if>
              <g:else>
                <div class="italic"><g:message code="none"/></div>
              </g:else>
            </g:if>
          </td>
        </tr>

        <g:if test="${parent.profile.job}">
          <tr>
            <td width="120" valign="middle" class="name-show"><g:message code="parent.profile.job"/></td>
            <td width="200" valign="middle" class="name-show"><g:message code="parent.profile.jobType"/></td>
            <td width="280" valign="middle" class="name-show"><g:if test="${grailsApplication.config.parentProfile.jobIncome}"><g:message code="parent.profile.jobIncome"/> (${grailsApplication.config.currency})</g:if></td>
            <td valign="middle" class="name-show"><g:if test="${grailsApplication.config.parentProfile.jobFrequency}"><g:message code="parent.profile.jobFrequency"/></g:if></td>
          </tr>

          <tr>
            <td valign="top" class="value-show">
              <g:formatBoolean boolean="${parent.profile.job}" true="${message(code:'yes')}" false="${message(code:'no')}"/>
            </td>
            <td valign="top" class="value-show">
              <g:if test="${parent.profile.jobtypes}">
                <ul>
                  <g:each in="${parent.profile.jobtypes}" var="jobtype">
                    <li><g:message code="job.${jobtype}"/></li>
                  </g:each>
                </ul>
              </g:if>
            </td>
            <td valign="top" class="value-show"><g:if test="${grailsApplication.config.parentProfile.jobIncome}">${fieldValue(bean: parent, field: 'profile.jobIncome')}</g:if></td>
            <td valign="top" class="value-show"><g:if test="${grailsApplication.config.parentProfile.jobFrequency}">${fieldValue(bean: parent, field: 'profile.jobFrequency')}</g:if></td>
          </tr>
        </g:if>

        <tr>
          <td valign="top" class="name-show"><g:if test="${grailsApplication.config.parentProfile.currentCountry}"><g:message code="parent.profile.currentCountry"/></g:if></td>
          <td valign="top" class="name-show"><g:message code="parent.profile.currentCity"/></td>
          <td valign="top" class="name-show"><g:message code="parent.profile.currentStreet"/></td>
          <td valign="top" class="name-show"><g:message code="parent.profile.currentZip"/></td>
        </tr>

        <tr>
          <td valign="middle" class="value-show">
            <g:if test="${grailsApplication.config.parentProfile.currentCountry}">
              ${parent.profile.currentCountry}
            </g:if>
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

        <tr>
          <td valign="top" class="name-show"><g:if test="${grailsApplication.config.parentProfile.socialSecurityNumber}">Sozialversicherungsnummer</g:if></td>
          <td valign="top" class="name-show"><g:if test="${grailsApplication.config.parentProfile.phone}">Telefon</g:if></td>
          <td valign="top" class="name-show"><g:if test="${grailsApplication.config.parentProfile.citizenship}">Staatsbürgerschaft</g:if></td>
        </tr>

        <tr>
          <td valign="middle" class="value-show">
            <g:if test="${grailsApplication.config.parentProfile.socialSecurityNumber}">
              ${fieldValue(bean: parent, field: 'profile.socialSecurityNumber') ?: '<div class="italic">'+message(code:'empty')+'</div>'}
            </g:if>
          </td>
          <td width="105" valign="middle" class="value-show">
            <g:if test="${grailsApplication.config.parentProfile.phone}">
              ${fieldValue(bean: parent, field: 'profile.phone') ?: '<div class="italic">'+message(code:'empty')+'</div>'}
            </g:if>
          </td>
          <td width="105" valign="middle" class="value-show">
            <g:if test="${grailsApplication.config.parentProfile.citizenship}">
              ${fieldValue(bean: parent, field: 'profile.citizenship') ?: '<div class="italic">'+message(code:'empty')+'</div>'}
            </g:if>
          </td>
        </tr>

      </table>

      <div class="email">
        <table>
          <tr>

            <erp:accessCheck entity="${currentEntity}" types="['Betreiber']">
              <td width="100" valign="middle">
                <span class="bold"><g:message code="active"/></span>
                <g:formatBoolean boolean="${parent.user.enabled}" true="${message(code:'yes')}" false="${message(code:'no')}"/>
              </td>
            </erp:accessCheck>

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
      <g:form id="${parent.id}">
        <erp:isMeOrAdminOrOperator entity="${parent}" current="${currentEntity}">
          <div class="button"><g:actionSubmit class="buttonGreen" action="edit" value="${message(code: 'edit')}" /></div>
        </erp:isMeOrAdminOrOperator>
        <erp:accessCheck entity="${currentEntity}" types="['Betreiber']">
          <div class="button"><g:actionSubmit class="buttonRed" action="delete" value="${message(code: 'delete')}" onclick="${erp.getLinks(id: parent.id)}" /></div>
        </erp:accessCheck>
        <div class="button"><g:actionSubmit class="buttonGray" action="list" value="${message(code: 'back')}" /></div>
      </g:form>
      <div class="spacer"></div>
    </div>

    <g:render template="/templates/links" model="[entity: parent]"/>

  </div>
</div>
</body>
