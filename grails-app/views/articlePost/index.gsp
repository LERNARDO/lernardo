<head>
  <title>News</title>
  <meta name="layout" content="public" />
  <g:javascript library="jquery"/>
</head>

<body>
  <h1>${listTitle ?: articleList ? articleList[0].category.description : "Keine Artikel gefunden" }</h1>
  <div id="article-container">
 
    <g:if test="${currentEntity}">
      <g:if test="${currentEntity.type.name == 'Paed'}">
        <p><g:link class="createArticle" controller="articlePost" action="create" fragment="anker">Neuen Artikel verfassen</g:link></p>
      </g:if>
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
        <g:render template="links"  model='[article:article]'/>
      </div>
    </g:each>

  </div>
</body>