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
      <g:remoteLink class="createArticle" controller="articlePost" action="create" update="createArticle" after="jQuery('#createArticle').show('fast')">Neuen Artikel erstellen</g:remoteLink>
      <div id="createArticle">
      </div>
    </g:if>
  </g:if>

    <g:each in="${articleList}" var="article">
      <div class="item">
        <g:render template="header" model='[article:article]'/>
        <g:render template="teaser" model='[article:article]'/>
        <g:render template="links"  model='[article:article]'/>
      </div>
    </g:each>

    %{--<p>
      <img src="/lernardoV2/images/static/bild_des_tages${day}.png" width="229" height="172" alt="bild des tages" id="randomPicture"/>
    </p>--}%

  </div>
</body>