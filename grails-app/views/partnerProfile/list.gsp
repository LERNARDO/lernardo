<head>
  <meta name="layout" content="private"/>
  <title><g:message code="partner"/></title>
</head>
<body>
<div class="headerGreen">
  <div class="second">
    <h1><g:message code="partner"/></h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    ${partnerTotal} <g:message code="partner.profile.c_total"/>

    <erp:isOperator entity="${currentEntity}">
      <div class="buttons">
        <g:link class="buttonGreen" action="create"><g:message code="partner.profile.create"/></g:link>
        <div class="spacer"></div>
      </div>
    </erp:isOperator>

    <table class="default-table">
      <thead>
      <tr>
        <g:sortableColumn property="fullName" title="${message(code:'partner.profile.name')}"/>
        <g:sortableColumn property="services" title="${message(code:'partner.profile.services')}"/>
      </tr>
      </thead>
      <tbody>
      <g:each in="${partnerList}" status="i" var="partner">
        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
          <td><g:link action="show" id="${partner.id}" params="[entity: partner.id]">${fieldValue(bean: partner, field: 'profile.fullName').decodeHTML()}</g:link></td>
          <td>
            <g:if test="${partner.profile.services}">
              <g:each in="${partner.profile.services}" var="service">
                <erp:getPartnerService service="${service}"/>,
              </g:each>
            </g:if>
            <g:else>
              <g:message code="noData"/>
            </g:else>
          </td>
        </tr>
      </g:each>
      </tbody>
    </table>

    <div class="paginateButtons">
      <g:paginate total="${partnerTotal}"/>
    </div>

  </div>
</div>
</body>