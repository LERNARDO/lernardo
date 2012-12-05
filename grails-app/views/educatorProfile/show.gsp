<head>
  <meta name="layout" content="database"/>
  <title><g:message code="educator"/> - ${educator.profile}</title>
</head>

<body>
<div class="boxHeader">
  <h1><erp:getFavorite entity="${educator}"/> ${educator.profile} <span style="font-size: 12px;">(<g:message code="educator"/>)</span></h1>
</div>
<g:render template="/templates/favmodal" model="[entity: educator]"/>

<div class="boxContent">

<g:render template="/templates/educatorNavigation" model="[entity: educator]"/>

<div class="tabnav">
  <ul>
    <li><g:link controller="educatorProfile" action="show" id="${educator.id}"><g:message code="profile"/></g:link></li>
    <li><g:remoteLink update="content" controller="educatorProfile" action="management" id="${educator.id}" before="showspinner('#content');"><g:message code="management"/></g:remoteLink></li>
    <li><g:remoteLink update="content" controller="publication" action="list" id="${educator.id}" before="showspinner('#content');"><g:message code="publications"/> <erp:getPublicationCount entity="${educator}"/></g:remoteLink></li>
    <li><g:remoteLink update="content" controller="msg" action="inbox" id="${educator.id}" before="showspinner('#content');"><g:message code="privat.posts"/></g:remoteLink></li>
    <li><g:remoteLink update="content" controller="appointmentProfile" action="index" id="${educator.id}" before="showspinner('#content');"><g:message code="appointments"/></g:remoteLink></li>
    <li><g:remoteLink update="content" controller="evaluation" action="myevaluations" id="${educator.id}" before="showspinner('#content');"><g:message code="privat.evaluation"/></g:remoteLink></li>
    <li><g:remoteLink update="content" controller="timeRecording" id="${educator.id}" before="showspinner('#content');"><g:message code="privat.workday"/></g:remoteLink></li>
  </ul>
</div>

