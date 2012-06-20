<head>
  <meta name="layout" content="organisation"/>
  <title><g:message code="evaluation2"/></title>
</head>

<body>

<div class="tabGrey">
  <div class="second">
    <h1><g:link controller="logBook" action="entries"><g:message code="entries"/></g:link></h1>
  </div>
</div>

<div class="tabGreen">
  <div class="second">
    <h1><g:message code="evaluation2"/></h1>
  </div>
</div>

<div class="tabGrey">
  <div class="second">
    <h1><g:link controller="logBook" action="processes"><g:message code="processes"/></g:link></h1>
  </div>
</div>

<div class="tabGrey">
  <div class="second">
    <h1><g:link controller="logBook" action="settings"><g:message code="attendance"/></g:link></h1>
  </div>
</div>

<div class="clear"></div>

<div class="boxGray">
  <div class="second">

    <div class="graypanel">
      <g:formRemote name="formRemote" url="[controller: 'logBook', action: 'showEvaluation']" update="evaluation" before="showspinner('#evaluation');">
        <span class="gray"><g:message code="facility"/>:</span> <g:select name="facility" from="${facilities}" optionKey="id" optionValue="profile"/>
        <span class="gray" style="margin-left: 10px;"><g:message code="date"/>:</span> <g:datePicker name="date" precision="month" value="${new Date()}"/>
        <g:submitButton name="button" value="OK"/>
      </g:formRemote>
    </div>

    <div id="evaluation"></div>

  </div>
</div>
</body>
