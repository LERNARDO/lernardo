<head>
  <meta name="layout" content="private"/>
  <title><g:message code="partner"/></title>
</head>
<body>
<div class="boxHeader">
  <div class="second">
    <h1><g:message code="partner"/></h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <div class="info-msg">
      ${totalPartners} <g:message code="partner.profile.c_total"/>
    </div>

    <erp:accessCheck entity="${currentEntity}" types="['Betreiber']">
      <div class="buttons">
        <g:form>
          <div class="button"><g:actionSubmit class="buttonGreen" action="create" value="${message(code: 'partner.profile.create')}"/></div>
          <div class="spacer"></div>
        </g:form>
      </div>
    </erp:accessCheck>

    <g:message code="searchForName"/>: <g:remoteField size="30" name="instantSearch" update="membersearch-results" paramName="name" url="[controller:'overview', action:'searchMe', params:[partner: 'yes']]" before="showspinner('#membersearch-results')" />
    <div style="padding-bottom: 5px" class="membersearch-results" id="membersearch-results"></div>

    <table class="default-table">
      <thead>
      <tr>
        <g:sortableColumn property="fullName" title="${message(code:'partner.profile.name')}"/>
        <g:sortableColumn property="services" title="${message(code:'partner.profile.services')}"/>
      </tr>
      </thead>
      <tbody>
      <g:each in="${partners}" status="i" var="partner">
        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
          <td><g:link action="show" id="${partner.id}" params="[entity: partner.id]">${fieldValue(bean: partner, field: 'profile.fullName').decodeHTML()}</g:link></td>
          <td>
            <g:if test="${partner.profile.services}">
              <g:each in="${partner.profile.services}" var="service">
                ${service},
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
      <g:paginate total="${totalPartners}"/>
    </div>

  </div>
</div>
</body>