<head>
  <meta name="layout" content="organisation"/>
  <title><g:message code="entries"/></title>
</head>

<body>

<div class="tabActive">
    <h1><g:message code="entries"/></h1>
</div>

%{--<erp:accessCheck types="['Betreiber']" facilities="${facilities}">--}%
  <div class="tabInactive">
      <h1><g:link controller="logBook" action="evaluation"><g:message code="evaluation2"/></g:link></h1>
  </div>
%{--</erp:accessCheck>--}%

<div class="tabInactive">
    <h1><g:link controller="logBook" action="processes"><g:message code="processes"/></g:link></h1>
</div>

<div class="tabInactive">
    <h1><g:link controller="logBook" action="settings"><g:message code="attendance"/></g:link></h1>
</div>

<div class="clear"></div>

<div class="boxContent">

    <div class="graypanel">
      <g:formRemote name="formRemote" url="[controller: 'logBook', action: 'showEntry']" update="entry" before="showspinner('#entry');">
        <span class="gray"><g:message code="facility"/>:</span> <g:select name="facility" from="${facilities}" optionKey="id" optionValue="profile"/>
        <span class="gray" style="margin-left: 10px;"><g:message code="date"/>:</span> <g:textField name="date" size="10" class="datepicker" value="${formatDate(date: new Date(), format: 'dd. MM. yyyy')}"/>
        <g:submitButton name="button" value="OK"/>
      </g:formRemote>
    </div>

    <div id="entry"></div>

</div>
</body>
