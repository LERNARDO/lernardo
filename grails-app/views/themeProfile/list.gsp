<head>
  <meta name="layout" content="planning"/>
  <title><g:message code="themes"/></title>
</head>
<body>
<div class="boxHeader">
  <div class="second">
    <h1><g:message code="themes"/></h1>
  </div>
</div>

<div class="boxGray">
  <div class="second">

    <div class="info-msg">
      <g:message code="object.total" args="[allThemes, message(code: 'themes')]"/>
    </div>

    <erp:accessCheck entity="${currentEntity}" types="['Betreiber']" facilities="${facilities ?: null}" >
      <div class="buttons">
        <g:form>
          <div class="button"><g:actionSubmit class="buttonGreen" action="create" value="${message(code: 'object.create', args: [message(code: 'theme')])}"/></div>
          <div class="spacer"></div>
        </g:form>
      </div>
    </erp:accessCheck>

    <div id="themelist">
      <g:render template="themes" model="[themes:themes]"/>
    </div>

  </div>
</div>
</body>