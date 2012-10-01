<head>
  <meta name="layout" content="planning"/>
  <title><g:message code="themes"/></title>
</head>
<body>
<div class="boxHeader">
  <h1><g:message code="themes"/></h1>
</div>

<div class="boxGray">

    <div class="info-msg">
      <g:message code="object.total" args="[allThemes, message(code: 'themes')]"/>
    </div>

    <erp:accessCheck types="['Betreiber']" facilities="${facilities ?: null}" >
      <div class="buttons cleared">
        <g:form>
          <div class="button"><g:actionSubmit class="buttonGreen" action="create" value="${message(code: 'object.create', args: [message(code: 'theme')])}"/></div>
        </g:form>
      </div>
    </erp:accessCheck>

    <div id="themelist">
      <g:render template="themes" model="[themes:themes]"/>
    </div>

</div>
</body>