<head>
  <meta name="layout" content="private"/>
  <title><g:message code="privat.workday"/></title>
</head>
<body>
<div class="boxHeader">
  <div class="second">
    <h1><g:message code="privat.workday"/></h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <p>Bitte einen Tag auswählen um Zeitaufzeichnungen einzutragen:</p>

    <g:formRemote name="formRemote" url="[controller:'workdayUnit', action:'showunits']" update="workdayunits" before="showspinner('#workdayunits')">
      <g:textField name="date" size="30" value="${new Date().format('dd. MM. yyyy')}" class="datepicker-birthday"/>
      <div class="spacer"></div>
      <g:submitButton name="submitButton" value="OK"/>
      <div class="spacer"></div>
    </g:formRemote>

    <div id="workdayunits"></div>

  </div>
</div>
</body>