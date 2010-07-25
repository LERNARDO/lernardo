<head>
  <title>Artikelansicht</title>
  <meta name="layout" content="public" />
</head>

<body>
  <div id="article-container">
    <div class="item">
      <g:render template="header"     model='[article:article]'/>
      <g:render template="teaser"     model='[article:article]'/>
      <g:render template="content"    model='[article:article]'/>
      <div class="links">
        <g:link action="index">&#187; zurück zur Übersicht</g:link>
      </div>
    </div>
  </div>
</body>
