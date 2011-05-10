<head>
  <meta name="layout" content="private"/>
  <title><g:message code="timeEvaluation"/></title>
</head>
<body>
<div class="boxHeader">
  <div class="second">
    <h1><g:message code="timeEvaluation"/></h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <p><g:message code="timeEvaluation.chooseRange"/></p>

    <g:formRemote name="formRemote" url="[controller:'educatorProfile', action:'showresult']" update="results" before="showspinner('#results')">
      <g:textField name="date1" size="30" class="datepicker-birthday"/>
      <g:textField name="date2" size="30" class="datepicker-birthday"/>
      <div class="spacer"></div>
      <g:submitButton name="submitButton" value="OK"/>
      <div class="spacer"></div>
    </g:formRemote>

    <div id="results" style="margin-top: 10px">
    </div>

  </div>
</div>

</body>