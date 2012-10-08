<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="layout" content="start"/>
  <title><g:message code="newsp"/></title>
</head>

<body>

<div class="boxHeader">
  <h1><g:message code="newsp"/></h1>
</div>

<div class="boxContent">

    <erp:accessCheck types="['Betreiber','Pädagoge']">
      <div class="buttons cleared">
        <g:form controller="news" action="create">
          <div class="button"><g:submitButton name="submit" class="buttonGreen" value="${message(code: 'object.create', args: [message(code: 'news')])}"/></div>
        </g:form>
      </div>
    </erp:accessCheck>

    <div id="news-container">
      <g:render template="newsitems" model="[news: news, newsCount: newsCount]"/>
    </div>

    <div class="paginateButtons">
      <g:paginate total="${newsCount}"/>
    </div>

</div>

</body>