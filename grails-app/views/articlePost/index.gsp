<head>
  <title>Neuigkeiten</title>
  <meta name="layout" content="public" />
</head>

<body>

  <div id="article-container">
 
    <g:if test="${currentEntity}">
      <erp:isEducator entity="${currentEntity}">
        <p><g:link class="createArticle" controller="articlePost" action="create" fragment="anker"><g:message code="article.create"/></g:link></p>
      </erp:isEducator>
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

    <div class="paginateButtonsPublic">
      <g:paginate action="index" total="${articleCount}"/>
    </div>

  </div>
</body>