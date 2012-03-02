<head>
  <meta name="layout" content="organisation"/>
  <title><g:message code="attendance"/></title>
</head>

<body>

<div class="tabGrey">
  <div class="second">
    <h1><g:link controller="logBook" action="entries"><g:message code="entries"/></g:link></h1>
  </div>
</div>

%{--<erp:accessCheck entity="${currentEntity}" types="['Betreiber']" facilities="${facilities}">--}%
  <div class="tabGrey">
    <div class="second">
      <h1><g:link controller="logBook" action="evaluation"><g:message code="evaluation2"/></g:link></h1>
    </div>
  </div>
%{--</erp:accessCheck>--}%

<div class="tabGrey">
  <div class="second">
    <h1><g:link controller="logBook" action="processes"><g:message code="processes"/></g:link></h1>
  </div>
</div>

<div class="tabGreen">
  <div class="second">
    <h1><g:message code="attendance"/></h1>
  </div>
</div>

<div class="clear"></div>

<div class="boxGray">
  <div class="second">

    <div style="background: #eee; padding: 10px; margin: 0 0 10px 0;">
      <g:formRemote name="formRemote" url="[controller:'logBook', action:'showAttendances']" update="attendances" before="showspinner('#attendances');">
        <span class="gray"><g:message code="facility"/>:</span> <g:select name="facility" from="${facilities}" optionKey="id" optionValue="profile"/>
        <g:submitButton name="button" value="OK"/>
      </g:formRemote>
    </div>

    <div id="attendances"></div>

  </div>
</div>
</body>
