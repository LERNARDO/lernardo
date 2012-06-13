<head>
  <meta name="layout" content="administration"/>
  <title><g:message code="educator.profile.workHours"/></title>
</head>
<body>

<div class="tabGrey">
  <div class="second">
    <h1><g:link controller="timeEvaluation"><g:message code="timeEvaluation"/></g:link></h1>
  </div>
</div>

<div class="tabGrey">
  <div class="second">
    <h1><g:link controller="workdayCategory" action="index"><g:message code="privat.workdaycategories"/></g:link></h1>
  </div>
</div>

<div class="tabGreen">
  <div class="second">
    <h1><g:message code="educator.profile.workHours"/></h1>
  </div>
</div>

<div class="clear"></div>

<div class="boxGray">

  <g:formRemote name="formRemote" url="[controller: 'workdayUnit', action: 'showPersons']" update="result" before="showspinner('#result')">
    <g:select name="type" from="[message(code: 'users'), message(code: 'educators')]"/>
    <g:submitButton name="submitButton" value="OK"/>
  </g:formRemote>

  <div id="result" style="margin-top: 10px;">
  </div>

</div>
</body>