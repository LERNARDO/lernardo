<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="layout" content="private"/>
  <title><g:message code="newsp"/></title>
</head>

<body>

<div class="boxHeader">
  <div class="second">
    <h1><g:message code="newsp"/></h1>
  </div>
</div>

<div class="boxGray">
  <div class="second">

    <erp:accessCheck entity="${currentEntity}" types="['Betreiber','Pädagoge']">
      <div class="buttons">
        <g:form controller="news" action="create">
          <div class="button"><g:submitButton name="submit" class="buttonGreen" value="${message(code: 'object.create', args: [message(code: 'news')])}"/></div>
          <div class="spacer"></div>
        </g:form>
      </div>
    </erp:accessCheck>

    <div id="news-container">
      <g:render template="newsitems" model="[news: news, newsCount: newsCount, currentEntity: currentEntity]"/>
    </div>

    <div class="paginateButtons">
      <g:paginate total="${newsCount}"/>
    </div>

  </div>
</div>

</body>