<head>
  <title>News</title>
  <meta name="layout" content="public" />
</head>

<body>
  <div id="article-index">
    <h1>${listTitle ?: articles ? articles[0].category.description : "Keine Artikel gefunden" }</h1>

    <!-- render all articles -->

    <g:each var="article" in="${articles}">
      <div class="article-index-item">
        <g:render template="header" model='[article:article.value]'/>
        <g:render template="teaser" model='[article:article.value]'/>
        <g:render template="links"  model='[article:article.value]'/>
      </div>
    </g:each>

    %{--<p>
      <img src="/lernardoV2/images/static/bild_des_tages${day}.png" width="229" height="172" alt="bild des tages" id="randomPicture"/>
    </p>--}%

  </div>
</body>