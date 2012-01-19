<head>
  <meta name="layout" content="database"/>
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

    <g:render template="/templates/parentNavigation" model="[entity: parent]"/>

    <div class="tabnav">
      <ul>
        <li><g:link controller="parentProfile" action="show" id="${parent.id}"><g:message code="profile"/></g:link></li>
        <li><g:remoteLink update="content" controller="publication" action="list" id="${parent.id}"><g:message code="publications"/> <erp:getPublicationCount entity="${parent}"/></g:remoteLink></li>
        <li><g:link controller="msg" action="inbox" id="${parent.id}"><g:message code="privat.posts"/></g:link></li>
        <li><g:link controller="appointmentProfile" action="index" id="${parent.id}" params="[entity: parent.id]"><g:message code="appointments"/></g:link></li>
        <li><g:link style="border-right: none" controller="evaluation" action="list" id="${parent.id}" params="[entity: parent.id]"><g:message code="privat.evaluation"/></g:link></li>
      </ul>
    </div>

    <div id="content">

      <table>
        <tr>
          <td style="padding-right: 40px; vertical-align: top;">
            <h4><g:message code="profile"/></h4>
            <table>

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
                <td class="two">${fieldValue(bean: parent, field: 'profile.lastName') ?: '<span class="italic">' + message(code: 'noData') + '</span>'} <g:if test="${family}">(<g:link controller="groupFamilyProfile" action="show"
                                                                                                                                                                         id="${family.id}">Familie ${family.profile.fullName}</g:link>)</g:if></td>
              </tr>

              <tr class="prop">
                <td class="one"><g:message code="birthDate"/>:</td>
                <td class="two"><g:formatDate date="${parent.profile.birthDate}" format="dd. MM. yyyy"/></td>
              </tr>

            </table>

            <h4><g:message code="educator.profile.curAddress"/></h4>
            <table>

              <tr class="prop">
                <td class="one"><g:message code="country"/>:</td>
                <td class="two">${fieldValue(bean: parent, field: 'profile.currentCountry') ?: '<div class="italic">' + message(code: 'empty') + '</div>'}</td>
              </tr>

              <tr class="prop">
                <td class="one"><g:message code="city"/>:</td>
                <td class="two">${fieldValue(bean: parent, field: 'profile.currentCity') ?: '<div class="italic">' + message(code: 'empty') + '</div>'}</td>
              </tr>

              <tr class="prop">
                <td class="one"><g:message code="street"/>:</td>
                <td class="two">${fieldValue(bean: parent, field: 'profile.currentStreet') ?: '<div class="italic">' + message(code: 'empty') + '</div>'}</td>
              </tr>

              <tr class="prop">
                <td class="one"><g:message code="zip"/>:</td>
                <td class="two">${fieldValue(bean: parent, field: 'profile.currentZip') ?: '<div class="italic">' + message(code: 'empty') + '</div>'}</td>
              </tr>

            </table>

          </td>
          <td style="padding-right: 40px; vertical-align: top;">

            <h4><g:message code="client.profile.more"/></h4>
            <table>

              <tr class="prop">
                <td class="one"><g:message code="client.profile.socialSecurityNumber"/>:</td>
                <td class="two">${fieldValue(bean: parent, field: 'profile.socialSecurityNumber') ?: '<div class="italic">' + message(code: 'noData') + '</div>'}</td>
              </tr>

              <tr class="prop">
                <td class="one"><g:message code="phone"/>:</td>
                <td class="two">${fieldValue(bean: parent, field: 'profile.phone') ?: '<div class="italic">' + message(code: 'noData') + '</div>'}</td>
              </tr>

              <tr class="prop">
                <td class="one"><g:message code="client.profile.citizenship"/>:</td>
                <td class="two">${fieldValue(bean: parent, field: 'profile.citizenship') ?: '<div class="italic">' + message(code: 'noData') + '</div>'}</td>
              </tr>

              <tr class="prop">
                <td class="one"><g:message code="parent.profile.maritalStatus"/>:</td>
                <td class="two">${parent.profile.maritalStatus}</td>
              </tr>

              <tr class="prop">
                <td class="one"><g:message code="languages"/>:</td>
                <td class="two">
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
              </tr>

              <tr class="prop">
                <td class="one"><g:message code="parent.profile.description"/>:</td>
                <td class="two">${fieldValue(bean: parent, field: 'profile.comment') ?: '<div class="italic">' + message(code: 'empty') + '</div>'}</td>
              </tr>

              <tr class="prop">
                <td class="one"><g:message code="parent.profile.education"/>:</td>
                <td class="two">
                  <g:if test="${parent.profile.education}">
                    ${parent.profile.education}
                  </g:if>
                  <g:else>
                    <div class="italic"><g:message code="none"/></div>
                  </g:else>
                </td>
              </tr>

              <g:if test="${parent.profile.job}">
                <tr class="prop">
                  <td class="one"><g:message code="parent.profile.job"/>:</td>
                  <td class="two"><g:formatBoolean boolean="${parent.profile.job}" true="${message(code: 'yes')}" false="${message(code: 'no')}"/></td>
                </tr>

                <tr class="prop">
                  <td class="one"><g:message code="parent.profile.jobType"/>:</td>
                  <td class="two">
                    <g:if test="${parent.profile.jobtypes}">
                      <ul>
                        <g:each in="${parent.profile.jobtypes}" var="jobtype">
                          <li>${jobtype}</li>
                        </g:each>
                      </ul>
                    </g:if>
                  </td>
                </tr>

                <tr class="prop">
                  <td class="one"><g:message code="parent.profile.jobIncome"/> (${grailsApplication.config.currency}):</td>
                  <td class="two">${fieldValue(bean: parent, field: 'profile.jobIncome')}</td>
                </tr>

                <tr class="prop">
                  <td class="one"><g:message code="parent.profile.jobFrequency"/>:</td>
                  <td class="two">${fieldValue(bean: parent, field: 'profile.jobFrequency')}</td>
                </tr>
              </g:if>

            </table>

          </td>
        </tr>
      </table>

      <div class="email">
        <table width="100%">
          <tr>
            <erp:accessCheck entity="${currentEntity}" types="['Betreiber']">
              <td>
                <span class="bold"><g:message code="active"/></span>
                <g:formatBoolean boolean="${parent.user.enabled}" true="${message(code: 'yes')}" false="${message(code: 'no')}"/>
              </td>
            </erp:accessCheck>
            <td>
              <span class="bold"><g:message code="email"/>:</span>
              ${fieldValue(bean: parent, field: 'user.email') ?: '<span class="italic">' + message(code: 'noData') + '</span>'}
            </td>
            <erp:accessCheck entity="${currentEntity}" types="['Betreiber']" me="${parent}">
              <td>
                <g:form controller="profile" action="changePassword" id="${parent.id}">
                  <span class="bold"><g:message code="password"/>:</span>
                  <g:submitButton name="submit" value="${message(code: 'change')}"/>
                  <div class="clear"></div>
                </g:form>
              </td>
            </erp:accessCheck>
          </tr>
        </table>
      </div>

      <g:render template="/templates/links" model="[entity: parent]"/>

    </div>

  </div>
</div>
</body>
