<head>
  <meta name="layout" content="private"/>
  <title><g:message code="privat.workday"/></title>
</head>
<body>

<div class="tabGrey">
  <div class="second">
    <h1><g:link controller="workdayUnit" action="index" id="${entity.id}"><g:message code="privat.workday"/></g:link></h1>
  </div>
</div>
<div class="tabGreen">
  <div class="second">
    <h1><g:message code="report"/></h1>
  </div>
</div>
<div class="clearFloat"></div>

<div class="boxGray">
  <div class="second">

    <p><g:message code="privat.workday.chooseRange"/></p>

    <g:formRemote name="formRemote" url="[controller:'workdayUnit', action:'showreport', id: entity.id]" update="results" before="showspinner('#results')">
      <g:textField name="date1" size="30" class="datepicker-birthday"/>
      <g:textField name="date2" size="30" class="datepicker-birthday"/>
      <g:submitButton name="submitButton" value="OK"/>
    </g:formRemote>

    <div id="results" style="margin-top: 10px">
    </div>

  </div>
</div>
</body>