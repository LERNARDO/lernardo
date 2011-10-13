<head>
  <title><g:message code="nav.news"/></title>
  <meta name="layout" content="public" />
</head>

<body>

  <div id="article-container">
 
    <g:if test="${currentEntity}">
      <erp:accessCheck entity="${currentEntity}" types="['Betreiber','Pädagoge']">
        <p><g:link class="createArticle" controller="articlePost" action="create" fragment="anker"><g:message code="${message(code: 'object.create', args: [message(code: 'article')])}"/></g:link></p>
      </erp:accessCheck>
    </g:if>

    <g:each in="${articleList}" var="article">
      <div class="item">
        <g:render template="header" model='[article:article]'/>
        <g:if test="${article.teaser}">
          <g:render template="teaser" model='[article:article]'/>
        </g:if>
        <g:else>
          <g:render template="content" model='[article:article]'/>
        </g:else>
        <g:render template="links" model='[article:article]'/>
      </div>
    </g:each>

    <div class="paginateButtons">
      <g:paginate action="index" total="${articleCount}"/>
    </div>

  </div>
</body>