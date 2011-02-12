<head>
  <title><g:message code="article"/></title>
  <meta name="layout" content="public" />
</head>

<body>
  <div id="article-container">
    <div class="item">
      <g:render template="header"     model='[article:article]'/>
      <g:render template="teaser"     model='[article:article]'/>
      <g:render template="content"    model='[article:article]'/>
      <div class="links">
        <g:link action="index">&#187; <g:message code="backToList"/></g:link>
      </div>
    </div>
  </div>
</body>
