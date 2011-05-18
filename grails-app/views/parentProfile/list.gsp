<head>
  <meta name="layout" content="private"/>
  <title><g:message code="parents"/></title>
</head>
<body>
<div class="boxHeader">
  <div class="second">
    <h1><g:message code="parents"/></h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <div class="info-msg">
      ${parents.totalCount} <g:message code="parent.profile.c_total"/>
    </div>

    <erp:accessCheck entity="${currentEntity}" types="['Betreiber']">
      <div class="buttons">
        <g:form>
          <div class="button"><g:actionSubmit class="buttonGreen" action="create" value="${message(code: 'parent.profile.create')}"/></div>
          <div class="spacer"></div>
        </g:form>
      </div>
    </erp:accessCheck>

    <table class="default-table">
      <thead>
      <tr>
        <g:sortableColumn property="fullName" title="${message(code:'parent.profile.name')}"/>
      </tr>
      </thead>
      <tbody>
      <g:each in="${parents}" status="i" var="parent">
        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
          <td><g:link action="show" id="${parent.id}" params="[entity: parent.id]">${fieldValue(bean: parent, field: 'profile.fullName').decodeHTML()}</g:link></td>
        </tr>
      </g:each>
      </tbody>
    </table>

    <div class="paginateButtons">
      <g:paginate total="${parents.totalCount}"/>
    </div>

  </div>
</div>
</body>