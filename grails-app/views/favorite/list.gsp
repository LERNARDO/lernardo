<head>
  <meta name="layout" content="start"/>
  <title><g:message code="favorites"/></title>
</head>
<body>
<div class="boxHeader">
  <h1><g:message code="favorites"/></h1>
</div>
<div class="boxGray">
  %{--<erp:showFolders>
    <g:render template="showFolders" model="[folders: subfolders, favorites: subfavorites]"/>
  </erp:showFolders>--}%
  <erp:showFolders2/>
</div>
</body>
