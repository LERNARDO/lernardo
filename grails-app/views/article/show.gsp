<head>
  <title>${article.value.title}</title>
  <meta name="layout" content="public" />
</head>

<body>
  <div id="article-detail">
    <g:render template="header"     model='[article:article.value]'/>
    <g:render template="content"    model='[article:article.value]'/>
  </div>
  <g:render template="links"      model='[article:article.value]'/>
</body>
