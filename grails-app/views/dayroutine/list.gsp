<head>
  <meta name="layout" content="private"/>
  <title><g:message code="dayroutine"/></title>
</head>

<body>

<div class="headerGreen">
  <div class="second">
    <h1><g:message code="dayroutine"/></h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <div id="dayroutine">

      <g:render template="routineday" model="[routines: routines, entity: entity, day: day]"/>

    </div>

  </div>
</div>

</body>