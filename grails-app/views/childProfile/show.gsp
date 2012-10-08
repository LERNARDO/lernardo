<head>
  <meta name="layout" content="database"/>
  <title><g:message code="child"/> - ${child.profile}</title>
</head>
<body>
<div class="boxHeader">
  <h1><erp:getFavorite entity="${child}"/> ${child.profile} <span style="font-size: 12px;">(<g:message code="child"/>)</span></h1>
</div>
<g:render template="/templates/favmodal" model="[entity: child]"/>

<div class="boxContent">

      <g:render template="/templates/childNavigation" model="[entity: child]"/>

      <div class="tabnav">
        <ul>
          <li><g:link controller="childProfile" action="show" id="${child.id}"><g:message code="profile"/></g:link></li>
          <li><g:remoteLink update="content" controller="publication" action="list" id="${child.id}"><g:message code="publications"/> <erp:getPublicationCount entity="${child}"/></g:remoteLink></li>
          <li><g:link controller="msg" action="inbox" id="${child.id}"><g:message code="privat.posts"/></g:link></li>
          <li><g:link style="border-right: none" controller="appointmentProfile" action="index" id="${child.id}"><g:message code="appointments"/></g:link></li>
        </ul>
      </div>

      <div id="content">

        <h4><g:message code="profile"/></h4>
        <table>

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
            <td class="two">${fieldValue(bean: child, field: 'profile.lastName') ?: '<span class="italic">' + message(code: 'noData') + '</span>'} <g:if test="${family}">(<g:link class="largetooltip" data-idd="${family.id}" controller="groupFamilyProfile" action="show" id="${family.id}">Familie ${family.profile}</g:link>)</g:if></td>
          </tr>

          <tr class="prop">
            <td class="one"><g:message code="birthDate"/>:</td>
            <td class="two"><g:formatDate date="${child.profile.birthDate}" format="dd. MM. yyyy"/></td>
          </tr>

          <g:if test="${child.profile.job}">
            <tr class="prop">
              <td class="one"><g:message code="child.profile.job"/>:</td>
              <td class="two"><g:formatBoolean boolean="${child.profile.job}" true="${message(code:'yes')}" false="${message(code:'no')}"/></td>
            </tr>

            <tr class="prop">
              <td class="one"><g:message code="child.profile.jobType"/>:</td>
              <td class="two">
                <g:if test="${child.profile.jobtypes}">
                  <ul>
                    <g:each in="${child.profile.jobtypes}" var="jobtype">
                      <li>${jobtype}</li>
                    </g:each>
                  </ul>
                </g:if>
                <g:else>
                  <span class="italic"><g:message code="noData"/></span>
                </g:else>
              </td>
            </tr>

            <tr class="prop">
              <td class="one"><g:message code="child.profile.jobIncome"/> (${grailsApplication.config.currency}):</td>
              <td class="two">${fieldValue(bean: child, field: 'profile.jobIncome') ?: '<span class="italic">' + message(code: 'noData') + '</span>'}</td>
            </tr>

            <tr class="prop">
              <td class="one"><g:message code="child.profile.jobFrequency"/>:</td>
              <td class="two">${fieldValue(bean: child, field: 'profile.jobFrequency') ?: '<span class="italic">' + message(code: 'noData') + '</span>'}</td>
            </tr>
          </g:if>

        </table>

      %{--<g:render template="/templates/links" model="[entity: child]"/>--}%

    </div>

</div>
</body>
