<head>
  <title><g:message code="evaluation.evaluation"/></title>
  <meta name="layout" content="database"/>
</head>
<body>
<div class="boxHeader">
  <h1><g:message code="evaluation.for" args="[entity.profile.fullName]"/></h1>
</div>
<div class="boxGray">
  <div class="second">

    <div class="info-msg">
      <g:message code="evaluation.sizeFor" args="[evaluationInstanceTotal, entity.profile.fullName]"/>
    </div>

    <div class="buttons">
      <g:link class="buttonGreen" action="create" id="${entity.id}"><g:message code="evaluation.create"/></g:link>
      <div class="clear"></div>
    </div>

    <g:render template="evaluations" model="[evaluationInstanceList: evaluationInstanceList]"/>

  </div>
</div>
</body>
