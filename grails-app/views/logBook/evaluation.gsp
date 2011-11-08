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

<div class="tabGreen">
  <div class="second">
    <h1>Auswertung</h1>
  </div>
</div>

<div class="tabGrey">
  <div class="second">
    <h1><g:link controller="logBook" action="processes">Vorgänge</g:link></h1>
  </div>
</div>

<div class="tabGrey">
  <div class="second">
    <h1><g:link controller="logBook" action="settings">Anwesenheit</g:link></h1>
  </div>
</div>

<div class="clearFloat"></div>

<div class="boxGray">
  <div class="second">

    <g:formRemote name="formRemote" url="[controller:'logBook', action:'showEvaluation']" update="evaluation" before="showspinner('#evaluation');">
      <g:message code="facility"/>: <g:select name="facility" from="${facilities}" optionKey="id" optionValue="profile"/>
      <g:message code="date"/>: <g:datePicker name="date" precision="month" value="${new Date()}"/>
      <g:submitButton name="button" value="OK"/>
    </g:formRemote>

    <div id="evaluation"></div>

  </div>
</div>
</body>
