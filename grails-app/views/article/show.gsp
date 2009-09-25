<head>
  <title>${article.title}</title>
  <meta name="layout" content="public" />
</head>

<body>
  <g:render template="links"      model='[article:article, teaser:false]'/>
  <div id="article-detail">
    <g:render template="header"     model='[article:article]'/>
    <g:render template="content"    model='[article:article]'/>
  </div>
  <g:render template="links"      model='[article:article, teaser:false]'/>
</body>
