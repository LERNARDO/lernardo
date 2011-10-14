<head>
  <meta name="layout" content="private"/>
  <title><g:message code="groupActivityTemplates"/></title>
</head>

<body>

<div class="tabGrey">
  <div class="second">
    <h1><g:link controller="logBook" action="entries">Einträge</g:link></h1>
  </div>
</div>

<div class="tabGrey">
  <div class="second">
    <h1><g:link controller="logBook" action="evaluation">Auswertung</g:link></h1>
  </div>
</div>

<div class="tabGrey">
  <div class="second">
    <h1><g:link controller="logBook" action="processes">Vorgänge</g:link></h1>
  </div>
</div>

<div class="tabGreen">
  <div class="second">
    <h1>Einstellungen</h1>
  </div>
</div>

<div class="clearFloat"></div>

<div class="boxGray">
  <div class="second">

    <g:formRemote name="formRemote" url="[controller:'logBook', action:'showAttendances']" update="attendances" before="showspinner('#attendances');">
      <g:message code="facility"/>: <g:select name="facility" from="${facilities}" optionKey="id" optionValue="profile"/>
      <g:submitButton name="button" value="OK"/>
    </g:formRemote>

    <div id="attendances"></div>

  </div>
</div>
</body>
