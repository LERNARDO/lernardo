<head>
  <title><g:message code="evaluation.evaluation"/></title>
  <meta name="layout" content="database"/>
</head>
<body>
<div class="boxHeader">
  <h1><g:message code="evaluation.for" args="[entity.profile.fullName]"/></h1>
</div>
<div class="boxGray">

    <div class="info-msg">
      <g:message code="evaluation.sizeFor" args="[evaluationInstanceTotal, entity.profile.fullName]"/>
    </div>

    <div class="buttons cleared">
      <g:link class="buttonGreen" action="create" id="${entity.id}"><g:message code="evaluation.create"/></g:link>
    </div>

    <g:render template="evaluations" model="[evaluationInstanceList: evaluationInstanceList]"/>

</div>
</body>
