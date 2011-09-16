<head>
  <meta name="layout" content="private"/>
  <title><g:message code="privat.workday"/></title>
</head>
<body>

<div class="tabGreen">
  <div class="second">
    <h1><g:message code="privat.workday"/></h1>
  </div>
</div>
<div class="tabGrey">
  <div class="second">
    <h1><g:link controller="workdayUnit" action="report" id="${entity.id}"><g:message code="report"/></g:link></h1>
  </div>
</div>
<div class="clearFloat"></div>

<div class="boxGray">
  <div class="second">

    <p><g:message code="privat.workday.chooseDay"/></p>

    <g:formRemote name="formRemote" url="[controller:'workdayUnit', action:'showunits', id: entity.id]" update="workdayunits" before="showspinner('#workdayunits')">
      <g:textField name="date" size="30" value="${new Date().format('dd. MM. yyyy')}" class="datepicker-birthday"/>
      <g:submitButton name="submitButton" value="OK"/>
    </g:formRemote>

    <div id="workdayunits"></div>

  </div>
</div>
</body>