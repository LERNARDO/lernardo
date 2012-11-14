<head>
  <meta name="layout" content="database"/>
  <title><g:message code="facility"/> - ${facility.profile}</title>
</head>
<body>
<div class="boxHeader">
  <h1><erp:getFavorite entity="${facility}"/> ${facility.profile} <span style="font-size: 12px;">(<g:message code="facility"/>)</span></h1>
</div>
<g:render template="/templates/favmodal" model="[entity: facility]"/>

<div class="boxContent">

    <g:render template="/templates/facilityNavigation" model="[entity: facility]"/>

    <div class="tabnav">
      <ul>
        <li><g:link controller="facilityProfile" action="show" id="${facility.id}"><g:message code="profile"/></g:link></li>
        <li><g:remoteLink update="content" controller="facilityProfile" action="management" id="${facility.id}" before="showspinner('#content');"><g:message code="management"/></g:remoteLink></li>
        <li><g:remoteLink update="content" controller="publication" action="list" id="${facility.id}" before="showspinner('#content');"><g:message code="publications"/> <erp:getPublicationCount entity="${facility}"/></g:remoteLink></li>
        <li><g:link controller="dayroutine" action="list" id="${facility.id}"><g:message code="dayroutine"/></g:link></li>
      </ul>
    </div>

    <div id="content">

      <h4><g:message code="profile"/></h4>
      <table>
        <tbody>

        <tr class="prop">
          <td class="one"><g:message code="name"/>:</td>
          <td class="two"><g:link action="show" id="${facility.id}">${facility.profile.decodeHTML()}</g:link></td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="description"/>:</td>
          <td class="two">${fieldValue(bean: facility, field: 'profile.description').decodeHTML() ?: '<div class="italic">'+message(code:'empty')+ '</div>'}</td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="groupColony"/>:</td>
          <td class="two">
            <g:if test="${colony}">
              <g:link controller="groupColonyProfile" action="show" id="${colony.id}">${colony.profile.zip} ${colony.profile.decodeHTML()}</g:link>
            </g:if>
            <g:else>
              <span class="italic red"><g:message code="facility.profile.noCol"/></span>
            </g:else>
          </td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="phone"/>:</td>
          <td class="two">${fieldValue(bean: facility, field: 'profile.phone') ?: '<div class="italic">'+message(code:'noData')+ '</div>'}</td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="street"/>:</td>
          <td class="two">${fieldValue(bean: facility, field: 'profile.street') ?: '<div class="italic">'+message(code:'empty')+ '</div>'}</td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="zip"/>:</td>
          <td class="two">${fieldValue(bean: facility, field: 'profile.zip') ?: '<div class="italic">'+message(code:'empty')+ '</div>'}</td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="city"/>:</td>
          <td class="two">${fieldValue(bean: facility, field: 'profile.city') ?: '<div class="italic">'+message(code:'empty')+ '</div>'}</td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="country"/>:</td>
          <td class="two">${fieldValue(bean: facility, field: 'profile.country') ?: '<div class="italic">'+message(code:'empty')+ '</div>'}</td>
        </tr>

        </tbody>
      </table>

      %{--<g:render template="/templates/links" model="[entity: facility]"/>--}%

    </div>

</div>
</body>
