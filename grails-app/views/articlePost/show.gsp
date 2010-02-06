<head>
  <title>Lernardo | Artikelansicht</title>
  <meta name="layout" content="public" />
</head>

<body>
  <div id="article-container">
    <h1>Artikelansicht</h1>
    <div class="item">
      <g:render template="header"     model='[article:article]'/>
      <g:render template="teaser"     model='[article:article]'/>
      <g:render template="content"    model='[article:article]'/>
      %{--<div class="actionlink">
        <g:link action="index">Zurück zur Übersicht</g:link>
      </div>--}%
      <div class="links">
        <g:link action="index">&#187; zurück zur Übersicht</g:link>
      </div>
    </div>
  </div>
</body>
