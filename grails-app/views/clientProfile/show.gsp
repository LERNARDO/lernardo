<head>
  <meta name="layout" content="database"/>
  <title><g:message code="profile"/> - ${client.profile.fullName}</title>
</head>

<body>
<div class="boxHeader">
  <h1><erp:getFavorite entity="${client}"/> ${client.profile.fullName} <span style="font-size: 12px;">(<g:message code="client"/>)</span></h1>
</div>
<g:render template="/templates/favmodal" model="[entity: client]"/>

<div class="boxGray">

<g:render template="/templates/clientNavigation" model="[entity: client]"/>

<div class="tabnav">
  <ul>
    <li><g:link controller="clientProfile" action="show" id="${client.id}"><g:message code="profile"/></g:link></li>
    <li><g:remoteLink update="content" controller="clientProfile" action="management" id="${client.id}"><g:message code="management"/></g:remoteLink></li>
    <li><g:remoteLink update="content" controller="publication" action="list" id="${client.id}"><g:message code="publications"/> <erp:getPublicationCount entity="${client}"/></g:remoteLink></li>
    <li><g:link controller="msg" action="inbox" id="${client.id}"><g:message code="privat.posts"/></g:link></li>
    <li><g:link controller="appointmentProfile" action="index" id="${client.id}"><g:message code="appointments"/></g:link></li>
    <li><g:link style="border-right: none" controller="evaluation" action="list" id="${client.id}"><g:message code="privat.evaluation"/></g:link></li>
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
        <td class="two"><erp:showGender gender="${client.profile.gender}"/></td>
      </tr>

      <tr class="prop">
        <td class="one"><g:message code="firstName"/>:</td>
        <td class="two">${fieldValue(bean: client, field: 'profile.firstName') ?: '<span class="italic">' + message(code: 'noData') + '</span>'}</td>
      </tr>

      <tr class="prop">
        <td class="one"><g:message code="lastName"/>:</td>
        <td class="two">${fieldValue(bean: client, field: 'profile.lastName') ?: '<span class="italic">' + message(code: 'noData') + '</span>'} <g:if test="${family}">(<g:link class="largetooltip" data-idd="${family.id}" controller="groupFamilyProfile" action="show"
                                                                                                                                                                 id="${family.id}">Familie ${family.profile.fullName}</g:link>)</g:if></td>
      </tr>

      <tr class="prop">
        <td class="one"><g:message code="birthDate"/>:</td>
        <td class="two"><g:formatDate date="${client.profile.birthDate}" format="dd. MM. yyyy"/></td>
      </tr>

      <tr class="prop">
        <td class="one"><g:message code="client.profile.interests"/>:</td>
        <td class="two">${fieldValue(bean: client, field: 'profile.interests') ?: '<span class="italic">' + message(code: 'noData') + '</span>'}</td>
      </tr>

    </table>

    <h4><g:message code="client.profile.curAddress"/></h4>
    <table>

      <tr class="prop">
        <td class="one"><g:message code="street"/>:</td>
        <td class="two">${fieldValue(bean: client, field: 'profile.currentStreet') ?: '<span class="italic">' + message(code: 'noData') + '</span>'}</td>
      </tr>

      <tr class="prop">
        <td class="one"><g:message code="groupColony"/>:</td>
        <td class="two"><g:if test="${colony}"><g:link controller="${colony.type.supertype.name + 'Profile'}" action="show" id="${colony.id}">${colony.profile.zip} ${colony.profile.fullName}</g:link></g:if><g:else><div class="italic"><g:message
            code="noData"/></div></g:else></td>
      </tr>

    </table>

    <h4><g:message code="client.profile.origin"/></h4>
    <table>

      <tr class="prop">
        <td class="one"><g:message code="city"/>:</td>
        <td class="two">${fieldValue(bean: client, field: 'profile.originCity') ?: '<span class="italic">' + message(code: 'noData') + '</span>'}</td>
      </tr>

      <tr class="prop">
        <td class="one"><g:message code="zip"/>:</td>
        <td class="two">${fieldValue(bean: client, field: 'profile.originZip') ?: '<div class="italic">' + message(code: 'empty') + '</div>'}</td>
      </tr>

      <tr class="prop">
        <td class="one"><g:message code="country"/>:</td>
        <td class="two">${fieldValue(bean: client, field: 'profile.originCountry') ?: '<span class="italic">' + message(code: 'noData') + '</span>'}</td>
      </tr>

    </table>

  </td>
  <td style="padding-right: 40px; vertical-align: top;">

    <h4><g:message code="client.profile.more"/></h4>
    <table>

      <tr class="prop">
        <td class="one"><g:message code="client.profile.familyStatus"/>:</td>
        <td class="two">${client.profile.familyStatus}</td>
      </tr>

      <tr class="prop">
        <td class="one"><g:message code="languages"/>:</td>
        <td class="two">
          <g:if test="${client.profile.languages}">
            <ul>
              <g:each in="${client.profile.languages}" var="language">
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
        <td class="one"><g:message code="client.profile.school"/>:</td>
        <td class="two">${fieldValue(bean: client, field: 'profile.school').decodeHTML() ?: '<span class="italic">' + message(code: 'client.noSchoolEntered') + '</span>'}</td>
      </tr>

      <tr class="prop">
        <td class="one"><g:message code="client.profile.schoolLevel"/>:</td>
        <td class="two">
          <g:if test="${client.profile.schoolLevel}">
            ${client.profile.schoolLevel}
          </g:if>
          <g:else>
            <div class="italic"><g:message code="none"/></div>
          </g:else>
        </td>
      </tr>

      <g:if test="${client.profile.job}">
        <tr class="prop">
          <td class="one"><g:message code="client.profile.job"/>:</td>
          <td class="two"><g:formatBoolean boolean="${client.profile.job}" true="${message(code: 'yes')}" false="${message(code: 'no')}"/></td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="client.profile.jobType"/>:</td>
          <td class="two">
            <g:if test="${client.profile.jobtypes}">
              <ul style="margin-left: 5px;">
                <g:each in="${client.profile.jobtypes}" var="jobtype">
                  <li style="list-style-type: disc;">${jobtype}</li>
                </g:each>
              </ul>
            </g:if>
            <g:else>
              <div class="italic"><g:message code="client.noWorkEntered"/></div>
            </g:else>
          </td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="client.profile.jobIncome"/> (${grailsApplication.config.currency}):</td>
          <td class="two">${client?.profile?.jobIncome?.toInteger() ?: '<span class="italic">' + message(code: 'noData') + '</span>'}</td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="client.profile.jobFrequency"/>:</td>
          <td class="two">${fieldValue(bean: client, field: 'profile.jobFrequency') ?: '<span class="italic">' + message(code: 'noData') + '</span>'}</td>
        </tr>
      </g:if>

      <g:if test="${client.profile.support}">
        <tr class="prop">
          <td class="one"><g:message code="client.profile.support"/>:</td>
          <td class="two"><g:formatBoolean boolean="${client.profile.support}" true="${message(code: 'yes')}" false="${message(code: 'no')}"/></td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="client.profile.supportDescription"/>:</td>
          <td class="two">${fieldValue(bean: client, field: 'profile.supportDescription') ?: '<span class="italic">' + message(code: 'noData') + '</span>'}</td>
        </tr>
      </g:if>

      <tr class="prop">
        <td class="one"><g:message code="citizenship"/>:</td>
        <td class="two">${fieldValue(bean: client, field: 'profile.citizenship').decodeHTML() ?: '<span class="italic">' + message(code: 'noData') + '</span>'}</td>
      </tr>

      <tr class="prop">
        <td class="one"><g:message code="socialSecurityNumber"/>:</td>
        <td class="two">${fieldValue(bean: client, field: 'profile.socialSecurityNumber') ?: '<span class="italic">' + message(code: 'noData') + '</span>'}</td>
      </tr>

    </table>

  </td>
  </tr>
  </table>

  %{--<g:render template="/templates/links" model="[entity: client]"/>--}%

</div>
</div>
</body>