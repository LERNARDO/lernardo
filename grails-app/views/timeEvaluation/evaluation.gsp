<head>
  <meta name="layout" content="administration"/>
  <title><g:message code="timeEvaluation"/></title>
</head>
<body>

<div class="tabActive">
    <h1><g:message code="timeEvaluation"/></h1>
</div>

<div class="tabInactive">
    <h1><g:link controller="workdayCategory" action="index"><g:message code="privat.workdaycategories"/></g:link></h1>
</div>

<div class="tabInactive">
    <h1><g:link controller="workdayUnit" action="workhours"><g:message code="educator.profile.workHours"/></g:link></h1>
</div>

<div class="clear"></div>

<div class="boxContent">

    <div class="info-msg"><g:message code="timeEvaluation.chooseRange"/></div>

    <g:formRemote name="formRemote" url="[controller: 'timeEvaluation', action: 'showEvaluation']" update="evaluate" before="showspinner('#evaluate')">
      <g:textField name="date1" size="30" class="datepicker-birthday"/>
      <g:textField name="date2" size="30" class="datepicker-birthday"/>
      <g:submitButton name="submitButton" value="OK"/>
    </g:formRemote>

    <div id="evaluate" style="margin-top: 10px;">
    </div>

</div>

</body>