<head>
  <meta name="layout" content="start"/>
  <title><g:message code="favorites"/></title>
</head>
<body>
<div class="boxHeader">
  <h1><g:message code="favorites"/></h1>
</div>
<div class="boxGray">
  <g:remoteLink class="buttonGreen" action="createFolder" update="faveditbox">Ordner erstellen</g:remoteLink>
  <div class="clear" style="padding-bottom: 5px;"></div>
  <div id="faveditbox"></div>
  <div id="favoriteslist">
    <g:render template="folders"/>
  </div>
</div>
</body>
