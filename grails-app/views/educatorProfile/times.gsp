<head>
  <meta name="layout" content="administration"/>
  <title><g:message code="timeEvaluation"/></title>
</head>
<body>

<div class="tabGreen">
  <div class="second">
    <h1><g:message code="timeEvaluation"/></h1>
  </div>
</div>

<div class="tabGrey">
  <div class="second">
    <h1><g:link controller="workdayCategory" action="index"><g:message code="privat.workdaycategories"/></g:link></h1>
  </div>
</div>

<div class="tabGrey">
  <div class="second">
    <h1><g:link controller="educatorProfile" action="workhours"><g:message code="educator.profile.workHours"/></g:link></h1>
  </div>
</div>

<div class="clearFloat"></div>

<div class="boxGray">
  <div class="second">

    <div class="info-msg"><g:message code="timeEvaluation.chooseRange"/></div>

    <g:formRemote name="formRemote" url="[controller:'educatorProfile', action:'showresult']" update="results" before="showspinner('#results')">
      <g:textField name="date1" size="30" class="datepicker-birthday"/>
      <g:textField name="date2" size="30" class="datepicker-birthday"/>
      <g:submitButton name="submitButton" value="OK"/>
    </g:formRemote>

    <div id="results" style="margin-top: 10px">
    </div>

  </div>
</div>

</body>