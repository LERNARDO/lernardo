<head>
  <meta name="layout" content="private"/>
  <title><g:message code="labels"/></title>
</head>
<body>
<div class="boxHeader">
  <div class="second">
    <h1><g:message code="labels"/></h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <div class="info-msg">
      ${labelInstanceTotal} <g:message code="labels.c_total"/>
    </div>

     <erp:accessCheck entity="${currentEntity}" types="['Betreiber']">
      <div class="buttons">
        <g:form>
          <div class="button"><g:actionSubmit class="buttonGreen" action="create" value="${message(code: 'label.create')}"/></div>
          <div class="spacer"></div>
        </g:form>
      </div>
    </erp:accessCheck>

    <table class="default-table">
      <thead>
      <tr>
        <g:sortableColumn property="name" title="${message(code:'name')}"/>
      </tr>
      </thead>
      <tbody>
      <g:each in="${labelInstanceList}" status="i" var="label">
        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
          <td><g:link action="show" id="${label.id}">${fieldValue(bean: label, field: 'name').decodeHTML()}</g:link></td>
        </tr>
      </g:each>
      </tbody>
    </table>

    <div class="paginateButtons">
      <g:paginate total="${labelInstanceTotal}"/>
    </div>

  </div>
</div>
</body>