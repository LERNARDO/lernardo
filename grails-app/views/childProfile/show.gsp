<head>
  <meta name="layout" content="database"/>
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

      <g:render template="/templates/childNavigation" model="[entity: entity]"/>

      <div class="tabnav">
        <ul>
          <li><g:link controller="publication" action="list" id="${entity.id}"><g:message code="publications"/> <erp:getPublicationCount entity="${entity}"/></g:link></li>
          <li><g:link controller="msg" action="inbox" id="${entity.id}"><g:message code="privat.posts"/></g:link></li>
          <li><g:link style="border-right: none" controller="appointmentProfile" action="index" id="${entity.id}" params="[entity:entity.id]"><g:message code="appointments"/></g:link></li>
        </ul>
      </div>

      <h4><g:message code="profile"/></h4>
      <table>
        <tbody>

        <tr class="prop">
          <td class="one"><g:message code="gender"/>:</td>
          <td class="two"><erp:showGender gender="${child.profile.gender}"/></td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="firstName"/>:</td>
          <td class="two">${fieldValue(bean: child, field: 'profile.firstName') ?: '<span class="italic">' + message(code: 'noData') + '</span>'}</td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="lastName"/>:</td>
          <td class="two"><g:link action="show" id="${child.id}" params="[entity:child.id]">${child.profile.lastName}</g:link> <g:if test="${family}">(<g:link controller="groupFamilyProfile" action="show" id="${family.id}">Familie ${family.profile.fullName}</g:link>)</g:if></td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="birthDate"/>:</td>
          <td class="two"><g:formatDate date="${child.profile.birthDate}" format="dd. MM. yyyy"/></td>
        </tr>

        </tbody>
      </table>

      <table width="100%" border="0" cellspacing="10">
        <tbody>

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
            <erp:accessCheck entity="${currentEntity}" types="['Betreiber']" me="${child}">
              <td>
                <g:form controller="profile" action="changePassword" id="${child.id}">
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

    <g:render template="/templates/links" model="[entity: child]"/>

  </div>
</div>
</body>
