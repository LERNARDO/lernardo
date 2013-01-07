<head>
  <meta name="layout" content="administration"/>
  <title>Admin Stuff</title>
</head>
<body>
<div class="boxHeader">
  <h1>Admin Stuff</h1>
</div>
<div class="boxContent">

    <h1 style="color: #f00; border: 0;">This is only for site admins, do not click anything here if you don't know what you are doing!</h1>

    %{--<div class="adminbox">
      <div class="bold">Show links "from" and "to" an entity:</div>
      <g:select from="${entities}" name="entity" optionKey="id" optionValue="profile" noSelection="[null:message(code:'non')]" onchange="${remoteFunction(controller: 'admin', action: 'linksresults', update: 'results', params:'\'id=\' + this.value')}"/>
      <div class="result" id="results"></div>
    </div>--}%

    <div class="adminbox">
      <div class="bold">Remove all comments without link:</div>
      <g:remoteLink update="roguecomments" action="removeroguecomments" before="showspinner('#roguecomments');">Remove</g:remoteLink>
      <div class="result" id="roguecomments"></div>
    </div>

    <div class="adminbox">
      <div class="bold">Create helper tables for sorting links:</div>
      <g:remoteLink update="tables" action="createtables" before="showspinner('#tables');">Create</g:remoteLink>
      <div class="result" id="tables"></div>
    </div>

    <div class="adminbox">
      <div class="bold">Check helper tables for sorting links:</div>
      <g:remoteLink update="checktables" action="checktables" before="showspinner('#checktables');">Check</g:remoteLink>
      <div class="result" id="checktables"></div>
    </div>

    <div class="adminbox">
      <div class="bold">Check database access times</div>
      <g:remoteLink update="db" action="checkDB" before="showspinner('#db');">Check</g:remoteLink>
      <div class="result" id="db"></div>
    </div>

    <div class="adminbox">
      <div class="bold">Remove unused assets and assetStorages</div>
      <g:remoteLink update="assets" action="removeAssets" before="showspinner('#assets');">Remove</g:remoteLink>
      <div class="result" id="assets"></div>
    </div>

    <div class="adminbox">
      <div class="bold">Create attendances of clients for log book</div>
      <g:remoteLink update="attendences" action="createAttendences" before="showspinner('#attendences');">Create</g:remoteLink>
      <div class="result" id="attendences"></div>
    </div>

    <div class="adminbox">
      <div class="bold">Create labels list</div>
      <g:remoteLink update="labels" action="createLabels" before="showspinner('#labels');">Create</g:remoteLink>
      <div class="result" id="labels"></div>
    </div>

    <div class="adminbox">
      <div class="bold">Favorites</div>
      <g:remoteLink update="favorites" action="favorites" before="showspinner('#favorites');">Update</g:remoteLink>
      <div class="result" id="favorites"></div>
    </div>

    <div class="adminbox">
        <div class="bold">Convert ABV to PV</div>
        <g:remoteLink update="conversion" action="conversion" before="showspinner('#conversion');">Convert</g:remoteLink>
        <div class="result" id="conversion"></div>
    </div>

</div>
</body>