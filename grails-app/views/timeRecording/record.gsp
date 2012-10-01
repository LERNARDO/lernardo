<head>
  <meta name="layout" content="database"/>
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
    <h1><g:link controller="timeRecording" action="report" id="${entity.id}"><g:message code="report"/></g:link></h1>
  </div>
</div>
<div class="clear"></div>

<div class="boxGray">

    <div class="info-msg">
      <g:message code="privat.workday.chooseDay"/>
    </div>

    <g:formRemote name="formRemote" url="[controller: 'timeRecording', action: 'showRecords', id: entity.id]" update="records" before="showspinner('#records')">
      <g:textField name="date" size="30" value="${new Date().format('dd. MM. yyyy')}" class="datepicker-birthday"/>
      <g:submitButton name="submitButton" value="OK"/>
    </g:formRemote>

    <div id="records" style="margin-top: 10px;"></div>

</div>
</body>