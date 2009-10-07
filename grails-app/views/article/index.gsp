<head>
  <title>News</title>
  <meta name="layout" content="public" />
</head>

<body>
  <h1>${listTitle ?: articles ? articles[0].category.description : "Keine Artikel gefunden" }</h1>
  <div id="article-container">

    <g:each var="article" in="${articles}">
      <div class="item">
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