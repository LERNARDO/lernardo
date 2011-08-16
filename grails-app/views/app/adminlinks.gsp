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

    <p>
      <g:remoteLink update="roguecomments" action="removeroguecomments" before="showspinner('#roguecomments');">Lösche Kommentare ohne Zugehörigkeit</g:remoteLink>
      <div id="roguecomments"></div>
    </p>

    <p>
      Tabellen für Aktivitätsblockvorlagen, Projektvorlagen und Projekttage erstellen<br/>
      <g:remoteLink update="tables" action="createtables" before="showspinner('#tables');">Erstellen</g:remoteLink>
      <div id="tables"></div>
    </p>

    <p>
      Check Tabellen für Aktivitätsblockvorlagen, Projektvorlagen und Projekttage erstellen<br/>
      <g:remoteLink update="checktables" action="checktables" before="showspinner('#checktables');">Check-Tab</g:remoteLink>
      <div id="checktables"></div>
    </p>

    <p>
      Check DB Access Times<br/>
      <g:remoteLink update="db" action="checkDB" before="showspinner('#db');">Check</g:remoteLink>
      <div id="db"></div>
    </p>

    <p>
      Remove unused assets and assetStorages<br/>
      <g:remoteLink update="db" action="removeAssets" before="showspinner('#assets');">Remove</g:remoteLink>
      <div id="assets"></div>
    </p>

  </div>
</div>
</body>