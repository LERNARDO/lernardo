<head>
  <meta name="layout" content="database"/>
  <title><g:message code="partner"/> - ${partner.profile}</title>
</head>

<body>
<div class="boxHeader">
  <h1><erp:getFavorite entity="${partner}"/> ${partner.profile} <span style="font-size: 12px;">(<g:message code="partner"/>)</span></h1>
</div>
<g:render template="/templates/favmodal" model="[entity: partner]"/>

<div class="boxContent">

    <g:render template="/templates/partnerNavigation" model="[entity: partner]"/>

    <div class="tabnav">
      <ul>
        <li><g:link controller="partnerProfile" action="show" id="${partner.id}"><g:message code="profile"/></g:link></li>
        <li><g:remoteLink update="content" controller="partnerProfile" action="management" id="${partner.id}" before="showspinner('#content');"><g:message code="management"/></g:remoteLink></li>
        <li><g:remoteLink update="content" controller="publication" action="list" id="${partner.id}" before="showspinner('#content');"><g:message code="publications"/> <erp:getPublicationCount entity="${partner}"/></g:remoteLink></li>
        <li><g:remoteLink update="content" controller="msg" action="inbox" id="${partner.id}" before="showspinner('#content');"><g:message code="privat.posts"/></g:remoteLink></li>
        <li><g:remoteLink update="content" controller="appointmentProfile" action="index" id="${partner.id}" before="showspinner('#content');"><g:message code="appointments"/></g:remoteLink></li>
      </ul>
    </div>

    <div id="content">

      <h4><g:message code="profile"/></h4>
      <table>
        <tbody>

        <tr class="prop">
          <td class="one"><g:message code="name"/>:</td>
          <td class="two">${fieldValue(bean: partner, field: 'profile') ?: '<span class="italic">'+message(code:'noData')+ '</span>'}</td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="description"/>:</td>
          <td class="two">${fieldValue(bean: partner, field: 'profile.description') ?: '<div class="italic">' + message(code: 'noData') + '</div>'}</td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="partner.profile.website"/>:</td>
          <td class="two">${fieldValue(bean: partner, field: 'profile.website') ?: '<div class="italic">' + message(code: 'noData') + '</div>'}</td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="phone"/>:</td>
          <td class="two">${fieldValue(bean: partner, field: 'profile.phone') ?: '<div class="italic">' + message(code: 'noData') + '</div>'}</td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="partner.profile.services"/>:</td>
          <td class="two">
            <g:if test="${partner.profile.services}">
              <ul>
                <g:each in="${partner.profile.services}" var="service">
                  <li>${service}</li>
                </g:each>
              </ul>
            </g:if>
            <g:else>
              <div class="italic"><g:message code="none"/></div>
            </g:else>
          </td>
        </tr>

        <tr class="prop">
            <td class="one"><g:message code="zip"/>:</td>
            <td class="two">${fieldValue(bean: partner, field: 'profile.zip') ?: '<div class="italic">' + message(code: 'noData') + '</div>'}</td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="street"/>:</td>
          <td class="two">${fieldValue(bean: partner, field: 'profile.street') ?: '<div class="italic">' + message(code: 'noData') + '</div>'}</td>
        </tr>

        <tr class="prop">
            <td class="one"><g:message code="city"/>:</td>
            <td class="two">${fieldValue(bean: partner, field: 'profile.city') ?: '<div class="italic">' + message(code: 'noData') + '</div>'}</td>
        </tr>

        <tr class="prop">
            <td class="one"><g:message code="country"/>:</td>
            <td class="two">${fieldValue(bean: partner, field: 'profile.country') ?: '<div class="italic">' + message(code: 'noData') + '</div>'}</td>
        </tr>

        </tbody>
      </table>

      %{--<g:render template="/templates/links" model="[entity: partner]"/>--}%

    </div>

</div>

<g:render template="/templates/ajaxCommands" model="[ajax: ajax, ajaxId: ajaxId]"/>

</body>