<div id="content">

    <p style="margin-top: 10px;"><g:message code="leadingFunction"/>
    <g:if test="${leadingFacilities}">
        <g:each in="${leadingFacilities}" var="facility" status="i">
            <g:link controller="facilityProfile" action="show" id="${facility.id}">${facility.profile}</g:link><g:if test="${i + 1 != leadingFacilities.size()}">, </g:if>
        </g:each>
    </g:if>
    <g:else>
        <span class="gray"><g:message code="noLeadingFunction"/></span>
    </g:else>
    </p>


  <table>
  <tr>
  <td style="padding-right: 40px; vertical-align: top;">

    <h4><g:message code="profile"/></h4>
    <table>

      <tr class="prop">
        <td class="one"><g:message code="gender"/>:</td>
        <td class="two"><erp:showGender gender="${educator.profile.gender}"/></td>
      </tr>

      <tr class="prop">
        <td class="one"><g:message code="title"/>:</td>
        <td class="two">${fieldValue(bean: educator, field: 'profile.title') ?: '<span class="italic">' + message(code: 'noData') + '</span>'}</td>
      </tr>

      <tr class="prop">
        <td class="one"><g:message code="firstName"/>:</td>
        <td class="two">${fieldValue(bean: educator, field: 'profile.firstName') ?: '<span class="italic">' + message(code: 'noData') + '</span>'}</td>
      </tr>

      <tr class="prop">
        <td class="one"><g:message code="lastName"/>:</td>
        <td class="two">${fieldValue(bean: educator, field: 'profile.lastName') ?: '<span class="italic">' + message(code: 'noData') + '</span>'}</td>
      </tr>

      <tr class="prop">
        <td class="one"><g:message code="birthDate"/>:</td>
        <td class="two"><g:formatDate date="${educator.profile.birthDate}" format="dd. MM. yyyy"/></td>
      </tr>

      <tr class="prop">
        <td class="one"><g:message code="educator.profile.education"/>:</td>
        <td class="two">${educator.profile.education.decodeHTML() ?: '<div class="italic">' + message(code: "noData") + '</div>'}</td>
      </tr>

      <tr class="prop">
        <td class="one"><g:message code="educator.profile.employment"/>:</td>
        <td class="two">${educator.profile.employment.decodeHTML() ?: '<div class="italic">' + message(code: "noData") + '</div>'}</td>
      </tr>

      <tr class="prop">
        <td class="one"><g:message code="educator.profile.enlisted"/>:</td>
        <td class="two">${fieldValue(bean: enlistedBy, field: 'profile') ?: message(code: 'no')}</td>
      </tr>

      <tr class="prop">
        <td class="one"><g:message code="educator.profile.interests"/>:</td>
        <td class="two">${fieldValue(bean: educator, field: 'profile.interests') ?: '<span class="italic">' + message(code: 'noData') + '</span>'}</td>
      </tr>

      <tr class="prop">
        <td class="one"><g:message code="educator.profile.inChargeOf"/>:</td>
        <td class="two">
          <g:if test="${educator.profile.inChargeOf}">
            <ul>
              <g:each in="${educator.profile.inChargeOf}" var="inchargeof">
                <li>${inchargeof}</li>
              </g:each>
            </ul>
          </g:if>
          <g:else>
            <div class="italic">${message(code: 'noData')}</div>
          </g:else>
        </td>
      </tr>

      <tr class="prop">
        <td class="one"><g:message code="educator.profile.languages"/>:</td>
        <td class="two">
          <g:if test="${educator.profile.languages}">
            <ul>
              <g:each in="${educator.profile.languages}" var="language">
                <li>${language}</li>
              </g:each>
            </ul>
          </g:if>
          <g:else>
            <div class="italic">${message(code: 'noData')}</div>
          </g:else>
        </td>
      </tr>

      <tr class="prop">
        <td class="one"><g:message code="bloodType"/>:</td>
        <td class="two">${fieldValue(bean: educator, field: 'profile.bloodType') ?: '<div class="italic">' + message(code: 'none') + '</div>'}</td>
      </tr>

    </table>

    <h4><g:message code="educator.profile.curAddress"/></h4>
    <table>

      <tr class="prop">
        <td class="one"><g:message code="street"/>:</td>
        <td class="two">${fieldValue(bean: educator, field: 'profile.currentStreet') ?: '<span class="italic">' + message(code: 'noData') + '</span>'}</td>
      </tr>

      <tr class="prop">
        <td class="one"><g:message code="groupColony"/>:</td>
        <td class="two"><g:if test="${colony}"><g:link controller="${colony.type.supertype.name + 'Profile'}" action="show" id="${colony.id}">${colony.profile.zip} ${colony.profile}</g:link></g:if><g:else><div class="italic"><g:message
            code="noData"/></div></g:else></td>
      </tr>

    </table>

  </td>
  <td style="padding-right: 40px; vertical-align: top;">
    <h4><g:message code="educator.profile.origin"/></h4>
    <table>

      <tr class="prop">
        <td class="one"><g:message code="street"/>:</td>
        <td class="two">${fieldValue(bean: educator, field: 'profile.originStreet') ?: '<span class="italic">' + message(code: 'noData') + '</span>'}</td>
      </tr>

      <tr class="prop">
        <td class="one"><g:message code="zip"/>:</td>
        <td class="two">${fieldValue(bean: educator, field: 'profile.originZip') ?: '<div class="italic">' + message(code: 'empty') + '</div>'}</td>
      </tr>

      <tr class="prop">
        <td class="one"><g:message code="city"/>:</td>
        <td class="two">${fieldValue(bean: educator, field: 'profile.originCity') ?: '<span class="italic">' + message(code: 'noData') + '</span>'}</td>
      </tr>

      <tr class="prop">
        <td class="one"><g:message code="country"/>:</td>
        <td class="two">${fieldValue(bean: educator, field: 'profile.originCountry') ?: '<span class="italic">' + message(code: 'noData') + '</span>'}</td>
      </tr>

    </table>

    <h4><g:message code="educator.profile.emContact"/></h4>
    <table>

      <tr class="prop">
        <td class="one"><g:message code="name"/>:</td>
        <td class="two">${fieldValue(bean: educator, field: 'profile.contactName') ?: '<span class="italic">' + message(code: 'noData') + '</span>'}</td>
      </tr>

      <tr class="prop">
        <td class="one"><g:message code="street"/>:</td>
        <td class="two">${fieldValue(bean: educator, field: 'profile.contactStreet') ?: '<span class="italic">' + message(code: 'noData') + '</span>'}</td>
      </tr>

      <tr class="prop">
        <td class="one"><g:message code="zip"/>:</td>
        <td class="two">${fieldValue(bean: educator, field: 'profile.contactZip') ?: '<div class="italic">' + message(code: 'empty') + '</div>'}</td>
      </tr>

      <tr class="prop">
        <td class="one"><g:message code="city"/>:</td>
        <td class="two">${fieldValue(bean: educator, field: 'profile.contactCity') ?: '<span class="italic">' + message(code: 'noData') + '</span>'}</td>
      </tr>

      <tr class="prop">
        <td class="one"><g:message code="country"/>:</td>
        <td class="two">${fieldValue(bean: educator, field: 'profile.contactCountry') ?: '<div class="italic">' + message(code: 'empty') + '</div>'}</td>
      </tr>

      <tr class="prop">
        <td class="one"><g:message code="phone"/>:</td>
        <td class="two">${fieldValue(bean: educator, field: 'profile.contactPhone') ?: '<span class="italic">' + message(code: 'noData') + '</span>'}</td>
      </tr>

      <tr class="prop">
        <td class="one"><g:message code="email"/>:</td>
        <td class="two">${fieldValue(bean: educator, field: 'profile.contactMail') ?: '<span class="italic">' + message(code: 'noData') + '</span>'}</td>
      </tr>

    </table>

    <h4><g:message code="other"/></h4>
    <table>

      <tr class="prop">
        <td class="one"><g:message code="phone"/> #1:</td>
        <td class="two">${fieldValue(bean: educator, field: 'profile.phone1') ?: '<span class="italic">' + message(code: 'noData') + '</span>'}</td>
      </tr>

      <tr class="prop">
        <td class="one"><g:message code="phone"/> #2:</td>
        <td class="two">${fieldValue(bean: educator, field: 'profile.phone2') ?: '<span class="italic">' + message(code: 'noData') + '</span>'}</td>
      </tr>

      <tr class="prop">
        <td class="one"><g:message code="educator.profile.privMail"/>:</td>
        <td class="two">${fieldValue(bean: educator, field: 'profile.privEmail') ?: '<div class="italic">' + message(code: 'noData') + '</div>'}</td>
      </tr>

    </table>
  </td>
  </tr>
  </table>

  %{--<g:render template="/templates/links" model="[entity: educator]"/>--}%

</div>
</div>

<g:render template="/templates/ajaxCommands" model="${ajax}"/>

</body>
