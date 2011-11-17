<head>
  <meta name="layout" content="private"/>
  <title><g:message code="entries"/></title>
</head>

<body>

<div class="tabGreen">
  <div class="second">
    <h1><g:message code="entries"/></h1>
  </div>
</div>

<erp:accessCheck entity="${currentEntity}" types="['Betreiber']" facilities="${facilities}">
  <div class="tabGrey">
    <div class="second">
      <h1><g:link controller="logBook" action="evaluation"><g:message code="evaluation2"/></g:link></h1>
    </div>
  </div>
</erp:accessCheck>

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

<div class="clearFloat"></div>

<div class="boxGray">
  <div class="second">

    <g:formRemote name="formRemote" url="[controller:'logBook', action:'showEntry']" update="entry" before="showspinner('#entry');">
      <g:message code="facility"/>: <g:select name="facility" from="${facilities}" optionKey="id" optionValue="profile"/>
      <g:message code="date"/>: <g:textField name="date" size="10" class="datepicker" value="${formatDate(date: new Date(), format: 'dd. MM. yyyy')}"/>
      <g:submitButton name="button" value="OK"/>
    </g:formRemote>

    <div id="entry"></div>

  </div>
</div>
</body>
