<head>
  <meta name="layout" content="private"/>
  <title>Link Check</title>
</head>
<body>
<div class="boxHeader">
  <div class="second">
    <h1>Link Check</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <g:select from="${entities}" name="entity" optionKey="id" optionValue="profile" noSelection="[null:message(code:'non')]" onchange="${remoteFunction(controller:'app', action:'adminlinksresults', update:'results', params:'\'id=\' + this.value')}"/>
    <div id="results"></div>

    <g:remoteLink update="roguecomments" action="removeroguecomments" before="showspinner('#roguecomments');">Lösche Kommentare ohne Zugehörigkeit</g:remoteLink>
    <div id="roguecomments"></div>

  </div>
</div>
</body>